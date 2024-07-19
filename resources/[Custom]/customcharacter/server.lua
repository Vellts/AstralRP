local ClothesInUsing = {}

function refreshPlayerClothes(target, clothesTable)
    local clothes = getAccountData(getPlayerAccount(target), "RoupasPersonagem")
    if type(clothes) == "table" and #clothes ~= 0 then
        ClothesInUsing[target] = clothes
    end 
end

function UpdatePlayerClothes(element, clothes)
    refreshPlayerClothes(element)
    ClothesInUsing[element] = clothes
    triggerClientEvent(root, "setPlayerClothe", root, element, clothes["skin"], ClothesInUsing[element])
    triggerClientEvent(element, "setPlayersClothes", element, ClothesInUsing)
end

addEventHandler("onPlayerQuit", getRootElement(), 
    function()
        ClothesInUsing[source] = nil
    end
)

addCommandHandler("cropa", function(player)
    UpdatePlayerClothes(player, defaultClothes[10])
end)

-- addEventHandler("onPlayerWasted", getRootElement(),
--     function()
--         local playerAccount = getPlayerAccount(source)
--         if playerAccount and not isGuestAccount(playerAccount) then
--             setTimer(function(source)
--                 local roupas = getAccountData(playerAccount, "RoupasPersonagem")
--                 local Generotable1 = getAccountData(playerAccount, "DadosPersonagem")
--                 local Generotable = fromJSON(Generotable1)
--                 if Generotable.Genero == "Masculino" then
--                     setElementModel(source, 14)
--                 elseif Generotable.Genero == "Femenino" then
--                     setElementModel(source, 10)
--                 end
--                 local minhasroupas = fromJSON(roupas)
--                 UpdatePlayerClothes(source, minhasroupas)
--             end, 5000, 1, source) -- com freeroam use 5s!  se nao pode tirar
--         end
--     end
-- )

--criar personagem

-- function getFreeDimension ()
--     local freeDim = nil
--     for dim = 1, 60000 do
--         if #getElementsInDimension ("player", dim) == 0 then
--             freeDim = dim
--             break
--         end
--     end
--     return freeDim
-- end

-- function getElementsInDimension(theType,dimension)
--     local elementsInDimension = { }
--     for key, value in ipairs(getElementsByType(theType)) do
--         if getElementDimension(value)==dimension then
--             table.insert(elementsInDimension,value)
--         end
--     end
--         return elementsInDimension
-- end

-- addEventHandler ( 'onPlayerLogin', getRootElement(), function(_, currentAccount)
--     if not getAccountData(currentAccount, 'DadosPersonagem') then
--         local dimen = getFreeDimension()
--         setElementDimension(source, dimen)
--         setCameraMatrix(source, 2127.6826171875, 1854.4733886719, 11.615599632263, 2126.7890625, 1854.9112548828, 11.517384529114, 0, 70)
--         setElementPosition(source, 0, 0, 0)
--         triggerClientEvent (source, "Abrircriarpersonagem", source)
--         ClothesInUsing[source] = nil
--     else
--     local roupas = getAccountData(getPlayerAccount(source), "RoupasPersonagem")
--     local Generotable1 = getAccountData(getPlayerAccount(source), "DadosPersonagem")
--     local Generotable = fromJSON(Generotable1)
--     if Generotable.Genero == "Masculino" then
--         setElementModel(source,14)
--     elseif Generotable.Genero == "Femenino" then
--         setElementModel(source,10) 
--     end
--         local minhasroupas = fromJSON(roupas)
--         UpdatePlayerClothes(source, minhasroupas)
-- end
-- end)

-- addEvent("Configurarpersonagem", true)
-- addEventHandler("Configurarpersonagem", getRootElement(),
--     function(element,genero)
--         ClothesInUsing[element] = nil
--         if genero == "Masculino" then
--             setPlayerSkin(element, 14)
--         elseif genero == "Femenino" then
--             setPlayerSkin(element, 10)
--         end
--         setElementRotation(element, -0, 0, -120)
--         setElementPosition(element, 2124.20459, 1856.92664, 10.67188)
--         triggerClientEvent (source, "Abrircriarroupas", source)
--     end
-- )

-- addEvent("SalvarRoupas", true)
-- addEventHandler("SalvarRoupas", getRootElement(),
--     function(element,roupas)
--     local roupasjson = toJSON(roupas)
--     setAccountData(getPlayerAccount(element), "RoupasPersonagem", roupasjson)
--     UpdatePlayerClothes(element, roupas)
--     exports["Santos_infobox"]:addNotification(element, "O seu estilo foi alterado!", "success")
--     end
-- )

-- addEvent("CarregarRoupas", true)
-- addEventHandler("CarregarRoupas", getRootElement(),
--     function(element)
--     local roupasss = getAccountData(getPlayerAccount(element), "RoupasPersonagem")
--     local roupasjson = fromJSON(roupasss)
--     UpdatePlayerClothes(element, roupasjson)
--     end
-- )

