local priorityResources = {
    "dgs",
    "assetify_library",
    "loadingScreen",
    "databaseManager",
    "playerManager",
    "core_player",
    "character_creation",
    "login",
}

local resourcesFolder = {
    "core_chat",
    "core_notifications",
    "core_vehicle",
    "newmodels",
    "newmodels-engine",
    "vehicle_loader",
    "vehicle_damage",
    "elements_interactions",
    "dev_info",
    "gps",
    "admin",
    -- "inventory",
    "realistic_cycle",
    "dynamic_lighting_vehicles",
    "mapa",
    "Mapa-LS",
    "Mapa2",
    "mapa3"
}

local function loadResources()
    if (table.size(priorityResources) >= 1) then
        for i, folder in ipairs(priorityResources) do
            local resource = getResourceFromName(folder)
            if (resource) then
                if (getResourceState(resource) == "running") then
                    restartResource(resource)
                end
                local state = startResource(resource)
                if (state) then
                    outputDebugString("Recurso "..folder.." iniciado con exito.")
                else
                    -- restartResource(resource)
                    outputDebugString("Recurso "..folder.." no pudo ser iniciado.")
                end
            else
                outputDebugString("Recurso "..folder.." no existe.")
            end
        end
    end

    if (table.size(resourcesFolder) >= 1) then
        for _, folder in ipairs(resourcesFolder) do
            local resource = getResourceFromName(folder)
            if (resource) then
                local state = startResource(resource)

                if (state) then
                    outputDebugString("Recurso "..folder.." iniciado con exito.")
                else
                    outputDebugString("Recurso "..folder.." no pudo ser iniciado.")
                end
            else
                outputDebugString("Recurso "..folder.." no existe.")
            end
        end
    end
end

addEventHandler("onResourceStart", resourceRoot, function()
    loadResources()
    -- set server settings
    setGameType("Roleplay")
    setMapName("San Andreas")
    setRuleValue("Website", "www.roleplay.com")
    setFPSLimit(100)
    
    -- exports.playerManager:spawnPlayerInWorld()
    
end)