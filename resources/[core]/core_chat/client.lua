local dgs = exports.dgs
local sW, sH = dgs:dgsGetScreenSize()
local data = {
    text = "",
    font = dgs:dgsCreateFont("assets/Poppins-Bold.ttf", 14),
    keyboardRendered = false,
    keyBoardHided = true,
    keyboard = {},
    timer = nil,
    messages = {},
    labels = {},
    timeTimer = 2000,
    chatVisible = true,
    chatTimerFocus = 100,
    blur = nil,
}

addEventHandler("onClientChatMessage", root, function()
    cancelEvent()
end)

-------------------------------- FUNCTIONS --------------------------------

function drawChat()
    data.scrollPane = dgs:dgsCreateScrollPane((sW * 0.014), (sH * 0.15), (sW * 0.2), (sH * 0.34), false)
    dgs:dgsSetProperties(data.scrollPane, {
        scrollBarThick =  10,
    })

    local scrollBar = dgs:dgsScrollPaneGetScrollBar(data.scrollPane)
    dgs:dgsScrollPaneSetScrollBarState(data.scrollPane, false, false)

    local shader = dgs:dgsCreateRoundRect(4, false, tocolor(31, 27, 27, 153))
    dgs:dgsSetProperties(scrollBar[1], {
        image = { shader, shader, shader },
        scrollArrow = false,
    })

    
end

function drawKeyBoard(create, state)
    data.keyboard.sendButton = dgs:dgsCreateButton((sW * 0.014), (sH * 0.5), (sW * 0.022), (sH * 0.035), "", false)

    data.blur = dgs:dgsCreateBlurBox(300, 100)
    dgs:dgsSetProperty(data.blur, "updateScreenSource", true)
    
    -- local shaderd = dgs:dgsCreateRoundRect(10, false, tocolor(135, 135, 135, 240))
    local shaderButton = dgs:dgsCreateRoundRect(4, false, tocolor(31, 27, 27, 153))
    ------- BLUR CONFIG -------

    dgs:dgsBlurBoxSetFilter(data.blur, shaderButton)
    dgs:dgsBlurBoxSetIntensity(data.blur, 5)
    dgs:dgsBlurBoxSetLevel(data.blur, 15)

    -- local shaderButton2 = dgs:dgsCreateRoundRect(4, false, tocolor(103, 101, 132, 153))

    dgs:dgsSetProperties(data.keyboard.sendButton, {
        image = { data.blur, data.blur, data.blur },
        iconImage = dxCreateTexture("assets/send.png"),
        iconAligment = { "center", "center" },
        iconOffset = { 8, 0 },
        alpha = 0,
    })

    addEventHandler("onDgsMouseClickDown", data.keyboard.sendButton, function()
        sendMessage()
    end)

    data.keyboard.editBox = dgs:dgsCreateEdit((sW * 0.04), (sH * 0.5), (sW * 0.148), (sH * 0.035), "", false)
    dgs:dgsSetProperties(data.keyboard.editBox, {
        font = data.font,
        bgImage = data.blur,
        placeHolder = "Escribe...",
        placeHolderColor = tocolor(255, 255, 255, 150),
        -- placeHolderOffset = { 10, 0 },
        selectColor = tocolor(255, 255, 255, 102),
        textColor = tocolor(255, 255, 255, 150),
        aligment = { "left", "center" },
        caretHeight = 0.8,
        caretColor = tocolor(255, 255, 255, 102),
        padding = { 10, 10 },
        maxLength = 50,
        alpha = 0,
    })
    for key, options in pairs(validCommands) do
        dgs:dgsEditAddAutoComplete(data.keyboard.editBox, {"/"..key, options.suggest}, true, true)
    end
    addEventHandler("onDgsEditAccepted", data.keyboard.editBox, function()
        sendMessage()
    end)

    data.keyboard.visibleButton = dgs:dgsCreateButton((sW * 0.192), (sH * 0.5), (sW * 0.022), (sH * 0.035), "", false)
    dgs:dgsSetProperties(data.keyboard.visibleButton, {
        image = { data.blur, data.blur, data.blur },
        iconImage = dxCreateTexture("assets/config.png"),
        iconAligment = { "center", "center" },
        iconOffset = { 8, 0 },
        alpha = 0,
    })

    addEventHandler("onDgsMouseClickDown", data.keyboard.visibleButton, changeChatState)

    


    --------- ANIMATIONS ---------
    dgs:dgsAlphaTo(data.keyboard.sendButton, 1, "OutQuad", 100)
    dgs:dgsAlphaTo(data.keyboard.editBox, 1, "OutQuad", 100)
    dgs:dgsAlphaTo(data.keyboard.visibleButton, 1, "OutQuad", 100)
    data.keyboardRendered = true
    showCursor(true)
    setTimer(function()
        dgs:dgsFocus(data.keyboard.editBox)
    end, data.chatTimerFocus, 1)
