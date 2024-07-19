---@diagnostic disable: undefined-global
local screenX, screenY = guiGetScreenSize()

function BackLine(parent, darkMode, from, name)
    local color = (darkMode ~= true) and tocolor(255, 255, 255, 255) or tocolor(20, 20, 20, 255)
    local roundRect2 = dgsCreateRoundRect(10, false, color)
    local lineBack = dgsCreateImage(screenX * 0.058, screenY * 0.63, screenX * 0.09, screenY * 0.02, roundRect2, false, parent)

    addEventHandler("onDgsMouseClick", lineBack, function()
        changeScreen(from, name)
    end, false)
end

function changeScreen(from, nameApp)
    if (from == "lock") then
        -- iprint(data["homeScreen"], data["lockScreen"])
        if (table.hasValues(data["homeScreen"]) or (data["screenAnim"])) then return end
        
        -- animate
        
        dgsAlphaTo(data["lockScreen"]["wallpaper"], 0, "InQuad", 300)
        dgsAlphaTo(data["lockScreen"]["skeleton"], 0, "InQuad", 300)
        
        setTimer(function()
            for i, v in pairs(data["lockScreen"]) do
                if (isElement(v)) then 
                    destroyElement(v) 
                    data["lockScreen"][i] = nil
                end
            end
            data["screenAnim"] = false
            data["lockScreen"] = {}
        end, 400, 1)
        data["actualScreen"] = "home"
        RenderHome()
    elseif (from == "home") then

        -- if (table.hasValues(data["appScreen"][nameApp])) then return end
        -- iprint(table.hasValues(data["appScreen"]))
        -- if (table.hasValues(data["appScreen"])) then return end
        -- if (dgsIsAlphaing(data["lockScreen"]["wallpaper"])) or (dgsIsAlphaing(data["lockScreen"]["skeleton"])) then return end
        if ((data["screenAnim"])) then return end
        data["actualScreen"] = "app"
        -- if (table.hasValues(data["appScreen"])) then return end

        dgsAlphaTo(data["homeScreen"]["wallpaper"], 0, "InQuad", 300)
        dgsAlphaTo(data["homeScreen"]["skeleton"], 0, "InQuad", 300)
        data["screenAnim"] = true
    
        setTimer(function()
            -- iprint(data["homeScreen"])
            -- iprint(true, 1)
            for i, v in pairs(data["homeScreen"]) do
                -- iprint(i, v, isElement(v))
                if (isElement(v)) then 
                    destroyElement(v)
                    data["homeScreen"][i] = nil
                end
            end
            data["screenAnim"] = false
            data["homeScreen"] = {}
        end, 400, 1)

        -- renderApp()
    elseif (from == "app") then
        -- volver a home
        -- local nameApp = getNameApp(data["appScreen"])
        if (table.hasValues(data["homeScreen"]) or (data["screenAnim"])) then return end
        
        -- if (dgsIsAlphaing(data["appScreen"]["wallpaper"]) or dgsIsAlphaing(data["appScreen"]["skeleton"])) then return end

        data["actualScreen"] = "home"
        
        dgsAlphaTo(data["appScreen"][nameApp]["wallpaper"], 0, "InQuad", 300)
        dgsAlphaTo(data["appScreen"][nameApp]["skeleton"], 0, "InQuad", 300)
        
        setTimer(function()
            for i, v in pairs(data["appScreen"][nameApp]) do
                if (isElement(v)) then 
                    -- iprint(i, v)
                    if (i ~= "icon") then
                        destroyElement(v)
                        data["appScreen"][nameApp][i] = nil
                    end
                end
            end
            data["screenAnim"] = false
            -- data["appScreen"][nameApp] = {}
        end, 200, 1)
        RenderHome()
        
    end
end

