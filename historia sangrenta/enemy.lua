local Player = require("player")
local Enemy = {}


Enemy.x = 700
Enemy.y = 400
Enemy.size = 40

Enemy.maxHealth = 100
Enemy.health = 100

function Enemy.load()

end

function Enemy.update(dt)
    -- código da colisão aqui


end

function Enemy.update(dt)

    if Player.x < Enemy.x + Enemy.size
    and Player.x + Player.size > Enemy.x
    and Player.y < Enemy.y + Enemy.size
    and Player.y + Player.size > Enemy.y then

        Enemy.touchingPlayer = true

    else

        Enemy.touchingPlayer = false

    end

end

function Enemy.draw()
    
    --corpo do inimigo
    love.graphics.setColor(0.8, 0.1, 0.1) -- vermelho

    love.graphics.rectangle("fill", Enemy.x, Enemy.y, Enemy.size, Enemy.size)

    -- barra de vida do inimigo
    love.graphics.setColor(0.2, 0.2, 0.2) -- fundo da barra de vida 

    love.graphics.rectangle("fill", Enemy.x, Enemy.y - 10, Enemy.size, 5) -- fundo da barra de vida

    local healthWidth = Enemy.size * (Enemy.health / Enemy.maxHealth)
    
    love.graphics.setColor(1, 1, 1) -- cor da barra de vida (branco)

    if Enemy.touchingPlayer then
        love.graphics.setColor(1, 1, 0)

        love.graphics.print("COLIDIU", Enemy.x, Enemy.y - 30 )
        

        love.graphics.setColor(1, 1, 1)
    end

end

return Enemy