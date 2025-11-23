-- main.lua
-- Team 1 Term Project

local Player = require("Player")
local utf8   = require("utf8")   -- needed for proper backspace handling

local score, lives, gameOver
local x, y, z, correctAnswer
local options = {}         -- values on asteroids
local asteroids = {}
local bullets = {}
local msg = ""
local msgTimer = 0

local player

local SCREEN_W, SCREEN_H = 800, 600

-- global text scaling
local TEXT_SCALE = 0.9

-- fonts table
local fonts = {}

-- sprites
local rocketImg
local asteroidImg
local bgImg
-- saving scores to file
local function saveScoreToFile(initials, scoreValue)
    -- enforce uppercase and max 3 characters just in case
    initials = string.upper(initials:sub(1, 3))
    local line = string.format("%s,%d\n", initials, scoreValue)
    love.filesystem.append("scores.txt", line)
        table.insert(scores, {
        initials = initials,
        score    = scoreValue,
        idx      = #scores + 1
    })

end


-- leaderboard system
local inputMode      = "none"
local initialsInput  = ""   -- what the player is currently typing (3 letters)
local currentInitials = ""  -- initials from this game once saved

-- scores loaded from / saved to scores.txt

local scores = {}

--score file info
local function loadScores()
    scores = {}
    if not love.filesystem.getInfo("scores.txt") then
        return
    end

    local data = love.filesystem.read("scores.txt")
    if not data then return end

    -- Each line format: INITIALS,SCORE
    for line in data:gmatch("[^\r\n]+") do
        local name, s = line:match("([^,]+),(%d+)")
        if name and s then
                        table.insert(scores, {
                initials = name,
                score    = tonumber(s),
                idx      = #scores + 1
            })

        end
    end
end

local function saveScoreToFile(initials, scoreValue)
    -- enforce uppercase and max 3 characters just in case
    initials = string.upper(initials:sub(1, 3))
    local line = string.format("%s,%d\n", initials, scoreValue)
    love.filesystem.append("scores.txt", line)
    table.insert(scores, {
        initials = initials,
        score    = scoreValue
    })
end
-- generate question

local function newQuestion()
    x = love.math.random(1, 9)
    y = love.math.random(1, 9)
    z = love.math.random(1, 9)
    correctAnswer = x + y + z

    options = { correctAnswer }
    local used = { [correctAnswer] = true }

    while #options < 3 do
        local delta = love.math.random(-6, 6)
        if delta == 0 then delta = 1 end
        local candidate = correctAnswer + delta
        if candidate >= 3 and candidate <= 27 and not used[candidate] then
            used[candidate] = true
            table.insert(options, candidate)
        end
    end

    for i = #options, 2, -1 do
        local j = love.math.random(1, i)
        options[i], options[j] = options[j], options[i]
    end
end


-- asteroids and bullets

local function spawnAsteroids()
    asteroids = {}

    for _, value in ipairs(options) do
        local side = love.math.random(1, 4)
        local ax, ay

        if side == 1 then
            ax = -40
            ay = love.math.random(40, SCREEN_H - 40)
        elseif side == 2 then
            ax = SCREEN_W + 40
            ay = love.math.random(40, SCREEN_H - 40)
        elseif side == 3 then
            ax = love.math.random(40, SCREEN_W - 40)
            ay = -40
        else
            ax = love.math.random(40, SCREEN_W - 40)
            ay = SCREEN_H + 40
        end

        local angleToCenter = math.atan2(SCREEN_H / 2 - ay, SCREEN_W / 2 - ax)
        local speed = love.math.random(40, 80)

        local scale = 0.7
        local r = (asteroidImg:getWidth() * scale) / 2

        table.insert(asteroids, {
            x = ax,
            y = ay,
            r = r,
            value = value,
            dx = math.cos(angleToCenter) * speed,
            dy = math.sin(angleToCenter) * speed,
            scale = scale
        })
    end
end

local function resetBullets()
    bullets = {}
end

local function resetGame()
    score = 0
    lives = 3
    gameOver = false
    msg = ""
    msgTimer = 0
    resetBullets()
    newQuestion()
    spawnAsteroids()
    player:reset(SCREEN_W / 2, SCREEN_H / 2)

-- reset initials / input state for next game
    inputMode = "none"
    initialsInput = ""
    currentInitials = ""
end

