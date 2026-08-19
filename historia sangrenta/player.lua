local World = require("world")

local Player = {}

-- Posição
Player.x = 400
Player.y = 300

-- Velocidades
Player.walkSpeed = 200
Player.runSpeed = 350
Player.crouchSpeed = 100

-- Tamanho
Player.size = 32

-- Direção
Player.direction = "down"

-- Estados
Player.isRunning = false
Player.isCrouching = false

-- Stamina
Player.maxStamina = 100
Player.stamina = 100

Player.staminaDrain = 25
Player.staminaRecovery = 15

-- vida
Player.maxHealth = 100
Player.health = 100

function Player.takeDamage(amount)
    Player.health = Player.health - amount
    
    Player.health = math.max(0, Player.health)

end

function Player.heal(amount)

    Player.health = Player.health + amount

    Player.health = math.min(Player.maxHealth, Player.health)

end

function Player.move(dx, dy, dt)

    local length = math.sqrt(dx * dx + dy * dy)

    -- Normaliza o movimento
    if length > 0 then
        dx = dx / length
        dy = dy / length

        dx = dx * Player.speed * dt
        dy = dy * Player.speed * dt
    end

    Player.x = Player.x + dx
    Player.y = Player.y + dy


    -- Limites horizontais
    Player.x = math.max(0, Player.x)
    Player.x = math.min(World.width - Player.size, Player.x)

    -- Limites verticais
    Player.y = math.max(0, Player.y)
    Player.y = math.min(World.height - Player.size, Player.y)

end


function Player.load()
end


function Player.update(dt)

    local dx = 0
    local dy = 0

    --Jorgador morto
    if Player.health <= 0 then
        Player.speed = 0
        return
    end

    --------------------------------------------------
    -- MOVIMENTO
    --------------------------------------------------

    if love.keyboard.isDown("w") then
        dy = dy - 1
    end

    if love.keyboard.isDown("s") then
        dy = dy + 1
    end

    if love.keyboard.isDown("a") then
        dx = dx - 1
    end

    if love.keyboard.isDown("d") then
        dx = dx + 1
    end


    --------------------------------------------------
    -- DIREÇÃO
    --------------------------------------------------

    if dx == 0 and dy < 0 then
        Player.direction = "up"

    elseif dx == 0 and dy > 0 then
        Player.direction = "down"

    elseif dx < 0 and dy == 0 then
        Player.direction = "left"

    elseif dx > 0 and dy == 0 then
        Player.direction = "right"

    elseif dx < 0 and dy < 0 then
        Player.direction = "up-left"

    elseif dx > 0 and dy < 0 then
        Player.direction = "up-right"

    elseif dx < 0 and dy > 0 then
        Player.direction = "down-left"

    elseif dx > 0 and dy > 0 then
        Player.direction = "down-right"
    end


    --------------------------------------------------
    -- ESTADOS
    --------------------------------------------------

    Player.isRunning = false
    Player.isCrouching = false


    -- Agachar
    if love.keyboard.isDown("lctrl", "rctrl") then

        Player.isCrouching = true
        Player.speed = Player.crouchSpeed


    -- Correr
    elseif love.keyboard.isDown("lshift", "rshift")
        and Player.stamina > 0
        and (dx ~= 0 or dy ~= 0) then

        Player.isRunning = true
        Player.speed = Player.runSpeed


    -- Andar normalmente
    else

        Player.speed = Player.walkSpeed

    end


    --------------------------------------------------
    -- STAMINA
    --------------------------------------------------

    if Player.isRunning then

        Player.stamina =
            Player.stamina - Player.staminaDrain * dt

    else

        Player.stamina =
            Player.stamina + Player.staminaRecovery * dt

    end


    -- Limita a stamina entre 0 e 100
    Player.stamina = math.max(0, Player.stamina)
    Player.stamina = math.min(Player.maxStamina, Player.stamina)

    --------------------------------------------------
    -- MOVIMENTAR
    --------------------------------------------------

    Player.move(dx, dy, dt)

end


function Player.draw()

    --------------------------------------------------
    -- TAMANHO DO PERSONAGEM
    --------------------------------------------------

    local drawWidth = Player.size
    local drawHeight = Player.size


    -- Agachado fica mais baixo
    if Player.isCrouching then

        drawHeight = Player.size * 0.6

    end


    --------------------------------------------------
    -- DESENHAR JOGADOR
    --------------------------------------------------

    love.graphics.setColor(1, 1, 1)

    love.graphics.rectangle(
        "fill",
        Player.x,
        Player.y + (Player.size - drawHeight),
        drawWidth,
        drawHeight
    )


    --------------------------------------------------
    -- CENTRO DO JOGADOR
    --------------------------------------------------

    local centerX =
        Player.x + drawWidth / 2

    local centerY =
        Player.y +
        (Player.size - drawHeight) +
        drawHeight / 2


    --------------------------------------------------
    -- INDICADOR DA DIREÇÃO
    --------------------------------------------------

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