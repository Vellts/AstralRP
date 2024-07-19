---@diagnostic disable: undefined-global

function ChangeScreenApp(newScreen)

    if (type(newScreen) ~= "string") then return end

    if (newScreen == "keypad" and (CallData["hover"]) ~= "keypad") then

        RemoveScreenAppDraw(CallData["hover"])
        
        DrawKeyPadScreen()
        UpdateIcons("keypad")
        CallData["hover"] = "keypad"

    elseif (newScreen == "contacts" and (CallData["hover"]) ~= "contacts") then
        RemoveScreenAppDraw(CallData["hover"])

        -- iprint(CallData["contactSearchStatus"])
        if (CallData["contactSearchStatus"]) then
            CallData["contactSearchStatus"] = false
        end
        
        DrawContactsScreen()
        UpdateIcons("contacts")
        CallData["hover"] = "contacts"
        

    elseif (newScreen == "favorites" and (CallData["hover"]) ~= "favorites") then
        RemoveScreenAppDraw(CallData["hover"])
        
        UpdateIcons("favorites")
        CallData["hover"] = "favorites"
    elseif (newScreen == "recents" and (CallData["hover"]) ~= "recents") then
        RemoveScreenAppDraw(CallData["hover"])
        
        UpdateIcons("recents")
        CallData["hover"] = "recents"
    end
end

local keypadInmutableValues = {
    ["favorites"] = true,
    ["contacts"] = true,
    ["recents"] = true,
    ["keypad"] = true,
    ["text"] = true,
    ["hover"] = true,
}

function RemoveScreenAppDraw(screen)
    -- OutTransitionScreenApp("call", keypadInmutableValues)
    Async:mapTable(CallData, function(k, v)
        if (not keypadInmutableValues[v]) then
            if (isElement(k)) then

                destroyElement(k)
            
                if (CallData[v]) then
                    CallData[v] = nil
                end
            end
        end
    end)
end
