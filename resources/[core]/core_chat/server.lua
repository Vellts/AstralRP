addEventHandler("onChatMessage", root, function()
    cancelEvent()
end)

function onCustomPlayerChat(message, by, typeMessage)
    if (type(message) ~= "string") or (getElementType(by) ~= "player") or (type(typeMessage) ~= "string") or (getElementType(client) ~= "player") then
        return
    end
    if (string.len(message) < 1) or (string.len(message) > 50) then
        return
    end

    local x, y, z = getElementPosition(by)
    local getPlayers = getElementsWithinRange(x, y, z, 20, "player")
    if (typeMessage == "normal") then
        if (table.size(getPlayers) >= 1) then
            if (string.sub(message, string.len(message)) == " ") then
                message = string.sub(message, 1, string.len(message) - 1)
            end
            if (string.sub(message, string.len(message)) ~= ".") then
                message = message .. "."
            end
            triggerClientEvent(getPlayers, "onNormalPlayerChat", by, by, message)
        end
    elseif (typeMessage == "command") then
        local command = string.match(message, "^%S+")
        local isValid = validCommands[string.gsub(command, "/", "")]
        if (isValid) then
            if isValid.needAdmin then
                setElementData(by, "player::devmode", not getElementData(by, "player::devmode"))
                exports["dev_info"]:updateChartsDeveloper(by, getElementData(by, "player::devmode"))
                -- iprint(exports["dev_info"])
                triggerClientEvent(by, "chat::specialAction", by, "badge", {
                    type = "dev"
                })
            end
            if isValid.needPremium then return end 

            if (isValid.chatAction) then
                if (table.size(getPlayers) >= 1) then
                    local new_message = string.sub(message, string.len(command) + 2)
                    if (string.sub(new_message, string.len(new_message)) ~= ".") then
                        new_message = new_message .. "."
                    end

                    triggerClientEvent(getPlayers, "onActionPlayerChat", by, by, new_message, string.gsub(command, "/", ""))
                end
            end
        end
    end
end
addEvent("onCustomPlayerChat", true)
addEventHandler("onCustomPlayerChat", root, onCustomPlayerChat)