using System.Text.Json;
using System.Text.Json.Serialization;
using System.Net.Http.Headers;
using DotNetEnv;

Env.Load(); // read .env file

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

string SUPABASE_URL = Environment.GetEnvironmentVariable("SUPABASE_URL") ?? throw new Exception("SUPABASE_URL not set");
string SUPABASE_ANON_KEY = Environment.GetEnvironmentVariable("SUPABASE_ANON_KEY") ?? throw new Exception("SUPABASE_ANON_KEY not set");
string SUPABASE_SERVICE_ROLE_KEY = Environment.GetEnvironmentVariable("SUPABASE_SERVICE_ROLE_KEY") ?? throw new Exception("SUPABASE_SERVICE_ROLE_KEY not set");
int DISPLAY_THRESHOLD = int.TryParse(Environment.GetEnvironmentVariable("DISPLAY_THRESHOLD"), out var dt) ? dt : 1000;

var client = new HttpClient();
client.DefaultRequestHeaders.Add("apikey", SUPABASE_ANON_KEY); // default for anon read requests

app.MapGet("/", () => Results.Ok(new { status = "ok" }));

// Validate token and return user id
async Task<Guid?> GetUserIdFromTokenAsync(string token)
{
    if (string.IsNullOrWhiteSpace(token)) return null;
    var url = $"{SUPABASE_URL.TrimEnd('/')}/auth/v1/user";
    try
    {
        var req = new HttpRequestMessage(HttpMethod.Get, url);
        req.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        req.Headers.Add("apikey", SUPABASE_ANON_KEY);

        var resp = await client.SendAsync(req);
        if (!resp.IsSuccessStatusCode) return null;
        var text = await resp.Content.ReadAsStringAsync();
        var doc = JsonDocument.Parse(text);
        if (doc.RootElement.TryGetProperty("id", out var idElem))
        {
            return Guid.Parse(idElem.GetString()!);
        }
        return null;
    }
    catch
    {
        return null;
    }
}

// Register
// Calls Supabase /auth/v1/signup using anon key
// Creates profile on success if user id returned
app.MapPost("/register", async (UserRegisterRequest r) =>
{
    // Validation
    if (string.IsNullOrWhiteSpace(r.Email) || string.IsNullOrWhiteSpace(r.Password) || string.IsNullOrWhiteSpace(r.Username))
        return Results.BadRequest(new { success = false, error = "email, password and username required" });

    // Bad word filter
    // TODO: implement bad words filtering
    var bannedWords = new[] { "badword1", "offensive", "inappropriate" };
    foreach (var w in bannedWords)
        if (r.Username.Contains(w, StringComparison.OrdinalIgnoreCase))
            return Results.BadRequest(new { success = false, error = "username contains inappropriate words" });

    var signupUrl = $"{SUPABASE_URL.TrimEnd('/')}/auth/v1/signup";
    var body = JsonSerializer.Serialize(new { email = r.Email, password = r.Password, data = new { } });
    var req = new HttpRequestMessage(HttpMethod.Post, signupUrl);
    req.Content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
    req.Headers.Add("apikey", SUPABASE_ANON_KEY);

    var resp = await client.SendAsync(req);
    var content = await resp.Content.ReadAsStringAsync();

    // Parse returned user id
    // If present, create profile row with service role
    try
    {
        var doc = JsonDocument.Parse(content);
        if (doc.RootElement.TryGetProperty("user", out var userElem) && userElem.ValueKind == JsonValueKind.Object)
        {
            if (userElem.TryGetProperty("id", out var idElem) && idElem.ValueKind == JsonValueKind.String)
            {
                var userId = idElem.GetString();
                // create profile via service_role
                var profilesUrl = $"{SUPABASE_URL.TrimEnd('/')}/rest/v1/profiles";
                var profPayload = JsonSerializer.Serialize(new { id = userId, username = r.Username, total_points = 0 });
                var profReq = new HttpRequestMessage(HttpMethod.Post, profilesUrl);
                profReq.Content = new StringContent(profPayload, System.Text.Encoding.UTF8, "application/json");
                profReq.Headers.Add("apikey", SUPABASE_SERVICE_ROLE_KEY);
                profReq.Headers.Authorization = new AuthenticationHeaderValue("Bearer", SUPABASE_SERVICE_ROLE_KEY);
                var profResp = await client.SendAsync(profReq);
            }
        }
    }
    catch {}

    return Results.Content(content, "application/json");
});

// Login
// Returns token JSON from Supabase
app.MapPost("/login", async (UserLoginRequest r) =>
{
    var loginUrl = $"{SUPABASE_URL.TrimEnd('/')}/auth/v1/token?grant_type=password";
    var body = JsonSerializer.Serialize(new { email = r.Email, password = r.Password });
    var req = new HttpRequestMessage(HttpMethod.Post, loginUrl);
    req.Content = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
    req.Headers.Add("apikey", SUPABASE_ANON_KEY);

    var resp = await client.SendAsync(req);
    var text = await resp.Content.ReadAsStringAsync();
    return Results.Content(text, "application/json");
});

