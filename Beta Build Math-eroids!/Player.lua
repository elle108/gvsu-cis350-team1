-- Player.lua

local Player = {}
Player.__index = Player

setmetatable(Player, {
    __call = function(cls, ...)
        return cls.new(cls, ...)
    end
})

-- NEW: accept rocket image
function Player.new(_, x, y, img)
    local self = setmetatable({}, Player)
    self.x = x or 400
    self.y = y or 300
    self.angle = -math.pi / 2     -- point up by default
    self.radius = 18
    self.speed = 0
    self.maxSpeed = 220
    self.turnSpeed = math.rad(180)
    self.accel = 200
    self.friction = 80

    self.img = img                 -- sprite
    return self
end

function Player:reset(x, y)
    self.x = x
    self.y = y
    self.angle = -math.pi / 2
    self.speed = 0
end

function Player:update(dt, turnLeft, turnRight, thrust)
    -- rotation
    if turnLeft then
        self.angle = self.angle - self.turnSpeed * dt
    end
    if turnRight then
        self.angle = self.angle + self.turnSpeed * dt
    end

    -- thrust
    if thrust then
        self.speed = self.speed + self.accel * dt
        if self.speed > self.maxSpeed then
            self.speed = self.maxSpeed
        end
    else
        self.speed = self.speed - self.friction * dt
        if self.speed < 0 then self.speed = 0 end
    end

    -- move
    self.x = self.x + math.cos(self.angle) * self.speed * dt
    self.y = self.y + math.sin(self.angle) * self.speed * dt

    -- screen wrap
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    if self.x < -20 then self.x = w + 20 end
    if self.x > w + 20 then self.x = -20 end
    if self.y < -20 then self.y = h + 20 end
    if self.y > h + 20 then self.y = -20 end
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    if self.img then
        -- draw rocket centered, rotated with the player
        local ox = self.img:getWidth() / 2
        local oy = self.img:getHeight() / 2

        -- if the rocket graphic points "up", angle is fine;
        -- if it points "down", add math.pi here.
        love.graphics.draw(self.img, self.x, self.y, self.angle, 1, 1, ox, oy)
    else
        -- fallback: simple triangle if image missing
        love.graphics.push()
        love.graphics.translate(self.x, self.y)
        love.graphics.rotate(self.angle)
        love.graphics.polygon("line",
            -15, 12,
             18, 0,
            -15, -12
        )
        love.graphics.pop()
    end
end

return Player
