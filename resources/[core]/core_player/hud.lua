local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }
hud = {
    fontSemiBold = exports.dgs:dgsCreateFont("assets/fonts/Poppins-SemiBold.ttf", 16),
    fontMedium = exports.dgs:dgsCreateFont("assets/fonts/Poppins-Medium.ttf", 16)
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
    -- hud.dev = drawDeveloper()
end
addEvent("player::drawHud", true)
addEventHandler("player::drawHud", root, drawHud)

function updateLabelFPS(label)
    local fps = math.floor(getCurrentFPS()) or 0
    exports.dgs:dgsSetText(label, fps.. " fps")
end

