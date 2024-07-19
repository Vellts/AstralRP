local skinname = 'skin/male'
local id = 14
local bodyparts = {
	"skin/male",
    "skin/cueca",
    "skin/cabelo",
    "skin/cabelo2",
    "skin/cabelo3",
    "skin/cabelo4",
    "skin/cabelo5",
    "skin/cabelo6",
    "skin/cabelo7",
    "skin/camisa",
    "skin/camisa2",
    "skin/camisa3",
    "skin/camisa4",
    "skin/camisa5",
    "skin/tubarao",
    "skin/short",
    "skin/calca",
    "skin/tenis",
	"skin/sandalia",
	"skin/mochila",
	"skin/oculos",
	"skin/bone",
	"skin/mascara",	
}

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		-- iprint(bodyparts)
		for i, tex in ipairs(bodyparts) do
			txd = engineLoadTXD(tex..".txd" )
			iprint(engineImportTXD( txd, id ))
		end

		dff = engineLoadDFF(skinname..".dff", id)
		engineReplaceModel( dff, id )
		-- fileDelete(skinname..".dff")

		-- for i, tex in ipairs(bodyparts) do
		-- 	fileDelete(tex..".txd")
		-- end

		fileCreate("skin.json")	
	end
)