local love = require("love")
Game = require("Game")
Player = require("Player")



function love.load()

    player = Player()
    game = Game()

end

function love.keypressed(key)
    
    if game.state.running then
        if key == "up" then
            player.moving = true
        end

        if key == "escape" then
            game:changeState("paused")
        end
    elseif game.state.paused then
        if key == "escape" then
            game:changeState("running")
        end
    end

end

function love.keyreleased(key)
    if key == "up" then

        player.moving = false

    end

end


function love.update(dt)
    if game.state.running then
        player:move()
    end

end

function love.draw()
    player:draw()
end