function destroyPhone(from, all_phone)
    if (isElement(data["phoneImage"])) then dgsMoveTo(data["phoneImage"], screenX * 0.75, screenY * 0.9, false, "InQuad", 500) end
    -- if (isElement(data["phoneWallpaper"])) then dgsMoveTo(data["phoneWallpaper"], screenX * 0.762, screenY * 0.92, false, "InQuad", 500) end

    setTimer(function()
        if (isElement(data["phoneImage"])) then 
            destroyElement(data["phoneImage"])
            data["phoneImage"] = nil
        end
        if (isTimer(data["timerHours"])) then 
            killTimer(data["timerHours"])
            data["timerHours"] = nil
        end
        
        data["status"] = false
        showCursor(false)
    end, 500, 1)

    if (data["actualScreen"] and from) then
        if (from == "app") then
            local nameApp = getNameApp(data["appScreen"])
            -- for i, v in pairs(data["appScreen"]) do
            --     if (type(i) == "string") then
            --         nameApp = i
            --         break
            --     end
            -- end

            local screen = screensAvailable[from]
            if (isElement(data[screen][nameApp]["wallpaper"])) then
                dgsMoveTo(data[screen][nameApp]["wallpaper"], screenX * 0.762, screenY * 0.92, false, "InQuad", 500)
            end

            CallData["contactSearchStatus"] = false
    
            setTimer(function()
                if (data[screen][nameApp]) then
                    -- iprint("destroying")
                    for i, v in pairs(data[screen][nameApp]) do
                        if (isElement(v)) then
                            -- iprint(v, 2)
                            destroyElement(v)
                            iprint(data[screen][nameApp][i])
                            -- data[screen][nameApp][i] = nil
                            
                        end
                    end
                    -- iprint(data[screen][nameApp])
                    data["actualScreen"] = "lock"
                    data[screen][nameApp] = {}

                    -- iprint(data)
                end
                restoreData()
            end, 550, 1)
        else
            local screen = screensAvailable[from]
            if (isElement(data[screen]["wallpaper"])) then
                dgsMoveTo(data[screen]["wallpaper"], screenX * 0.762, screenY * 0.92, false, "InQuad", 500)
            end
    
            setTimer(function()
                if (data[screen]) then
                    iprint("destroying")
                    for i, v in pairs(data[screen]) do
                        if (isElement(v)) then destroyElement(v) end
                    end
                    data["actualScreen"] = "lock"
                    data[screen] = {}
                end
                restoreData()
            end, 500, 1)
        end


        -- iprint(data[screen])
    end


    -- if (data["actualScreen"] == "lock") then
    --     if (isElement(data["lockScreen"]["wallpaper"])) then
    --         dgsMoveTo(data["lockScreen"]["wallpaper"], screenX * 0.762, screenY * 0.92, false, "InQuad", 500)
    --     end

    --     setTimer(function()
    --         if (data["lockScreen"]) then
    --             for i, v in pairs(data["lockScreen"]) do
    --                 if (isElement(v)) then destroyElement(v) end
    --             end
    --         end
    --     end, 500, 1)
    -- elseif (data["actualScreen"] == "home") then
    --     -- iprint(true)
    --     if (isElement(data["homeScreen"]["wallpaper"])) then
    --         dgsMoveTo(data["homeScreen"]["wallpaper"], screenX * 0.762, screenY * 0.92, false, "InQuad", 500)
    --     end

    --     setTimer(function()
    --         if (data["homeScreen"]) then
    --             for i, v in pairs(data["homeScreen"]) do
    --                 if (isElement(v)) then destroyElement(v) end
    --             end

    --             data["homeScreen"] = {}
    --             data["actualScreen"] = "lock"
    --         end
    --     end, 500, 1)
    -- end
end

function transitionScreen(from, app)
    local screen = screensAvailable[from]

    if (screen) then
        -- mover el icono al centro
        dgsMoveTo(data[screen][app]["icon"], screenX * 0.06, -(screenY * 0.302), false, "InQuad", 200)

        setTimer(function()
            -- destruir el icono
            if (isElement(data[screen][app]["icon"])) then destroyElement(data[screen][app]["icon"]) end
            -- mover el wallpaper al centro
            -- dgsMoveTo(data[screen]["wallpaper"], screenX * 0.762, screenY * 0.92, false, "InQuad", 300)
        end, 300, 1)
    end
end
