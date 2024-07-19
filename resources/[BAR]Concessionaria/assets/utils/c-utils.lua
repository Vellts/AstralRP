function findPriceByModelVehicle(model)
    for category, vehicles in pairs(config['veiculos']) do
        for _, vehicleData in ipairs(vehicles) do
            if vehicleData[2] == model then
                return vehicleData[3]
            end
        end
    end
    return ''
end

function findNameByModelVehicle(model)
    for category, vehicles in pairs(config['veiculos']) do
        for _, vehicleData in ipairs(vehicles) do
            if vehicleData[2] == model then
                return vehicleData[1]
            end
        end
    end
    return ''
end

function convertTime(ms) 
    local min = math.floor ( ms/30000 ) 
    local sec = math.floor( (ms/1000)%60 ) 
    return min, sec 
end

function convertNumber ( number )   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end