local love = require ("love")

function Asteroid(x, y)
    

    speed = math.random(50)
    
    --determines direction that asteroid travels at random.
    direction = 1
    if math.random() < 0.5 then
        direction = -1
    end

    return {
        x = x,
        y = y,
        x_speed = math.random() * speed * dir,
        y_speed = math.random() * speed * dir,

        draw = function(self)
            
            love.graphics.circle("line", self.x, self.y, 15)

        end


    }
end

return Asteroid