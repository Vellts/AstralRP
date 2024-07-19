local textures = {}
local shaders = {}
local characters = {}


----------------------- FUNCTIONS -----------------------

local function addTextureToPlayer(player, texture, path)
    -- iprint(player, texture, path)
    textures[player] = dxCreateTexture(path)
    iprint(textures[player])
    dxSetShaderValue(texture, "tex", textures[player])
    destroyElement(texture)
end

local function clearClothes(player, skin, var, style)
    -- iprint(player, skin, var, style)
    if (not getElementType(player) == "player") then return end
    if (not shaders[player]) then
        textures[player] = {}
        shaders[player] = {}
    end

    if (not shaders[player][var]) then
        shaders[player][var] = {}
    end

    if (isElement(shaders[player][var])) then
        destroyElement(shaders[player][var])
        shaders[player][var] = nil
    end

    if (style) then
        -- iprint("in")
        shaders[player][var] = dxCreateShader("assets/shader.fx", 0, 0, false, "ped")
        -- iprint(var, style, player)
        local clothe = clothes[skin][var][style]
        iprint("clothe: "..clothe)
        iprint(engineApplyShaderToWorldTexture(shaders[player][var], clothe, player))
    end
end

local function setClothe(player, skin, var, style, text)
    -- if (getElementType(style) ~= "string") or (getElementType(text) ~= "string") then return end
    style = tonumber(style)
    text = tonumber(text)
    iprint(player, skin, var, style, text)
    if (clothes[skin]) and (clothes[skin][var]) and (clothes[skin][var][style]) and (text > 0) then
        clearClothes(player, skin, var, style)
        -- TODO: calzado
        local shader = shaders[player][var]
        local pedSkin = getPedSkin(player)
        local path = "assets/characters/"..pedSkin.."/clothes/"..var.."/"..style.."/"..text..".png"
        addTextureToPlayer(player, shader, path)
    elseif (var) and (style < 1) then
        clearClothes(player, skin, var)
    else
        iprint("Nothing")
    end
end

local function setClotheToPlayer(player, skin, clothesToChange)
    -- if (type(clothesToChange) ~= "table") then return end
    -- iprint(player, skin, clothesToChange)
    for clothe, _ in pairs(clothesToChange) do
        -- iprint(clothesToChange[clothe])
        if (clothe ~= "skin") then
            iprint("toChange: "..clothesToChange[clothe][1])
            setClothe(player, skin, clothe, clothesToChange[clothe][1], clothesToChange[clothe][2])
        end
    end
end

local function changeClotheToPlayers(clothe)
    -- iprint(clothe)
    local data = {}
    data = clothe
    -- iprint(tempData)
    for _, player in ipairs(getElementsByType("player")) do
        if data[player] then
            -- iprint("dentro")
            setClotheToPlayer(player, clothe[player].skin, clothe[player])
        end
    end
end

local function loadCharactersSkin()
    for id, textures in pairs(texturesFiles) do
        local model = id
        for _, tex in ipairs(textures) do
            local path = "assets/characters/"..model.."/"..tex
            -- iprint(path)
            local txd = engineLoadTXD(path..".txd")
            engineImportTXD(txd, model)
        end

        local dff = engineLoadDFF("assets/characters/"..model.."/tex/male.dff", model)
		engineReplaceModel( dff, model )
    end
end

----------------------- EVENTS -----------------------

addEvent("player::changeClothes", true)
addEventHandler("player::changeClothes", root, setClotheToPlayer)

addEvent("player::updateClothes", true)
addEventHandler("player::updateClothes", root, changeClotheToPlayers)

addEventHandler("onClientResourceStart", resourceRoot, loadCharactersSkin)
