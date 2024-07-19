local dgs = exports.dgs

data = {
    login = {},
    register = {},
    window = "login",
    isLogged = false,
    fonts = {
        Poppins = {
            [12] = exports.dgs:dgsCreateFont("assets/fonts/Poppins-Bold.ttf", 12),
            [50] = exports.dgs:dgsCreateFont("assets/fonts/Poppins-Bold.ttf", 50),
        },
    },
    isRendered = false,
    isRender = {
        login = false,
        register = false,
    },
    animationTime = 1000,
}

local function mainScreen()
    if (data.isLogged) then return end
    if (not data.isRendered) then
        guiSetInputMode("no_binds_when_editing")
        showCursor(true)
        showChat(false)
        local screenX, screenY = dgs.dgsGetScreenSize()

        data.background = dgs:dgsCreateImage(0, 0, screenX, screenY, "assets/wallpaper.jpg", false)
        data.logo = dgs:dgsCreateImage(0.47, 0.05, 0.055, 0.09, "assets/logo.png", true, data.background)
        data.copyright = dgs:dgsCreateLabel(0.44, 0.95, 0.1, 0.02, "Global Roleplay. © 2024.", true, data.background)
        dgs:dgsSetProperties(data.copyright, {
            font = data.fonts.Poppins[12],
            textColor = tocolor(141, 141, 141, 178),
            alignment = { "center", "center" }
        })
        loadUpdates(data.background)
        data.isRendered = true
    end

    local status, username = loadXml()
    if (status == "false") then username = "" end

    if (data.window == "login") then
        data.login = loadLogin(data.background, username, status)
    elseif (data.window == "register") then
        data.register = loadRegister(data.background)
    end
end

function switchWindow()
    if (data.window == "login") then
        data.window = "register"
        if (table.size(data.register) > 0) then
            for _, v in ipairs(data.register) do
                dgs:dgsSetVisible(v, true)
                dgs:dgsAlphaTo(v, 1, "OutQuad", data.animationTime)
            end
        else
            data.register = loadRegister(data.background)
        end
        for _, v in ipairs(data.login) do
            dgs:dgsSetVisible(v, true)
            dgs:dgsAlphaTo(v, 0, "OutQuad", data.animationTime)
        end
    else
        data.window = "login"
        if (table.size(data.login) > 0) then
            for _, v in ipairs(data.login) do
                dgs:dgsSetVisible(v, true)
                dgs:dgsAlphaTo(v, 1, "OutQuad", data.animationTime)
            end
        else
            data.login = loadLogin(data.background)
        end
        for _, v in ipairs(data.register) do
            dgs:dgsSetVisible(v, false)
            dgs:dgsAlphaTo(v, 0, "OutQuad", data.animationTime)
        end
    end
end

addEventHandler("onClientResourceStart", resourceRoot, mainScreen)

addEvent("player::loginResponse", true)
addEventHandler("player::loginResponse", root, function(success, message, username, checkStatus)
    if success then
        if (isElement(data.background)) then
            destroyElement(data.background)
        end
        data.isLogged = true
        data.login = {}
        showCursor(false)
        setElementData(localPlayer, "player::isLogged", true)
        guiSetInputMode("allow_binds")
        -- iprint(checkStatus)
        saveXml(username, checkStatus)
    else
        iprint("Login failed: " .. message)
    end
end)

addEvent("player::registerResponse", true)
addEventHandler("player::registerResponse", root, function(success, message)
    if success then
        iprint("Register success: ")
        iprint(message)
        switchWindow()
    else
        iprint("Register failed: " .. message)
    end
end)