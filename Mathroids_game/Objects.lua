function Object(x_pos, y_pos, obj_max_speed)
   
    return {


        x = x_pos;
        y = y_pos;
        x_speed = 0;
        y_speed = 0;
        max_speed = obj_max_speed;


    }
end



function Player()


    local player = Object(400, 200, 7)


    player.accel = 0.25
   
    return player
end


function Bullet(x_pos, y_pos)


    local bullet = Object(x_pos, y_pos, 22)


    return bullet
end



function Asteroid(x_pos, y_pos, ast_val)


    local asteroid = Object(x_pos, y_pos, 4)


    asteroid.val = ast_val
    return asteroid

end