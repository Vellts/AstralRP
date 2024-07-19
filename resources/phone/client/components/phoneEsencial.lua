local hours = 0
local time = 0

function PhoneEsencial(parent)
    
    local screenX, screenY = dgsGetScreenSize()
    -- battery icon
    -- local batteryImage = dgsCreateImage(screenX * 0.168, screenY * 0.028, screenX * 0.01, screenY * 0.01, "assets/battery_icon.png", false, parent) 
    local batteryImage = dgsCreateImage(screenX * 0.17, screenY * 0.018, screenX * 0.0135, screenY * 0.032, "assets/battery_icon.png", false, parent) 
    local wifiImage = dgsCreateImage(screenX * 0.1598, screenY * 0.026, screenX * 0.01, screenY * 0.016, "assets/wifi_icon.png", false, parent)
    local signalImage = dgsCreateImage(screenX * 0.149, screenY * 0.026, screenX * 0.009, screenY * 0.016, "assets/signal_icon.png", false, parent)

    -- hours
    time = getHours()
    local textSize = 0.5 * (screenX / 1920) * 1.5

    hours = dgsCreateLabel(screenX * 0.027, screenY * 0.02, screenX * 0.022, screenY * 0.02, time, false, parent)
    dgsSetProperties(hours, {
        ["font"] = data["globalFonts"]["SemiBold"],
        ["textSize"] = { textSize, textSize },
        ["shadow"] = { 0, 0, tocolor(20, 20, 20, 255), 2 },
    })

    data["timerHours"] = setTimer(ChangeHour, 60000, 0)

    return batteryImage, wifiImage, signalImage
end

function ChangeHour()
    time = getHours()

    dgsSetProperty(hours, "text", time)

end
