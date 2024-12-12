--[[
    Si ticksCount alcanza el numero 3, reelije a un siguiente evento astronomico.
]]
local lastTransitions = {}
local index = 1

--[[
    Gestiona eventos astronomicos, tales como la lluvia, truenos, nubes, etc.
]]
---@return nil
function SetBasicAstronomicEvent()
    local oldWeather, isTransitioning = getWeather()

    lastTransitions[index] = oldWeather
    index = index + 1
    if (not isTransitioning) or (oldWeather == isTransitioning) or (table.size(lastTransitions) >= 3) then

        if (table.size(lastTransitions) >= 3) then
            -- verificar que los 3 eventos sean iguales
            if (table.isEquals(lastTransitions)) then
                lastTransitions = {}
                index = 1
                return ManageAstronomicsEvents(oldWeather)
            end
        end
        ManageAstronomicsEvents(oldWeather)
    else
        -- iprint(oldWeather, isTransitioning)
    end
end

--[[
    Maneja los eventos astronomicos.
]]
---@param oldWeather number
---@return nil
function ManageAstronomicsEvents(oldWeather)
    local rn = math.random(1, 100) -- numero random
    if (rn > 0) and (rn <= 3) then
        setWeatherBlended(Weather["TORMENTA"])
    elseif (rn > 3) and (rn <= 18) then
        setWeatherBlended(Weather["SOLEADO_BAJO"])
    elseif (rn > 18) and (rn <= 35) then
        setWeatherBlended(Weather["SOLEADO_ALTO"])
    elseif (rn > 35) and (rn <= 80) then
        setWeatherBlended(Weather["NUBLADO_ALTO"])
    elseif (rn > 80) and (rn <= 100) then
        setWeatherBlended(Weather["NUBLADO_BAJO"])
    end

    local _, newWeather = getWeather()
    triggerEvent("NH>>onAstronomicEventChange", resourceRoot, Weather_names[oldWeather], Weather_names[newWeather])
end

--[[
    Establece un evento aleatorio. Tales como viento o lluvia.
    Nada: 60%
    Viento bajo: 25%
    Viento alto: 10%
    Lluvia: 5%
]]
---@return nil
function SetRandomEvent()
    local rn = math.random(1, 100) -- numero random
    if (rn > 0) and (rn <= 5) then
        -- Si ya hay tormenta, no se puede establecer otro evento.
        if (getWeather() == Weather["TORMENTA"]) then return end
        ResetEvents()
        setRainLevel(1)
        triggerEvent("NH>>onAstronomicRandomEvent", resourceRoot, "RAIN", { level = 1 })
    elseif (rn > 5) and (rn <= 15) then
        ResetEvents()
        local x = math.random(1, 10)
        local y = 3
        local z = 2
        setWindVelocity(x, y, z)
        triggerEvent("NH>>onAstronomicRandomEvent", resourceRoot, "Viento alto", { x = x, y = y, z = z })
    elseif (rn > 15) and (rn <= 40) then
        ResetEvents()
        local x = math.random(1, 3)
        local y = 3
        local z = 2
        setWindVelocity(x, y, z)
        triggerEvent("NH>>onAstronomicRandomEvent", resourceRoot, "Viento bajo", { x = x, y = y, z = z })
    else
        ResetEvents()
        triggerEvent("NH>>onAstronomicRandomEvent", resourceRoot, "NOTHING", {})
    end
end
setTimer(SetRandomEvent, (1000 * 60 * 15), 0)

--[[
    Reinicia los eventos.
]]
---@return nil
function ResetEvents()
    resetRainLevel()
    setWindVelocity(0, 0, 0)
end
