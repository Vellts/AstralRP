local function databaseConnection()
    if data.type == "sqlite" then
        local connection = dbConnect("sqlite", ":/database.db")
        if connection then
            data.connection = connection
            return true
        else
            return false
        end
    end
end

addEventHandler("onResourceStart", resourceRoot, function()
    if databaseConnection() then
        outputDebugString("Conexión a la base de datos establecida.")
    else
        outputDebugString("No se pudo establecer la conexión a la base de datos.")
    end
end)

function getDatabaseConnection()
    return data.connection
end