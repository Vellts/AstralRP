local time = 0
local hoursLabel = nil

function RenderDates(parent)
    local screenX, screenY = dgsGetScreenSize()

    -- fecha

    local time = getRealTime()
    local month = normalizeMonths[time.month + 1]
    local day = time.monthday
    local weekday = normalizeWeeks[time.weekday]
    local dateText = string.format("%s, %s de %s", weekday, day, month)
    local textSize = 0.8 * (screenX / 1920) * 1.02

    local dateLabel = dgsCreateLabel(screenX * 0.032, screenY * 0.1, screenX * 0.12, screenY * 0.04, dateText, false, parent)
    dgsSetProperties(dateLabel, {
        ["font"] = data["globalFonts"]["Bold"],
        ["textSize"] = { textSize, textSize }
    })

    -- tiempo

    time = getHours()
    local textSize2 = 1.4 * (screenX / 1920) * 1.2
    hoursLabel = dgsCreateLabel(screenX * 0.07, screenY * 0.12, screenX * 0.05, screenY * 0.04, time, false, parent)
    dgsSetProperties(hoursLabel, {
        ["font"] = data["globalFonts"]["Bold"],
        ["textSize"] = { textSize2, textSize2 }
    })

    return dateLabel, hoursLabel
end
