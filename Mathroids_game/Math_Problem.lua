--main.lua

local score, lives, gameOver
local x, y, z, correct
local options = {}
local buttons = {}
local msg = ""
local msgTimer = 0

local function newQuestion()
    x = love.math.random(1, 9)
    y = love.math.random(1, 9)
    z = love.math.random(1, 9)
    correct = x + y + z

    -- generate random options: 1 correct + 2 wrong
    options = { correct }
    local used = { [correct] = true }

    while #options < 3 do
        local delta = love.math.random(-6, 6)  -- a wider variation
        if delta == 0 then delta = 1 end
        local candidate = correct + delta
        if candidate >= 3 and candidate <= 27 and not used[candidate] then
            used[candidate] = true
            table.insert(options, candidate)
        end
    end

    -- shuffle options (ensures random button order)
    for i = #options, 2, -1 do
        local j = love.math.random(1, i)
        options[i], options[j] = options[j], options[i]
    end

    -- lay out buttons horizontally
    buttons = {}
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    local bw, bh = 160, 60
    local spacing = 24
    local totalW = 3 * bw + 2 * spacing
    local startX = (sw - totalW) / 2
    local yPos = sh * 0.6

    for i = 1, 3 do
        buttons[i] = {
            x = startX + (i - 1) * (bw + spacing),
            y = yPos,
            w = bw,
            h = bh,
            value = options[i]
        }
    end
end

-- reset the end of the game
local function resetGame()
    score = 0
    lives = 3
    gameOver = false
    msg = ""
    msgTimer = 0
    newQuestion()
end
-- label for the browser and background color
function love.load()
    love.window.setTitle("Math-eroids!")
    love.math.setRandomSeed(os.time())
    love.graphics.setBackgroundColor(0.1, 0.105, 0.12)
    resetGame()
end

function love.update(dt)
    if msgTimer > 0 then
        msgTimer = msgTimer - dt
        if msgTimer <= 0 then
            msgTimer = 0
            msg = ""
        end
    end
end

local function pointInRect(px, py, r)
    return px >= r.x and px <= r.x + r.w and py >= r.y and py <= r.y + r.h
end
--click function
function love.mousepressed(mx, my, button)
if button ~= 1 then return end
if gameOver then return end

-- logic to decide if the pressed button is correct
for _, b in ipairs(buttons) do
    if pointInRect(mx, my, b) then
        if b.value == correct then
                score = score + 1
         msg = "Correct!"
            msgTimer = 0.6
        else
            lives = lives - 1
            msg = "Wrong!"
                msgTimer = 0.8
                if lives <= 0 then
                    gameOver = true
                 msg = "Game Over!"
                 msgTimer = 0
                 return
end
end
            newQuestion()
            return
        end
    end
end



function love.draw()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

--Title
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Math-eroids!", 0, sh * 0.08, sw, "center")

--Score & Lives
    love.graphics.printf("Score: " .. tostring(score), 0, sh * 0.16, sw, "center")
    love.graphics.printf("Lives: " .. tostring(lives), 0, sh * 0.22, sw, "center")

if gameOver then
love.graphics.printf("Game Over! Final Score: " .. tostring(score), 0, sh * 0.42, sw, "center")

return
end

--Question
    local question = string.format("%d + %d + %d = ?", x, y, z)
    love.graphics.printf(question, 0, sh * 0.38, sw, "center")

--Feedback message
    if msg ~= "" then
        love.graphics.setColor(1, 1, 0.3)
        love.graphics.printf(msg, 0, sh * 0.46, sw, "center")
        love.graphics.setColor(1, 1, 1)
    end

--Buttons
    for _, b in ipairs(buttons) do
        --button box
        love.graphics.setColor(0.2, 0.22, 0.26)
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h, 10, 10)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", b.x, b.y, b.w, b.h, 10, 10)

        --label
        love.graphics.printf(tostring(b.value), b.x, b.y + b.h/2 - 10, b.w, "center")
    end
end