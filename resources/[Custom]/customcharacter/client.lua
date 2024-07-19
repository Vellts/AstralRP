local texture = {}
local myShader = {}
local mycharacter = {} 

local myShader_raw_data = [[
	texture tex;
	technique replace {
		pass P0 {
			Texture[0] = tex;
		}
	}
]]

createEvent = function(eventname, ...)
	addEvent(eventname, true)
	addEventHandler(eventname, ...)
end

function applyTexture(element, shader, dir)
	texture[element] = dxCreateTexture(dir)
	dxSetShaderValue(shader, "tex", texture[element])
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

	if isElement(myShader[element][variavel]) then
		destroyElement(myShader[element][variavel])
	end

	if stylo then
		myShader[element][variavel] = dxCreateShader(myShader_raw_data, 0, 0, false, "ped")
		-- iprint(class_clothes[skin][variavel][stylo])
		engineApplyShaderToWorldTexture(myShader[element][variavel], class_clothes[skin][variavel][stylo], element)
	end
end
 
function setClothe(element, skin, variavel, stylo, text)
	stylo = tonumber(stylo)
	text = tonumber(text)
if class_clothes[skin] and class_clothes[skin][variavel] and class_clothes[skin][variavel][stylo] and text > 0 then

		clearShaderClothe(element, skin, variavel, stylo)

		if variavel == "calcado" and stylo == 1 then
			clearShaderClothe(element, skin, "pe", 1)
			applyTexture(element, myShader[element]["pe"],"assets/"..getPedSkin(element).."/"..skin.."/1.png")
		end
		applyTexture(element, myShader[element][variavel],"assets/"..getPedSkin(element).."/"..variavel.."/"..stylo.."/"..text..".png")
		
	elseif variavel and stylo < 1 then
		clearShaderClothe(element, skin, variavel)
	else
		outputChatBox("Nenhuma variável encontrada."..variavel,255,0,0,true)
	end
end

function setPlayerClothe(element, skin, clothes)
	for clothe, _ in pairs(clothes) do
		if clothe ~= "skin" then
			setClothe(element, skin, clothe, clothes[clothe][1], clothes[clothe][2])
		end
	end
end
createEvent("setPlayerClothe", getRootElement(),setPlayerClothe)

createEvent("setPlayersClothes", getRootElement(), 
	function(clothe)
		local inTable = {}
		inTable = clothe
		for i, player in ipairs(getElementsByType("player")) do
			if inTable[player] then
				setPlayerClothe(player, clothe[player]["skin"], clothe[player])
			end
		end
	end
)

addEventHandler("onClientPlayerQuit", getRootElement(), 
	function()
		for variavel, _ in pairs(class_clothes[getElementSkin(source)])do
			clearShaderClothe(source, getElementSkin(source), variavel)
		end
		myShader[source] = nil
	end
)

-- function obterposicaoroupa(valor1, valor2, tabela)
--     for index, value in ipairs(tabela) do
--         if value[1] == valor1 and value[2] == valor2 then
--             return index
--         end
--     end
--     return 1
-- end

-- ---------------------------------------------------------------------------------


-- local screenSize = Vector2(guiGetScreenSize())
-- local screenW, screenH = guiGetScreenSize()
-- local x, y = (screenW/1920), (screenH/1080)

-- local painelsexo = false
-- local painelroupas = false
-- local sexoselecionado = nil

-- local nome = createElement("EditBoxAccount")
-- local subnome = createElement("EditBoxAccount")
-- local idade = createElement("EditBoxAccount")

-- local corpele=1
-- local calcaa=1
-- local cabeloo=0
-- local corcabelo=1

-- function painelescolhersexo ()
-- 	if sexoselecionado == "Masculino" then
-- 		dxDrawImage(x*0, y*0, x*1920, y*1080, "files/sexo_m.png")
-- 	elseif sexoselecionado == "Femenino" then
-- 		dxDrawImage(x*0, y*0, x*1920, y*1080, "files/sexo_f.png")
-- 	else
-- 		dxDrawImage(x*0, y*0, x*1920, y*1080, "files/sexo_nil.png")
-- 	end
-- end

