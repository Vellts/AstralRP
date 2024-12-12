--[[
    Registra los eventos de los ciclos astronómicos
]]
---@param oldEvent string
---@param newEvent string
---@return nil
function OnAstronomicEventChange(oldEvent, newEvent)
    if (not oldEvent) or (not newEvent) then
        return
    end
    outputDebugString("Evento astronomico cambiado de " .. oldEvent .. " a " .. newEvent..".", 3)
    
end
addEvent("NH>>onAstronomicEventChange", true)
addEventHandler("NH>>onAstronomicEventChange", resourceRoot, OnAstronomicEventChange)

--[[
    Registra los eventos aleatorios de los ciclos astronómicos.
]]
---@param newEvent string
---@param args table
---@return nil
function onAstronomicRandomEvent(newEvent, args)
    if (not newEvent) or (not args) then
        return
    end
    outputDebugString("Evento aleatorio ha sido cambiado a "..newEvent..". Con argumentos: "..inspect(args), 3)
    
end
addEvent("NH>>onAstronomicRandomEvent", true)
addEventHandler("NH>>onAstronomicRandomEvent", resourceRoot, onAstronomicRandomEvent)
