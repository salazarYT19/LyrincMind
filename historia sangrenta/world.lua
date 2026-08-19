local World = {}

function World.load()
    World.width = 2000
    World.height = 1200
end

function World.draw()
    -- Fundo
    love.graphics.setColor(0.08, 0.08, 0.08)

    love.graphics.rectangle(
        "fill",
        0,
        0,
        World.width,
        World.height
    )

    -- Grade do chão
    love.graphics.setColor(0.12, 0.12, 0.12)

    for x = 0, World.width, 50 do
        love.graphics.line(x, 0, x, World.height)
    end

    for y = 0, World.height, 50 do
        love.graphics.line(0, y, World.width, y)
    end

    love.graphics.setColor(1, 1, 1)
end

return World