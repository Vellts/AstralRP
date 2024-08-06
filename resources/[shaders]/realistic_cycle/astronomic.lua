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
    iprint(isTransitioning, (oldWeather == isTransitioning), table.size(lastTransitions))
    if (not isTransitioning) or (oldWeather == isTransitioning) or (table.size(lastTransitions) >= 3) then

        if (table.size(lastTransitions) >= 3) then
            -- verificar que los 3 eventos sean iguales
            if (table.isEquals(lastTransitions)) then
                iprint(":)")
                lastTransitions = {}
                index = 1
                return ManageAstronomicsEvents(oldWeather)
            end
        end
        iprint("1.")
        ManageAstronomicsEvents(oldWeather)
    else
        iprint(oldWeather, isTransitioning)
    end
end

--[[
    Maneja los eventos astronomicos.
]]
---@param oldWeather number
---@return nil
function ManageAstronomicsEvents(oldWeather)
    iprint("boombastic", oldWeather)
    local random_number = math.random(1, 100)
    if (random_number > 0) and (random_number <= 25) then
        setWeatherBlended(Weather.LLUVIA_BAJO)
    elseif (random_number > 25) and (random_number <= 45) then
        setWeatherBlended(Weather.LLUVIA_BAJO)
    elseif (random_number > 45) and (random_number <= 63) then
        setWeatherBlended(Weather.NIEBLA_ALTO)
    elseif (random_number > 63) and (random_number <= 78) then
        setWeatherBlended(Weather.NUBLADO_ALTO)
    elseif (random_number > 78) and (random_number <= 88) then
        setWeatherBlended(Weather.SOLEADO_ALTO)
    elseif (random_number > 88) and (random_number <= 97) then
        setWeatherBlended(Weather.LLUVIA_BAJO)
    elseif (random_number > 97) and (random_number <= 100) then
        setWeatherBlended(Weather.LLUVIA_ALTO)
    end
    local _, newWeather = getWeather()
    triggerEvent("NH>>onAstronomicEventChange", resourceRoot, Weather_names[oldWeather], Weather_names[newWeather])
end