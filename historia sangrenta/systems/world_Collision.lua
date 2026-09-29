local WorldCollision = {}

function WorldCollision.check(a, b)

    return
        a.x < b.x + bwidth and
        ax + a.size > b.x and
        ay < b.y + b.height and
        a.y + a.size > b.Y
    end

return WorldCollision