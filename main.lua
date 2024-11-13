
-- Define global variables
local titleFont, buttonFont
local fadeAlpha = 0
local titleScale = 1
local buttons = {}
local currentButton = 1

function love.load()
    anim8 = require 'libs/anim8'
    sprites = {}
    sprites.backgroundSheet = love.graphics.newImage('sprites/main_menu_background-spritesheet.png')
    local grid = anim8.newGrid(800, 600, sprites.backgroundSheet:getWidth(), sprites.backgroundSheet:getHeight())

    WINDOW_WIDTH = love.graphics.getWidth()
    WINDOW_HEIGHT = love.graphics.getHeight()

    -- Load custom fonts
    titleFont = love.graphics.newFont('fonts/newRocker.ttf',64)  -- Adjust font size as needed
    buttonFont = love.graphics.newFont('fonts/newRocker.ttf', 32)

    animations = {}
    animations.background = anim8.newAnimation(grid('1-10','1-9'), 0.05)

    buttons = {
        {text = "Start Game", action = startGame},
        {text = "Load Game", action = loadGame},
        {text = "Settings", action = settings},
        {text = "Exit", action = exitGame}
    }

    fadeAlpha = 1  -- Full opacity for initial fade-in effect

end


function love.update(dt)
    animations.background:update(dt)

    -- Simulate fade-in effect for the title
    if fadeAlpha < 1 then
        fadeAlpha = fadeAlpha + dt * 0.5
    end
end


function love.draw()

    animations.background:draw(sprites.backgroundSheet, 0, 0)
    love.graphics.setColor(1, 1, 1, fadeAlpha)  -- White with fading alpha
    love.graphics.setFont(titleFont)
    -- love.graphics.printf('Elements of the Five', 0, WINDOW_HEIGHT, WINDOW_WIDTH, 'center')
    love.graphics.printf('Elements of the Five', 100, 100, love.graphics.getWidth(), "left", 0, 1, 1)


    -- Draw the buttons
    love.graphics.setFont(buttonFont)
    for i, button in ipairs(buttons) do
        if i == currentButton then
            love.graphics.setColor(0.8, 0.8, 0.8)  -- Highlight selected button
        else
            love.graphics.setColor(1, 1, 1)  -- Normal color for other buttons
        end

        -- Draw each button centered horizontally and spaced vertically
        love.graphics.printf(button.text, 100, (love.graphics.getHeight() / 2 + (i - 1) * 60) - 80, love.graphics.getWidth(), "left")
    end
end

-- Handle key press for navigation between buttons
function love.keypressed(key)
    if key == "up" then
        currentButton = currentButton - 1
        if currentButton < 1 then currentButton = #buttons end
    elseif key == "down" then
        currentButton = currentButton + 1
        if currentButton > #buttons then currentButton = 1 end
    elseif key == "return" then
        buttons[currentButton].action()
    end
end


-- Start Game button action
function startGame()
    print("Starting the game...")
end

-- Load Game button action
function loadGame()
    print("Loading a saved game...")
end

-- Settings button action
function settings()
    print("Opening settings...")
end

-- Exit Game button action
function exitGame()
    love.event.quit()  -- Exit the game
end