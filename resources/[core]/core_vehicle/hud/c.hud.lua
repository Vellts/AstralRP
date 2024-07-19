dgs = exports.dgs
local sW, sY = dgs:dgsGetScreenSize()
local font = dgs:dgsCreateFont("assets/fonts/Poppins-MediumItalic.ttf", 64)

svgs = {}

function drawBadges()
    ------------------- HAND BRAKE -------------------

    local rawHandBrake = getHandBrakeSvg()
    svgs.svgHB = dgs:dgsCreateSVG(22, 19, rawHandBrake)
    local xHB, yHB = (sW/2) - (sW*0.08), (sY - sY*0.04)
    local wHB, hHB = (sW*0.015), (sY*0.02)
    local imageHandBrake = dgs:dgsCreateImage(xHB, yHB, wHB, hHB, svgs.svgHB, false)

    ------------------- LIGHT -------------------

    local rawLight = getLightSvg()
    svgs.svgL = dgs:dgsCreateSVG(22, 19, rawLight)
    local xL, yL = (sW/2) - (sW*0.055), (sY - sY*0.04)
    local wL, hL = (sW*0.015), (sY*0.02)
    local imageLight = dgs:dgsCreateImage(xL, yL, wL, hL, svgs.svgL, false)

    ------------------- CINTURON -------------------

    local rawCinturon = getCinturonSvg()
    svgs.svgC = dgs:dgsCreateSVG(22, 19, rawCinturon)
    local xC, yC = (sW/2) - (sW*0.03), (sY - sY*0.04)
    local wC, hC = (sW*0.013), (sY*0.02)
    local imageCinturon = dgs:dgsCreateImage(xC, yC, wC, hC, svgs.svgC, false)

    ------------------- KEY -------------------
    
    local rawKey = getKeySvg()
    svgs.svgK = dgs:dgsCreateSVG(22, 19, rawKey)
    local xK, yK = (sW/2) - (sW*0.005), (sY - sY*0.04)
    local wK, hK = (sW*0.015), (sY*0.02)
    local imageKey = dgs:dgsCreateImage(xK, yK, wK, hK, svgs.svgK, false)

    ------------------- GAS -------------------

    local rawGas = getGasSvg()
    local svgG = dgs:dgsCreateSVG(22, 19, rawGas)
    local xG, yG = (sW/2) + (sW*0.02), (sY - sY*0.04)
    local wG, hG = (sW*0.013), (sY*0.02)
    local imageGas = dgs:dgsCreateImage(xG, yG, wG, hG, svgG, false)

end

function drawVehicleVelocity()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (not vehicle) then return end
    local speed = math.ceil(getVehicleSpeed(vehicle))
    local rpm = getVehicleRPM(vehicle)
    local gear = getVehicleCurrentGear(vehicle)


    local xSP, ySP = (sW/2) - (sW*0.068), (sY - sY*0.12)
    local wSP, hSP = (sW*0.04), (sY*0.05)
    local textSpeed = dgs:dgsCreateLabel(xSP, ySP, wSP, hSP, speed, false)
    dgs:dgsSetProperties(textSpeed, {
        font = font,
        color = tocolor(255, 255, 255, 255),
        alignment = {"right", "center"},
        textSize = {
            (sW*0.0004),
            (sY*0.001)
        },
        functions = stringGetVehicleSpeed
    })
    local textKmH = dgs:dgsCreateLabel(xSP, ySP + (sY*0.03), wSP, hSP, "km/h", false)
    dgs:dgsSetProperties(textKmH, {
        font = font,
        color = tocolor(255, 255, 255, 255),
        alignment = {"right", "center"},
        textSize = {
            (sW*0.0001),
            (sY*0.00025)
        },
        alpha = 0.6
    })

    local xRPM, yRPM = (sW/2) - (sW*0.115), (sY - sY*0.12)
    local wRPM, hRPM = (sW*0.04), (sY*0.03)
    local textRPM = dgs:dgsCreateLabel(xRPM, yRPM, wRPM, hRPM, rpm, false)
    dgs:dgsSetProperties(textRPM, {
        font = font,
        color = tocolor(255, 255, 255, 255),
        alignment = {"right", "center"},
        textSize = {
            (sW*0.0002),
            (sY*0.00045)
        },
        functions = stringGetVehicleRpm
    })

    local textRpm2 = dgs:dgsCreateLabel(xRPM, yRPM + (sY*0.03), wRPM, hRPM, "rpm", false)
    dgs:dgsSetProperties(textRpm2, {
        font = font,
        color = tocolor(255, 255, 255, 255),
        alignment = {"right", "center"},
        textSize = {
            (sW*0.0001),
            (sY*0.0002)
        },
        alpha = 0.6
    })

    local xGear, yGear = (sW/2) - (sW*0.035), (sY - sY*0.12)
    local wGear, hGear = (sW*0.04), (sY*0.05)
    local textGear = dgs:dgsCreateLabel(xGear, yGear, wGear, hGear, gear, false)
    dgs:dgsSetProperties(textGear, {
        font = font,
        color = tocolor(255, 255, 255, 255),
        alignment = {"right", "center"},
        textSize = {
            (sW*0.00045),
            (sY*0.0012)
        },
        functions = stringGetVehicleGear
    })

    -- gear image
    
    local gearImage = dgs:dgsCreateImage(xGear + (sW*0.045), yGear, wGear - (sW*0.03), hGear - (sY*0.025), "assets/images/gears.png", false)

    local rectShader = dgs:dgsCreateRoundRect(4, false, tocolor(255, 255, 255, 255))
    local rectVel = dgs:dgsCreateImage(xSP + (sW*0.046), ySP - (sY*0.025), wSP - (sW*0.0365), hSP + (sY*0.045), rectShader, false)
    dgs:dgsSetProperty(rectVel, "alpha", 0.6)

end

function healthVehicle()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (not vehicle) then return end

    local xHt, yHt = (sW/2) + (sW*0.02), (sY - sY*0.14)
    local wHt, hHt = (sW*0.035), (sY*0.08)
    local rawSvgHt = getAxisSvg()
    local svgHt = dgs:dgsCreateSVG(46, 60, rawSvgHt)
    local imageHt = dgs:dgsCreateImage(xHt, yHt, wHt, hHt, svgHt, false)

    local vehicleHealth = getElementHealth(vehicle)
    -- convert health to percentage
    vehicleHealth = math.floor((vehicleHealth/1000)*100)

    local textHt = dgs:dgsCreateLabel(xHt + (sW*0.03), yHt + (sY*0.03), wHt - (sW*0.015), hHt - (sY*0.06), vehicleHealth.."%", false)
    dgs:dgsSetProperties(textHt, {
        font = font,
        color = tocolor(255, 255, 255, 255),
        alignment = {"left", "center"},
        textSize = {
            (sW*0.00015),
            (sY*0.0003)
        },
    })
    dgs:dgsSetProperty(textHt, "functions", stringGetVehicleHealth, svgHt)
end

function removeHud()
    local getElements = dgs:dgsGetElementsFromResource()
    for k, v in pairs(getElements) do
        if (isElement(v)) then
            destroyElement(v)
        end
    end
end

