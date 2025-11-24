local player = require("Player")

function love.load()

    player = Player()

end

function love.keypressed(key)
    if key == "up" then


        player.moving = true

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

