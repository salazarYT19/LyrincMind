local Health = {}

function Health.new(maxHealth)

    local self = {}

    self.maxHealth = maxHealth or 100
    self.health = self.maxHealth

    function self.takeDamage(amount)
        self.health = self.health - amount
        self.health = math.max(0, self.health)
    end

    function self.heal(amount)
        self.health = self.health + amount
        self.health = math.min(self.maxHealth, self.health)
    end

    function self.isDead()
        return self.health <= 0
    end

    return self
end

return Health