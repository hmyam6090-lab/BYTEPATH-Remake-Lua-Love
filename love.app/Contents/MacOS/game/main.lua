Object = require 'libraries/classic/classic'

function love.load()
    frame = 0
end

function love.update(dt)
    frame = frame + 1
    print(frame)
end

function love.draw()
    love.graphics.print(frame, 400, 300)
end
