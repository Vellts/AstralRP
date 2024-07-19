local dgs = exports.dgs
notifications = {}
util = {
    font = dgs:dgsCreateFont("assets/fonts/Poppins-Bold.ttf", 14),
    isAniming = false,
    queue = {
        elements = {},
    },
    serchingQueue = false,
    durations = {
        normal = 6000,
        interaction = 3000,
        multi = 12000,
    },
    elementsAnimating = 0
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

    if (type == "normal") then
        info.duration = info.duration or util.durations.normal
        normalNotification(info)
        playSound("assets/notification_effect.wav")
    elseif (type == "interaction") then
        info.duration = info.duration or util.durations.interaction
        interactionNotification(info)
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


function removeNotification(notification, height)
    
    if (util.isAniming) and (util.elementsAnimating ~= 0) then
        local queue = addElementToQueue(util.queue, {
            notification = notification,
            height = height
        })
        if (not queue) then return end
        -- iprint("Guardando queue la queue: ")
        -- iprint(queue)
        return
    end

    -- iprint(table.size(util.queue))
    if (table.size(util.queue) > 0) and (not util.searchingQueue) then
        util.searchingQueue = true
        for i, v in pairs(util.queue) do
            -- iprint(v)
            removeNotification(v.notification, v.height)
            if (isTimer(v.timer)) then
                killTimer(v.timer)
            end
            util.queue[i] = nil
            util.searchingQueue = false
            break
        end
        return
    end
    if (isElement(notification)) then
        -- iprint("A notificación se le ha dado remove")
        util.isAniming = true
        local h = getYOfElement(notifications, notification, dgs) or height
        dgs:dgsMoveTo(notification, 1, h, true, "OutQuad", 500)
        setTimer(function()
            local n_index = 0
            local last_elm = nil
            local data_ps = {
                y = 0,
                h = 0,
            }
            for i, v in ipairs(notifications) do
                if (v.dgsDataElm == notification) then
                    n_index = i
                    -- iprint("n_index: "..n_index)
                end
                
                if (n_index ~= 0) then
                    local index_elm = i + 1
                    -- iprint(index_elm)
                    if (#notifications >= index_elm) then
                        if (not last_elm) then
                            -- iprint("here: 2")
                            -- iprint("index_elm: "..index_elm)
                            last_elm = notification
                            local elm = notifications[index_elm].dgsDataElm

                            local _, y = dgs:dgsGetPosition(last_elm, true)
                            local x, y1 = dgs:dgsGetPosition(elm, true)
                            local _, h = dgs:dgsGetSize(elm, true)
                            data_ps.y = y1
                            data_ps.h = h
                            last_elm = elm

                            dgs:dgsMoveTo(elm, x, y, true, "OutQuad", 500)
                            addAnimationCounter()
                        else
                            -- iprint("here: 1")
                            -- iprint("index_elm: "..index_elm)
                            local elm = notifications[index_elm].dgsDataElm
                            local y = data_ps.y
                            local h = data_ps.h
                            local x, ny = dgs:dgsGetPosition(elm, true)
                            local _, nh = dgs:dgsGetSize(elm, true)
                            data_ps.y = ny
                            data_ps.h = nh
                            last_elm = elm

                            -- iprint("x: "..x.." y: "..y.." h: "..h)
                            dgs:dgsMoveTo(elm, x, y + nh + 0.01, true, "OutQuad", 500)
                            addAnimationCounter()
                        end
                    end
                end
            end
            destroyElement(notification)
            table.remove(notifications, n_index)
        end, 501, 1)
    end
end

function addAnimationCounter()
    util.elementsAnimating = util.elementsAnimating + 1
    setTimer(function()
        util.elementsAnimating = util.elementsAnimating - 1
        iprint("elementsAnimating: "..util.elementsAnimating)
        if (util.elementsAnimating == 0) then
            util.isAniming = false
            removeNotification()
        end
    end, 500, 1)
end

-- local index = 0

local index = 2
addCommandHandler("testnoti", function()
    local index = math.random(1, 3)
    -- local index = 2
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
        -- local info = {
        --     type = "normal",
        --     icon = "in",
        --     title = nil,
        --     message = "Has iniciado sesión en el servidor.",
        --     duration = 5000
        -- }
        -- normalNotification(info)
        multiNotification()
        playSound("assets/notification_effect.wav")
        -- index = 1
    elseif (index == 3) then
        local info = {
        type = "normal",
        icon = "in",
        title = nil,
        message = "Has iniciado sesión en el servidor.",
        duration = 5000
        }
        normalNotification(info)
        playSound("assets/notification_effect.wav")
    end
end)
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