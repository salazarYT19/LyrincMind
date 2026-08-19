local Player = require("player")
local World = require("world")
local Enemy = require("enemy")

local camera = {
    x = 0,
    y = 0
}

function love.load ()
    print("ESTOU EXECUTANDO O MEU JOGO!")

    love.window.setTitle ("A História Sangrenta")

    love.window.setMode (1280, 720)

    Player.load ()
    World.load ()
    Enemy.load ()
end

function love.update (dt)
    Player.update(dt)
    Enemy.update(dt)

    -- Câmera seguindo o jogador
    camera.x = Player.x - 1280 / 2
    camera.y = Player.y - 720 / 2

    -- Limites da câmera
    if camera.x < 0 then
        camera.x = 0
    end

    if camera.y < 0 then
        camera.y = 0
    end

    if camera.x > World.width - 1280 then
        camera.x = World.width - 1280
    end

    if camera.y > World.height - 720 then
        camera.y = World.height - 720
    end
end

function love.draw()
    love.graphics.push()

    -- Aplicar câmera
    love.graphics.translate(-camera.x, -camera.y)

    World.draw()
    Player.draw()
    Enemy.draw()

    love.graphics.pop()

    -- Interface
    love.graphics.setColor(1, 1, 1)

    love.graphics.print("A HISTÓRIA SANGRENTA", 20, 20)
    love.graphics.print("WASD - Mover", 20, 45)

    -- barra de stamina
    local barX =20
    local barY = 125
    local barwidth = 200
    local barheight = 20
    
    -- barra de vida

    local healthBarX = 20
    local healthBarY = 75
    local healthBarWidth = 200
    local healthBarHeight = 20

    -- fundo da barra de vida
    love.graphics.setColor(0.2, 0.2, 0.2)

    love.graphics.rectangle("fill", healthBarX, healthBarY, healthBarWidth, healthBarHeight)

    -- vida atual
    local healthWidth = healthBarWidth * (Player.health / Player.maxHealth)

    local healthPercent = Player.health / Player.maxHealth

    love.graphics.setColor(1 - healthPercent,healthPercent,0)

    love.graphics.rectangle("fill", healthBarX, healthBarY, healthWidth, healthBarHeight)

    --texto da barra de vida
    love.graphics.setColor(1, 1, 1)

    love.graphics.print("Vida: " .. math.floor(Player.health), healthBarX, healthBarY + 25)


    --fundo da barra
    love.graphics.setColor(0.2, 0.2, 0.2)

    love.graphics.rectangle("fill", barX, barY, barwidth, barheight)

    -- Stamina atual
    local staminaWidth = (Player.stamina / Player.maxStamina)

    local staminaPercent = Player.stamina / Player.maxStamina

    local r = 0.2 + (0.3 * (1 - staminaPercent))
    local g = 0.5 + (0.3 * staminaPercent)
    local b = 1.0

    love.graphics.setColor(r, g, b)

    love.graphics.rectangle("fill", barX, barY, staminaWidth * barwidth, barheight)

    --texto
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Stamina: " .. math.floor(Player.stamina), barX, barY + 25)

end

function love.keypressed(key)

    if key == "j" then
        Player.heal(10)
    end

    if key == "h" then
        Player.takeDamage(10)
    end

    if key == "r" and Player.health < Player.maxHealth then
        Player.x = 400
        Player.y = 300

        Player.health = Player.maxHealth
        Player.stamina = Player.maxStamina

        Player.isRunning = false
        Player.isCrouching = false
    end
end