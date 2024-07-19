local dgs = exports.dgs
notifications = {}
util = {
    font = dgs:dgsCreateFont("assets/fonts/Poppins-Bold.ttf", 14),
    isAniming = false,
    queue = {
        elements = {},
        timer = nil,
    },
    durations = {
        normal = 6000,
        interaction = 10000,
        multi = 6000,
    },
    elementsAnimating = 0,
}
-- notifacations structure example
-- max 70 characteres per message
-- max 20 characteres per title
-- [[
--     {
--         type = "normal",
--         icon = "in",
--         title = nil,
--         message = "Has iniciado sesión en el servidor.",
--         dataInfo = {},
--         dgsDataElm = nil,
--     },
--     {
--         type = "key",
--         icon = "E",
--         title = nil,
--         dataInfo = {},
--         message = "Presiona la letra {letter} para entrar al vehiculo.",
--         dgsDataElm = nil,
--     },
--     {
--         type = "multi",
--         icon = "money",
--         title = "Pago mensual",
--         message = nil,
--         dataInfo = {
--             {
--                 type = 1 -- [1] solo texto, [2] texto con barra, [3] texto con icono y barra
--                 text = "Pago mensual de la casa: $5000",
--                 icon = nil,
--                 bar = {},
--                 dataSubInfo = {}
--             },
--             {
--                 type = 2 -- [1] solo texto, [2] texto con barra, [3] texto con icono y barra
--                 text = "Has consumido droga",
--                 icon = nil,
--                 bar = {
--                     minValue = 0,
--                     maxValue = 100,
--                     value = 50,
--                     elm = nil
--                 },
--                 dataSubInfo = {}
--             }
--         },
--         dgsDataElm = nil,
--     }
-- ]]

function createNotification(type, info)
    if (not info) or (not type) then assert(false, "No se ha proporcionado la información de la notificación.") end
    -- iprint(util.isAniming)
    -- iprint(info)
    
    if (type == "normal") then
        info.duration = info.duration or util.durations.normal
        local data = normalNotification(info)
        playSound("assets/notification_effect.wav")
    elseif (type == "interaction") then
        info.duration = info.duration or util.durations.interaction
        local data = interactionNotification(info)
        playSound("assets/notification_effect.wav")
    elseif (type == "multi") then
        info.duration = info.duration or util.durations.multi
        multiNotification(info)
        playSound("assets/notification_effect.wav")
    else
        assert(false, "El tipo de notificación no es válido.")
    end
end
addEvent("GL_Core::client::notification", true)
addEventHandler("GL_Core::client::notification", root, createNotification)

function removeInteractionNotification()
    for i, v in ipairs(notifications) do
        if (v.type == "interaction") then
            if (v.dataInfo.mainElement) then
                if (getElementType(v.dataInfo.mainElement) == "vehicle") then
                    removeNotification(v.dgsDataElm)
                end
            end
        end
    end
end
addEvent("GL_Core::client::removeNotification", true)
addEventHandler("GL_Core::client::removeNotification", root, removeInteractionNotification)

function removeNotification(notification)

    if (not isElement(notification)) then return end

    if (util.isAniming) then
        table.insert(util.queue.elements, {notification = notification})
        setTimer(generateQueue, 500, 1, true)
        return
    end
        
    -- move the notification to x position to hide it
    util.isAniming = true
    local x, y = dgs:dgsGetPosition(notification, true)
    dgs:dgsMoveTo(notification, 1, y, true, "OutQuad", 500)
    addEventHandler("onDgsStopMoving", notification, function()
        if (source ~= notification) then return end
        util.isAniming = false
        local index = getNotificationIndex(notifications, notification)
        if (index) then
            table.remove(notifications, index)
            destroyElement(notification)
        end
    end)

    -- move the rest of the notifications to the last y position of the last moved notification
    for i, v in ipairs(notifications) do
        if (v.dgsDataElm == notification) then
            for i2, v2 in ipairs(notifications) do
                if (i2 > i) then
                    local x, y = dgs:dgsGetPosition(v2.dgsDataElm, true)
                    local w, h = dgs:dgsGetSize(v2.dgsDataElm, true)
                    if (v.type == "multi") then
                        w, h = dgs:dgsGetSize(v.dgsDataElm, true)
                    end
                    util.isAniming = true
                    dgs:dgsMoveTo(v2.dgsDataElm, x, y - h - 0.01, true, "OutQuad", 500)
                    addEventHandler("onDgsStopMoving", v2.dgsDataElm, function()
                        if (source ~= v2.dgsDataElm) then return end
                        util.isAniming = false
                    end)
                end
            end
        end
    end
end


function animateElement(element, info)
    if (not isElement(element)) then return end
    local x, y, time = unpack(info)
    dgs:dgsMoveTo(element, x, y, true, "OutQuad", time)
end

