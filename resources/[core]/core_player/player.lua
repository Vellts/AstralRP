local dgs = exports.dgs
local sW, sH = dgs:dgsGetScreenSize()

--------------------------- FUNCIONES  ---------------------------

function drawMicrophone()
    local x, y = (sW * 0.045), (sH * 0.025)
    local w, h = (sW * 0.06), (sH * 0.018)
    local mic_status = getElementData(localPlayer, "player::mic_status") or true
    local draw_fps = dgs:dgsCreateLabel(x, y, w, h, "#FFFFFFmic: "..((mic_status) and "#ACBF99on" or "#C06966off"), false)
    dgs:dgsSetProperties(draw_fps, {
        font = hud.fontSemiBold,
        colorCoded = true,
        alpha = 0.6,
    })
    
    return draw_fps
end

function drawHealth()
    local x, y = (sW * 0.94), (sH * 0.03)
    local w, h = (sW * 0.04), (sH * 0.07)

    local circleShader = dgs:dgsCreateRoundRect({
        { 1, true },
        { 1, true },
        { 1, true },
        { 1, true }
    }, tocolor(124, 121, 155, 240))
    
    local blur = dgs:dgsCreateBlurBox(x, y)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)

    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, circleShader)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)

    
    local health = getElementHealth(localPlayer)
    
    local circle_parent = dgs:dgsCreateImage(x, y, w, h, blur, false)
    dgs:dgsAttachToAutoDestroy(blur, circle_parent)
    dgs:dgsAttachToAutoDestroy(circleShader, circle_parent)

    ------- PROGRESSBAR -------

    local progressBar = dgs:dgsCreateProgressBar(-0.65, -0.7, 2.3, 2.4, true, circle_parent)
    dgs:dgsProgressBarSetProgress(progressBar, health)
    dgs:dgsProgressBarSetStyle(progressBar, "ring-round", {
        isClockwise = false,
        rotation = 90,
        antiAliased = 0.05,
        radius = 0.2,
        thickness = 0.025
    })
    dgs:dgsSetProperties(progressBar, {
        bgColor = tocolor(50, 49, 61, 0),
        indicatorColor = tocolor(159, 109, 101, 120)
    })
    dgs:dgsSetProperty(progressBar, "functions", [[
        local health = getElementHealth(localPlayer)
        dgsSetProperty(self, "progress", health)
    ]])


    local health_image = dgs:dgsCreateImage(0.21, 0.25, 0.55, 0.55, "assets/images/health.png", true, circle_parent)

    return circle_parent
end

function drawArmor()
    local x, y = (sW * 0.895), (sH * 0.03)
    local w, h = (sW * 0.04), (sH * 0.07)

    local circleShader = dgs:dgsCreateRoundRect({
        { 1, true },
        { 1, true },
        { 1, true },
        { 1, true }
    }, tocolor(124, 121, 155, 240))
    
    local blur = dgs:dgsCreateBlurBox(x, y)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)

    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, circleShader)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)

    
    local armor = getPedArmor(localPlayer)
    
    local circle_parent = dgs:dgsCreateImage(x, y, w, h, blur, false)
    dgs:dgsAttachToAutoDestroy(blur, circle_parent)
    dgs:dgsAttachToAutoDestroy(circleShader, circle_parent)

    ------- PROGRESSBAR -------

    local progressBar = dgs:dgsCreateProgressBar(-0.65, -0.7, 2.3, 2.4, true, circle_parent)
    dgs:dgsProgressBarSetProgress(progressBar, armor)
    dgs:dgsProgressBarSetStyle(progressBar, "ring-round", {
        isClockwise = false,
        rotation = 90,
        antiAliased = 0.05,
        radius = 0.2,
        thickness = 0.025
    })
    dgs:dgsSetProperties(progressBar, {
        bgColor = tocolor(50, 49, 61, 0),
        indicatorColor = tocolor(76, 74, 70, 120)
    })
    dgs:dgsSetProperty(progressBar, "functions", [[
        local armor = getPedArmor(localPlayer)
        dgsSetProperty(self, "progress", armor)
    ]])


    local health_image = dgs:dgsCreateImage(0.21, 0.25, 0.55, 0.55, "assets/images/armor.png", true, circle_parent)

    return circle_parent
end

