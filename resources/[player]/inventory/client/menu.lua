Dgs = exports.dgs
SW, SH = guiGetScreenSize()
Items_dgs = {
    menu = {},
    mini_menu = {
        slots = {},
        main = nil
    },
    dress = {},
    items = {},
    slots = {},
    popup = {},
    shaders = {}
}

local function renderShape(parent)
    local skin = getElementModel(localPlayer)
    local texture = (skin == 14) and "assets/images/character_male.png" or "assets/images/character_male.png"
    local x, y = (SW * 0.365), (SH * 0.35)
    local w, h = (SW * 0.08), (SH * 0.35)
    local shape = Dgs:dgsCreateImage(x, y, w, h , texture, false, parent)
    return shape
end

local function renderWeightProgress(parent)
    local playerWeight = 12
    local playerItems = GetPlayerItems(localPlayer)
    -- sum all items weight
    local totalWeight = 0
    for _, item in pairs(playerItems) do
        totalWeight = totalWeight + item.weight
    end

    -- RESOLUTION --
    local x, y = (SW * 0.77), (SH * 0.35)
    local w, h = (SW * 0.025), (SH * 0.35)
    -- BG --
    local shaderRect = Dgs:dgsCreateRoundRect(6, false, tocolor(60, 70, 70, 245))

    -- BLUR --
    local blur = Dgs:dgsCreateBlurBox(w, h)
    Dgs:dgsSetProperty(blur, "updateScreenSource", true)
    Dgs:dgsBlurBoxSetFilter(blur, shaderRect)
    Dgs:dgsBlurBoxSetIntensity(blur, 5)
    Dgs:dgsBlurBoxSetLevel(blur, 15)

    local image = Dgs:dgsCreateImage(x, y, w, h, blur, false, parent)
    Dgs:dgsAttachToAutoDestroy(shaderRect, image)
    Dgs:dgsAttachToAutoDestroy(blur, image)

    -- ICON --
    local icon = Dgs:dgsCreateImage(0.28, 0.06, 0.4, 0.06, "assets/icons/weight.png", true, image)

    -- TEXT --
    local weightLabel = Dgs:dgsCreateLabel(0.1, 0.8, 0.8, 0.06, totalWeight.."/"..playerWeight, true, image)
    Dgs:dgsSetProperties(weightLabel, {
        color = tocolor(255, 255, 255, 30),
        font = "default-bold",
        scale = 1,
        alignment = {"center", "center"}
    })
    local kgLabel = Dgs:dgsCreateLabel(0.1, 0.85, 0.8, 0.06, "KG", true, image)
    Dgs:dgsSetProperties(kgLabel, {
        color = tocolor(255, 255, 255, 30),
        font = "default-bold",
        scale = 1,
        alignment = {"center", "center"}
    })


    -- PROGRESS BAR --
    local progress = Dgs:dgsCreateProgressBar(0.2, 0.78, 0.6, -0.6, true, image)
    Dgs:dgsProgressBarSetProgress(progress, (totalWeight / playerWeight) * 100)
    
    -- -- PROGRESS BAR CONFIG --
    local shaderProgress = Dgs:dgsCreateRoundRect(6, false, tocolor(59, 55, 54, 245))

    Dgs:dgsProgressBarSetStyle(progress, "normal-vertical")
    Dgs:dgsSetProperties(progress, {
        bgImage = shaderProgress,
        indicatorImage = shaderRect,
        padding = {
            2, -2
        }
    })
    Dgs:dgsAttachToAutoDestroy(shaderProgress, progress)

    return progress
end

local function renderBackground()
    local background = Dgs:dgsCreateImage(0, 0, SW, SH, "assets/images/bg.png", false)
    return background
end


local function renderMenu(parent)
    renderShape(parent)
    RenderMenuItems(parent)
    renderWeightProgress(parent)
    RenderWearableItems(parent)
end

function RenderInventory(render)
    if (render) then
        showCursor(true)
        if (not Items_dgs.background) then
            Items_dgs.background = renderBackground()
            Dgs:dgsSetAlpha(Items_dgs.background, 0)
            -- Dgs:dgsSetVisible(Items_dgs.background, false)
            Items_dgs.menu = renderMenu(Items_dgs.background)
            Dgs:dgsAlphaTo(Items_dgs.background, 1, "Linear", 500)
            RenderMiniInventory(false, 500)
        else
            -- set alpha to 0
            RenderMiniInventory(false, 500)
            Dgs:dgsSetVisible(Items_dgs.background, true)
            Dgs:dgsAlphaTo(Items_dgs.background, 1, "Linear", 500)
            -- setTimer(function()
            -- end, 1500, 1)
        end
    else
        showCursor(false)
        if (Items_dgs.background) then
            -- set alpha to 255
            RenderMiniInventory(true, 500)
            Dgs:dgsAlphaTo(Items_dgs.background, 0, "Linear", 500)
            setTimer(function()
                Dgs:dgsSetVisible(Items_dgs.background, false)
            end, 500, 1)
        end
    end
    playSound("assets/sounds/menu_sound.mp3")
end
-- RenderInventory()
local renderState = false
bindKey("tab", "down", function()
    if (Items_dgs.background) then
        if (Dgs:dgsIsAniming(Items_dgs.background)) then
            return
        end
    end
    renderState = not renderState
    RenderInventory(renderState)
end)

function RenderMiniInventory(render, time)
    if (render) then
        if (isPedInVehicle(localPlayer)) then return end
        if (not isElement(Items_dgs.mini_menu.main)) then
            RenderMiniMenuItems()
            return
        end
        
        if (ItemsAcc > 3) then return end
        Dgs:dgsSetVisible(Items_dgs.mini_menu.main, true)
        Dgs:dgsAlphaTo(Items_dgs.mini_menu.main, 1, "Linear", time)
    else
        if (isElement(Items_dgs.mini_menu.main)) then
            Dgs:dgsAlphaTo(Items_dgs.mini_menu.main, 0, "Linear", time)
            setTimer(function()
                Dgs:dgsSetVisible(Items_dgs.mini_menu.main, false)
            end, time, 1)
        end
    end
end
RenderMiniInventory(true)

addEventHandler("onClientVehicleEnter", root, function()
    RenderMiniInventory(false, 500)
end)

addEventHandler("onClientVehicleExit", root, function()
    RenderMiniInventory(true, 500)
end)