function generateQueue(isRemoveNotification, isAnimate)
    if (isRemoveNotification) then
        -- add a queue to remove the notification
        if (#util.queue.elements > 0) then
            local element = util.queue.elements[1]
            table.remove(util.queue.elements, 1)
            removeNotification(element.notification)
        end
    elseif (isAnimate) then
        if (#util.queue.elements > 0) then
            local element = util.queue.elements[1]
            table.remove(util.queue.elements, 1)
            animateElement(element.dgsDataElm, element.info)
        end
    else
        if (#util.queue.elements > 0) then
            local element = util.queue.elements[1]
            table.remove(util.queue.elements, 1)
            createNotification(element.type, element.info)
        end
    end
end


-- local index = 0

function testNotification()
    local index = math.random(2, 3)
    -- iprint("index: "..index)
    if (index == 1) then
        local info = {
            type = "interaction",
            icon = "E",
            title = nil,
            message = "Presiona la letra {letter} para entrar al vehiculo.",
            duration = 3000,
        }
        interactionNotification(info)
        playSound("assets/notification_effect.wav")
        -- index = 2
    elseif (index == 2) then
        local info = {
            type = "multi",
            title = "Prueba de multinotificación!",
            message = nil,
            icon = "money",
            dataInfo = {
                {
                    type = 1,
                    text = "#ffffffTrabajo:     #D4F5C8+$75000",
                    icon = nil,
                    bar = {},
                    dataSubInfo = {}
                },
                {
                    type = 1,
                    text = "#ffffffImpuesto vivienda:   #FA8585-$10000",
                    icon = nil,
                    bar = {},
                    dataSubInfo = {}
                },
                -- {
                --     type = 1,
                --     text = "#ffffffImpuesto vehiculo:   #FA8585-$21000",
                --     icon = nil,
                --     bar = {},
                --     dataSubInfo = {}
                -- },
                -- {
                --     type = 1,
                --     text = "#ffffffGanancia negocios:   #D4F5C8+$80000",
                --     icon = nil,
                --     bar = {},
                --     dataSubInfo = {}
                -- },
                -- {
                --     type = 1,
                --     text = "#ffffffGanancias totales:   #D4F5C8+$124000",
                --     icon = nil,
                --     bar = {},
                --     dataSubInfo = {}
                -- },
                {
                    type = 2,
                    text = "Has consumido 2 gramos de cannabis.",
                    icon = nil,
                    bar = {
                        minValue = 0,
                        maxValue = 100,
                        value = 50,
                    },
                    dataSubInfo = {}
                },
                {
                    type = 3,
                    text = "Prueba de texto con icono",
                    icon = "drugs",
                    bar = {},
                    dataSubInfo = {}
                },
                {
                    type = 4,
                    text = "Has consumido 2 gramos de cannabis.",
                    icon = "drugs",
                    bar = {
                        minValue = 0,
                        maxValue = 100,
                        value = 70,
                    },
                    dataSubInfo = {}
                },
            },
            lastElementHeight = 0.1,
            duration = 2000
        }
        -- normalNotification(info)

        if (util.isAniming) then
            table.insert(util.queue.elements, {type = "multi", info = info})
            setTimer(generateQueue, 500, 1)
            return
        end

        multiNotification(info)
        playSound("assets/notification_effect.wav")
        -- index = 1
    elseif (index == 3) then
        local info = info_data or {
        type = "normal",
        icon = "in",
        title = nil,
        message = "Has iniciado sesión en el servidor.",
        duration = 5000
        }
        if (util.isAniming) then
            table.insert(util.queue.elements, {type = "normal", info = info})
            setTimer(generateQueue, 500, 1)
            return
        end

        normalNotification(info)
        playSound("assets/notification_effect.wav")
    end
end

addCommandHandler("testnoti", testNotification)
-- local x, y = dgs:dgsGetPosition(notification, true)
-- local w, h = dgs:dgsGetSize(notification, true)
-- local n_index = 0
-- for i, v in ipairs(notifications) do
--     if (v.dgsDataElm == notification) then
--         n_index = i
--     end
--     if ((n_index ~= 0) and (i > n_index)) then
--         local x, y = dgs:dgsGetPosition(v.dgsDataElm, true)
--         local w, h = dgs:dgsGetSize(v.dgsDataElm, true)
        
--         -- if the current notification is multi, increase the move distance
--         local notType = notifications[n_index].type
--         if (notType == "multi") then
--             local moveTo = y - (h + 0.33)
--             if (moveTo > 0.33) then
--                 moveTo = 0.33
--             end
--             dgs:dgsMoveTo(v.dgsDataElm, x, moveTo, true, "OutQuad", 500)
--         else
--             dgs:dgsMoveTo(v.dgsDataElm, x, y - h - 0.01, true, "OutQuad", 500)
--         end

--         -- dgs:dgsMoveTo(v.dgsDataElm, x, y - h - 0.01, true, "OutQuad", 500)
--     end
-- end

-- table.remove(notifications, n_index)
-- destroyElement(notification)