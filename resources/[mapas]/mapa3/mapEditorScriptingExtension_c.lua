   --NÃO RETIRAR CREDITOS!  NÃO RETIRAR CREDITOS!  NÃO RETIRAR CREDITOS!   
  --              https://discord.gg/KXV2GHtJtg                              


--PROCURANDO SCRIPTS, MAPAS, MODELAGENS EXCLUSIVOS?
--NOSSA COMUNIDADE ESTÁ SEMPRE A ATIVA SOLTANDO VARIOS MODS DE GRAÇA!

--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO
--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO
--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO
--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO

--LINK DE CONVITE PERMANENTE:

--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   


function requestLODsClient()
	triggerServerEvent("requestLODsClient", resourceRoot)
end
addEventHandler("onClientResourceStart", resourceRoot, requestLODsClient)

function setLODsClient(lodTbl)
	for model in pairs(lodTbl) do
		engineSetModelLODDistance(model, 300)
	end
end
addEvent("setLODsClient", true)
addEventHandler("setLODsClient", resourceRoot, setLODsClient)

function applyBreakableState()
	for k, obj in pairs(getElementsByType("object", resourceRoot)) do
		local breakable = getElementData(obj, "breakable")
		if breakable then
			setObjectBreakable(obj, breakable == "true")
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, applyBreakableState)
