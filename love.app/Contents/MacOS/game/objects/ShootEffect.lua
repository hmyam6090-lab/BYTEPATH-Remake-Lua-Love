ShootEffect = GameObject:extend()

function ShootEffect:new()
    Player.super.new(self, area, x, y, opts)
end

function ShootEffect:update()
    ShootEffect.super.update(self, dt)
end

function ShootEffect:draw()

end

function ShootEffect:destroy()
    ShootEffect.super.destroy()
end
