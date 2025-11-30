local player = require("Player")
local leaderboard = require("Leaderboard")
local Home = require("Home")
local Menu = require("Menu")
require("Math_Problem")

currentScreen = "home"

function love.load()
    leaderboard.load()
    player = Player()
    Home.load()
    Menu.load()
end

function love.update(dt)
    if currentScreen == "game" then
        love.updateMathGame(dt)
    end
end

function love.draw()
    if currentScreen == "home" then
        Home.draw()
    elseif currentScreen == "menu" then
        Menu.draw()
    elseif currentScreen == "game" then
        love.drawMathGame()
    elseif currentScreen == "initials" then
        drawInitialsEntry()
    elseif currentScreen == "leaderboard" then
        drawLeaderboard()
    elseif currentScreen == "instructions" then
        drawInstructions()
    end
end

function love.keypressed(key)
    if currentScreen == "home" then
        Home.keypressed(key)
    elseif currentScreen == "menu" then
        Menu.keypressed(key)
    elseif currentScreen == "game" then
        love.keypressedMathGame(key)
    elseif currentScreen == "initials" then
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
    elseif currentScreen == "leaderboard" then
        if key == "space" then
            currentScreen = "menu"
        end
    elseif currentScreen == "instructions" then
        if key == "space" then
            currentScreen = "menu"
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


function love.draw()
    -- love.graphics.circle("fill", player.x, player.y, 30)
    player:draw()

    -- width = 20
    -- height = 20
    -- love.graphics.translate(width/2, height/2)
    -- love.graphics.rotate(angle)
    -- love.graphics.translate(-width/2, -height/2)
    -- love.graphics.draw(rocket, player.x, player.y)


end

