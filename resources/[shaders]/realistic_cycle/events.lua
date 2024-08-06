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
