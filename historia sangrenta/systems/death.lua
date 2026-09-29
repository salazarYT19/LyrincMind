local Death = {}

Death.isDead = false

Death.respawnX = 400
Death.respawnY = 300

function Death.die()
    Death.isDead = true
end

function Death.respawn(Player, Health, Stamina)

    Death.isDead = false

    Player.x = Death.respawnX
    Player.y = Death.respawnY

    Player.healthSystem.health = Player.healthSystem.maxHealth
    Stamina.stamina = Stamina.maxStamina

    Player.isRunning = false
    Player.isCrouching = false
    Player.speed = Player.walkSpeed
end

return Death