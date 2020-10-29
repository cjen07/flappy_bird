push = require 'push'
Class = require 'class'
require 'Column'
require 'Bird'

WINDOW_WIDTH = 600
WINDOW_HEIGHT = 1000
VIRTUAL_WIDTH = 300
VIRTUAL_HEIGHT = 500

SPEED = 4

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird')
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    column1 = Column(350, 50)
    column2 = Column(500, 50)

    bird = Bird(20, 20)

    score = 0
    gameState = 'start'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if gameState == 'play' then
        if bird:collides(column1) or bird:collides(column2) or bird.y <= 0 or bird.y + bird.height >= VIRTUAL_HEIGHT then
            gameState = 'done'
            column1:reset(350)
            column2:reset(500)
            bird:reset()
        end
        if column1.x + column1.width < bird.x and column1.scored == false then
            score = score + 1
            column1.scored = true
        end
        if column2.x + column2.width < bird.x and column2.scored == false then
            score = score + 1
            column2.scored = true
        end
    end

    if love.keyboard.isDown('space') then
        bird.dy = bird.dy - SPEED
    end

    if gameState == 'play' then
        bird:update(dt)
        column1:update(dt)
        column2:update(dt)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'space' then
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'play'
            score = 0
        end
    end
end

function love.draw()
    push:start()
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    if gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Flappy Bird!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Space to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Final score is ' .. tostring(score), 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Space to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    end
    displayScore()
    column1:render()
    column2:render()
    bird:render()
    displayFPS()
    push:finish()
end

function displayScore()
    -- score display
    love.graphics.setFont(scoreFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print(tostring(score), VIRTUAL_WIDTH - 50, 50)
    love.graphics.setColor(255, 255, 255, 255)
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(255, 255, 255, 255)
end