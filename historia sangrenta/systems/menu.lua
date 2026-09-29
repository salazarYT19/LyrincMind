local Menu = {}

function Menu.update(dt)
end

function Menu.draw()

    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle(
        "fill",
        0,
        0,
        love.graphics.getWidth(),
        love.graphics.getHeight()
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "A HISTORIA SANGRENTA",
        0,
        180,
        love.graphics.getWidth(),
        "center"
    )

    love.graphics.printf(
        "INICIAR",
        0,
        350,
        love.graphics.getWidth(),
        "center"
    )

end

function Menu.mousepressed(x, y, button)

    if button == 1 then

        local screenWidth = love.graphics.getWidth()

        if y >= 330 and y <= 390 then
            return "start"
        end

    end

    return nil
end

function Menu.touchpressed(x, y)

    if y >= 330 and y <= 390 then
        return "start"
    end

    return nil
end

return Menu