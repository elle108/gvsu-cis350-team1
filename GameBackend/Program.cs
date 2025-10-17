using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Supabase;
using DotNetEnv;
using System.Threading.Tasks;

var builder = WebApplication.CreateBuilder(args);

// Load environment variables from .env
Env.Load();

// Get Supabase credentials
var supabaseUrl = Environment.GetEnvironmentVariable("SUPABASE_URL");
var supabaseKey = Environment.GetEnvironmentVariable("SUPABASE_ANON_KEY");

if (string.IsNullOrEmpty(supabaseUrl) || string.IsNullOrEmpty(supabaseKey))
{
    throw new InvalidOperationException("Supabase credentials are missing. Please check your environment variables.");
}

// Initialize Supabase client as a singleton
var supabaseClient = new Supabase.Client(supabaseUrl, supabaseKey);
await supabaseClient.InitializeAsync();
Console.WriteLine("✅ Connected to Supabase: " + supabaseUrl);
builder.Services.AddSingleton(supabaseClient);

// Add services for controllers (API endpoints)
builder.Services.AddControllers();

// Enable CORS (frontend calls API)
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

// Use middleware
app.UseCors();
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

// Run the app
app.Run();
