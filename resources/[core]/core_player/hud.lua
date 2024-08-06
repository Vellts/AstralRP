local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }
hud = {
    fontSemiBold = exports.dgs:dgsCreateFont("assets/fonts/Poppins-SemiBold.ttf", 16),
    fontMedium = exports.dgs:dgsCreateFont("assets/fonts/Poppins-Medium.ttf", 16),
    isShow = false
}

function drawHud()
    setPlayerHudComponentVisible("all", false )
    showChat(false)
    hud.fps = drawFps()
    hud.mic = drawMicrophone()
    hud.health = drawHealth()
    hud.armor = drawArmor()
    hud.weapons = drawWeapons()
    hud.hunger = drawHunger()
    hud.drink = drawThirst()
    hud.location = DrawLocation()
    hud.hour = DrawHour()
    hud.isShow = not hud.isShow
    bindKey("F10", "down", ShowHud)
end
addEvent("player::drawHud", true)
addEventHandler("player::drawHud", root, drawHud)

function updateLabelFPS(label)
    local fps = math.floor(getCurrentFPS()) or 0
    exports.dgs:dgsSetText(label, fps.. " fps")
end
-- setTimer(drawHud, 3000, 1)
-- drawHud()

function ShowHud()
    for _, element in pairs(hud) do
        if (type(element) == "table") then
            for _, v in pairs(element) do
                if (isElement(v)) and (getElementType(v) ~= "dx-font") then
                    exports.dgs:dgsSetVisible(v, not hud.isShow)
                end
            end
        else
            if (isElement(element)) and (getElementType(element) ~= "dx-font") then
                exports.dgs:dgsSetVisible(element, not hud.isShow)
            end
        end
    end
    hud.isShow = not hud.isShow
end