local ids = {
    14
}
local bodyparts = {
    [14] = {
        "assets/characters/maleskin/male",
        "assets/characters/maleskin/cueca",
        "assets/characters/maleskin/cabelo",
        "assets/characters/maleskin/cabelo2",
        "assets/characters/maleskin/cabelo3",
        "assets/characters/maleskin/cabelo4",
        "assets/characters/maleskin/cabelo5",
        "assets/characters/maleskin/cabelo6",
        "assets/characters/maleskin/cabelo7",
        "assets/characters/maleskin/camisa",
        "assets/characters/maleskin/camisa2",
        "assets/characters/maleskin/camisa3",
        "assets/characters/maleskin/camisa4",
        "assets/characters/maleskin/camisa5",
        "assets/characters/maleskin/tubarao",
        "assets/characters/maleskin/short",
        "assets/characters/maleskin/calca",
        "assets/characters/maleskin/tenis",
        "assets/characters/maleskin/sandalia",
        "assets/characters/maleskin/mochila",
        "assets/characters/maleskin/oculos",
        "assets/characters/maleskin/bone",
        "assets/characters/maleskin/mascara",
    }
}

addEventHandler("onClientResourceStart", resourceRoot, function()
    iprint(ids)
    for _, id in ipairs(ids) do
        for _, bodypart in ipairs(bodyparts[id]) do
            txd = engineLoadTXD(bodypart..".txd" )
			iprint(engineImportTXD( txd, id ))
        end

        local skinName = (id == 14) and "assets/characters/maleskin/male" or "assets/characters/femaleskin/female"
        
        dff = engineLoadDFF(skinName..".dff", id)
        engineReplaceModel(dff, id)
    end
end)