local function spawnBullet()
    local speed = 400
    local bx = player.x + math.cos(player.angle) * player.radius
    local by = player.y + math.sin(player.angle) * player.radius

    table.insert(bullets, {
        x = bx,
        y = by,
        r = 4,
        dx = math.cos(player.angle) * speed,
        dy = math.sin(player.angle) * speed,
    })
end
-- math logic
local function dist(a, b, x, y)
local dx = a - x
local dy = b - y
return math.sqrt(dx * dx + dy * dy)
end
-- love 2d asset calls
function love.load()
    love.window.setMode(SCREEN_W, SCREEN_H)
 love.window.setTitle("Math-eroids!")
love.math.setRandomSeed(os.time())
    love.graphics.setBackgroundColor(0, 0, 0)

    -- load images
    rocketImg   = love.graphics.newImage("rocket.png")
asteroidImg = love.graphics.newImage("asteroid.png")
    bgImg       = love.graphics.newImage("space_bg.png")

    -- set up fonts (all sizes multiplied by TEXT_SCALE)
    fonts.title    = love.graphics.newFont(36 * TEXT_SCALE)
 fonts.ui       = love.graphics.newFont(20 * TEXT_SCALE)
fonts.question = love.graphics.newFont(24 * TEXT_SCALE)
    fonts.msg      = love.graphics.newFont(22 * TEXT_SCALE)
fonts.asteroid = love.graphics.newFont(18 * TEXT_SCALE)
    fonts.gameOver = love.graphics.newFont(28 * TEXT_SCALE)

    player = Player(SCREEN_W / 2, SCREEN_H / 2, rocketImg)

loadScores()
    resetGame()
end

function love.update(dt)
    if gameOver then
        -- still update player so ship can idle if you want
        player:update(dt, false, false, false)
        return
    end

    if msgTimer > 0 then
        msgTimer = msgTimer - dt
        if msgTimer <= 0 then
           msgTimer = 0
            msg = ""
        end
    end

    local turnLeft  = love.keyboard.isDown("left")
    local turnRight = love.keyboard.isDown("right")
    local thrust    = love.keyboard.isDown("up")

    player:update(dt, turnLeft, turnRight, thrust)

    for i = #bullets, 1, -1 do
        local b = bullets[i]
        b.x = b.x + b.dx * dt
        b.y = b.y + b.dy * dt
        if b.x < -20 or b.x > SCREEN_W + 20 or b.y < -20 or b.y > SCREEN_H + 20 then
            table.remove(bullets, i)
        end
    end

    for i = #asteroids, 1, -1 do
        local a = asteroids[i]
        a.x = a.x + a.dx * dt
        a.y = a.y + a.dy * dt

        if a.x < -50 then a.x = SCREEN_W + 50 end
        if a.x > SCREEN_W + 50 then a.x = -50 end
        if a.y < -50 then a.y = SCREEN_H + 50 end
        if a.y > SCREEN_H + 50 then a.y = -50 end
    end

    for ai = #asteroids, 1, -1 do
        local a = asteroids[ai]

        for bi = #bullets, 1, -1 do
            local b = bullets[bi]

            if dist(a.x, a.y, b.x, b.y) < a.r + b.r then
                local hitValue = a.value

                table.remove(bullets, bi)
                table.remove(asteroids, ai)

                if hitValue == correctAnswer then
                    score = score + 1
                    msg = "Correct!"
                    msgTimer = 0.7

                    newQuestion()
                    spawnAsteroids()
                    resetBullets()
                else
                    lives = lives - 1
                    msg = "Wrong!"
                    msgTimer = 0.8

                    if lives <= 0 then
                        gameOver = true
                        msg = "Game Over!"
                        msgTimer = 0

                        -- start initials prompt
                        inputMode = "initials"
                        initialsInput = ""
                        currentInitials = ""
                    else
                        spawnAsteroids()
                        resetBullets()
                    end
                end

                break
            end
        end
    end
end


-- Input

function love.keypressed(key)
    -- handle initials entry while game over
    if gameOver and inputMode ~= "none" and inputMode ~= "done" then
        if key == "backspace" then
            local byteoffset = utf8.offset(initialsInput, -1)
            if byteoffset then
                initialsInput = string.sub(initialsInput, 1, byteoffset - 1)
            else
                initialsInput = ""
            end
        elseif key == "return" or key == "kpenter" then
            -- save score once some initials have been entered
            if #initialsInput > 0 then
                currentInitials = string.upper(initialsInput:sub(1, 3))
                saveScoreToFile(currentInitials, score)
                inputMode = "done"
            end
        end
        -- don't let other controls fire while entering initials
        return
    end

    if key == "space" and not gameOver then
        spawnBullet()
    elseif key == "r" and gameOver and inputMode == "done" then
        resetGame()
    elseif key == "escape" then
        love.event.quit()
    end