-- addEvent("Criarpersonagem", true)
-- addEventHandler("Criarpersonagem", getRootElement(),
--     function(element, primeironome,ultimonome,idade,corpele,calca,cabelo,corcabelo)
--     if primeironome == "" or ultimonome == "" or idade == "" then
--         exports["Santos_infobox"]:addNotification(element,"Por favor, preencha todos os campos.", "info")
--         return
--     end
    
-- if not tonumber(idade) then
--     exports["Santos_infobox"]:addNotification(element, "A idade tem de ser um número.", "info")
--     return
-- end
    
--     if not primeironome:match("^[A-Z][a-z]*$") then
--         exports["Santos_infobox"]:addNotification(element, "O Primeiro Nome não é válido. Certifique-se de que não contenha números e a primeira letra esteja em maiúscula.", "info")
--         return
--     end

--     if not ultimonome:match("^[A-Z][a-z]*$") then
--         exports["Santos_infobox"]:addNotification(element, "O Ultimo Nome não é válido. Certifique-se de que não contenha números e a primeira letra esteja em maiúscula.", "info")
--         return
--     end

--     setElementPosition(element, 1482.29761, -1740.99561, 13.54688)
--     setElementDimension(element, 0)
--     exports["Santos_infobox"]:addNotification(element, "Personagem criada.", "success")
--     triggerClientEvent(element, "RemoverCriarPersonagem", root)
--     if getElementModel ( element ) == 14 then
--         sexo = "Masculino"
--     else
--         sexo = "Femenino"
--     end
    
--     local minhaTabela = {
--         PrimeiroNome = primeironome,
--         UltimoNome = ultimonome,
--         Idade = idade,
--         Genero = sexo
--     }
-- local minhaTabela2 = {
--         ["skin"] = getPlayerSkin(element),
--         ["perna"] = {1, calca},
--         ["body"] = {1, corpele},
--         ["face"] = {1, corpele},
--         ["coxa"] = {1, corpele},
--         ["pec"] = {1, corpele},
--         ["cabelo"] = {cabelo, corcabelo}}
--     local minhaTabelaJson = toJSON(minhaTabela)
--     local minhaTabelaJson2 = toJSON(minhaTabela2)
--     local novoNome = primeironome .. "_" .. ultimonome
--     setPlayerName(element, novoNome)
--     setAccountData(getPlayerAccount(element), "DadosPersonagem", minhaTabelaJson)
--     setAccountData(getPlayerAccount(element), "RoupasPersonagem", minhaTabelaJson2)
--     UpdatePlayerClothes(element, minhaTabela2)
-- end
-- )

-- --loja roupa

-- local entrarlojaroupa = createMarker(2244.53760, -1664.78369, 15.47656-0.95, 'cylinder', 1.0, 0, 255, 255, 255) -- entrar loja de roupa
-- local sairlojaroupa = createMarker(161.37653, -96.50153, 1001.80469-0.95, 'cylinder', 1.0, 0, 255, 255, 255) 
-- local usarlojaroupa = createMarker(161.26387, -83.25166, 1001.80469-0.95, 'cylinder', 1.0, 0, 255, 255, 255)
-- setElementInterior(sairlojaroupa, 18)
-- setElementInterior(usarlojaroupa, 18)
-- createBlipAttachedTo(entrarlojaroupa,45)

-- function entrarlojaroupafun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         setElementPosition(hitElement, 161.27808, -94.38094, 1001.80469)
--         setElementInterior(hitElement, 18)
--         setElementDimension(hitElement, 0)
--     end
-- end
-- addEventHandler("onMarkerHit", entrarlojaroupa, entrarlojaroupafun)

-- function sairlojaroupafun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         setElementPosition(hitElement, 2245.24536, -1662.02881, 15.46900)
--         setElementInterior(hitElement, 0)
--         setElementDimension(hitElement, 0)
--     end 
-- end
-- addEventHandler("onMarkerHit", sairlojaroupa, sairlojaroupafun)

-- function usarlojaroupafun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         local playerAccount = getPlayerAccount(hitElement)
--         if playerAccount and not isGuestAccount(playerAccount) then
--             local playerSkin = getPlayerSkin(hitElement)
--             if playerSkin == 10 or playerSkin == 14 then
--                 local dimen = getFreeDimension()
--                 local roupas = getAccountData(playerAccount, "RoupasPersonagem")
--                 local dados = getAccountData(playerAccount, "DadosPersonagem")
--                 triggerClientEvent(hitElement, "Abrirlojaroupa", root, roupas,dados)
--                 setElementDimension(hitElement, dimen)
--                 setCameraMatrix(hitElement, 180.93440246582, -88.184799194336, 1002.7855834961, 181.92977905273, -88.162506103516, 1002.692199707, 0, 70)
--                 setElementPosition(hitElement, 179.92381, -88.19852, 1002.02344)
--                 setElementRotation(hitElement, 0, 0, -90)
--             end
--         end
--     end
-- end
-- addEventHandler("onMarkerHit", usarlojaroupa, usarlojaroupafun)

