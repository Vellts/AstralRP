---@diagnostic disable: undefined-global
local screenX, screenY = dgsGetScreenSize()

function DrawAppCallIcon()
    local image = dgsCreateImage(screenX * 0.085, screenY * 0.51, screenX * 0.035, screenY * 0.055, "assets/callapp/call_icon.png", false, data["appScreen"]["callApp"]["skeleton"])

    if (not isEventHandlerAdded("onDgsMouseEnter", image)) then
        addEventHandler("onDgsMouseEnter", image, function()
            if (source ~= image) then return end
            
            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/call_icon2.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseLeave", image)) then
            removeEventHandler("onDgsMouseLeave", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseLeave", image)) then
        addEventHandler("onDgsMouseLeave", image, function()
            if (source ~= image) then return end

            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/call_icon.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseEnter", image)) then
            removeEventHandler("onDgsMouseEnter", image, function() end)
        end
    end

    return image
end

function DrawAppRemoveIcon()
    local image = dgsCreateImage(screenX * 0.138, screenY * 0.52, screenX * 0.0255, screenY * 0.0362, "assets/callapp/delete_icon.png", false, data["appScreen"]["callApp"]["skeleton"])
    
    if (not isEventHandlerAdded("onDgsMouseEnter", image)) then
        addEventHandler("onDgsMouseEnter", image, function()
            if (source ~= image) then return end
            
            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/delete_icon2.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseLeave", image)) then
            removeEventHandler("onDgsMouseLeave", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseLeave", image)) then
        addEventHandler("onDgsMouseLeave", image, function()
            if (source ~= image) then return end

            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/delete_icon.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseEnter", image)) then
            removeEventHandler("onDgsMouseEnter", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseClickDown", image)) then
        addEventHandler("onDgsMouseClickDown", image, function()
            if (source ~= image) then return end

            RemoveNewNumber()
        end)
    end

    return image
end

function DrawAppKeyPadIcon()
    local image = dgsCreateImage(screenX * 0.147, screenY * 0.575, screenX * 0.0315, screenY * 0.042, (CallData["hover"] == "keypad") and "assets/callapp/teclado2.png" or "assets/callapp/teclado.png", false, data["appScreen"]["callApp"]["skeleton"])

    if (not isEventHandlerAdded("onDgsMouseEnter", image)) then
        addEventHandler("onDgsMouseEnter", image, function()
            if (source ~= image) then return end
            
            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/teclado2.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseLeave", image)) then
            removeEventHandler("onDgsMouseLeave", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseLeave", image)) then
        addEventHandler("onDgsMouseLeave", image, function()
            if (source ~= image) then return end

            -- iprint(not (CallData["hover"] == "keypad"))
            if (isElement(image) and (not (CallData["hover"] == "keypad"))) then
                dgsImageSetImage(image, "assets/callapp/teclado.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseEnter", image)) then
            removeEventHandler("onDgsMouseEnter", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseClickDown", image)) then
        addEventHandler("onDgsMouseClickDown", image, function()
            if (source ~= image) then return end

            if (isElement(image) and (not (CallData["hover"] == "keypad"))) then
                dgsImageSetImage(image, "assets/callapp/teclado2.png")
                
                -- change screen

                ChangeScreenApp("keypad")

                -- iprint("to keypad")
                -- CallData["hover"] = "keypad"
            end
        end)
    end

    return image
end

function DrawAppContactsIcon()
    local image = dgsCreateImage(screenX * 0.105, screenY * 0.575, screenX * 0.0315, screenY * 0.042, (CallData["hover"] == "contacts") and "assets/callapp/contactos2.png" or "assets/callapp/contactos.png", false, data["appScreen"]["callApp"]["skeleton"])

    if (not isEventHandlerAdded("onDgsMouseEnter", image)) then
        addEventHandler("onDgsMouseEnter", image, function()
            if (source ~= image) then return end
            
            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/contactos2.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseLeave", image)) then
            removeEventHandler("onDgsMouseLeave", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseLeave", image)) then
        addEventHandler("onDgsMouseLeave", image, function()
            if (source ~= image) then return end

            if (isElement(image) and (not (CallData["hover"] == "contacts"))) then
                dgsImageSetImage(image, "assets/callapp/contactos.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseEnter", image)) then
            removeEventHandler("onDgsMouseEnter", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseClickDown", image)) then
        addEventHandler("onDgsMouseClickDown", image, function()
            if (source ~= image) then return end

            if (isElement(image) and (not (CallData["hover"] == "contacts"))) then
                dgsImageSetImage(image, "assets/callapp/contactos2.png")
                
                -- change screen
                -- iprint("to contacts")
                ChangeScreenApp("contacts")
                -- CallData["hover"] = "contacts"
            end
        end)
    end

    return image
end

function DrawAppRecentsIcon()
    local image = dgsCreateImage(screenX * 0.065, screenY * 0.575, screenX * 0.0315, screenY * 0.042, (CallData["hover"] == "recents") and "assets/callapp/recientes2.png" or "assets/callapp/recientes.png", false, data["appScreen"]["callApp"]["skeleton"])

    if (not isEventHandlerAdded("onDgsMouseEnter", image)) then
        addEventHandler("onDgsMouseEnter", image, function()
            if (source ~= image) then return end
            
            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/recientes2.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseLeave", image)) then
            removeEventHandler("onDgsMouseLeave", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseLeave", image)) then
        addEventHandler("onDgsMouseLeave", image, function()
            if (source ~= image) then return end

            if (isElement(image) and (not (CallData["hover"] == "recents"))) then
                dgsImageSetImage(image, "assets/callapp/recientes.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseEnter", image)) then
            removeEventHandler("onDgsMouseEnter", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseClickDown", image)) then
        addEventHandler("onDgsMouseClickDown", image, function()
            if (source ~= image) then return end

            if (isElement(image) and (not (CallData["hover"] == "recents"))) then
                dgsImageSetImage(image, "assets/callapp/recientes2.png")
                
                -- change screen
                ChangeScreenApp("recents")

            end
        end)
    end

    return image
end

function DrawAppFavoritesIcon()
    local image = dgsCreateImage(screenX * 0.028, screenY * 0.575, screenX * 0.0315, screenY * 0.042, (CallData["hover"] == "favorites") and "assets/callapp/favoritos2.png" or "assets/callapp/favoritos.png", false, data["appScreen"]["callApp"]["skeleton"])

    if (not isEventHandlerAdded("onDgsMouseEnter", image)) then
        addEventHandler("onDgsMouseEnter", image, function()
            if (source ~= image) then return end
            
            if (isElement(image)) then
                dgsImageSetImage(image, "assets/callapp/favoritos2.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseLeave", image)) then
            removeEventHandler("onDgsMouseLeave", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseLeave", image)) then
        addEventHandler("onDgsMouseLeave", image, function()
            if (source ~= image) then return end

            if (isElement(image) and (not (CallData["hover"] == "favorites"))) then
                dgsImageSetImage(image, "assets/callapp/favoritos.png")
            end
        end)

        if (isEventHandlerAdded("onDgsMouseEnter", image)) then
            removeEventHandler("onDgsMouseEnter", image, function() end)
        end
    end

    if (not isEventHandlerAdded("onDgsMouseClickDown", image)) then
        addEventHandler("onDgsMouseClickDown", image, function()
            if (source ~= image) then return end

            if (isElement(image) and (not (CallData["hover"] == "favorites"))) then
                dgsImageSetImage(image, "assets/callapp/favoritos2.png")
                
                -- change screen
                ChangeScreenApp("favorites")
            end
        end)
    end
    
    return image
end

function UpdateIcons(newHover)
    if (not isElement(data["appScreen"]["callApp"]["skeleton"])) then return end

    if (newHover == "keypad") then
        dgsImageSetImage(CallData["keypad"], "assets/callapp/teclado2.png")
        dgsImageSetImage(CallData["contacts"], "assets/callapp/contactos.png")
        dgsImageSetImage(CallData["recents"], "assets/callapp/recientes.png")
        dgsImageSetImage(CallData["favorites"], "assets/callapp/favoritos.png")
    elseif (newHover == "contacts") then
        dgsImageSetImage(CallData["keypad"], "assets/callapp/teclado.png")
        dgsImageSetImage(CallData["contacts"], "assets/callapp/contactos2.png")
        dgsImageSetImage(CallData["recents"], "assets/callapp/recientes.png")
        dgsImageSetImage(CallData["favorites"], "assets/callapp/favoritos.png")
    elseif (newHover == "recents") then
        dgsImageSetImage(CallData["keypad"], "assets/callapp/teclado.png")
        dgsImageSetImage(CallData["contacts"], "assets/callapp/contactos.png")
        dgsImageSetImage(CallData["recents"], "assets/callapp/recientes2.png")
        dgsImageSetImage(CallData["favorites"], "assets/callapp/favoritos.png")
    elseif (newHover == "favorites") then
        dgsImageSetImage(CallData["keypad"], "assets/callapp/teclado.png")
        dgsImageSetImage(CallData["contacts"], "assets/callapp/contactos.png")
        dgsImageSetImage(CallData["recents"], "assets/callapp/recientes.png")
        dgsImageSetImage(CallData["favorites"], "assets/callapp/favoritos2.png")
    end
end
