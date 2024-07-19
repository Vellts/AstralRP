---@diagnostic disable: undefined-global

function OutTransitionScreenApp(app, inmutables)

    if (not app) then return end

    if (app == "call") then
        Async:mapTable(CallData, function(k, v)
            if (not inmutables[v]) then
                if (isElement(k)) then
                    dgsAlphaTo(k, 0, "InQuad", 300)
                end
                -- dgsAlphaTo(k, 0, "InQuad", 300)
            end
        end)
    end
end

function DgsAnimateTextColor(text, oldColor, newColor)
    if (not text) or (not newColor) or (not oldColor) then return end
    if (not isElement(text)) then return end

    if (not isEventHandlerAdded("onDgsMouseEnter", text)) then
        addEventHandler("onDgsMouseEnter", text, function()

            if (source ~= text) then return end

            dgsSetProperty(text, "textColor", newColor)
        end)
    elseif (isEventHandlerAdded("onDgsMouseEnter", text)) then
        removeEventHandler("onDgsMouseEnter", text, function()end)
    end

    if (not isEventHandlerAdded("onDgsMouseLeave", text)) then
        addEventHandler("onDgsMouseLeave", text, function()

            if (source ~= text) then return end


            dgsSetProperty(text, "textColor", oldColor)
        end)
    elseif (isEventHandlerAdded("onDgsMouseLeave", text)) then
        removeEventHandler("onDgsMouseLeave", text, function()end)
    end
end

function DgsAnimateChildAndParentColor(parent, oldColor, newColor, only_text)
    if (not parent) or (not newColor) or (not oldColor) then return end
    if (not isElement(parent)) then return end
    if not (only_text) then only_text = false end

    if (getElementType(parent) == 'dgs-dximage') then
        if (only_text == true) and (type(oldColor) == 'number') and (type(newColor) == 'number') then
            if (not isEventHandlerAdded("onDgsMouseEnter", parent)) then
                addManyEventHandler("onDgsMouseEnter", dgsGetChildren(parent), function()
                    if (table.hasValue(dgsGetChildren(parent), source) or source == parent) then
                        local labelChilds = DgsGetChildByElementType(parent, 'dgs-dxlabel')
                        for i = 1, #labelChilds do
                            dgsSetProperty(labelChilds[i], "textColor", newColor)
                        end
                    end
                end)
            end
        
            if (not isEventHandlerAdded("onDgsMouseLeave", parent)) then
                addManyEventHandler("onDgsMouseLeave", dgsGetChildren(parent), function()
                    if (table.hasValue(dgsGetChildren(parent), source) or source == parent) then
                        local labelChilds = DgsGetChildByElementType(parent, 'dgs-dxlabel')
                        for i = 1, #labelChilds do
                            dgsSetProperty(labelChilds[i], "textColor", oldColor)
                        end
                    end
                end)
            end
        
            return
        elseif (getElementType(oldColor) == 'shader') and (getElementType(newColor) == 'shader') then
            if (not isEventHandlerAdded("onDgsMouseEnter", parent)) then
                addManyEventHandler("onDgsMouseEnter", dgsGetChildren(parent), function()
                    if (table.hasValue(dgsGetChildren(parent), source) or source == parent) then
                        dgsSetProperty(parent, "image", newColor)
                    end
                end)
            end

            if (not isEventHandlerAdded("onDgsMouseLeave", parent)) then
                addManyEventHandler("onDgsMouseLeave", dgsGetChildren(parent), function()
                    if (table.hasValue(dgsGetChildren(parent), source) or source == parent) then
                        dgsSetProperty(parent, "image", oldColor)
                    end
                end)
            end
        end
    else
        if (not isEventHandlerAdded("onDgsMouseEnter", parent)) then
            addEventHandler("onDgsMouseEnter", parent, function()
                if (source == parent) then
                    dgsSetProperty(parent, "color", newColor)
                end
            end)
        end

        if (not isEventHandlerAdded("onDgsMouseLeave", parent)) then
            addEventHandler("onDgsMouseLeave", parent, function()
                if (source == parent) then
                    dgsSetProperty(parent, "color", oldColor)
                end
            end)
        end
    end
end
