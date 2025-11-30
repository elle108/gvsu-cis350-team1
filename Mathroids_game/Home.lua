local Home = {}

function Home.load()
    Home.title = "Math-eroids!"
    Home.prompt = "Press Enter to Continue"
end

function Home.update(dt)
end

function Home.draw()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont(72))
    love.graphics.printf(Home.title, 0, sh*0.3, sw, "center")
    love.graphics.setFont(love.graphics.newFont(36))
    love.graphics.printf(Home.prompt, 0, sh*0.5, sw, "center")
end

function Home.keypressed(key)
    if key == "return" or key == "enter" then
        currentScreen = "menu"
        require("Menu").load()
    end
end

return Home