function drawHunger()
    local x, y = (sW * 0.848), (sH * 0.03)
    local w, h = (sW * 0.04), (sH * 0.07)

    local circleShader = dgs:dgsCreateRoundRect({
        { 1, true },
        { 1, true },
        { 1, true },
        { 1, true }
    }, tocolor(124, 121, 155, 240))
    
    local blur = dgs:dgsCreateBlurBox(x, y)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)

    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, circleShader)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)

    
    local hunger = getElementData(localPlayer, "player::hunger")
    
    local circle_parent = dgs:dgsCreateImage(x, y, w, h, blur, false)
    dgs:dgsAttachToAutoDestroy(blur, circle_parent)
    dgs:dgsAttachToAutoDestroy(circleShader, circle_parent)

    ------- PROGRESSBAR -------

    local progressBar = dgs:dgsCreateProgressBar(-0.65, -0.7, 2.3, 2.4, true, circle_parent)
    dgs:dgsProgressBarSetProgress(progressBar, hunger)
    dgs:dgsProgressBarSetStyle(progressBar, "ring-round", {
        isClockwise = false,
        rotation = 90,
        antiAliased = 0.05,
        radius = 0.2,
        thickness = 0.025
    })
    dgs:dgsSetProperties(progressBar, {
        bgColor = tocolor(50, 49, 61, 0),
        indicatorColor = tocolor(251, 217, 130, 120)
    })
    dgs:dgsSetProperty(progressBar, "functions", [[
        local hunger = getElementData(localPlayer, "player::hunger") and 20
        dgsSetProperty(self, "progress", hunger)
    ]])


    local health_image = dgs:dgsCreateImage(0.21, 0.25, 0.55, 0.55, "assets/images/hunger.png", true, circle_parent)

    return circle_parent
end

function drawThirst()
    local x, y = (sW * 0.802), (sH * 0.03)
    local w, h = (sW * 0.04), (sH * 0.07)

    local circleShader = dgs:dgsCreateRoundRect({
        { 1, true },
        { 1, true },
        { 1, true },
        { 1, true }
    }, tocolor(124, 121, 155, 240))
    
    local blur = dgs:dgsCreateBlurBox(x, y)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)

    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, circleShader)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)

    
    local thirst = getElementData(localPlayer, "player::thirst")
    
    local circle_parent = dgs:dgsCreateImage(x, y, w, h, blur, false)
    dgs:dgsAttachToAutoDestroy(blur, circle_parent)
    dgs:dgsAttachToAutoDestroy(circleShader, circle_parent)

    ------- PROGRESSBAR -------

    local progressBar = dgs:dgsCreateProgressBar(-0.65, -0.7, 2.3, 2.4, true, circle_parent)
    dgs:dgsProgressBarSetProgress(progressBar, thirst)
    dgs:dgsProgressBarSetStyle(progressBar, "ring-round", {
        isClockwise = false,
        rotation = 90,
        antiAliased = 0.05,
        radius = 0.2,
        thickness = 0.025
    })
    dgs:dgsSetProperties(progressBar, {
        bgColor = tocolor(50, 49, 61, 0),
        indicatorColor = tocolor(87, 126, 146, 120)
    })
    dgs:dgsSetProperty(progressBar, "functions", [[
        local thirst = getElementData(localPlayer, "player::thirst") and 80
        dgsSetProperty(self, "progress", thirst)
    ]])


    local health_image = dgs:dgsCreateImage(0.21, 0.25, 0.55, 0.55, "assets/images/drink.png", true, circle_parent)

    return circle_parent
end

function drawDeveloper()
    local x, y = (sW * 0.753), (sH * 0.03)
    local w, h = (sW * 0.04), (sH * 0.07)

    local circleShader = dgs:dgsCreateRoundRect({
        { 1, true },
        { 1, true },
        { 1, true },
        { 1, true }
    }, tocolor(124, 121, 155, 240))
    
    local blur = dgs:dgsCreateBlurBox(x, y)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)

    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, circleShader)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)

    
    
    local circle_parent = dgs:dgsCreateImage(x, y, w, h, blur, false)
    dgs:dgsAttachToAutoDestroy(blur, circle_parent)
    dgs:dgsAttachToAutoDestroy(circleShader, circle_parent)

    ------- PROGRESSBAR -------

    local progressBar = dgs:dgsCreateProgressBar(-0.65, -0.7, 2.3, 2.4, true, circle_parent)
    dgs:dgsProgressBarSetProgress(progressBar, 100)
    dgs:dgsProgressBarSetStyle(progressBar, "ring-round", {
        isClockwise = false,
        rotation = 90,
        antiAliased = 0.05,
        radius = 0.2,
        thickness = 0.025
    })
    dgs:dgsSetProperties(progressBar, {
        bgColor = tocolor(50, 49, 61, 0),
        indicatorColor = tocolor(79, 70, 69, 120)
    })


    local health_image = dgs:dgsCreateImage(0.21, 0.25, 0.55, 0.55, "assets/images/developer.png", true, circle_parent)

    return circle_parent
