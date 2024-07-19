local dgs = exports.dgs

function normalNotification(info_data)
    -- iprint(info_data)
    local y = 0.2
    if (#notifications > 0) then
        local lastElement = notifications[#notifications]
        if (isElement(lastElement.dgsDataElm)) then
            local _, heightElm = dgs:dgsGetSize(lastElement.dgsDataElm, true)
            local _, yElm = dgs:dgsGetPosition(lastElement.dgsDataElm, true)
            y = yElm + heightElm + 0.01
        end
    end
    
    local blur = dgs:dgsCreateBlurBox(300, 100)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)
    
    local shaderd = dgs:dgsCreateRoundRect(10, false, tocolor(135, 135, 135, 240))
    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, shaderd)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)


    -------------- TEST --------------


    -- local image = dgs:dgsCreateImage(150, 50, 300, 100, blur, false)
    local image = dgs:dgsCreateImage(1, y, 0.18, 0.07, blur, true)
    local text = dgs:dgsCreateLabel(0.17, 0.3, 0.8, 0.5, info_data.message, true, image)
    dgs:dgsAttachToAutoDestroy(blur, image)
    dgs:dgsSetProperties(text, {
        textColor = tocolor(255, 255, 255, 160),
        font = util.font,
        wordBreak = true,
        alignment = {"left", "center"},
    })

    local icon = dgs:dgsCreateImage(0.025, 0.3, 0.1, 0.4, "assets/icons/"..info_data.icon..".png", true, image)
    util.isAniming = true
    -- iprint(util)
    dgs:dgsMoveTo(image, 0.795, y, true, "OutQuad", 500)

    setTimer(removeNotification, util.durations.normal, 1, image, y)

    local data = {
        type = info_data.type,
        icon = info_data.icon,
        title = info_data.title or "",
        message = info_data.message or "",
        dgsDataElm = image,
        dataInfo = info_data or {},
    }
    table.insert(notifications, data)
    addEventHandler("onDgsStopMoving", image, function()
        if (source ~= image) then return end
        util.isAniming = false
    end)
    -- iprint(util)
    return image, data
end
-- addEventHandler("onClientResourceStart", resourceRoot, normalNotification)