// Profile
app.MapGet("/me", async (HttpRequest httpRequest) =>
{
    if (!httpRequest.Headers.TryGetValue("Authorization", out var auth)) return Results.Unauthorized();
    var token = auth.ToString().Replace("Bearer ", "", StringComparison.OrdinalIgnoreCase).Trim();
    var uid = await GetUserIdFromTokenAsync(token);
    if (uid == null) return Results.Unauthorized();

    var profilesUrl = $"{SUPABASE_URL.TrimEnd('/')}/rest/v1/profiles?select=id,username,total_points,created_at&id=eq.{uid}";
    var req = new HttpRequestMessage(HttpMethod.Get, profilesUrl);
    req.Headers.Add("apikey", SUPABASE_ANON_KEY);
    req.Headers.Authorization = new AuthenticationHeaderValue("Bearer", SUPABASE_ANON_KEY);
    var resp = await client.SendAsync(req);
    var text = await resp.Content.ReadAsStringAsync();
    return Results.Content(text, "application/json");
});

// Submit Score
app.MapPost("/scores", async (HttpRequest httpRequest) =>
{
    if (!httpRequest.Headers.TryGetValue("Authorization", out var auth)) return Results.Unauthorized();
    var token = auth.ToString().Replace("Bearer ", "", StringComparison.OrdinalIgnoreCase).Trim();
    var uid = await GetUserIdFromTokenAsync(token);
    if (uid == null) return Results.Unauthorized();

    var scoreReq = await httpRequest.ReadFromJsonAsync<ScoreSubmitRequest>();
    if (scoreReq == null) return Results.BadRequest(new { success = false, error = "invalid payload" });

    // validate input
    if (scoreReq.Value < 0 || scoreReq.Lives < 0 || scoreReq.Duration < 0)
        return Results.BadRequest(new { success = false, error = "invalid score values" });

    // server-side time-bonus (example: if finished faster than 60s, +10 points per second saved)
    var finalValue = scoreReq.Value;
    if (scoreReq.Duration > 0 && scoreReq.Duration < 60)
        finalValue += (60 - scoreReq.Duration) * 10;

    // call RPC using service_role key
    var rpcUrl = $"{SUPABASE_URL.TrimEnd('/')}/rpc/insert_score_and_add_points";
    var payload = new
    {
        p_user_id = uid,
        p_value = finalValue,
        p_mode = scoreReq.Mode ?? "classic",
        p_lives = scoreReq.Lives,
        p_duration = scoreReq.Duration
    };
    var rpcReq = new HttpRequestMessage(HttpMethod.Post, rpcUrl);
    rpcReq.Content = new StringContent(JsonSerializer.Serialize(payload), System.Text.Encoding.UTF8, "application/json");
    rpcReq.Headers.Add("apikey", SUPABASE_SERVICE_ROLE_KEY);
    rpcReq.Headers.Authorization = new AuthenticationHeaderValue("Bearer", SUPABASE_SERVICE_ROLE_KEY);

    var rpcResp = await client.SendAsync(rpcReq);
    var rpcText = await rpcResp.Content.ReadAsStringAsync();
    if (!rpcResp.IsSuccessStatusCode)
        return Results.BadRequest(new { success = false, error = rpcText });

    return Results.Content(rpcText, "application/json");
});

// Leaderboard
app.MapGet("/leaderboard", async (int limit = 10, int? threshold = null) =>
{
    var effectiveThreshold = threshold ?? DISPLAY_THRESHOLD;
    var url = $"{SUPABASE_URL.TrimEnd('/')}/rest/v1/profiles?select=id,username,total_points&order=total_points.desc&limit={limit}";
    var req = new HttpRequestMessage(HttpMethod.Get, url);
    req.Headers.Add("apikey", SUPABASE_ANON_KEY);
    req.Headers.Authorization = new AuthenticationHeaderValue("Bearer", SUPABASE_ANON_KEY);
    var resp = await client.SendAsync(req);
    var text = await resp.Content.ReadAsStringAsync();

    // mask usernames
    try
    {
        var arr = JsonDocument.Parse(text).RootElement;
        var output = new List<object>();
        if (arr.ValueKind == JsonValueKind.Array)
        {
            foreach (var item in arr.EnumerateArray())
            {
                var id = item.GetProperty("id").GetString();
                var username = item.TryGetProperty("username", out var un) ? un.GetString() : null;
                var totalPoints = item.TryGetProperty("total_points", out var tp) ? tp.GetInt64() : 0;
                var displayName = (totalPoints >= effectiveThreshold && !string.IsNullOrEmpty(username)) ? username : "Anonymous";
                output.Add(new { id, username = displayName, total_points = totalPoints });
            }
        }
        return Results.Json(new { threshold = effectiveThreshold, rows = output });
    }
    catch
    {
        return Results.Content(text, "application/json");
    }
});

// run
app.Run();

// DTOs
public record UserRegisterRequest(string Email, string Password, string Username);
public record UserLoginRequest(string Email, string Password);
public record ScoreSubmitRequest(int Value, string? Mode = "classic", int Lives = 0, int Duration = 0);

