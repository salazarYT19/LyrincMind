local HUD = {}

function HUD.draw(player)

    love.graphics.push()

    -- =========================
    -- POSIÇÃO E TAMANHO DA HUD
    -- =========================

    local hudX = 25
    local hudY = 25

    local barWidth = 300
    local barHeight = 28

    -- =========================
    -- TÍTULO
    -- =========================

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "A HISTORIA SANGRENTA",
        hudX,
        hudY
    )

    love.graphics.print(
        "WASD - Move",
        hudX,
        hudY + 30
    )

    -- =========================
    -- VIDA
    -- =========================

    local health = player.health or 0
    local maxHealth = player.maxHealth or 100

    local healthPercent = health / maxHealth

    -- Impede a barra de passar dos limites
    healthPercent = math.max(0, math.min(1, healthPercent))

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "Vida: " .. math.floor(health) .. " / " .. math.floor(maxHealth),
        hudX,
        hudY + 65
    )

    -- Fundo da barra
    love.graphics.setColor(0.15, 0.15, 0.15)

    love.graphics.rectangle(
        "fill",
        hudX,
        hudY + 90,
        barWidth,
        barHeight
    )

    -- Barra de vida
    love.graphics.setColor(1, 0, 0)

    love.graphics.rectangle(
        "fill",
        hudX,
        hudY + 90,
        barWidth * healthPercent,
        barHeight
    )

    -- =========================
    -- STAMINA
    -- =========================

    local stamina = player.stamina or 0
    local maxStamina = player.maxStamina or 100

    local staminaPercent = stamina / maxStamina

    staminaPercent = math.max(0, math.min(1, staminaPercent))

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "Stamina: " .. math.floor(stamina) .. " / " .. math.floor(maxStamina),
        hudX,
        hudY + 130
    )

    -- Fundo da barra
    love.graphics.setColor(0.15, 0.15, 0.15)

    love.graphics.rectangle(
        "fill",
        hudX,
        hudY + 155,
        barWidth,
        barHeight
    )

    -- Barra de stamina
    love.graphics.setColor(0.2, 0.6, 1)

    love.graphics.rectangle(
        "fill",
        hudX,
        hudY + 155,
        barWidth * staminaPercent,
        barHeight
    )

    love.graphics.pop()
end

return HUD