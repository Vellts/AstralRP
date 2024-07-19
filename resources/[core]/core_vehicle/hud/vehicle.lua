local stateSvg = {
    key = false,
    lights = 0,
    handBrake = false,
    cinturon = false
}

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function getVehicleRPM(vehicle)
    local vehicleRPM = 0
    if (vehicle) then
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then
                vehicleRPM = math.floor(((getElementSpeed(vehicle, "km/h") / getVehicleCurrentGear(vehicle)) * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            else
                vehicleRPM = math.floor((getElementSpeed(vehicle, "km/h") * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            end
        else
            vehicleRPM = 0
        end

        return tonumber(vehicleRPM)
    else
        return 0
    end
end

function getVehicleSpeed(vehicle)
    local velX, velY, velZ = getElementVelocity(vehicle)
    return math.sqrt( (velX * velX) + (velY * velY) + (velZ * velZ) ) * 184
end

function isVehicleReversing(theVehicle)
    local getMatrix = getElementMatrix (theVehicle)
    local getVelocity = Vector3 (getElementVelocity(theVehicle))
    local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3])
    if (getVectorDirection < 0) then
        return true
    end
    return false
end

stringGetVehicleSpeed = [[
    local function getVehicleSpeed(vehicle)
        local velX, velY, velZ = getElementVelocity(vehicle)
        return math.sqrt( (velX * velX) + (velY * velY) + (velZ * velZ) ) * 184
    end

    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (not vehicle) then return end
    local speed = math.ceil(getVehicleSpeed(vehicle))
    dgsSetText(self, speed)
]]

stringGetVehicleRpm = [[
    local function getElementSpeed(theElement, unit)
        -- Check arguments for errors
        assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
        local elementType = getElementType(theElement)
        assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
        assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
        -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
        unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
        -- Setup our multiplier to convert the velocity to the specified unit
        local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
        -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
        return (Vector3(getElementVelocity(theElement)) * mult).length
    end
    local function getVehicleRPM(vehicle)
        local vehicleRPM = 0
        if (vehicle) then
            if (getVehicleEngineState(vehicle) == true) then
                if getVehicleCurrentGear(vehicle) > 0 then
                    vehicleRPM = math.floor(((getElementSpeed(vehicle, "km/h") / getVehicleCurrentGear(vehicle)) * 160) + 0.5)
                    if (vehicleRPM < 650) then
                        vehicleRPM = math.random(650, 750)
                    elseif (vehicleRPM >= 9000) then
                        vehicleRPM = math.random(9000, 9900)
                    end
                else
                    vehicleRPM = math.floor((getElementSpeed(vehicle, "km/h") * 160) + 0.5)
                    if (vehicleRPM < 650) then
                        vehicleRPM = math.random(650, 750)
                    elseif (vehicleRPM >= 9000) then
                        vehicleRPM = math.random(9000, 9900)
                    end
                end
            else
                vehicleRPM = 0
            end

            return tonumber(vehicleRPM)
        else
            return 0
        end
    end

    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (not vehicle) then return end
    local rpm = getVehicleRPM(vehicle)
    if (rpm >= 4000) then
        dgsSetProperty(self, "textColor", tocolor(208, 125, 125, 255))
    else
        dgsSetProperty(self, "textColor", tocolor(255, 255, 255, 255))
    end
    dgsSetText(self, rpm)
]]

stringGetVehicleGear = [[
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (not vehicle) then return end
    local function isVehicleReversing(theVehicle)
        local getMatrix = getElementMatrix (theVehicle)
        local getVelocity = Vector3 (getElementVelocity(theVehicle))
        local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3])
        if (getVectorDirection < 0) then
            return true
        end
        return false
    end
    local gear = getVehicleCurrentGear(vehicle)
    if (isVehicleReversing(vehicle)) then
        gear = "R"
    elseif (gear == 0) then
        gear = "N"
    end
    dgsSetText(self, gear)
]]

stringGetVehicleHealth = [[
    local args = {...}
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (not vehicle) then return end
    local health = getElementHealth(vehicle)
    local vehicleHealth = math.floor((health/1000)*100)


    local inverseHealth = 100 - vehicleHealth
    if (inverseHealth <= 10) then
        local svgDoc = dgsSVGGetDocument(args[1])
        dgsSVGNodeSetAttribute(svgDoc, "stroke", "#FFFFFF")
    else
        local svgDoc = dgsSVGGetDocument(args[1])
        dgsSVGNodeSetAttribute(svgDoc, "stroke", "#FFB7B7")
        dgsSVGNodeSetAttribute(svgDoc, "stroke-opacity", tostring(inverseHealth/100))
    end

    dgsSetText(self, vehicleHealth.."%")
]]

function svgChangeKeyState(state, vehicle)
    local svg = svgs.svgK
    local svgDoc = dgs:dgsSVGGetDocument(svg)
    stateSvg.key = state
    stateHud(vehicle)
    if (stateSvg.key) then
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#A8FF93")
    else
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#FFFFFF")
    end
end
addEvent("core_vehicle::svgChangeKeyState", true)
addEventHandler("core_vehicle::svgChangeKeyState", root, svgChangeKeyState)

function svgChangeLightsState(mode)
    local svg = svgs.svgL
    local svgDoc = dgs:dgsSVGGetDocument(svg)
    stateSvg.lights = mode
    if (stateSvg.lights == 0) then
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#FFFFFF")
    elseif (stateSvg.lights == 1) then
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#FFD700")
    elseif (stateSvg.lights == 2) then
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#FF7E7E")
    end
end
addEvent("core_vehicle::svgChangeLightsState", true)
addEventHandler("core_vehicle::svgChangeLightsState", root, svgChangeLightsState)

function svgChangeHandBrakeState(status)
    local svg = svgs.svgHB
    local svgDoc = dgs:dgsSVGGetDocument(svg)
    stateSvg.handBrake = status
    if (stateSvg.handBrake) then
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#FF7E7E")
    else
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#FFFFFF")
    end
end
addEvent("core_vehicle::svgChangeHandBrakeState", true)
addEventHandler("core_vehicle::svgChangeHandBrakeState", root, svgChangeHandBrakeState)

function svgChangeCinturonState(status)
    local svg = svgs.svgC
    local svgDoc = dgs:dgsSVGGetDocument(svg)
    stateSvg.cinturon = status
    if (stateSvg.cinturon) then
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#A8FF93")
    else
        dgs:dgsSVGNodeSetAttribute(svgDoc, "fill", "#FFFFFF")
    end
end
addEvent("core_vehicle::svgChangeCinturonState", true)
addEventHandler("core_vehicle::svgChangeCinturonState", root, svgChangeCinturonState)

function stateHud(vehicle)
    if (not vehicle) then return end

    local getEngineState = getVehicleEngineState(vehicle)
    
    -- set all the elements to 0.3 opacity
    local getElements = dgs:dgsGetElementsFromResource()
    for i, element in ipairs(getElements) do
        if (not getEngineState) then
            dgs:dgsSetProperty(element, "alpha", 0.3)
        else
            dgs:dgsSetProperty(element, "alpha", 0.8)
        end
    end

end

function updateSvgs()
    svgChangeKeyState(stateSvg.key)
    svgChangeLightsState(stateSvg.lights)
    svgChangeHandBrakeState(stateSvg.handBrake)
    svgChangeCinturonState(stateSvg.cinturon)
    stateHud()
end