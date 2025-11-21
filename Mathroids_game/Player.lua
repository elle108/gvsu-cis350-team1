function Player()


    return {


        radius = 15,
        angle = math.rad(90),
        x = 400,
        y = 200,
        rotation = 0,
        moving = false,
        thruster = {
            x = 0,
            y = 0,
            speed = 4
        },


        draw = function(self)


            love.graphics.polygon(
                "fill",
                self.x + ((4/3) * self.radius) * math.cos(self.angle),
                self.y - ((4/3) * self.radius) * math.sin(self.angle),
                self.x - self.radius * (2 / 3 * math.cos(self.angle) + math.sin(self.angle)),
                self.y + self.radius * (2 / 3 * math.sin(self.angle) - math.cos(self.angle)),
                self.x - self.radius * (2 / 3 * math.cos(self.angle) - math.sin(self.angle)),
                self.y + self.radius * (2 / 3 * math.sin(self.angle) + math.cos(self.angle))
            )




        end,


        move = function(self)
            deccel = 0.7


            self.rotation = 360/180 * math.pi / love.timer.getFPS()


            if love.keyboard.isDown("left") then


                self.angle = self.angle + self.rotation


            end


            if love.keyboard.isDown("right") then


                self.angle = self.angle - self.rotation


            end


            if self.moving then


                self.thruster.x = self.thruster.x + self.thruster.speed * math.cos(self.angle) / love.timer.getFPS()
                self.thruster.y = self.thruster.y - self.thruster.speed * math.sin(self.angle) / love.timer.getFPS()


            else
                if self.thruster.x ~= 0 or self.thruster.y ~= 0 then
                    self.thruster.x = self.thruster.x - deccel * self.thruster.x / love.timer.getFPS()
                    self.thruster.y = self.thruster.y - deccel * self.thruster.y / love.timer.getFPS()

                end
            end




            self.x = self.x + self.thruster.x
            self.y = self.y + self.thruster.y
       
        end

    }


end


return Player



