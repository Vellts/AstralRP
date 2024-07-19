local skinname = 'skin/male'
local id = 10
local bodyparts = {
	"skin/male",
	"skin/cabelo",
	"skin/cabelo1",
	"skin/cabelo2",
	"skin/cabelo3",
	"skin/camisa",
	"skin/camisa1",
	"skin/camisa2",
	"skin/perna",
	"skin/perna1",
	"skin/pe",
	"skin/pe1",	
	"skin/oculos",
	"skin/oculos1",
	"skin/calcinha",
	"skin/tubarao",
	"skin/mochila",
	"skin/mascara",
}

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		for i, tex in ipairs(bodyparts) do
			txd = engineLoadTXD(tex..".txd" )
		   iprint("Skin iniciada com sucesso")
			engineImportTXD( txd, id )
		end

		dff = engineLoadDFF(skinname..".dff", id)
		engineReplaceModel( dff, id )
		fileDelete(skinname..".dff")

		for i, tex in ipairs(bodyparts) do
			fileDelete(tex..".txd")
		end

		fileCreate("skin.json")	
	end
)