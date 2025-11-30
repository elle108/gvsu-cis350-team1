local Menu = {}

function Menu.load()
    Menu.options = {"Start Game", "Instructions", "Leaderboard", "Exit"}
    Menu.currentSelection = 1
end

function Menu.update(dt)
end

function Menu.draw()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Math-eroids Menu", 0, sh*0.2, sw, "center")
    
    for i, option in ipairs(Menu.options) do
        local y = sh*0.35 + i*50
        if i == Menu.currentSelection then
            love.graphics.setColor(1, 1, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.printf(option, 0, y, sw, "center")
    end
end

function Menu.keypressed(key)
    if key == "up" then
        Menu.currentSelection = Menu.currentSelection - 1
        if Menu.currentSelection < 1 then Menu.currentSelection = #Menu.options end
    elseif key == "down" then
        Menu.currentSelection = Menu.currentSelection + 1
        if Menu.currentSelection > #Menu.options then Menu.currentSelection = 1 end
    elseif key == "return" or key == "enter" then
        if Menu.currentSelection == 1 then
            -- Start game
            if love.math then love.math.setRandomSeed(os.time()) end
            currentScreen = "game"
            resetGame()  -- call function from Math_Problem.lua
        elseif Menu.currentSelection == 2 then
            currentScreen = "instructions"
        elseif Menu.currentSelection == 3 then
            currentScreen = "leaderboard"
        elseif Menu.currentSelection == 4 then
            love.event.quit()
        end
    end
end

return Menu