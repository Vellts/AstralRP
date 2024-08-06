-- FILE: mapEditorScriptingExtension_c.lua
-- PURPOSE: Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps
-- VERSION: RemoveWorldObjects (v1) AutoLOD (v2) BreakableObjects (v1)

function setLODsClient(lodTbl)
	for model in pairs(lodTbl) do
		engineSetModelLODDistance(model, 300)
	end
end
addEvent("setLODsClient", true)
addEventHandler("setLODsClient", resourceRoot, setLODsClient)


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