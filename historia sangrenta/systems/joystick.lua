local joystick = {}

-- Configuração
joystick.x = 100
joystick.y = 500

joystick.radius = 50
joystick.knobRadius = 20

-- Estado
joystick.active = false
joystick.touchId = nil

joystick.dx = 0
joystick.dy = 0


function joystick.draw()

    if love.system.getOS() ~= "Android" and love.system.getOS() ~= "iOS" then
        return
    end

    -- Base do joystick
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.circle(
        "line",
        joystick.x,
        joystick.y,
        joystick.radius
    )

    -- Bolinha do joystick
    local knobX = joystick.x + joystick.dx * joystick.radius
    local knobY = joystick.y + joystick.dy * joystick.radius

    love.graphics.circle(
        "fill",
        knobX,
        knobY,
        joystick.knobRadius
    )

end


function joystick.touchpressed(x, y, id)

    local distance = math.sqrt(
        (x - joystick.x) ^ 2 +
        (y - joystick.y) ^ 2
    )

    if distance <= joystick.radius then
        joystick.active = true
        joystick.touchId = id

        joystick.updatePosition(x, y)
    end

end


function joystick.touchmoved(x, y, id)

    if joystick.active and joystick.touchId == id then
        joystick.updatePosition(x, y)
    end

end


function joystick.touchreleased(id)

    if joystick.active and joystick.touchId == id then
        joystick.active = false
        joystick.touchId = nil

        joystick.dx = 0
        joystick.dy = 0
    end

end


function joystick.updatePosition(x, y)

    local dx = x - joystick.x
    local dy = y - joystick.y

    local distance = math.sqrt(dx * dx + dy * dy)

    if distance > joystick.radius then
        dx = dx / distance
        dy = dy / distance

        joystick.dx = dx
        joystick.dy = dy
    else
        joystick.dx = dx / joystick.radius
        joystick.dy = dy / joystick.radius
    end

end


function joystick.getDirection()

    return joystick.dx, joystick.dy

end


return joystick