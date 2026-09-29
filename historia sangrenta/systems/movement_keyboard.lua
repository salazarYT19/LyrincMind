local World = require("world")
local Stamina = require("systems.stamina")
local Joystick = require("systems.joystick")
local Collision = require("systems.Enemy.collision")
local Controls = require("systems.controls")
local WorldCollision = require("systems.world_Collision")

local Movement = {}

Movement.walkSpeed = 200
Movement.runSpeed = 350
Movement.crouchSpeed = 100

Movement.staminaDrain = 25


function Movement.update(player, dt, enemy)

    local dx = 0
    local dy = 0

    -- =========================
    -- TECLADO
    -- =========================

    if love.keyboard.isDown(Controls.up) then
        dy = dy - 1
    end

    if love.keyboard.isDown(Controls.down) then
        dy = dy + 1
    end

    if love.keyboard.isDown(Controls.left) then
        dx = dx - 1
    end

    if love.keyboard.isDown(Controls.right) then
        dx = dx + 1
    end


    -- =========================
    -- JOYSTICK
    -- =========================

    local joystickX, joystickY = Joystick.getDirection()

    if joystickX ~= 0 or joystickY ~= 0 then
        dx = joystickX
        dy = joystickY
    end


    -- =========================
    -- DIREÇÃO
    -- =========================

    if dx == 0 and dy < 0 then
        player.direction = "up"

    elseif dx == 0 and dy > 0 then
        player.direction = "down"

    elseif dx < 0 and dy == 0 then
        player.direction = "left"

    elseif dx > 0 and dy == 0 then
        player.direction = "right"

    elseif dx < 0 and dy < 0 then
        player.direction = "up-left"

    elseif dx > 0 and dy < 0 then
        player.direction = "up-right"

    elseif dx < 0 and dy > 0 then
        player.direction = "down-left"

    elseif dx > 0 and dy > 0 then
        player.direction = "down-right"
    end


    -- =========================
    -- ESTADOS
    -- =========================

    player.isRunning = false
    player.isCrouching = false

    player.speed = Movement.walkSpeed


    -- =========================
    -- AGACHAR
    -- =========================

    if love.keyboard.isDown(Controls.crouch) then

        player.isCrouching = true
        player.speed = Movement.crouchSpeed


    -- =========================
    -- CORRER
    -- =========================

    elseif love.keyboard.isDown(Controls.run)
        and Stamina.stamina > 0
        and (dx ~= 0 or dy ~= 0) then

        player.isRunning = true
        player.speed = Movement.runSpeed

    end


    -- =========================
    -- STAMINA
    -- =========================

    if player.isRunning then

        Stamina.consume(
            Stamina.drain * dt
        )

    else

        Stamina.restore(
            Stamina.recovery * dt
        )

    end


    -- =========================
    -- MOVIMENTO
    -- =========================

    local length = math.sqrt(dx * dx + dy * dy)

    if length > 0 then

        dx = dx / length
        dy = dy / length

        dx = dx * player.speed * dt
        dy = dy * player.speed * dt

    end

    local newX = player.x + dx
    local newY = player.y + dy

    local testPlayer = {
        x = newX,
        y = player.y,
        size = player.size
    }
    
    if enemy.isDead or not Collision.check(testPlayer, enemy) then

      local canMoveX = true

      for _, obstacle in ipairs(World.obstacles) do
          if WorldCollision.check(testPlayer, obstacle) then
              canMoveX = false
               break
        end
    end

    if canMoveX then
        player.x = newX
    end



    testPlayer.x = player.x
    testPlayer.y = newY

    if enemy.isDead or not Collision.check(testPlayer, enemy) then

     local canMoveX = true

      for _, obstacle in ipairs(World.obstacles) do
          if WorldCollision.check(testPlayer, obstacle) then
              canMoveX = false
               break
           end
       end

       if canMoveX then
           player.x = newX
       end

    end

    testPlayer.x = player.x
    testPlayer.y = newY

    if enemy.isDead or not Collision.check(testPlayer, enemy) then

      local canMoveY = true

      for _, obstacle in ipairs(World.obstacles) do
          if WorldCollision.check(testPlayer, obstacle) then
              canMoveY = false
              break
          end
      end

     if canMoveY then
         player.y = newY
      end

    end

    testPlayer.x = player.x
    testPlayer.y = newY

    if enemy.isDead or not Collision.check(testPlayer, enemy) then
        player.y = newY
    end


    -- =========================
    -- LIMITES DO MUNDO
    -- =========================

    player.x = math.max(0, player.x)
    player.x = math.min(
        World.width - player.size,
        player.x
    )

    player.y = math.max(0, player.y)
    player.y = math.min(
        World.height - player.size,
        player.y
    )

end


return Movement