interactionInfo = {}

function createNotification(player, type, info)
    if (not player or not type or not info) then return end
    if (not isElement(player)) then return end

    info["type"] = type
    if (type == "interaction") then
        table.insert(interactionInfo, info)
        -- iprint(interactionInfo)
    end
    triggerClientEvent(player, "GL_Core::client::notification", player, type, info)
end

function removeInteractionNotification(player, type)
    -- iprint(type)
    triggerClientEvent(player, "GL_Core::client::removeNotification", player, type)
end

