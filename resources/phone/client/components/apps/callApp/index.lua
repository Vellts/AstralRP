---@diagnostic disable: undefined-global

CallData = {
    ["hover"] = "keypad",
    ["text"] = "",
    ["contacts"] = {},
    ["contactSearchStatus"] = false,
    ["onPopUp"] = false,
}

function callIconComponent(parent, parent2)
    local screenX, screenY = guiGetScreenSize()

    data["appScreen"]["callApp"]["icon"] = dgsCreateImage(screenX * 0.005, screenY * 0.0026, screenX * 0.03,
        screenY * 0.06, "assets/phone_icon.png", false, parent)

    addEventHandler("onDgsMouseEnter", data["appScreen"]["callApp"]["icon"], function()
        if (data["actualScreen"] == "app") then return end
        dgsMoveTo(data["appScreen"]["callApp"]["icon"], screenX * 0.005, 0, false, "Linear", 100)
        removeEventHandler("onDgsMouseLeave", data["appScreen"]["callApp"]["icon"], function() end)
    end, false)

    addEventHandler("onDgsMouseLeave", data["appScreen"]["callApp"]["icon"], function()
        if (data["actualScreen"] == "app") then return end
        dgsMoveTo(data["appScreen"]["callApp"]["icon"], screenX * 0.005, screenY * 0.0026, false, "Linear", 100)
        removeEventHandler("onDgsMouseEnter", data["appScreen"]["callApp"]["icon"], function() end)
    end, false)

    addEventHandler("onDgsMouseClick", data["appScreen"]["callApp"]["icon"], function()
        -- callAppGui(parent2)
        changeScreen("home")
        renderApp("call", parent2)
    end, false)
end

function callAppGui(parent)
    -- CONFIGS

    local screenX, screenY = dgsGetScreenSize()

    data["actualScreen"] = "app"
    transitionScreen("app", "callApp")

    data["appScreen"]["callApp"]["skeleton"] = dgsCreateImage(0, 0, screenX * 0.198, screenY * 0.7, "assets/skeleton.png",
        false, data["phoneImage"])

    -- WALLPAPER

    local roundRect = dgsCreateRoundRect(10, false, tocolor(255, 255, 255, 255))
    data["appScreen"]["callApp"]["wallpaper"] = wallpaperComponent(screenX * 0.765, screenY * 0.318, screenX * 0.174,
        screenY * 0.6422, roundRect)

    dgsSetAlpha(data["appScreen"]["callApp"]["wallpaper"], 0)
    dgsAlphaTo(data["appScreen"]["callApp"]["wallpaper"], 1, "Linear", 300)

    BackLine(data["appScreen"]["callApp"]["skeleton"], true, "app", "callApp")

    setTimer(function()

        if (CallData["hover"] == "keypad") then
            DrawKeyPadScreen()
        elseif (CallData["hover"] == "contacts") then
            DrawContactsScreen()
        end
        -- DrawKeyPadScreen()
        -- DrawContactsScreen()

        CallData["keypad"] = DrawAppKeyPadIcon()
        CallData["contacts"] = DrawAppContactsIcon()
        CallData["recents"] = DrawAppRecentsIcon()
        CallData["favorites"] = DrawAppFavoritesIcon()

    end, 200, 1)
end

function AddNewNumber(number)
    -- get the length of the text
    local length = string.len(CallData["text"])
    if (length < 0 or length == 10) then return end

    CallData["text"] = CallData["text"] .. number

    dgsSetText(CallData["number"], CallData["text"])
end

function RemoveNewNumber()
    local length = string.len(CallData["text"])
    if (length < 0) then return end

    CallData["text"] = string.sub(CallData["text"], 1, length - 1)

    dgsSetText(CallData["number"], CallData["text"])
end

-- addEventHandler("onClientResourceStart", resourceRoot, function()
--     showCursor(true)
--     local roundRect = dgsCreateRoundRect(20, false, tocolor(20, 20, 20, 255))
--     local bgImage = dgsCreateImage(500, 300, 800, 600, roundRect, false)
--     local scrollPane = dgsCreateScrollPane(500, 300, 800, 600, false)

--     dgsSetProperties(scrollPane, {
--         ["bgImage"] = bgImage,
--         ["padding"] = { 0.08, 0, 0 },
--         ["scrollBarThick"] = 0
--     })
--     -- add data to the scroll pane
--     -- iprint(#FakeContactsData)
--     for i = 1, #FakeContactsData do

--         local name = FakeContactsData[i]["name"]
        
--         local rect = dgsCreateRoundRect(10, false, tocolor(255, 255, 255, 255))
--         local rectImage = dgsCreateImage(0, (i * 70) + 2, 100, 40, rect, false, scrollPane)
--         local label = dgsCreateLabel(20, 0 + (i * 70), 100, 20, name, false, scrollPane)
        
--         -- style the label
        
--         dgsSetProperties(label, {
--             ["textSize"] = { 1.5, 1.5 },
--             ["textColor"] = tocolor(80, 80, 80, 255) 
--         })
        
--         -- add a rectangle to the label
        
        
--     end
-- end)
