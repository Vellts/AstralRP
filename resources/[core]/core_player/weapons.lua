local dgs = exports.dgs
local weapons = {
    [0] = "fist",
    [1] = "brassknuckle",
    [2] = "golfclub",
    [3] = "nightstick",
    [4] = "knife",
    [5] = "bat",
    [7] = "poolstick",
    [8] = "katana",
    [22] = "colt45",
    [23] = "silenced",
    [24] = "deagle",
    [25] = "shotgun",
    [26] = "sawedoff",
    [27] = "combatshotgun",
    [28] = "uzi",
    [29] = "mp5",
    [32] = "tec9",
    [30] = "ak47",
    [31] = "m4",
    [33] = "rifle",
    [34] = "sniper",
    [15] = "cane",
    [16] = "grenade",
    [17] = "teargas",
    [18] = "molotov",
    [39] = "satchel",
    [41] = "spraycan",
    [42] = "fireextinguisher",
    [46] = "parachute"
}

local weaponMultiplier = {
    [0] = { 0.02, 0.03 }, -- fist
    [1] = { 0.028, 0.035 }, --brassknuckle
    [2] = { 0.07, 0.02 }, --golfclub
    [3] = { 0.07, 0.03 }, --nightstick
    [4] = { 0.06, 0.02 }, --knife
    [5] = { 0.07, 0.02 }, -- bat
    [7] = { 0.09, 0.01 }, -- poolstick
    [8] = { 0.07, 0.02 }, -- katana
    [15] = { 0.07, 0.02 }, -- cane
    [16] = { 0.02, 0.01 }, -- grenade
    [17] = { 0.015, 0.03 }, -- teargas
    [18] = { 0.03, 0.035 }, -- molotov
    [22] = { 0.04, 0.03 }, -- colt45
    [23] = { 0.04, 0.03 }, -- silenced
    [24] = { 0.04, 0.03 }, -- deagle
    [25] = { 0.07, 0.03 }, -- shotgun
    [26] = { 0.05, 0.03 }, -- sawedoff
    [27] = { 0.05, 0.03 }, -- combatshotgun
    [28] = { 0.05, 0.03 }, -- uzi
    [29] = { 0.05, 0.035 }, -- mp5
    [30] = { 0.07, 0.04 }, -- ak47
    [31] = { 0.07, 0.04 }, -- m4
    [32] = { 0.045, 0.035 }, -- tec9
    [33] = { 0.07, 0.03 }, -- rifle
    [34] = { 0.07, 0.03 }, -- sniper
    [39] = { 0.04, 0.025 }, -- satchel
    [41] = { 0.018, 0.035 }, -- spraycan
    [42] = { 0.015, 0.04 }, -- fireextinguisher
    [46] = { 0.025, 0.04 }, -- parachute
}

local weaponData = {}

function _getWeaponNameFromID(id)
    return weapons[id]
end

function drawWeapons()
    if (table.size(weaponData) >= 1) then
        -- destroy elements
        for k, v in pairs(weaponData) do
            if (isElement(v)) then
                destroyElement(v)
            end
        end
    end 
    local sW, sH = dgs:dgsGetScreenSize()
    local weapon = _getWeaponNameFromID(getPedWeapon(localPlayer))
    local ammo = getPedAmmoInClip(localPlayer)
    local totalAmmo = getPedTotalAmmo(localPlayer)
    local w, h = (sW * weaponMultiplier[getPedWeapon(localPlayer)][1]), (sH * weaponMultiplier[getPedWeapon(localPlayer)][2])

    weaponData.image = dgs:dgsCreateImage(sW * 0.014, sH * 0.06, w, h, "assets/images/weapons/"..weapon..".png", false)
    dgs:dgsSetProperty(weaponData.image, "alpha", 0.72)
    weaponData.weaponName = dgs:dgsCreateLabel(sW * 0.014, sH * 0.1, (sW * 0.02), (sH * 0.02), capitalizeString(getWeaponNameFromID(getPedWeapon(localPlayer))), false)
    dgs:dgsSetProperties(weaponData.weaponName, {
        textColor = tocolor(255, 255, 255, 150),
        font = hud.fontMedium,
    })
    weaponData.weaponAmmo = dgs:dgsCreateLabel(sW * 0.014, sH * 0.12, (sW * 0.02), (sH * 0.02), ammo.."/"..totalAmmo, false)
    dgs:dgsSetProperties(weaponData.weaponAmmo, {
        textColor = tocolor(255, 255, 255, 150),
        font = hud.fontMedium,
    })

    return image
end



addEventHandler("onClientPlayerWeaponSwitch", localPlayer, function()
    if (isElement(source) and getElementType(source) == "player" and source == localPlayer) then
        drawWeapons()
    end
end)

addEventHandler("onClientPlayerWeaponFire", localPlayer, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if (isElement(source) and getElementType(source) == "player" and source == localPlayer) then
        if (isElement(weaponData.weaponAmmo)) then
            dgs:dgsSetText(weaponData.weaponAmmo, ammoInClip.."/"..ammo)
        end
    end
end)