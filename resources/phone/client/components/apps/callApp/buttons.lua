---@diagnostic disable: undefined-global
local screenX, screenY = dgsGetScreenSize()

function DrawKeypadButtons()

    -- circles

    local circle = dgsCreateCircle(0.5, 0, 360, tocolor(180, 180, 180, 255))
    local circle2 = dgsCreateCircle(0.5, 0, 360, tocolor(120, 120, 120, 255))

    Async:iterate(1, 12, function(i)
        local y = screenY * 0.2
        local x = screenX * 0.035
        if (i > 9) then
            y = screenY * 0.2 + screenY * 0.07 * 3.35
            x = (screenX * 0.002) - screenX * 0.4072
        elseif (i > 6) then
            y = screenY * 0.2 + screenY * 0.07 * 2.23
            x = (screenX * 0.002) - screenX * 0.2602
        elseif (i > 3) then
            y = screenY * 0.2 + screenY * 0.07 * 1.1
            x = (screenX * 0.002) - screenX * 0.1135
        end
        CallData["circle"..tostring(i)] = dgsCreateImage(x + (screenX * 0.049 * (i - 1)), y, screenX * 0.035, screenY * 0.06, circle, false, data["appScreen"]["callApp"]["skeleton"])
        
        if (not isEventHandlerAdded("onDgsMouseEnter", CallData["circle"..tostring(i)])) then
            addEventHandler("onDgsMouseEnter", CallData["circle"..tostring(i)], function()
                if (source ~= CallData["circle"..tostring(i)]) then return end
                if (isElement(CallData["circle"..tostring(i)])) then
                    dgsImageSetImage(CallData["circle"..tostring(i)], circle2)
                end

            end)
            if ((isEventHandlerAdded("onDgsMouseLeave", CallData["circle"..tostring(i)]))) then
                removeEventHandler("onDgsMouseLeave", CallData["circle"..tostring(i)], function()
                end)
            end
        end

        if (not isEventHandlerAdded("onDgsMouseLeave", CallData["circle"..tostring(i)])) then
            addEventHandler("onDgsMouseLeave", CallData["circle"..tostring(i)], function()
                if (source ~= CallData["circle"..tostring(i)]) then return end
                if (isElement(CallData["circle"..tostring(i)])) then
                    dgsImageSetImage(CallData["circle"..tostring(i)], circle)
                end
            end)
            
            if ((isEventHandlerAdded("onDgsMouseEnter", CallData["circle"..tostring(i)]))) then
                removeEventHandler("onDgsMouseEnter", CallData["circle"..tostring(i)], function()
                end)
            end
        end

        if (not isEventHandlerAdded("onDgsMouseClickDown", CallData["circle"..tostring(i)])) then
            addEventHandler("onDgsMouseClickDown", CallData["circle"..tostring(i)], function()
                if (source ~= CallData["circle"..tostring(i)]) then return end
                
                local number = tostring(i)
                if (number == "11") then
                    number = "0"
                end
                if not (number == "10" or number == "12") then
                    AddNewNumber(number)
                end
            end)
        end
    end)

    -- numeros

    Async:iterate(1, 12, function(i)
        local x, y = screenX * 0.0098, screenY * 0.012
        local number = string.format("assets/callapp/numbers/%s.png", tostring(i))

        if (i > 9) then
            y = screenY * 0.012 + screenY * 0.07 * 0.055
            x = (screenX * 0.0098) - screenX * (5.8 ^ (-4))
        elseif (i > 6) then
            y = screenY * 0.012 + screenY * 0.07 * 0.03
            x = (screenX * 0.0098) - screenX * (6.2 ^ (-4))
        elseif (i > 3) then
            y = screenY * 0.012 + screenY * 0.007 * 0.1
            x = (screenX * 0.0098) - screenX * (6 ^ (-4))
        end

        CallData["numbers"..tostring(i)] = dgsCreateImage(x, y, screenX * 0.015, screenY * 0.035, number, false, CallData["circle"..tostring(i)])
        
        if (not isEventHandlerAdded("onDgsMouseEnter", CallData["numbers"..tostring(i)])) then
            addEventHandler("onDgsMouseEnter", CallData["numbers"..tostring(i)], function()
                if (source ~= CallData["numbers"..tostring(i)]) then return end
                if (isElement(CallData["numbers"..tostring(i)])) then
                    dgsImageSetImage(CallData["circle"..tostring(i)], circle2)
                end

            end)
            if ((isEventHandlerAdded("onDgsMouseLeave", CallData["numbers"..tostring(i)]))) then
                removeEventHandler("onDgsMouseLeave", CallData["numbers"..tostring(i)], function()
                end)
            end
        end

        if (not isEventHandlerAdded("onDgsMouseLeave", CallData["numbers"..tostring(i)])) then
            addEventHandler("onDgsMouseLeave", CallData["numbers"..tostring(i)], function()
                if (source ~= CallData["numbers"..tostring(i)]) then return end
                if (isElement(CallData["numbers"..tostring(i)])) then
                    dgsImageSetImage(CallData["circle"..tostring(i)], circle)
                end
            end)
            
            if ((isEventHandlerAdded("onDgsMouseEnter", CallData["numbers"..tostring(i)]))) then
                removeEventHandler("onDgsMouseEnter", CallData["numbers"..tostring(i)], function()
                end)
            end
        end

        if (not isEventHandlerAdded("onDgsMouseClickDown", CallData["numbers"..tostring(i)])) then
            addEventHandler("onDgsMouseClickDown", CallData["numbers"..tostring(i)], function()
                if (source ~= CallData["numbers"..tostring(i)]) then return end
                
                local number = tostring(i)
                if (number == "11") then
                    number = "0"
                end

                if not (number == "10" or number == "12") then
                    AddNewNumber(number)
                end
            end)
        end
    end)
end