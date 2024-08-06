local texture = {}
local myShader = {}
local mycharacter = {}

function applyTexture(element, shader, dir)
	texture[element] = dxCreateTexture(dir)
    dxSetShaderValue(shader, "tex", texture[element])
	-- iprint("1", dxSetShaderValue(shader, "tex", texture[element]))
	destroyElement(texture[element])
end

function clearShaderClothe(element, skin, variavel, stylo)
	if not myShader[element] then
		myShader[element] = {}
		texture[element] = {}
	end
	if not myShader[element][variavel] then
		myShader[element][variavel] = {}
	end

	if not myShader[element][variavel]then
		myShader[element][variavel] = {}
	end
	-- iprint("1", myShader[element][variavel])
	if isElement(myShader[element][variavel]) then
		destroyElement(myShader[element][variavel])
	end

	if stylo then
		myShader[element][variavel] = dxCreateShader("assets/characters/shader.fx", 0, 0, false, "ped")
		-- iprint("1", myShader[element][variavel])
		engineApplyShaderToWorldTexture(myShader[element][variavel], clothes[skin][variavel][stylo], element)
	end
end

function setClothe(element, skin, variavel, stylo, text)
	-- iprint("xd")
	stylo = tonumber(stylo)
	text = tonumber(text)
	if clothes[skin] and clothes[skin][variavel] and clothes[skin][variavel][stylo] and text > 0 then
		
		clearShaderClothe(element, skin, variavel, stylo)
		
		if variavel == "calcado" and stylo == 1 then
			clearShaderClothe(element, skin, "pe", 1)
			applyTexture(element, myShader[element]["pe"],"assets/characters/"..getPedSkin(element).."/"..skin.."/1.png")
		end
		-- iprint(element, "assets/characters/"..getPedSkin(element).."/"..variavel.."/"..stylo.."/"..text..".png")
		applyTexture(element, myShader[element][variavel],"assets/characters/"..getPedSkin(element).."/"..variavel.."/"..stylo.."/"..text..".png")
		
	elseif variavel and stylo < 1 then
		clearShaderClothe(element, skin, variavel)
	else
		iprint("Error!")
	end
end

function setPlayerClothe(element, skin, clothes)
	-- outputDebugString(element, skin, clothes)
	-- iprint(element, skin, clothes)
	iprint("aa")
	for clothe, _ in pairs(clothes) do
		if clothe ~= "skin" then
			setClothe(element, skin, clothe, clothes[clothe][1], clothes[clothe][2])
			-- mycharacter[element] = clothes
		end
	end
end
addEvent("setPlayerClothe", true)
addEventHandler("setPlayerClothe", root, setPlayerClothe)

function setPlayerClothes(clothe)
    local inTable = {}
    inTable = clothe
    for i, player in ipairs(getElementsByType("player")) do
        if inTable[player] then
            setPlayerClothe(player, clothe[player]["skin"], clothe[player])
        end
    end
end
addEvent("setPlayerClothes", true)
addEventHandler("setPlayerClothes", root, setPlayerClothes)

local function onPlayerQuit()
    for variavel, _ in pairs(class_clothes[getPedSkin(source)])do
        clearShaderClothe(source, getPedSkin(source), variavel)
    end
    myShader[source] = nil
end

function getPlayerClothe(player)

end