-- function painelescolherroupas ()
-- 	dxDrawImage(x*0, y*0, x*1920, y*1080, "files/createperson.png")
-- 	dxDrawEditBox("", x*107, y*293, x*237, y*28, false, 15, nome)
-- 	dxDrawEditBox("", x*107, y*359, x*164, y*28, false, 15, subnome)
-- 	dxDrawEditBox("", x*107, y*434, x*164, y*28, false, 3, idade)
--     dxDrawText(corpele.."/5", x*292, y*544, x*347, y*584, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText(corcabelo.."/3", x*292, y*795, x*347, y*835, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     if getElementModel ( localPlayer ) == 10 then
--     dxDrawText(cabeloo.."/3", x*292, y*714, x*347, y*751, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
-- else
-- 	dxDrawText(cabeloo.."/4", x*292, y*714, x*347, y*751, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
-- end
--     dxDrawText(calcaa.."/2", x*292, y*627, x*347, y*667, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
-- end

-- function painellojaroupa ()
-- 	dxDrawImage(x*0, y*0, x*1920, y*1080, "files/shop.png")
-- 	dxDrawText((bone-1).."/"..#(roupas[genero].bone)-1, x*307, y*105, x*365, y*286, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
-- 	dxDrawText((mascara-1).."/"..#(roupas[genero].mascara)-1, x*307, y*324, x*365, y*286, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText((oculos-1).."/"..#(roupas[genero].oculos)-1, x*307, y*436, x*365, y*396, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText((camisa-1).."/"..#(roupas[genero].camisa)-1, x*307, y*546, x*365, y*510, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText((mochila-1).."/"..#(roupas[genero].mochila)-1, x*307, y*652, x*365, y*628, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText((perna-1).."/"..#(roupas[genero].perna)-1, x*307, y*745, x*365, y*755, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText((tenis-1).."/"..#(roupas[genero].tenis)-1, x*307, y*857, x*365, y*865, tocolor(254, 254, 254, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText("Preço Total: "..preco*precoroupa.roupa.."R$", x*383, y*95, x*503, y*118, tocolor(255, 255, 255, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
-- end

-- function valorcarrinho(tabela2, tabela1)
--   local linhasDiferentes = 0
--   local chaves1 = {}
--   local chaves2 = {}
  
--   for chave, _ in pairs(tabela1) do
--     table.insert(chaves1, chave)
--   end
  
--   for chave, _ in pairs(tabela2) do
--     table.insert(chaves2, chave)
--   end
  
--   table.sort(chaves1)
--   table.sort(chaves2)
  
--   if #chaves1 ~= #chaves2 or not table.deepcompare(chaves1, chaves2) then
--     linhasDiferentes = linhasDiferentes + 1
--   end
  
--   for chave, valor1 in pairs(tabela1) do
--     local valor2 = tabela2[chave]
    
--     if type(valor1) == "table" and type(valor2) == "table" then
--       if not table.deepcompare(valor1, valor2) then
--         linhasDiferentes = linhasDiferentes + 1
--       end
--     elseif valor1 ~= valor2 then
--       linhasDiferentes = linhasDiferentes + 1
--     end
--   end
  
--   return linhasDiferentes
-- end

-- table.deepcompare = function(t1, t2)
--   for k1, v1 in pairs(t1) do
--     local v2 = t2[k1]
--     if type(v1) == "table" and type(v2) == "table" then
--       if not table.deepcompare(v1, v2) then
--         return false
--       end
--     elseif v1 ~= v2 then
--       return false
--     end
--   end
--   return true
-- end

-- function abrirpainelsexo ()
-- 	if painelsexo == false then
-- 		addEventHandler ("onClientRender", root, painelescolhersexo)
-- 		showCursor (true)
-- 		showChat (false)
-- 		painelsexo = true
-- 	end
-- end
-- addEvent ("Abrircriarpersonagem", true)
-- addEventHandler ("Abrircriarpersonagem", root, abrirpainelsexo)

-- function fecharpainelsexo ()
-- 		removeEventHandler ("onClientRender", root, painelescolherroupas)
-- 		showCursor (false)
-- 		showChat (true)
-- 		painelroupas = false
-- 		setCameraTarget(localPlayer, localPlayer)
-- end
-- addEvent ("RemoverCriarPersonagem", true)
-- addEventHandler ("RemoverCriarPersonagem", root, fecharpainelsexo)

-- function abrirescolheroupas ()
-- 	if painelroupas == false then
-- 		addEventHandler ("onClientRender", root, painelescolherroupas)
-- 		painelroupas = true
-- 		setClothe(localPlayer, getElementModel ( localPlayer ), "perna", '1', '1')
-- 	end
-- end
-- addEvent ("Abrircriarroupas", true)
-- addEventHandler ("Abrircriarroupas", root, abrirescolheroupas)

-- --LOJA DE ROUPA

-- local painellojaroupav = false
-- function abrirlojaroupaa(roupasdoplayer,dados)
--     if painellojaroupav == false then
--         minhasroupas = fromJSON(roupasdoplayer)
--         minhasroupasat = fromJSON(roupasdoplayer)
--         minhasdados = fromJSON(dados)
--         genero = minhasdados.Genero
-- 		mascara = obterposicaoroupa((minhasroupas["mascara"] and minhasroupas["mascara"][1] or 0), (minhasroupas["mascara"] and minhasroupas["mascara"][2] or 0), roupas[genero].mascara)
-- 		oculos = obterposicaoroupa((minhasroupas["oculos"] and minhasroupas["oculos"][1] or 0), (minhasroupas["oculos"] and minhasroupas["oculos"][2] or 0), roupas[genero].oculos)
-- 		camisa = obterposicaoroupa((minhasroupas["camisa"] and minhasroupas["camisa"][1] or 0), (minhasroupas["camisa"] and minhasroupas["camisa"][2] or 0), roupas[genero].camisa)
-- 		mochila = obterposicaoroupa((minhasroupas["mochila"] and minhasroupas["mochila"][1] or 0), (minhasroupas["mochila"] and minhasroupas["mochila"][2] or 0), roupas[genero].mochila)
-- 		bone = obterposicaoroupa((minhasroupas["cabelo"] and minhasroupas["cabelo"][1] or 0), (minhasroupas["cabelo"] and minhasroupas["cabelo"][2] or 0), roupas[genero].bone)
-- 		perna = obterposicaoroupa((minhasroupas["perna"] and minhasroupas["perna"][1] or 0), (minhasroupas["perna"] and minhasroupas["perna"][2] or 0), roupas[genero].perna)
-- 		tenis = obterposicaoroupa((minhasroupas["tenis"] and minhasroupas["tenis"][1] or 0), (minhasroupas["tenis"] and minhasroupas["tenis"][2] or 0), roupas[genero].tenis)
--         addEventHandler("onClientRender", root, painellojaroupa)
--         painellojaroupav = true
--         showCursor(true)
--         showChat(false)
--         triggerServerEvent("CarregarRoupas", localPlayer,localPlayer)
--         preco=0
--     end
-- end

-- addEvent("Abrirlojaroupa", true)
-- addEventHandler("Abrirlojaroupa", root, abrirlojaroupaa)

-- addEventHandler("onClientClick", getRootElement(), --cliques da loja de roupa
--     function(b, s)
--         if painellojaroupav == true then
--             if (b == "left") and (s == "down") then
--                 if cursorPosition(x*503, y*56, x*22, y*20) then
--                 	removeEventHandler("onClientRender", root, painellojaroupa)
--         			painellojaroupav = false
--         			showCursor(false)
--         			showChat(true)
--         			setCameraTarget(localPlayer, localPlayer)
--         			setElementDimension ( localPlayer, 0 )
--         			triggerServerEvent("CarregarRoupas", localPlayer,localPlayer)
--         		elseif cursorPosition(x*392, y*293, x*47, y*26) then -- +mascara
--         			if mascara < #roupas[genero].mascara then
--         				mascara=mascara+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "mascara", roupas[genero]["mascara"][mascara][1], roupas[genero]["mascara"][mascara][2])
--         			minhasroupas["mascara"] = {roupas[genero]["mascara"][mascara][1], roupas[genero]["mascara"][mascara][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*226, y*294, x*45, y*25) then -- -mascara
--                 	if mascara > 1 then
--         				mascara=mascara-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "mascara", roupas[genero]["mascara"][mascara][1], roupas[genero]["mascara"][mascara][2])
--         			minhasroupas["mascara"] = {roupas[genero]["mascara"][mascara][1], roupas[genero]["mascara"][mascara][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--         		elseif cursorPosition(x*391, y*405, x*48, y*28) then -- +oculos
--         			if oculos < #roupas[genero].oculos then
--         				oculos=oculos+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "oculos", roupas[genero]["oculos"][oculos][1], roupas[genero]["oculos"][oculos][2])
--         			minhasroupas["oculos"] = {roupas[genero]["oculos"][oculos][1], roupas[genero]["oculos"][oculos][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*225, y*406, x*46, y*27) then -- -oculos
--                 	if oculos > 1 then
--         				oculos=oculos-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "oculos", roupas[genero]["oculos"][oculos][1], roupas[genero]["oculos"][oculos][2])
--         			minhasroupas["oculos"] = {roupas[genero]["oculos"][oculos][1], roupas[genero]["oculos"][oculos][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--         		elseif cursorPosition(x*390, y*516, x*45, y*27) then -- +camisa
--         			if camisa < #roupas[genero].camisa then
--         				camisa=camisa+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "camisa", roupas[genero]["camisa"][camisa][1], roupas[genero]["camisa"][camisa][2])
--         			minhasroupas["camisa"] = {roupas[genero]["camisa"][camisa][1], roupas[genero]["camisa"][camisa][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*225, y*518, x*46, y*25) then -- -camisa
--                 	if camisa > 1 then
--         				camisa=camisa-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "camisa", roupas[genero]["camisa"][camisa][1], roupas[genero]["camisa"][camisa][2])
--         			minhasroupas["camisa"] = {roupas[genero]["camisa"][camisa][1], roupas[genero]["camisa"][camisa][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--         		elseif cursorPosition(x*390, y*629, x*49, y*26) then -- +mochila
--         			if mochila < #roupas[genero].mochila then
--         				mochila=mochila+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "mochila", roupas[genero]["mochila"][mochila][1], roupas[genero]["mochila"][mochila][2])
--         			minhasroupas["mochila"] = {roupas[genero]["mochila"][mochila][1], roupas[genero]["mochila"][mochila][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*225, y*629, x*46, y*26) then -- -mochila
--                 	if mochila > 1 then
--         				mochila=mochila-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "mochila", roupas[genero]["mochila"][mochila][1], roupas[genero]["mochila"][mochila][2])
--         			minhasroupas["mochila"] = {roupas[genero]["mochila"][mochila][1], roupas[genero]["mochila"][mochila][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--         		elseif cursorPosition(x*390, y*182, x*49, y*26) then -- +bone
--         			if bone < #roupas[genero].bone then
--         				bone=bone+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", roupas[genero]["bone"][bone][1], roupas[genero]["bone"][bone][2])
--         			minhasroupas["cabelo"] = {roupas[genero]["bone"][bone][1], roupas[genero]["bone"][bone][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*223, y*180, x*48, y*28) then -- -bone
--                 	if bone > 1 then
--         				bone=bone-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", roupas[genero]["bone"][bone][1], roupas[genero]["bone"][bone][2])
--         			minhasroupas["cabelo"] = {roupas[genero]["bone"][bone][1], roupas[genero]["bone"][bone][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--         		elseif cursorPosition(x*391, y*740, x*48, y*28) then -- +perna
--         			if perna < #roupas[genero].perna then
--         				perna=perna+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "perna", roupas[genero]["perna"][perna][1], roupas[genero]["perna"][perna][2])
--         			minhasroupas["perna"] = {roupas[genero]["perna"][perna][1], roupas[genero]["perna"][perna][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*224, y*739, x*47, y*29) then -- -perna
--                 	if perna > 1 then
--         				perna=perna-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "perna", roupas[genero]["perna"][perna][1], roupas[genero]["perna"][perna][2])
--         			minhasroupas["perna"] = {roupas[genero]["perna"][perna][1], roupas[genero]["perna"][perna][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--         		elseif cursorPosition(x*391, y*848, x*48, y*31) then -- +tenis
--         			if tenis < #roupas[genero].tenis then
--         				tenis=tenis+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "tenis", roupas[genero]["tenis"][tenis][1], roupas[genero]["tenis"][tenis][2])
--         			minhasroupas["tenis"] = {roupas[genero]["tenis"][tenis][1], roupas[genero]["tenis"][tenis][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*227, y*852, x*44, y*27) then -- -tenis
--                 	if tenis > 1 then
--         				tenis=tenis-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "tenis", roupas[genero]["tenis"][tenis][1], roupas[genero]["tenis"][tenis][2])
--         			minhasroupas["tenis"] = {roupas[genero]["tenis"][tenis][1], roupas[genero]["tenis"][tenis][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*42, y*972, x*493, y*56) then -- comprar
--                 if getPlayerMoney(localPlayer) >= (preco*precoroupa.roupa) then
--                 	takePlayerMoney(preco*precoroupa.roupa)
-- 					triggerServerEvent("SalvarRoupas", localPlayer,localPlayer, minhasroupas)
-- 					removeEventHandler("onClientRender", root, painellojaroupa)
--         			painellojaroupav = false
--         			showCursor(false)
--         			showChat(true)
--         			setCameraTarget(localPlayer, localPlayer)
--         			setElementDimension ( localPlayer, 0 ) 
--         		else
--         			exports["Santos_infobox"]:addNotification("Dinheiro insuficiente!", "info")
--         		end
--             	end
--         	end
--         end
--     end
-- )

-- --barbeiro

-- function painelbarbeiro ()
-- 	dxDrawImage(x*0, y*0, x*1920, y*1080, "files/barbearia.png")
-- 	dxDrawText((cabelo-1).."/"..#(roupas[genero].cabelo)-1, x*300, y*464, x*368, y*510, tocolor(255, 255, 255, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText("0/0", x*300, y*577, x*368, y*623, tocolor(255, 255, 255, 255), 1.40, "default", "center", "center", false, false, false, false, false)
--     dxDrawText("Preço Total: "..preco*precoroupa.cabelo.."R$", x*383, y*682, x*503, y*118, tocolor(255, 255, 255, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
-- end

-- addEventHandler("onClientClick", getRootElement(), --cliques barbeiro
--     function(b, s)
--         if painelbarbeirov == true then
--             if (b == "left") and (s == "down") then
--                 if cursorPosition(x*503, y*344, x*22, y*21) then --
--                 	removeEventHandler("onClientRender", root, painelbarbeiro)
--         			painelbarbeirov = false
--         			showCursor(false)
--         			showChat(true)
--         			setCameraTarget(localPlayer, localPlayer)
--         			setElementDimension ( localPlayer, 0 )
--         			triggerServerEvent("CarregarRoupas", localPlayer,localPlayer)
--         		elseif cursorPosition(x*390, y*475, x*46, y*25) then -- +cabelo
--         			if cabelo < #roupas[genero].cabelo then
--         				cabelo=cabelo+1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", roupas[genero]["cabelo"][cabelo][1], roupas[genero]["cabelo"][cabelo][2])
--         			minhasroupas["cabelo"] = {roupas[genero]["cabelo"][cabelo][1], roupas[genero]["cabelo"][cabelo][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*224, y*475, x*48, y*25) then -- -cabelo
--                 	if cabelo > 1 then
--         				cabelo=cabelo-1
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", roupas[genero]["cabelo"][cabelo][1], roupas[genero]["cabelo"][cabelo][2])
--         			minhasroupas["cabelo"] = {roupas[genero]["cabelo"][cabelo][1], roupas[genero]["cabelo"][cabelo][2]}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*44, y*683, x*492, y*59) then -- comprar
--                                 if getPlayerMoney(localPlayer) >= (preco*precoroupa.cabelo) then
--                 	takePlayerMoney(preco*precoroupa.cabelo)
-- 					triggerServerEvent("SalvarRoupas", localPlayer,localPlayer, minhasroupas)
-- 					removeEventHandler("onClientRender", root, painelbarbeiro)
--         			painelbarbeirov = false
--         			showCursor(false)
--         			showChat(true)
--         			setCameraTarget(localPlayer, localPlayer)
--         			setElementDimension ( localPlayer, 0 )
--        			        		else
--         			exports["Santos_infobox"]:addNotification("Dinheiro insuficiente!", "info")
--         		end
--             	end
--         	end
--         end
--     end
-- )

-- painelbarbeirov = false
-- function abrirbarbeiroa(roupasdoplayer,dados)
--     if painelbarbeirov == false then
--         minhasroupas = fromJSON(roupasdoplayer)
--         minhasroupasat = fromJSON(roupasdoplayer)
--         minhasdados = fromJSON(dados)
--         genero = minhasdados.Genero
--         painelbarbeirov = true
-- 		cabelo = obterposicaoroupa((minhasroupas["cabelo"] and minhasroupas["cabelo"][1]) or 0, (minhasroupas["cabelo"] and minhasroupas["cabelo"][2]) or 0, roupas[genero].cabelo)
--         addEventHandler("onClientRender", root, painelbarbeiro)
--         showCursor(true)
--         showChat(false)
--         triggerServerEvent("CarregarRoupas", localPlayer,localPlayer)
--         preco=0
--     end
-- end

-- addEvent("Abrirbarbeiro", true)
-- addEventHandler("Abrirbarbeiro", root, abrirbarbeiroa)

-- function paineltatuador ()
-- 	dxDrawImage(x*0, y*0, x*1920, y*1080, "files/tatuador.png")
-- 	dxDrawText(tatuagemface.."/2", x*300, y*240, x*368, y*510, tocolor(255, 255, 255, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
-- 	dxDrawText(tatuagembody.."/2", x*300, y*463, x*368, y*510, tocolor(255, 255, 255, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
-- 	dxDrawText(tatuagemcoxa.."/2", x*300, y*684, x*368, y*510, tocolor(255, 255, 255, 255), x*1.40, "default", "center", "center", false, false, false, false, false)
-- 	dxDrawText("Preço Total: "..preco*precoroupa.tatuagem.."R$", x*383, y*435, x*503, y*118, tocolor(255, 255, 255, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
-- end


-- paineltatuadorv = false
-- function abrirtatuadora(roupasdoplayer,dados)
--     if paineltatuadorv == false then
--         minhasroupas = fromJSON(roupasdoplayer)
--         minhasroupasat = fromJSON(roupasdoplayer)
--         minhasdados = fromJSON(dados)
--         genero = minhasdados.Genero
--         paineltatuadorv = true
--         face = minhasroupas["face"][2]
--         if face >= 1 and face <= 5 then
--   		tatuagemface = 0
-- 		elseif face >= 6 and face <= 10 then
--   		tatuagemface = 1
-- 		elseif face >= 11 and face <= 15 then
--   		tatuagemface = 2
-- 		end
--         body = minhasroupas["body"][2]
--         if body >= 1 and body <= 5 then
--   		tatuagembody = 0
-- 		elseif body >= 6 and body <= 10 then
--   		tatuagembody = 1
-- 		elseif body >= 11 and body <= 15 then
--   		tatuagembody = 2
-- 		end
--         coxa = minhasroupas["coxa"][2]
--         if coxa >= 1 and coxa <= 5 then
--   		tatuagemcoxa = 0
-- 		elseif coxa >= 6 and coxa <= 10 then
--   		tatuagemcoxa = 1
-- 		elseif coxa >= 11 and coxa <= 15 then
--   		tatuagemcoxa = 2
-- 		end
--         addEventHandler("onClientRender", root, paineltatuador)
--         showCursor(true)
--         showChat(false)
--         triggerServerEvent("CarregarRoupas", localPlayer,localPlayer)
--         preco=0
--     end
-- end

-- addEvent("Abrirtatuador", true) 
-- addEventHandler("Abrirtatuador", root, abrirtatuadora)

-- addEventHandler("onClientClick", getRootElement(), --tatuador cliques
--     function(b, s)
--         if paineltatuadorv == true then
--             if (b == "left") and (s == "down") then
--             	preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 if cursorPosition(x*224, y*363, x*54, y*29) then -- -face
--                 	if tatuagemface > 0 then
--                 		tatuagemface=tatuagemface-1
--                 		face=face-5
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "face", "1", face)
--         			minhasroupas["face"] = {"1", face}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*391, y*364, x*47, y*28) then -- +face
--                 	if tatuagemface < 2 then
--                 		tatuagemface=tatuagemface+1
--                 		face=face+5
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "face", "1", face)
--         			minhasroupas["face"] = {"1", face}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*223, y*473, x*45, y*28) then -- -body
--                 	if tatuagembody > 0 then
--                 		tatuagembody=tatuagembody-1
--                 		body=body-5
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "body", "1", body)
--         			minhasroupas["body"] = {"1", body}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*390, y*474, x*48, y*27) then -- +body
--                 	if tatuagembody < 2 then
--                 		tatuagembody=tatuagembody+1
--                 		body=body+5
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "body", "1", body)
--         			minhasroupas["body"] = {"1", body}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*223, y*586, x*45, y*27) then -- -coxa
--                 	if tatuagemcoxa > 0 then
--                 		tatuagemcoxa=tatuagemcoxa-1
--                 		coxa=coxa-5
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "coxa", "1", coxa)
--         			minhasroupas["coxa"] = {"1", coxa}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*390, y*587, x*48, y*26) then -- +coxa
--                 	if tatuagemcoxa < 2 then
--                 		tatuagemcoxa=tatuagemcoxa+1
--                 		coxa=coxa+5
--       				setClothe(localPlayer, getPlayerSkin ( localPlayer ), "coxa", "1", coxa)
--         			minhasroupas["coxa"] = {"1", coxa}
--         			preco = valorcarrinho(minhasroupasat, minhasroupas)
--                 	end
--                 elseif cursorPosition(x*503, y*231, x*25, y*22) then -- fechar
--                     removeEventHandler("onClientRender", root, paineltatuador)
--         			paineltatuadorv = false
--         			showCursor(false)
--         			showChat(true)
--         			setCameraTarget(localPlayer, localPlayer)
--         			setElementDimension ( localPlayer, 0 )
--         			triggerServerEvent("CarregarRoupas", localPlayer,localPlayer)
--                 elseif cursorPosition(x*48, y*686, x*490, y*57) then -- comprar
--                 if getPlayerMoney(localPlayer) >= (preco*precoroupa.tatuagem) then
--                 	takePlayerMoney(preco*precoroupa.tatuagem)
-- 					triggerServerEvent("SalvarRoupas", localPlayer,localPlayer, minhasroupas)
--                     removeEventHandler("onClientRender", root, paineltatuador)
--         			paineltatuadorv = false
--         			showCursor(false)
--         			showChat(true)
--         			setCameraTarget(localPlayer, localPlayer)
--         			setElementDimension ( localPlayer, 0 )
--         			        		else
--         			exports["Santos_infobox"]:addNotification("Dinheiro insuficiente!", "info")
--         		end
--                 end
--             end
--         end
--     end
-- )

-- function cursorPosition(x, y, width, height)
--     if(not isCursorShowing()) then
--         return false
--     end
--     local sx, sy = guiGetScreenSize()
--     local cx, cy = getCursorPosition()
--     local cx, cy =(cx*sx),(cy*sy)
--     if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
--         return true
--     else
--         return false
--     end
-- end

-- addEventHandler("onClientClick", getRootElement(), --escolher sexo
--     function(b, s)
--         if painelsexo == true then
--             if (b == "left") and (s == "down") then
--                 if cursorPosition(x*820, y*434, x*120, y*106) then
--                 	sexoselecionado = "Masculino"	
--                 elseif cursorPosition(x*977, y*434, x*122, y*106) then
--                 	sexoselecionado = "Femenino"	
--                 elseif cursorPosition(x*820, y*602, x*279, y*44) then
--                 	if sexoselecionado==nil then
--                 		exports["Santos_infobox"]:addNotification("Antes de prosseguir,  selecione o gênero do seu personagem para continuar com a criação.", "info")
--                 	else
--                 		triggerServerEvent("Configurarpersonagem", localPlayer,localPlayer, sexoselecionado)
--                 		removeEventHandler ("onClientRender", root, painelescolhersexo)
--                 		painelsexo=false
--                 	end 
--                 end
--             end
--         end
--     end
-- )

-- addEventHandler("onClientClick", getRootElement(), --escolher roupa
--     function(b, s)
--         if painelroupas == true then
--             if (b == "left") and (s == "down") then
--                 if cursorPosition(x*214, y*552, x*40, y*22) then -- -pele
--                 	if corpele > 1 then
--                 	 corpele=corpele-1
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "body", '1', corpele)
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "face", '1', corpele)
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "coxa", '1', corpele)
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "pec", '1', corpele)
--                 	end
--                 elseif cursorPosition(x*381, y*553, x*42, y*26) then -- +pele
--                 	if corpele < 5 then
--                 	 corpele=corpele+1
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "body", '1', corpele)
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "face", '1', corpele)
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "coxa", '1', corpele)
--                 	 setClothe(localPlayer, getPlayerSkin ( localPlayer ), "pec", '1', corpele)
--                 	end
--                 elseif cursorPosition(x*212, y*638, x*45, y*26) then -- -calca
--                 	if calcaa > 1 then
--                 	 calcaa=calcaa-1
-- 					setClothe(localPlayer, getPlayerSkin ( localPlayer ), "perna", '1', calcaa)
--                 	end
--                 elseif cursorPosition(x*378, y*638, x*43, y*26) then -- +calca
--                 	if calcaa < 2 then
--                 	 calcaa=calcaa+1
-- 					setClothe(localPlayer, getPlayerSkin ( localPlayer ), "perna", '1', calcaa)
--                 	end
--                 elseif cursorPosition(x*211, y*719, x*46, y*27) then -- -cabelo
--                 	if cabeloo > 0 then
--                 	 cabeloo=cabeloo-1
-- 					setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", cabeloo, corcabelo)
--                 	end
--                 elseif cursorPosition(x*379, y*719, x*46, y*27) then -- +cabelo
--                 if getPlayerSkin ( localPlayer ) == 14 then
--                 	if cabeloo < 4 then
--                 	 cabeloo=cabeloo+1
-- 					setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", cabeloo, corcabelo)
-- 					end
-- 				else
--                 	if cabeloo < 3 then
--                 	 cabeloo=cabeloo+1
-- 					setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", cabeloo, corcabelo)
--                 	end
--                 end
--                 elseif cursorPosition(x*212, y*807, x*45, y*22) then -- -corcabelo
--                 	if corcabelo > 1 then
--                 	 corcabelo=corcabelo-1
-- 					setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", cabeloo, corcabelo)
--                 	end
--                 elseif cursorPosition(x*379, y*805, x*46, y*24) then -- +corcabelo
--                 	if corcabelo < 3 then
--                 	 corcabelo=corcabelo+1
-- 					setClothe(localPlayer, getPlayerSkin ( localPlayer ), "cabelo", cabeloo, corcabelo)
-- 					end
--                 elseif cursorPosition(x*52, y*900, x*451, y*64) then --confirmar 
--                		local primeironome = getElementData(nome, "text")
--                     local ultimonome = getElementData(subnome, "text")
--                     local idade = getElementData(idade, "text")
--                     triggerServerEvent("Criarpersonagem", localPlayer,localPlayer, primeironome,ultimonome,idade,corpele,calcaa,cabeloo,corcabelo)
--                 end
--             end
--         end
--     end
-- )



--[[
███╗   ███╗████████╗ █████╗    ███████╗ █████╗     ███╗   ███╗ ██████╗ ██████╗ ███████╗
████╗ ████║╚══██╔══╝██╔══██╗██╗██╔════╝██╔══██╗    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝
██╔████╔██║   ██║   ███████║╚═╝███████╗███████║    ██╔████╔██║██║   ██║██║  ██║███████╗
██║╚██╔╝██║   ██║   ██╔══██║██╗╚════██║██╔══██║    ██║╚██╔╝██║██║   ██║██║  ██║╚════██║
██║ ╚═╝ ██║   ██║   ██║  ██║╚═╝███████║██║  ██║    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████║
╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════    
                       
					   A MAIOR COMUNIDADE DE MODS DO MTA:SA BR
						   
PROCURANDO SCRIPTS, MAPAS, MODELAGENS EXCLUSIVOS?
NOSSA COMUNIDADE ESTÁ SEMPRE ATIVA SOLTANDO VARIOS MODS DE GRAÇA!

MAIS DE 400 MODS DESCOMPILADOS COM DOWNLOAD DIRETO!
MAIS DE 400 MODS DESCOMPILADOS COM DOWNLOAD DIRETO!
MAIS DE 400 MODS DESCOMPILADOS COM DOWNLOAD DIRETO!
MAIS DE 400 MODS DESCOMPILADOS COM DOWNLOAD DIRETO!

LINK DE CONVITE PERMANENTE:

https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
https://discord.gg/KXV2GHtJtg   
]]