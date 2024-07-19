local dgs = exports.dgs

function interactionNotification(info_data)
    -- info_data = {
    --     message = "Presiona la letra {letter} para entrar al vehiculo.",
    --     icon = "E",
    --     lastElementHeight = 0.1 
    -- } 
    local height = 0.2
    if (#notifications > 0) then
        local lastElement = notifications[#notifications]
        if (isElement(lastElement.dgsDataElm)) then
            local _, heightElm = dgs:dgsGetSize(lastElement.dgsDataElm, true)
            local _, yElm = dgs:dgsGetPosition(lastElement.dgsDataElm, true)
            height = yElm + heightElm + 0.01
        end
    end

    local blur = dgs:dgsCreateBlurBox(300, 100)
    dgs:dgsSetProperty(blur, "updateScreenSource", true)
    
    local shaderd = dgs:dgsCreateRoundRect(10, false, tocolor(135, 135, 135, 240))
    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(blur, shaderd)
    dgs:dgsBlurBoxSetIntensity(blur, 5)
    dgs:dgsBlurBoxSetLevel(blur, 15)

    

    local shader_2 = dgs:dgsCreateRoundRect(4, false, tocolor(255, 255, 255, 50))
    local image = dgs:dgsCreateImage(1, height, 0.18, 0.07, blur, true)
    -- iprint(image)

    -- split the {letter} from the message
    local letter = string.match(info_data.message, "{(.-)}")
    if letter then
        local message = string.gsub(info_data.message, "{(.-)}", "'"..info_data.icon.."'")


        local messageLabel = dgs:dgsCreateLabel(0.17, 0.3, 0.8, 0.5, message, true, image)
        local iconKey = dgs:dgsCreateImage(0.025, 0.2, 0.12, 0.6, shader_2, true, image)
        local keyLabel = dgs:dgsCreateLabel(0.45, 0.15, 0.1, 0.8, info_data.icon, true, iconKey)
        dgs:dgsSetProperties(messageLabel, {
            textColor = tocolor(255, 255, 255, 170),
            alignment = {"left", "center"},
            font = util.font,
            wordBreak = true
        })

        dgs:dgsSetProperties(keyLabel, {
            textColor = tocolor(255, 255, 255, 170),
            alignment = {"center", "center"},
            font = util.font,
            textSize = {
                1.5,
                1.5
            }
        })
    end

    dgs:dgsMoveTo(image, 0.795, height, true, "OutQuad", 500)
    setTimer(removeNotification, util.durations.interaction, 1, image, height)

    local data = {
        type = info_data.type,
        icon = info_data.icon,
        title = info_data.title or "",
        message = info_data.message or "",
        dgsDataElm = image,
        dataInfo = info_data or {},
    }

    table.insert(notifications, data)

    return data
end
-- addEventHandler("onClientResourceStart", resourceRoot, interactionNotification)