-- --barbeiro

-- local entrarbarbeiro = createMarker(2070.90015, -1793.84778, 13.55328-0.95, 'cylinder', 1.0, 0, 255, 255, 255) -- entrar barbeiro
-- local sairbarbeiro = createMarker(411.66373, -23.01593, 1001.80469-0.95, 'cylinder', 1.0, 0, 255, 255, 255)
-- local usarbarbeiro = createMarker(414.54974, -19.84221, 1001.80469-0.95, 'cylinder', 1.0, 0, 255, 255, 255)
-- setElementInterior(sairbarbeiro, 2)
-- setElementInterior(usarbarbeiro, 2)
-- createBlipAttachedTo(entrarbarbeiro,7)

-- function entrarbarbeirofun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         setElementPosition(hitElement, 411.54593, -21.36291, 1001.80469)
--         setElementInterior(hitElement, 2)
--         setElementDimension(hitElement, 0)
--     end
-- end
-- addEventHandler("onMarkerHit", entrarbarbeiro, entrarbarbeirofun)

-- function sairbarbeirofun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         setElementPosition(hitElement, 2072.26733, -1793.69922, 13.54688)
--         setElementInterior(hitElement, 0)
--         setElementDimension(hitElement, 0)
--     end 
-- end
-- addEventHandler("onMarkerHit", sairbarbeiro, sairbarbeirofun)

-- function usarbarbeirofun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         local playerAccount = getPlayerAccount(hitElement)
--         if playerAccount and not isGuestAccount(playerAccount) then
--             local playerSkin = getPlayerSkin(hitElement)
--             if playerSkin == 10 or playerSkin == 14 then
--                 local dimen = getFreeDimension()
--                 local roupas = getAccountData(playerAccount, "RoupasPersonagem")
--                 local dados = getAccountData(playerAccount, "DadosPersonagem")
--                 triggerClientEvent(hitElement, "Abrirbarbeiro", root, roupas,dados)
--                 setElementDimension(hitElement, dimen)
--                 setCameraMatrix(hitElement, 415.64990234375, -18.847900390625, 1002.4592285156, 414.66632080078, -18.864368438721, 1002.2794799805, 0, 70)
--                 setElementPosition(hitElement, 414.22522, -18.92051, 1001.80469)
--                 setElementRotation(hitElement, 0, 0, -90)
--             end
--         end
--     end
-- end
-- addEventHandler("onMarkerHit", usarbarbeiro, usarbarbeirofun)

-- -- tatuador

-- local entrartatuador = createMarker(2068.89111, -1779.79163, 13.55947-0.95, 'cylinder', 1.0, 0, 255, 255, 255) -- entrar tatuador
-- local sairtatuador = createMarker(-204.30072, -26.99689, 1002.27344-0.95, 'cylinder', 1.0, 0, 255, 255, 255)
-- local usartatuador = createMarker(-201.06140, -25.83372, 1002.27344-0.95, 'cylinder', 1.0, 0, 255, 255, 255)
-- setElementInterior(sairtatuador, 16)
-- setElementInterior(usartatuador, 16)
-- createBlipAttachedTo(entrartatuador,39)

-- function usartatuadorfun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         local playerAccount = getPlayerAccount(hitElement)
--         if playerAccount and not isGuestAccount(playerAccount) then
--             local playerSkin = getPlayerSkin(hitElement)
--             if playerSkin == 10 or playerSkin == 14 then
--                 local dimen = getFreeDimension()
--                 local roupas = getAccountData(playerAccount, "RoupasPersonagem")
--                 local dados = getAccountData(playerAccount, "DadosPersonagem")
--                 triggerClientEvent(hitElement, "Abrirtatuador", root, roupas,dados)
--                 setElementDimension(hitElement, dimen)
--                 setCameraMatrix(hitElement, -204.65190124512, -25.560699462891, 1003.4744262695, -203.76362609863, -25.390756607056, 1003.0477294922, 0, 70)
--                 setElementPosition(hitElement, -202.02669, -25.04580, 1002.27344)
--                 setElementRotation(hitElement, 0, 0, 110)
--             end
--         end
--     end
-- end
-- addEventHandler("onMarkerHit", usartatuador, usartatuadorfun)

-- function entrartatuadorfun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         setElementPosition(hitElement, -204.29341, -25.95198, 1002.27344)
--         setElementInterior(hitElement, 16)
--         setElementDimension(hitElement, 0)
--     end
-- end
-- addEventHandler("onMarkerHit", entrartatuador, entrartatuadorfun)

-- function sairtatuadorfun(hitElement)
--     if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
--         setElementPosition(hitElement, 2070.16089, -1779.86621, 13.55885)
--         setElementInterior(hitElement, 0)
--         setElementDimension(hitElement, 0)
--     end 
-- end
-- addEventHandler("onMarkerHit", sairtatuador, sairtatuadorfun)



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