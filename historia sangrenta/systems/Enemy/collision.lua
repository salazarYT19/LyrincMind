local Collision = {}



function Collision.check(a, b)
    return a.x < b.x + b.size and
            a.x + a.size > b.x and
            a.y< b.y + b.size and
            a.y + a.size > b.y
end

return Collision