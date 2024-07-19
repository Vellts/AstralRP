local function drawVelocimeter()
    drawBadges()
    drawVehicleVelocity()
    healthVehicle()
    updateSvgs()
end
addEvent("vel::draw", true)
addEventHandler("vel::draw", root, drawVelocimeter)

local function drawVelocimeter()
    removeHud()
end
addEvent("vel::remove", true)
addEventHandler("vel::remove", root, drawVelocimeter)