local Player = require("player")
local World = require("world")
local Enemy = require("enemy")
local joystick = require("systems.joystick")
local Menu = require("systems.menu")
local HUD = require("systems.hud")
local Melee = require("systems.combat.melee")


local camera = {
    x = 0,
    y = 0
}

local gameState = "menu"

function love.load ()
    print("ESTOU EXECUTANDO O MEU JOGO!")
    love.window.setTitle("A Historia Sangrenta")
    love.window.setMode(1280, 720)

    Player.load()
    World.load()
    Enemy.load()
end

function love.update(dt)
    if gameState == "menu" then
        Menu.update(dt)
        return
    end

    Player.update(dt, Enemy)
    Enemy.update(dt, Player)

    camera.x = Player.x - 1280 / 2
    camera.y = Player.y - 720 / 2

    if camera.x < 0 then camera.x = 0 end
    if camera.y < 0 then camera.y = 0 end
    if camera.x > World.width - 1280 then
        camera.x = World.width - 1280
    end
    if camera.y > World.height - 720 then
        camera.y = World.height - 720
    end
end

function love.draw()
    if gameState == "menu" then
        Menu.draw()
        return
    end

    love.graphics.push()

    love.graphics.translate(-camera.x, -camera.y)

    World.draw()
    Player.draw()
    Enemy.draw()

    love.graphics.pop()

    joystick.draw()

    HUD.draw(Player)
end

function love.mousepressed(x, y, button)
    if gameState == "menu" then
        local action = Menu.mousepressed(x, y, button)

        if action == "start" then
            gameState = "game"
        end
    end
end

function love.keypressed(key)

    if key == "f" then
        Melee.attack(Player, Enemy)
    end


    if key == "j" then
        Player.heal(10)
    end

    if key == "h" then
        Player.takeDamage(10)
    end

    if key == "r" and Player.health < Player.maxHealth then
        Player.respawn()
    end


end

function love.touchpressed(id, x, y, dx, dy, pressure)
    if gameState == "menu" then
        local action = Menu.touchpressed(x, y)

        if action == "start" then
            gameState = "game"
        end

        return
    end

    joystick.touchpressed(x, y, id)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    joystick.touchmoved(x, y, id)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    joystick.touchreleased(id)
end