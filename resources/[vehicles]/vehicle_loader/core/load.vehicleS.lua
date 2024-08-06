loadstring(exports.assetify_library:import("*"))()
local engine = exports.newmodels

local function loadVehicle()
    local cPromise = promise()
    async(function(self)
        outputDebugString("Extracting vehicle data in resource: "..getResourceName(getThisResource()), 3)
        sleep(1000)
        for i = 1, table.size(VehiclesAvailable["cars"]) do
            local vehicleData = {
                [1] = {
                    elementType = "vehicle",
                    id = VehiclesAvailable["cars"][i].vehicle_id,
                    name = VehiclesAvailable["cars"][i].name,
                    base_id = VehiclesAvailable["cars"][i].base_id,
                    path_dff = VehiclesAvailable["cars"][i].path.dff,
                    path_txd = VehiclesAvailable["cars"][i].path.txd,
                }
            }
            local data, msg = exports["newmodels"]:addExternalMods_CustomFileNames(vehicleData)
            if (not data) then
                cPromise.reject({
                    data,
                    inspect(msg)
                })
            else
                outputDebugString("Vehicle data loaded to: "..vehicleData[1].id, 3)
            end
            self:pause()
        end
        -- do the same, but with bikes
        for i = 1, table.size(VehiclesAvailable["bikes"]) do
            local vehicleData = {
                [1] = {
                    elementType = "vehicle",
                    id = VehiclesAvailable["bikes"][i].vehicle_id,
                    name = VehiclesAvailable["bikes"][i].name,
                    base_id = VehiclesAvailable["bikes"][i].base_id,
                    path_dff = VehiclesAvailable["bikes"][i].path.dff,
                    path_txd = VehiclesAvailable["bikes"][i].path.txd,
                }
            }
            local data, msg = exports["newmodels"]:addExternalMods_CustomFileNames(vehicleData)
            if (not data) then
                cPromise.reject({
                    data,
                    inspect(msg)
                })
            else
                outputDebugString("Vehicle data loaded to: "..vehicleData[1].id, 3)
            end
            self:pause()
        end
        cPromise.resolve('done')
    end):resume({executions=1, frames=200})
    return cPromise
end

addEventHandler("onResourceStart", resourceRoot, function()
    async(function(self)
        try({
            exec = function(self)
                local res = await(loadVehicle())
                return res
            end,
            catch = function(error)
                print("got an exception on the execution", error)
                return error
            end
        })
    end):resume()
end)

function table.size(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end
