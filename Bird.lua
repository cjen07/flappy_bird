Bird = Class{}

function Bird:init(width, height)
    self.x = VIRTUAL_WIDTH / 7 * 3 
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
    self.width = width
    self.height = height
    self.dy = 0
    self.ddy = 5
end

function Bird:collides(column)
    if self.x > column.x + column.width or column.x > self.x + self.width or self.y > column.h1 then
        if self.x > column.x + column.width or column.x > self.x + self.width or column.h2 > self.y + self.height then
            return false
        end
    end
    return true
end

function Bird:reset()
    self.x = VIRTUAL_WIDTH / 7 * 3 
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
    self.dy = 0
    self.ddy = 5
end

function Bird.update(dt)
    self.dy = self.dy + self.ddy * dt / 2
    self.y = self.y + self.dy * dt
end

function Bird:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end