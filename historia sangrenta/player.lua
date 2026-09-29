local Health = require("systems.health")
local Stamina = require("systems.stamina")
local Movement = require("systems.movement_keyboard")
local Death = require("systems.death")


local Player = {}

-- Posição
Player.x = 400
Player.y = 300

-- Tamanho
Player.size = 32

-- Direção
Player.direction = "down"

-- Estados
Player.isRunning = false
Player.isCrouching = false

-- Vida
Player.healthSystem = Health.new(100)

Player.maxHealth = Player.healthSystem.maxHealth
Player.health = Player.healthSystem.health

-- Stamina
Player.maxStamina = Stamina.maxStamina
Player.stamina = Stamina.stamina

-- Dano para jogador

Player.attackDamage = 25
Player.attackRange = 60
Player.attackCooldown = 0.1
Player.attackDelay = 0.5


function Player.load()

end


function Player.update(dt, enemy)

    Player.attackCooldown = math.max(0, Player.attackCooldown - dt)

    -- Jogador morto
    if Player.healthSystem.isDead() then
        Death.die()
        Player.speed = 0
        return
    end

    -- Movimento
    Movement.update(Player, dt, enemy)

    -- Atualiza vida
    Player.health = Player.healthSystem.health
    Player.maxHealth = Player.healthSystem.maxHealth

    -- Atualiza stamina
    Player.stamina = Stamina.stamina
    Player.maxStamina = Stamina.maxStamina

end


function Player.takeDamage(amount)

    Player.healthSystem.takeDamage(amount)

    Player.health = Player.healthSystem.health

end


function Player.heal(amount)

    Player.healthSystem.heal(amount)

    Player.health = Player.healthSystem.health

end


function Player.respawn()

    Death.respawn(Player, Health, Stamina)

    Player.health = Player.healthSystem.health
    Player.maxHealth = Player.healthSystem.maxHealth

    Player.stamina = Stamina.stamina
    Player.maxStamina = Stamina.maxStamina

end


function Player.draw()

    local drawWidth = Player.size
    local drawHeight = Player.size

    -- Agachado fica mais baixo
    if Player.isCrouching then
        drawHeight = Player.size * 0.6
    end

    -- Jogador
    love.graphics.setColor(1, 1, 1)

    love.graphics.rectangle(
        "fill",
        Player.x,
        Player.y + (Player.size - drawHeight),
        drawWidth,
        drawHeight
    )

    -- Centro
    local centerX = Player.x + drawWidth / 2

    local centerY =
        Player.y +
        (Player.size - drawHeight) +
        drawHeight / 2

    -- Indicador da direção
    if Player.direction == "up" then

        love.graphics.rectangle(
            "fill",
            centerX - 4,
            Player.y - 8,
            8,
            8
        )

    elseif Player.direction == "down" then

        love.graphics.rectangle(
            "fill",
            centerX - 4,
            Player.y + Player.size,
            8,
            8
        )

    elseif Player.direction == "left" then

        love.graphics.rectangle(
            "fill",
            Player.x - 8,
            centerY - 4,
            8,
            8
        )

    elseif Player.direction == "right" then

        love.graphics.rectangle(
            "fill",
            Player.x + drawWidth,
            centerY - 4,
            8,
            8
        )

    elseif Player.direction == "up-left" then

        love.graphics.rectangle(
            "fill",
            Player.x - 6,
            Player.y - 6,
            8,
            8
        )

    elseif Player.direction == "up-right" then

        love.graphics.rectangle(
            "fill",
            Player.x + Player.size - 2,
            Player.y - 6,
            8,
            8
        )

    elseif Player.direction == "down-left" then

        love.graphics.rectangle(
            "fill",
            Player.x - 6,
            Player.y + Player.size - 2,
            8,
            8
        )

    elseif Player.direction == "down-right" then

        love.graphics.rectangle(
            "fill",
            Player.x + Player.size - 2,
            Player.y + Player.size - 2,
            8,
            8
        )

    end

end


return Player