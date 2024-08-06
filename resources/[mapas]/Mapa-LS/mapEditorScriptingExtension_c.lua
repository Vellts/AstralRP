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

function applyBreakableState()
	local objectsTable = getElementsByType("object", resourceRoot)

	for objectID = 1, #objectsTable do
		local objectElement = objectsTable[objectID]
		local objectBreakable = getElementData(objectElement, "breakable")

		if objectBreakable then
			setObjectBreakable(objectElement, objectBreakable == "true")
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, applyBreakableState)

--[[
 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
 ███╗   ███╗████████╗ █████╗    ███████╗ █████╗     ███╗   ███╗ ██████╗ ██████╗ ███████╗█
 ████╗ ████║╚══██╔══╝██╔══██╗██╗██╔════╝██╔══██╗    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝█
 ██╔████╔██║   ██║   ███████║╚═╝███████╗███████║    ██╔████╔██║██║   ██║██║  ██║███████╗█
 ██║╚██╔╝██║   ██║   ██╔══██║██╗╚════██║██╔══██║    ██║╚██╔╝██║██║   ██║██║  ██║╚════██║█
 ██║ ╚═╝ ██║   ██║   ██║  ██║╚═╝███████║██║  ██║    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████║█
 █╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════█
 █                                                                                      █
 █                ┌───────────────────────────────────────────────────┐                 █
 █                ┤MAIS DE 1000 MODS DESCOMPILADOS COM DOWNLOAD DIRETO┤                 █
 █                └───────────────────────────────────────────────────┘                 █
 █                   ┌─────────────────────────────────────────────┐                    █
 █                   ┤ A MAIOR COMUNIDADE DE MODS DO MTA BRASIL 🥇 ┤                    █
 █                   └─────────────────────────────────────────────┘                    █
 █                          ┌───────────────────────────────┐                           █
 █                          ┤  LINK DE CONVITE PERMANENTE:  ┤                           █
 █                          ┤ https://discord.gg/KXV2GHtJtg ┤                           █
 █                          ┤ https://discord.gg/KXV2GHtJtg ┤                           █
 █                          ┤ https://discord.gg/KXV2GHtJtg	┤                           █
 █                          └───────────────────────────────┘                           █
 █ ┌────────────────────────────────────────┐                                           █
 ├≡┤ Canais que postamos mods todos os dias │                                           █
 █ └────────────────────────────────────────┘                                           █
 █ ┤ Veiculos-Low-Poly                                                                  █
 █ ┤ Armas-Exclusivas                                                                   █
 █ ┤ Skins-Exclusivas                                                                   █
 █ ┤ Concessionárias                                                                    █
 █ ┤ Modelagens                                                                         █
 █ ┤ Sons-Armas                                                                         █
 █ ┤ Exclusivos - Mods Exclusivos                                                       █
 █ ┤ Interiores                                                                         █
 █ ┤ Animações                                                                          █
 █ ┤ Resources                                                                          █
 █ ┤ ls-full-br - Uma conversão de mapas para deixar los santos brasileira              █
 █ ┤ Calçadas                                                                           █
 █ ┤ Mapas                                                                              █
 █ ┤ Radar                                                                              █
 █ ┤ Huds                                                                               █
 █                                                                                      █
 ██▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄██
 ]]