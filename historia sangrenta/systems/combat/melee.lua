local Melee = {}

function Melee.attack(player, enemy)

    if not enemy then
        return
    end

    local dx = enemy.x - player.x
    local dy = enemy.y - player.y

    local distance = math.sqrt(dx * dx + dy * dy)

    if distance <= 100 and enemy.health > 0 then
        enemy.health = enemy.health - 25

        if enemy.health <= 0 then
            enemy.health = 0
            enemy.isDead = true
        end
    end

end

return Melee