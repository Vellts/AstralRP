local intensidad = 800
Time_Astronomic_Interval = 1000 * 60 * 2

--- Cosas a tomar en cuenta:
-- setWindVelocity
-- setWeatherBlended / getWeather
-- setRainLevel


--[[
    Esta función se encarga de inicializar el ciclo de tiempo.
    Se encarga de obtener la última hora registrada en un archivo xml.

]]
---@return nil
function InitCycle()
    --@TODO: Obtener ultima hora registrada en un xml
    local last_hour_saved = 12
    local last_minute_saved = 43
    setTime(last_hour_saved, last_minute_saved)
    SetWorldTime()
    setWeather(1)
    setTimer(SetBasicAstronomicEvent, Time_Astronomic_Interval, 0)
end

--[[
    Establece la hora y los minutos, correspondiendo al intervalo [time_interval], fijado en el meta.xml.
]]
---@return nil
function SetWorldTime()
    local interval = get("time_interval") or 1000
    setTimer(function()
        local hour, minute = getTime()
        setTime(hour, minute + 1)
    end, interval, 0)
end

--[[
    Se encarga de establecer el color del cielo y la niebal en función del tiempo.
]]
---@return nil
function SetWorldProperties()
    local hour, minute = getTime()
    local transformed_hour = hour + (minute / 60)
    local transformed_minute = minute + (hour * 60)
    
    if ((transformed_hour >= 20) and (transformed_hour <= 23)) then
        if (transformed_hour <= 23) then
            --Se establece el color del cielo en función de la hora.
            setSkyGradient(Clr(168, transformed_hour), Clr(135, transformed_hour), Clr(84, transformed_hour), Clr(136, transformed_hour), Clr(91, transformed_hour), Clr(61, transformed_hour))
        end
        if ((transformed_hour >= 21) and (transformed_hour <= 23)) then
            --Se establece la niebla en función de la hora.
            setFogDistance(-intensidad + (intensidad/120 * (1400 - transformed_minute)))
        end
    elseif (((transformed_hour > 23) and (transformed_hour <= 24)) or ((transformed_hour >= 0) and (transformed_hour < 2))) then
        -- Establece la niebla lo más intensa posible.
        setFogDistance(-intensidad)
        --Se establece el color del cielo a negro.
        setSkyGradient(0, 0, 0, 0, 0, 0)
    elseif ((transformed_hour >= 2) and (transformed_hour <= 5)) then
        setSkyGradient(Uclr(168/10, hour), Uclr(135/10, transformed_hour), Uclr(84/10, transformed_hour), Uclr(136/10, transformed_hour), Uclr(91/10, transformed_hour), Uclr(61/10, transformed_hour))
		setFogDistance(-intensidad + (intensidad/180 * (transformed_minute-120)))
    elseif ((transformed_hour > 5) and (transformed_hour < 20)) then
        resetSkyGradient()
    end
end
setTimer(SetWorldProperties, 100, 0)

addEventHandler("onResourceStart", resourceRoot, InitCycle)

addCommandHandler("sweather", function(player, cmd, weather)
    setWeatherBlended(tonumber(weather))
end)