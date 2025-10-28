function love.load()
    player = {}

    -- player starting postion, subject to change 
    player.x = 400
    player.y = 200

    --player speed
    player.x_speed = 0
    player.y_speed = 0

    -- max speed moving positively along x and y axis
    player.max_speed = 7

    -- max speed moving negatively along x and y axis
    player.min_speed = -7

    --player acceleration
    player.accel = 0.25


end


function love.update(dt)
    player.x = player.x + player.x_speed
    player.y = player.y + player.y_speed

    --check for keyboard input
    if love.keyboard.isDown("right") then

        --check that player speed has not exceeded max speed
        if player.x_speed < player.max_speed then
            
            --if player speed is below max speed, add acceleratioj value
            player.x_speed = player.x_speed + player.accel
        end
    
    --if key input is not being held down
    else
        
        --if player is still moving
        if player.x_speed > 0 then
            
            --deccelerate player
            player.x_speed = player.x_speed - player.accel
        end
    end


    if love.keyboard.isDown("left") then
        if player.x_speed > player.min_speed then
            player.x_speed = player.x_speed - player.accel
        end
    else
        if player.x_speed < 0 then
            player.x_speed = player.x_speed + player.accel
        end
    end


    if love.keyboard.isDown("down") then
        if player.y_speed < player.max_speed then
            player.y_speed = player.y_speed + player.accel
        end
    else
        if player.y_speed > 0 then
            player.y_speed = player.y_speed - player.accel
        end
    end


    if love.keyboard.isDown("up") then
        if player.y_speed > player.min_speed then
            player.y_speed = player.y_speed - player.accel
        end
    else
        if player.y_speed < 0 then
            player.y_speed = player.y_speed + player.accel
        end
    end

    
    -- check to make sure player does not go out of bounds
    if player.x <= 30 then
        player.x = 30
    end

    if player.y <= 30 then
        player.y = 30
    end

    if player.x >= 770 then
        player.x = 770
    end

    if player.y >= 570 then
        player.y = 570
    end

end


function love.draw()
    love.graphics.circle("fill", player.x, player.y, 30)
end
