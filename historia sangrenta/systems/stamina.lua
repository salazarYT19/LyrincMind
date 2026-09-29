local Stamina = {}

Stamina.maxStamina = 100
Stamina.stamina = 100

Stamina.drain = 25
Stamina.recovery = 15

function Stamina.consume(amount)
    Stamina.stamina = Stamina.stamina - amount
    Stamina.stamina = math.max(0, Stamina.stamina)
end

function Stamina.restore(amount)
    Stamina.stamina = Stamina.stamina + amount
    Stamina.stamina = math.min(Stamina.maxStamina, Stamina.stamina)
end

return Stamina