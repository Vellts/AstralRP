local dgs = exports.dgs

function DrawLocation()
    local x, y, z = getElementPosition(localPlayer)
    local country = getZoneName(x, y, z, true)
    local city = getZoneName(x, y, z)
    local location = city..", "..country

    local sW, sH = dgs:dgsGetScreenSize()
    local x, y = (sW * 0.96), (sH * 0.118)
    local w, h = (sW * 0.016), (sH * 0.028)
    -- ICON --
    local icon = dgs:dgsCreateImage(x, y, w, h, "assets/images/location.png", false)
    -- LABEL --
    local x, y = (sW * 0.815), (sH * 0.12)
    local w, h = (sW * 0.14), (sH * 0.03)
    local label = dgs:dgsCreateLabel(x, y, w, h, location, false)
    dgs:dgsSetProperties(label, {
        color = tocolor(255, 255, 255, 255),
        font = hud.fontMedium,
        alignment = {"right", "center"},
        alpha = 0.60
    })
    dgs:dgsSetProperty(label, "functions", [[
        local label = self
        local x, y, z = getElementPosition(localPlayer)
        local country = getZoneName(x, y, z, true)
        local city = getZoneName(x, y, z)
        local location = city..", "..country
        dgsSetText(label, location)
    ]])

    return {label, icon}
end

function DrawHour()
    local sW, sH = dgs:dgsGetScreenSize()
    local x, y = (sW * 0.962), (sH * 0.152)
    local w, h = (sW * 0.013), (sH * 0.02)
    -- ICON --
    local icon = dgs:dgsCreateImage(x, y, w, h, "assets/images/hour.png", false)
    -- LABEL --
    local x, y = (sW * 0.815), (sH * 0.15)
    local w, h = (sW * 0.14), (sH * 0.03)
    local label = dgs:dgsCreateLabel(x, y, w, h, "00:00", false)
    dgs:dgsSetProperties(label, {
        color = tocolor(255, 255, 255, 255),
        font = hud.fontMedium,
        alignment = {"right", "center"},
        alpha = 0.60
    })
    dgs:dgsSetProperty(label, "functions", [[
        local label = self
        local h, m = getTime()
        if (h < 10) then h = "0"..h end
        if (m < 10) then m = "0"..m end
        dgsSetText(label, h..":"..m)
    ]])
    return {label, icon}
end