end

function sendMessage()
    local text = dgs:dgsGetText(data.keyboard.editBox)
    if text == "" then return end
    
    if (string.sub(text, 1, 1) == "/") then
        triggerServerEvent("onCustomPlayerChat", localPlayer, text, localPlayer, "command")
        dgs:dgsSetText(data.keyboard.editBox, "")
        showOrHideKeyboard(false)
        return
    end

    triggerServerEvent("onCustomPlayerChat", localPlayer, text, localPlayer, "normal")
    dgs:dgsSetText(data.keyboard.editBox, "")
    showOrHideKeyboard(false)
end

function showOrHideKeyboard(state)
    if (state) then
        for _, v in pairs(data.keyboard) do
            dgs:dgsAlphaTo(v, 1, "OutQuad", 100)
        end
        -- dgs:dgsFocus(data.keyboard.editBox)
        data.keyBoardHided = false
        showCursor(true)
        if (data.scrollPane) then
            dgs:dgsScrollPaneSetScrollBarState(data.scrollPane, true, false)
        end
        if (isTimer(data.timer)) then
            killTimer(data.timer)
            data.timer = nil
        end
        setTimer(function()
            dgs:dgsFocus(data.keyboard.editBox)
        end, data.chatTimerFocus, 1)
    else
        for _, v in pairs(data.keyboard) do
            dgs:dgsAlphaTo(v, 0, "OutQuad", 100)
        end
        data.keyBoardHided = true
        showCursor(false)
        if (data.scrollPane) then
            dgs:dgsScrollPaneSetScrollBarState(data.scrollPane, false, false)
        end
        dgs:dgsBlur(data.keyboard.editBox)
        if (isTimer(data.timer)) then
            killTimer(data.timer)
            data.timer = nil
        end
    end
end


function onPlayerKey(button, press)
    if press then
        if button == "t" then
            if (not getElementData(localPlayer, "player::isLogged")) then return end
            if (data.keyBoardHided and data.keyboardRendered) then
                showOrHideKeyboard(true)
                data.timer = setTimer(function()
                    showOrHideKeyboard(false)
                    if (isTimer(data.timer)) then
                        killTimer(data.timer)
                        data.timer = nil
                    end
                end, data.timeTimer, 1)
                return
            end
            if (data.keyboardRendered) and (not data.keyBoardHided) then return end
            drawKeyBoard()
            if (isTimer(data.timer)) then
                killTimer(data.timer)
                data.timer = nil
            end
            data.timer = setTimer(function()
                showOrHideKeyboard(false)
                if (isTimer(data.timer)) then
                    killTimer(data.timer)
                    data.timer = nil
                end
            end, data.timeTimer, 1)
        end
    end
end

function onEditPlayerKey(button, press)
    if (source ~= data.keyboard.editBox) then return end
    if (not press) then
        if (isTimer(data.timer)) then
            killTimer(data.timer)
            data.timer = nil
        end
        data.timer = setTimer(function()
            showOrHideKeyboard(false)
            if (isTimer(data.timer)) then
                killTimer(data.timer)
                data.timer = nil
            end
        end, data.timeTimer, 1)
    else
        if (isTimer(data.timer)) then
            killTimer(data.timer)
            data.timer = nil
        end
    end
end

function onDgsMouseLeave()
    if (isTimer(data.timer)) then
        killTimer(data.timer)
        data.timer = nil
    end
    data.timer = setTimer(function()
        showOrHideKeyboard(false)
        if (isTimer(data.timer)) then
            killTimer(data.timer)
            data.timer = nil
        end
    end, data.timeTimer, 1)
end

function _getPlayerName(player)
    return "Jose Osorio"
end

function specialAction(action, dataAction)
    -- iprint()
    if (action == "badge") then
        if (dataAction.type == "dev") then
            iprint("aqui")
            exports.core_player:updateBadge("devmode")
        end
    end
end

