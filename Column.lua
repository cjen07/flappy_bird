Column = Class{}

function Column:init(x, width)
    self.x = x
    self.width = width
    self.h1 = math.random(20, VIRTUAL_HEIGHT - 200)
    self.h2 = self.h1 + math.random(70, 180)
    self.dx = -10
    self.scored = false
end

function Column:update(dt)
    if self.x <= -self.width then
        self.x = VIRTUAL_WIDTH
        self.h1 = math.random(20, VIRTUAL_HEIGHT - 200)
        self.h2 = self.h1 + math.random(70, 180)
        self.scored = false
    else
        self.x = self.x + self.dx * dt
    end 
end

function Column:reset(x)
    self.x = x
    self.h1 = math.random(20, VIRTUAL_HEIGHT - 200)
    self.h2 = self.h1 + math.random(70, 180)
    self.scored = false
end

function Column:render()
    love.graphics.rectangle('fill', self.x, 0, self.width, self.h1)
    love.graphics.rectangle('fill', self.x, self.h2, self.width, VIRTUAL_HEIGHT)
end