end

-- capture typed characters for initials
function love.textinput(t)
    if not gameOver then return end
    if inputMode == "initials" then
        -- only letters, max 3
        if t:match("%a") and #initialsInput < 3 then
            initialsInput = initialsInput .. string.upper(t)
        end
    end
end


-- Draw operations

function love.draw()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    if bgImg then
        local bw, bh = bgImg:getWidth(), bgImg:getHeight()
        local scale = math.max(sw / bw, sh / bh)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(
            bgImg,
            sw / 2, sh / 2,
            0,
            scale, scale,
            bw / 2, bh / 2
        )
    end

-- UI text
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(fonts.title)
    love.graphics.printf("Math-eroids!", 0, sh * 0.02, sw, "center")

    love.graphics.setFont(fonts.ui)
    love.graphics.printf("Score: " .. tostring(score), 0, sh * 0.08, sw, "center")
    love.graphics.printf("Lives: " .. tostring(lives), 0, sh * 0.12, sw, "center")

    local question = string.format("%d + %d + %d = ?", x, y, z)
    love.graphics.setFont(fonts.question)
    love.graphics.printf(question, 0, sh * 0.18, sw, "center")

    if msg ~= "" then
        love.graphics.setFont(fonts.msg)
        love.graphics.setColor(1, 1, 0.3)
        love.graphics.printf(msg, 0, sh * 0.24, sw, "center")
        love.graphics.setColor(1, 1, 1)
    end

 -- player & bullets
    player:draw()

    for _, b in ipairs(bullets) do
        love.graphics.circle("fill", b.x, b.y, b.r)
    end

 -- asteroids
    for _, a in ipairs(asteroids) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(
            asteroidImg,
            a.x, a.y,
            0,
            a.scale, a.scale,
            asteroidImg:getWidth() / 2,
            asteroidImg:getHeight() / 2
        )

        love.graphics.setFont(fonts.asteroid)
        love.graphics.printf(
            tostring(a.value),
            a.x - a.r, a.y - 8,
            a.r * 2,
            "center"
        )
    end

    if gameOver then
        love.graphics.setFont(fonts.gameOver)
        love.graphics.setColor(1, 0.4, 0.4)

        local header = "Game Over! Final Score: " .. tostring(score)
        if currentInitials ~= "" then
            header = header .. " (" .. currentInitials .. ")"
        end
        love.graphics.printf(header, 0, sh * 0.45, sw, "center")

        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(
            "Press R to play again",
            0, sh * 0.52, sw, "center"
        )

     -- initials prompt
        love.graphics.setFont(fonts.ui)
        local y = sh * 0.60

        if inputMode == "initials" then
            love.graphics.printf("Enter your initials (3 letters):", 0, y, sw, "center")
            y = y + 24
            love.graphics.printf(initialsInput, 0, y, sw, "center")

            y = y + 32
            love.graphics.printf("(Press Enter to save)", 0, y, sw, "center")

        elseif inputMode == "done" then
            love.graphics.printf("Score saved! Press R to play again.", 0, y, sw, "center")
        end

    -- show saved scores list (top 10)
        love.graphics.setFont(fonts.ui)
        local sx = 20
        local sy = sh * 0.15
        love.graphics.print("Saved Scores (from scores.txt):", sx, sy)
        sy = sy + 24

                table.sort(scores, function(a, b)
            if a.score == b.score then
                return (a.idx or 0) < (b.idx or 0)
            else
                return a.score > b.score
            end
        end)

        local lastScore = nil
        local lastRank  = 0
        local countAtRank = 0

        for i, entry in ipairs(scores) do
            if i > 10 then break end

            local rank
            if lastScore == nil then
                rank = 1
                countAtRank = 1
            elseif entry.score == lastScore then
                rank = lastRank
                countAtRank = countAtRank + 1
            else
                rank = lastRank + countAtRank
                countAtRank = 1
            end

            lastScore = entry.score
            lastRank  = rank

            local line = string.format("%d) %s - %d", rank, entry.initials, entry.score)
            love.graphics.print(line, sx, sy)
            sy = sy + 20
        end

    end
end
