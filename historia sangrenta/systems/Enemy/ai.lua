local AI = {}

local Collision = require("systems.Enemy.collision")

local attackCooldown = 0
local attackDelay = 0.8

function AI.update(enemy, player, dt)

    attackCooldown = attackCooldown - dt

    local enemyCenterX = enemy.x + enemy.size / 2
    local enemyCenterY = enemy.y + enemy.size / 2

    local playerCenterX = player.x + player.size / 2
    local playerCenterY = player.y + player.size / 2

    local dx = playerCenterX - enemyCenterX
    local dy = playerCenterY - enemyCenterY

    local distance = math.sqrt(dx * dx + dy * dy)
    
    local attackDistance = 50


    if distance > 0 then

        local directionX = dx / distance
        local directionY = dy / distance

        if distance <= attackDistance then
            enemy.isAttacking = true

            if attackCooldown<= 0 then
                player.takeDamage(10)
                attackCooldown = attackDelay
            end
        else
            enemy.isAttacking = false
        end

        if distance > attackDistance then
            -- movimento X
            local nextX = enemy.x + directionX * 80 * dt
            local oldX = enemy.x

            enemy.x = nextX
            
            if Collision.check(enemy, player) then
                enemy.x = oldX
            end
            -- movimento Y 
            local nextY = enemy.y + directionY * 80 * dt
            local oldY = enemy.y
            
            enemy.y = nextY

            if Collision.check(enemy, player) then
                enemy.y = oldY
            end

        end

    end

end

return AI