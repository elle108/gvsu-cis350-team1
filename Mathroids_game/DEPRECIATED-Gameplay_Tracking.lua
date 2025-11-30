local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson")

-- update after deploy (use http://localhost:5000 for local)
local backend = "http://localhost:5000"
local access_token = nil
local player = {
    score = 0,
    lives = 3,
    start_time = os.time()
}

-- Register user
function register_user(email, password, username)
    local body = json.encode({ Email = email, Password = password, Username = username })
    local response = {}
    local res, code = http.request{
        url = backend .. "/register",
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
        },
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response)
    }
    return table.concat(response), code
end

-- Login user and store access token
function login_user(email, password)
    local body = json.encode({ Email = email, Password = password })
    local response = {}
    local res, code = http.request{
        url = backend .. "/login",
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json"
        },
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response)
    }
    local text = table.concat(response)
    local parsed, pos, err = json.decode(text)
    if parsed and parsed.access_token then
        access_token = parsed.access_token
        return true, parsed
    else
        return false, text
    end
end

-- Gameplay functions
function start_game()
    player.score = 0
    player.lives = 3
    player.start_time = os.time()
end

function add_score(points)
    player.score = player.score + points
end

function lose_life()
    player.lives = player.lives - 1
    if player.lives <= 0 then
        end_game()
    end
end

-- Submit final score to backend
function submit_score()
    if not access_token then
        print("Not logged in; cannot submit score")
        return false
    end
    local duration = os.time() - player.start_time
    local payload = {
        Value = player.score,
        Mode = "classic",
        Lives = player.lives,
        Duration = duration
    }
    local body = json.encode(payload)
    local response = {}
    local res, code = http.request{
        url = backend .. "/scores",
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. access_token
        },
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response)
    }
    local text = table.concat(response)
    print("Submit score HTTP", code, text)
    return code == 200 or code == 201
end

function end_game()
    submit_score()
end

-- Get leaderboard
function get_leaderboard(limit, threshold)
    limit = limit or 10
    threshold = threshold or nil
    local url = backend .. "/leaderboard?limit=" .. tostring(limit)
    if threshold then url = url .. "&threshold=" .. tostring(threshold) end
    local response = {}
    local res, code = http.request{ url = url, method = "GET", sink = ltn12.sink.table(response) }
    local text = table.concat(response)
    local parsed, pos, err = json.decode(text)
    return parsed, code
end