end

function drawName(player, name)
    local x, y, z = getElementPosition(player)
    local text = dgs:dgsCreate3DText(x, y, z,"Persona desconocida #1230")
    dgs:dgsSetProperties(text, {
        font = hud.fontSemiBold,
        color = tocolor(255, 255, 255, 153),
        fadeDistance = 2,
        textSize = { 0.3, 0.3 },
    })
    dgs:dgs3DTextAttachToElement(text,player,0,0,0.9)

    return text
end

function drawAxis()
    local raw = [[
        <svg width="60" height="60" viewBox="0 0 60 60" fill="none" stroke="#000000" xmlns="http://www.w3.org/2000/svg">
        <path d="M22.5 45H37.5M22.5 15H37.5M30 16.25V15V45M12.5 12.5C12.5 11.1739 13.0268 9.90215 13.9645 8.96447C14.9021 8.02678 16.1739 7.5 17.5 7.5C18.8261 7.5 20.0979 8.02678 21.0355 8.96447C21.9732 9.90215 22.5 11.1739 22.5 12.5V17.5C22.5 18.8261 21.9732 20.0979 21.0355 21.0355C20.0979 21.9732 18.8261 22.5 17.5 22.5C16.1739 22.5 14.9021 21.9732 13.9645 21.0355C13.0268 20.0979 12.5 18.8261 12.5 17.5V12.5ZM12.5 42.5C12.5 41.1739 13.0268 39.9021 13.9645 38.9645C14.9021 38.0268 16.1739 37.5 17.5 37.5C18.8261 37.5 20.0979 38.0268 21.0355 38.9645C21.9732 39.9021 22.5 41.1739 22.5 42.5V47.5C22.5 48.8261 21.9732 50.0979 21.0355 51.0355C20.0979 51.9732 18.8261 52.5 17.5 52.5C16.1739 52.5 14.9021 51.9732 13.9645 51.0355C13.0268 50.0979 12.5 48.8261 12.5 47.5V42.5ZM37.5 12.5C37.5 11.1739 38.0268 9.90215 38.9645 8.96447C39.9021 8.02678 41.1739 7.5 42.5 7.5C43.8261 7.5 45.0979 8.02678 46.0355 8.96447C46.9732 9.90215 47.5 11.1739 47.5 12.5V17.5C47.5 18.8261 46.9732 20.0979 46.0355 21.0355C45.0979 21.9732 43.8261 22.5 42.5 22.5C41.1739 22.5 39.9021 21.9732 38.9645 21.0355C38.0268 20.0979 37.5 18.8261 37.5 17.5V12.5ZM37.5 42.5C37.5 41.1739 38.0268 39.9021 38.9645 38.9645C39.9021 38.0268 41.1739 37.5 42.5 37.5C43.8261 37.5 45.0979 38.0268 46.0355 38.9645C46.9732 39.9021 47.5 41.1739 47.5 42.5V47.5C47.5 48.8261 46.9732 50.0979 46.0355 51.0355C45.0979 51.9732 43.8261 52.5 42.5 52.5C41.1739 52.5 39.9021 51.9732 38.9645 51.0355C38.0268 50.0979 37.5 48.8261 37.5 47.5V42.5Z" stroke="" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
    ]]

    local svg = dgs:dgsCreateSVG(120, 120, raw)
    local image = dgs:dgsCreateImage(0.85, 0.85, 0.1, 0.1, svg, true)
    setTimer(function()
        local svgDoc = dgs:dgsSVGGetDocument(svg)
        dgs:dgsSVGNodeSetAttribute(svgDoc, "stroke", "#B05353")
        iprint(dgs:dgsSVGNodeGetAttributes(svgDoc))
    end, 500, 1)
    return image
end
-- addEventHandler("onClientResourceStart", resourceRoot, drawAxis)