local player = require("Player")
local leaderboard = require("Leaderboard")
local currentScreen = "game"

function love.load()
    leaderboard.load()
    player = Player()

end

function love.keypressed(key)
    if currentScreen == "initials" then
        if key == "up" then
            leaderboard.initialsEntry.increment()
        elseif key == "down" then
            leaderboard.initialsEntry.decrement()
        elseif key == "return" or key == "enter" then
            leaderboard.initialsEntry.confirmLetter()

            if not leaderboard.initialsEntry.active then
                currentScreen = "leaderboard"
            end
        end
        return
    end
    if currentScreen == "leaderboard" then
        if key == "space" then
            currentScreen = "game"
            game.start()
        end
        return
    end
    if currentScreen == "game" then
        if key == "up" then
            player.moving = true
        end
        if key == "l" then
            currentScreen = "leaderboard"
        end
        if key == "h" then
            leaderboard.checkHighScore( math.random(100, 999) )
            currentScreen = "initials"
        end
    end
end

function love.keyreleased(key)
    if key == "up" then


        player.moving = false


    end


end



function createAsteroid()
    local asteroid = {
        x = math.random(50, 750),
        y = math.random(50, 550),

        --bsprite = love.graphics.newImage("sprites/asteroid")

        
    }

    return asteroid

end

function love.update(dt)
    -- local FPS = love.timer.getFPS()
   
    player:move()


end

function drawInitialsEntry()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(48))

    love.graphics.printf("NEW HIGH SCORE!", 0, 50, love.graphics.getWidth(), "center")

    -- Draw the letters
    for i = 1, 3 do
        local letter = leaderboard.initialsEntry.letters[leaderboard.initialsEntry.index[i]]
        local x = love.graphics.getWidth()/2 - 120 + (i-1)*120
        local y = 200

        -- Highlight the current letter
        if i == leaderboard.initialsEntry.currentPos then
            love.graphics.setColor(1, 1, 0) -- yellow highlight
        else
            love.graphics.setColor(1, 1, 1)
        end

        love.graphics.printf(letter, x, y, 120, "center")
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.printf("USE ↑ ↓ TO CHANGE LETTER · ENTER TO CONFIRM", 0, 400, love.graphics.getWidth(), "center")
end

function drawLeaderboard()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(48))
    love.graphics.printf("LEADERBOARD", 0, 50, love.graphics.getWidth(), "center")

    love.graphics.setFont(love.graphics.newFont(32))

    for i, entry in ipairs(leaderboard.entries) do
        local text = string.format("%2d.   %s   -   %d", i, entry.initials, entry.score)
        love.graphics.printf(text, 0, 150 + (i-1)*40, love.graphics.getWidth(), "center")
    end

    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.printf("PRESS SPACE TO RETURN TO GAME", 0, 500, love.graphics.getWidth(), "center")
end

function love.draw()
    if currentScreen == "game" then
        player:draw()

    elseif currentScreen == "initials" then
        drawInitialsEntry()

    elseif currentScreen == "leaderboard" then
        drawLeaderboard()
    end
end

    -- love.graphics.circle("fill", player.x, player.y, 30)
    -- player:draw()

    -- width = 20
    -- height = 20
    -- love.graphics.translate(width/2, height/2)
    -- love.graphics.rotate(angle)
    -- love.graphics.translate(-width/2, -height/2)
    -- love.graphics.draw(rocket, player.x, player.y)
