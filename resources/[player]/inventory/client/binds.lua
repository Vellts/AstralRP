local last_id_action = 0
local oldColor = tocolor(31, 27, 27, 245)
local newColor = tocolor(33, 31, 68, 220)

function ExecuteItemAction(key)
    -- iprint("ExecuteItemAction;", "key:", key)
    local parseKey = tonumber(key)
    for key, slot in pairs(Items_dgs.mini_menu.slots) do
        -- iprint(key, value)
        -- iprint(slot.id, parseKey)
        if (slot.id == parseKey) then
            if (last_id_action == slot.id) then
                -- change last slot color
                local color = oldColor
                local shader = Items_dgs.shaders[key]
                exports.dgs:dgsRoundRectSetColor(shader, color)
                last_id_action = 0
            else
                -- change slot color
                local color = newColor
                local shader = Items_dgs.shaders[key]
                exports.dgs:dgsRoundRectSetColor(shader, color)
                last_id_action = slot.id
            end
        else
            if (last_id_action ~= 0) then
                -- change last slot color
                local color = oldColor
                local shader = Items_dgs.shaders[key]
                exports.dgs:dgsRoundRectSetColor(shader, color)
            end
        end
    end
end
bindKey("1", "down", ExecuteItemAction)
bindKey("2", "down", ExecuteItemAction)
bindKey("3", "down", ExecuteItemAction)
bindKey("4", "down", ExecuteItemAction)