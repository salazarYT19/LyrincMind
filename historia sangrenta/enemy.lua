local Collision = require("systems.enemy.collision")
local AI = require("systems.enemy.ai")

local Enemy = {}


Enemy.x = 700
Enemy.y = 400
Enemy.size = 40

Enemy.maxHealth = 100
Enemy.isDead = false
Enemy.health = 100

function Enemy.load()

end

function Enemy.update(dt, player)

    if Enemy.isDead then
        return
    end


    AI.update(Enemy,player, dt)
    if not Enemy.isDead then
        Enemy.touchingPlayer= Collision.check(player, Enemy)
    end
end

function Enemy.draw()
    
    if Enemy.isDead then
        return
    end

    --corpo do inimigo
    love.graphics.setColor(0.8, 0.1, 0.1) -- vermelho

    love.graphics.rectangle("fill", Enemy.x, Enemy.y, Enemy.size, Enemy.size)

    -- barra de vida do inimigo
    love.graphics.setColor(0.2, 0.2, 0.2) -- fundo da barra de vida 

    love.graphics.rectangle("fill", Enemy.x, Enemy.y - 10, Enemy.size, 5) -- fundo da barra de vida

    local healthWidth = Enemy.size * (Enemy.health / Enemy.maxHealth)

    love.graphics.setColor(1, 1, 1) -- cor da barra de vida (branco)

    love.graphics.rectangle("fill", Enemy.x, Enemy.y - 10, healthWidth, 5)

    if Enemy.touchingPlayer then
        love.graphics.setColor(1, 1, 0)

        love.graphics.print("COLIDIU", Enemy.x, Enemy.y - 30 )


        love.graphics.setColor(1, 1, 1)
    end

end

return Enemy