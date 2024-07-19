--[[
	Author: https://github.com/Fernando-A-Rocha

	mod_list.lua

	
	Default mods are defined here in 'modList'.
	
	If you to add your mods with other resources (recommended) then you can delete this file.
		The server will assume an empty modList.
]]

-- ....................................... modList explained .......................................
	
-- The following mod list is stored in server only, then sent to client on request
-- These are the default mods, more than be added via functions from other resources

-- 'id' must be unique and out of the default GTA (& preferrably SA-MP too) ID ranges

-- 'base_id' is the model the mod will inherit some properties from
--	Doesn't make much difference on peds(skins), but it does on vehicles & objects

-- 'path' can be:
--		a string, in which case it expects files to be named ID.dff or ID.txd in that folder
-- 		an array(table), in which case it expects an array of file names like {dff="filepath.dff", txd="filepath.txd", col="filepath.col"}
--  		For files encrypted using NandoCrypt, don't add the .nandocrypt extension, it's defined by the 'NANDOCRYPT_EXT' setting
-- 	All paths defined manually in this file need to be local (this resource)
--		To add a mod from another resource see the examples provided in the documentation.

-- 'name' can be whatever you want (string)

-- + optional parameters:

-- 		'lodDistance' : custom LOD distance in GTA units (number), see possible values https://wiki.multitheftauto.com/wiki/EngineSetModelLODDistance
-- 		'ignoreTXD', 'ignoreDFF', 'ignoreCOL' : if true, the script won't try to load TXD/DFF/COL for the mod
--		'metaDownloadFalse' : if true, the mod will be only be downloaded when needed (when trying to set model)
-- 		'disableAutoFree' : if true, the allocated mod ID will not be freed when no element streamed in is no longer using the mod ID
--  		This causes the mod to stay in memory, be careful when enabling for big mods
-- 		'filteringEnabled' (engineLoadTXD)
-- 		'alphaTransparency' (engineReplaceModel)

modList = {
	
	ped = {

		{id=20001, base_id=1, path="models/peds/", name="Mafioso 1"},
		{id=20003, base_id=1, path="models/peds/", name="Mafioso 2"},
		{id=20002, base_id=1, path="models/peds/", name="Mafioso 3", metaDownloadFalse = true},
	},

	vehicle = {
		-- AUTOS
		{id=80001, base_id=451, path={dff="models/vehicles/flferrari.dff", txd="models/vehicles/flferrari.txd"}, name="Ferrari LaFerrari 2014"},
		{id=80002, base_id=562, path={dff="models/vehicles/911s.dff", txd="models/vehicles/911s.txd"}, name="Porsche 911s"},
		{id=80003, base_id=554, path={dff="models/vehicles/f150.dff", txd="models/vehicles/f150.txd"}, name="Ford F-150 Raptor"},
		{id=80004, base_id=602, path={dff="models/vehicles/amvantages.dff", txd="models/vehicles/amvantages.txd"}, name="Aston Martin Vantage S"},
		{id=80005, base_id=541, path={dff="models/vehicles/fordgtcl.dff", txd="models/vehicles/fordgtcl.txd"}, name="Ford GT Classic"},
		{id=80006, base_id=409, path={dff="models/vehicles/cl300c.dff", txd="models/vehicles/cl300c.txd"}, name="Chrysler 300C"},
		{id=80007, base_id=550, path={dff="models/vehicles/siwrxsti.dff", txd="models/vehicles/siwrxsti.txd"}, name="Subaru Impreza WRX STI"},
		{id=80008, base_id=439, path={dff="models/vehicles/dcrt1970.dff", txd="models/vehicles/dcrt1970.txd"}, name="Dodge Charger RT 1970"},
		{id=80009, base_id=402, path={dff="models/vehicles/dcsrth.dff", txd="models/vehicles/dcsrth.txd"}, name="Dodge Charger SRT Hellcat"},
		{id=80010, base_id=579, path={dff="models/vehicles/ff550.dff", txd="models/vehicles/ff550.txd"}, name="Ford F-550 Jerr-Dan"},
		{id=80011, base_id=518, path={dff="models/vehicles/phttu.dff", txd="models/vehicles/phttu.txd"}, name="Pagani Huayra TT Ultimate"},
		{id=80012, base_id=533, path={dff="models/vehicles/wmlh.dff", txd="models/vehicles/wmlh.txd"}, name="W Motors Lykan Hypersport"},
		{id=80013, base_id=586, path={dff="models/vehicles/hdfbl.dff", txd="models/vehicles/hdfbl.txd"}, name="Harley-Davidson Fat Boy Lo"},
		{id=80014, base_id=468, path={dff="models/vehicles/ymxt660.dff", txd="models/vehicles/ymxt660.txd"}, name="Yamaha XT660"},
		{id=80015, base_id=521, path={dff="models/vehicles/dtdmcrr.dff", txd="models/vehicles/dtdmcrr.txd"}, name="Ducati Desmosedici RR"},
		{id=80016, base_id=586, path={dff="models/vehicles/dtdv.dff", txd="models/vehicles/dtdv.txd"}, name="Ducati Diavel"},
		{id=80017, base_id=521, path={dff="models/vehicles/ymxj6.dff", txd="models/vehicles/ymxj6.txd"}, name="Yamaha XJ6"},
		{id=80018, base_id=522, path={dff="models/vehicles/kwnj300r.dff", txd="models/vehicles/kwnj300r.txd"}, name="Kawasaki Ninja 300R"},
		{id=80019, base_id=521, path={dff="models/vehicles/hayabusa.dff", txd="models/vehicles/hayabusa.txd"}, name="hayabusa"},
		{id=80020, base_id=506, path={dff="models/vehicles/pcgt.dff", txd="models/vehicles/pcgt.txd"}, name="Porsche Carrera GT 2003"},
	},

	object = {
		{id=50001, base_id=1337, path="models/objects/", name="Engine Hoist"},
		{id=50002, base_id=3594, lodDistance=300, path={txd="models/objects/wrecked_car.txd", dff="models/objects/wrecked_car1.dff", col="models/objects/wrecked_car1.col"}, name="Wrecked Car 1"},
		{id=50003, base_id=3593, lodDistance=300, path={txd="models/objects/wrecked_car.txd", dff="models/objects/wrecked_car2.dff", col="models/objects/wrecked_car2.col"}, name="Wrecked Car 2"},
	},
}
