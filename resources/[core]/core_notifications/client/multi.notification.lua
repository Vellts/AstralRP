local dgs = exports.dgs
local screenX, screenY = dgs:dgsGetScreenSize()

function multiNotification(info_data)
    -- info_data = {
        -- type = "multi",
        -- title = "Prueba de multinotificación!",
        -- message = nil,
        -- icon = "money",
        -- dataInfo = {
        --     {
        --         type = 1,
        --         text = "#ffffffTrabajo:     #D4F5C8+$75000",
        --         icon = nil,
        --         bar = {},
        --         dataSubInfo = {}
        --     },
        --     {
        --         type = 1,
        --         text = "#ffffffImpuesto vivienda:   #FA8585-$10000",
        --         icon = nil,
        --         bar = {},
        --         dataSubInfo = {}
        --     },
        --     {
        --         type = 1,
        --         text = "#ffffffImpuesto vehiculo:   #FA8585-$21000",
        --         icon = nil,
        --         bar = {},
        --         dataSubInfo = {}
        --     },
        --     {
        --         type = 1,
        --         text = "#ffffffGanancia negocios:   #D4F5C8+$80000",
        --         icon = nil,
        --         bar = {},
        --         dataSubInfo = {}
        --     },
        --     {
        --         type = 1,
        --         text = "#ffffffGanancias totales:   #D4F5C8+$124000",
        --         icon = nil,
        --         bar = {},
        --         dataSubInfo = {}
        --     },
        --     {
        --         type = 2,
        --         text = "Has consumido 2 gramos de cannabis.",
        --         icon = nil,
        --         bar = {
        --             minValue = 0,
        --             maxValue = 100,
        --             value = 50,
        --         },
        --         dataSubInfo = {}
        --     },
        --     {
        --         type = 3,
        --         text = "Prueba de texto con icono",
        --         icon = "drugs",
        --         bar = {},
        --         dataSubInfo = {}
        --     },
        --     {
        --         type = 4,
        --         text = "Has consumido 2 gramos de cannabis.",
        --         icon = "drugs",
        --         bar = {
        --             minValue = 0,
        --             maxValue = 100,
        --             value = 70,
        --         },
        --         dataSubInfo = {}
        --     },
        -- },
        -- lastElementHeight = 0.1,
        -- duration = 2000
    -- }

    if (#info_data.dataInfo > 9) then
        assert(false, "No puedes tener más de 8 elementos en la notificación.")
    end 

    local height = 0.2
    local heightImage = 0.07 + (#info_data.dataInfo * 0.04)
    if (#notifications > 0) then
        local lastElement = notifications[#notifications]
        if (isElement(lastElement.dgsDataElm)) then
            local _, heightElm = dgs:dgsGetSize(lastElement.dgsDataElm, true)
            local _, yElm = dgs:dgsGetPosition(lastElement.dgsDataElm, true)
            -- iprint(#info_data.dataInfo)
            if (#info_data.dataInfo > 0) then
                -- heightImage = heightImage + (#info_data.dataInfo * 0.04)
                height = yElm + heightElm + 0.01
                -- iprint("height: ", height)
            else
                height = yElm + heightElm + 0.01
            end
        end
    end

    local blur = dgs:dgsCreateBlurBox(300, 100)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)
    
    local shaderd = dgs:dgsCreateRoundRect(10, false, tocolor(135, 135, 135, 240))
    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, shaderd)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)

    -- local shader = dgs:dgsCreateRoundRect(6, false, tocolor(30, 30, 30, 200))
    local image = dgs:dgsCreateImage(1, height, 0.18, heightImage, blur, true)

    ----------- ICON & TITLE ------------

    local icon = dgs:dgsCreateImage(screenX * 0.01, screenY * 0.014, screenX * 0.016, screenY * 0.025, "assets/icons/"..info_data.icon..".png", false, image)
    local title = dgs:dgsCreateLabel(screenX * 0.03, screenY * 0.014, screenX * 0.14, screenY * 0.025, info_data.title, false, image)
    dgs:dgsSetProperties(title, {
        textColor = tocolor(255, 255, 255, 160),
        -- textSize = { 1.2, 1.2 },
        font = util.font,
        wordBreak = true,
        alignment = {"left", "center"},
    })
    
    -- local icon = dgs:dgsCreateImage(0.03, 0.1, 0.08, 0.15, "assets/icons/"..info_data.icon..".png", true, image)
    -- local title = dgs:dgsCreateLabel(0.15, 0.15, 0.65, 0.1, info_data.title, true, image)

    -- ----------- DATA INFO ------------
    local lastElm = nil
    for i, data in ipairs(info_data.dataInfo) do
        local textY = screenY * 0.06
        if (lastElm) then
            local _, yElm = dgs:dgsGetPosition(lastElm, false)
            local _, heightElm = dgs:dgsGetSize(lastElm, false)
            textY = yElm + heightElm + (screenY * 0.01)
            -- iprint("textY: ", textY)
        end

        if (data.type == 1) then
            local text = dgs:dgsCreateLabel(screenX * 0.01, textY, screenX * 0.14, screenY * 0.025, "• "..data.text, false, image)
            dgs:dgsSetProperties(text, {
                textColor = tocolor(255, 255, 255, 160),
                -- textSize = { 1, 1 },
                font = util.font,
                colorCoded = true,
                alignment = {"left", "center"},
                alpha = 0.72,
            })
            lastElm = text
        elseif (data.type == 2) then
            local text = dgs:dgsCreateLabel(screenX * 0.01, textY, screenX * 0.14, screenY * 0.025, "• "..data.text, false, image)
            dgs:dgsSetProperties(text, {
                textColor = tocolor(255, 255, 255, 160),
                -- textSize = { 1, 1 },
                font = util.font,
                colorCoded = true,
                alignment = {"left", "center"},
                alpha = 0.72,
            })
            local bar_shader = dgs:dgsCreateRoundRect(4, false, tocolor(255, 255, 255, 200))
            local bar_shader2 = dgs:dgsCreateRoundRect(4, false, tocolor(255, 255, 255, 50))
            local bar = dgs:dgsCreateProgressBar(screenX * 0.01, textY + screenY * 0.025, screenX * 0.14, screenY * 0.015, false, image)
            dgs:dgsSetProperties(bar, {
                bgImage = bar_shader2,
                progress = data.bar.value,
                indicatorImage = bar_shader,
            })
            lastElm = bar
        elseif (data.type == 3) then
            local text = dgs:dgsCreateLabel(screenX * 0.025, textY, screenX * 0.14, screenY * 0.025, data.text, false, image)
            dgs:dgsSetProperties(text, {
                textColor = tocolor(255, 255, 255, 160),
                -- textSize = { 1, 1 },
                font = util.font,
                colorCoded = true,
                alignment = {"left", "center"},
                alpha = 0.72,
            })
            local icon = dgs:dgsCreateImage(screenX * 0.01, textY - screenY * 0.0008, screenX * 0.014, screenY * 0.02, "assets/icons/"..data.icon..".png", false, image)
            lastElm = text
        elseif (data.type == 4) then
            local text = dgs:dgsCreateLabel(screenX * 0.025, textY, screenX * 0.14, screenY * 0.025, data.text, false, image)
            dgs:dgsSetProperties(text, {
                textColor = tocolor(255, 255, 255, 160),
                -- textSize = { 1, 1 },
                font = util.font,
                colorCoded = true,
                alignment = {"left", "center"},
                alpha = 0.72,
            })
            local bar_shader = dgs:dgsCreateRoundRect(4, false, tocolor(255, 255, 255, 200))
            local bar_shader2 = dgs:dgsCreateRoundRect(4, false, tocolor(255, 255, 255, 50))
            local bar = dgs:dgsCreateProgressBar(screenX * 0.01, textY + screenY * 0.025, screenX * 0.14, screenY * 0.015, false, image)
            dgs:dgsSetProperties(bar, {
                bgImage = bar_shader2,
                progress = data.bar.value,
                indicatorImage = bar_shader,
            })
            local icon = dgs:dgsCreateImage(screenX * 0.01, textY - screenY * 0.0008, screenX * 0.014, screenY * 0.02, "assets/icons/"..data.icon..".png", false, image)
            lastElm = bar
        end
    end

    util.isAniming = true
    dgs:dgsMoveTo(image, 0.795, height, true, "OutQuad", 500)
    -- -- if (not info_data.duration)
    setTimer(removeNotification, info_data.duration, 1, image, height)

    table.insert(notifications, {
        type = info_data.type,
        icon = info_data.icon,
        title = info_data.title or "",
        message = info_data.message or "",
        dgsDataElm = image,
        dataInfo = info_data.dataInfo or {},
    })

    addEventHandler("onDgsStopMoving", image, function()
        if (source ~= image) then return end
        util.isAniming = false
    end)
    return image
end
-- addEventHandler("onClientResourceStart", resourceRoot, multiNotification)