function onNormalPlayerChat(by_player, message_player)
    if (not data.scrollPane) then
        drawChat()
        local hour = "["..getRealTime().hour..":"..getRealTime().minute..":"..getRealTime().second.."] "
        table.insert(data.messages, {
            by = by_player,
            message = message_player
        })
        for i = table.size(data.messages), 1, -1 do
            local y = i * 0.08
            local message = hour.." ".._getPlayerName(data.messages[i].by).." dice: "..data.messages[i].message
            local textWidth = dxGetTextWidth(message, 1, data.font)
            local txtAbs = textWidth * 0.001
            local h = txtAbs * 0.2
            local label = dgs:dgsCreateLabel(0, y, 1, h, message, true, data.scrollPane)
            table.insert(data.labels, label)
            dgs:dgsSetProperties(label, {
                font = data.font,
                textColor = tocolor(255, 255, 255, 120),
                alpha = 0,
                wordBreak = true,
                aligment = { "left", "center" },
                clip = false,
            })
            dgs:dgsAlphaTo(label, 1, "OutQuad", 100)
        end
    else
        local hour = "["..getRealTime().hour..":"..getRealTime().minute..":"..getRealTime().second.."] "
        table.insert(data.messages, {
            by = by_player,
            message = message_player
        })
        local message = hour.." ".._getPlayerName(by_player).." dice: "..message_player

        local sizeW, sizeH = dgs:dgsGetSize(data.labels[#data.labels], true)
        local sizeX, sizeY = dgs:dgsGetPosition(data.labels[#data.labels], true)

        local y = sizeY + sizeH + 0.01
        -- local h = string.len(message) * 0.004
        --iprint(dxGetTextWidth(message, 1, data.font))
        local textWidth = dxGetTextWidth(message, 1, data.font)
        -- convert to absolute
        local txtAbs = textWidth * 0.01
        local multiplier = 0.020
        if (txtAbs >= 3.7 and txtAbs < 4.8) then
            multiplier = 0.026
            --iprint(multiplier)
        elseif (txtAbs >= 4.8) then
            multiplier = 0.02
        end
        local h = txtAbs * multiplier
        iprint("txtAbs: "..txtAbs.." h: "..h)

        local label = dgs:dgsCreateLabel(0, y, 1, h, message, true, data.scrollPane)
        table.insert(data.labels, label)
        dgs:dgsSetProperties(label, {
            font = data.font,
            textColor = tocolor(255, 255, 255, 120),
            alpha = 0,
            wordBreak = true,
            clip = false,
        })
        dgs:dgsAlphaTo(label, 1, "OutQuad", 100)
        local scrollBar = dgs:dgsScrollPaneGetScrollBar(data.scrollPane)
        dgs:dgsScrollBarSetScrollPosition(scrollBar[1], 100)
    end
end

function onActionPlayerChat(by_player, message_player, command)
    if (not data.scrollPane) then
        drawChat()
        table.insert(data.messages, {
            by = by_player,
            message = message_player
        })
        for i = table.size(data.messages), 1, -1 do
            local y = i * 0.08
            local message = _getPlayerName(data.messages[i].by).." "..data.messages[i].message
            local label = dgs:dgsCreateLabel(0, y, 1, 0.1, message, true, data.scrollPane)
            table.insert(data.labels, label)
            dgs:dgsSetProperties(label, {
                font = data.font,
                textColor = validCommands[command].color,
                alpha = 0,
                wordBreak = true,
                aligment = { "left", "center" },
                clip = false,
                shadow = {
                    1,
                    1,
                    tocolor(0, 0, 0, 102),
                    1
                }
            })
            dgs:dgsAlphaTo(label, 1, "OutQuad", 100)
        end
    else
        table.insert(data.messages, {
            by = by_player,
            message = message_player
        })
        local message = _getPlayerName(by_player).." "..message_player

        local sizeW, sizeH = dgs:dgsGetSize(data.labels[#data.labels], true)
        local sizeX, sizeY = dgs:dgsGetPosition(data.labels[#data.labels], true)

        local y = sizeY + sizeH + 0.01
        local textWidth = dxGetTextWidth(message, 1, data.font)
        local txtAbs = textWidth * 0.01
        local h = txtAbs * 0.030

        local label = dgs:dgsCreateLabel(0, y, 1, h, message, true, data.scrollPane)
        table.insert(data.labels, label)
        dgs:dgsSetProperties(label, {
            font = data.font,
            textColor = validCommands[command].color,
            alpha = 0,
            wordBreak = true,
            clip = false,
            shadow = {
                1,
                1,
                tocolor(0, 0, 0, 102),
                1
            }
        })
        dgs:dgsAlphaTo(label, 1, "OutQuad", 100)
        local scrollBar = dgs:dgsScrollPaneGetScrollBar(data.scrollPane)
        dgs:dgsScrollBarSetScrollPosition(scrollBar[1], 100)
    end
end

function changeChatState()
    if (data.scrollPane) then
        dgs:dgsSetVisible(data.scrollPane, not data.chatVisible)
        data.chatVisible = not data.chatVisible
    end
    showOrHideKeyboard(false)
end

-------------------------------- EVENTS --------------------------------

addEventHandler("onClientKey", root, onPlayerKey)
addEventHandler("onDgsKey", root, onEditPlayerKey)
addEventHandler("onDgsMouseLeave", root, onDgsMouseLeave)
-- addeventHandler("onDgsEditAccepted", )

addEvent("onNormalPlayerChat", true)
addEventHandler("onNormalPlayerChat", root, onNormalPlayerChat)

addEvent("onActionPlayerChat", true)
addEventHandler("onActionPlayerChat", root, onActionPlayerChat)

addEvent("chat::specialAction", true)
addEventHandler("chat::specialAction", root, specialAction)