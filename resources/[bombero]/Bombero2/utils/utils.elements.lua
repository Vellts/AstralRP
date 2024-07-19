-- Obtiene la posición de un elemento con un offset (desplazamiento)
-- element: Elemento
-- offX: Desplazamiento en X
-- offY: Desplazamiento en Y
-- offZ: Desplazamiento en Z

function getPositionFromElementOffset(element,offX,offY,offZ) 
    local m = getElementMatrix ( element )  -- Get the matrix 
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform 
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2] 
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3] 
    return x, y, z                               -- Return the transformed point 
end

-- Obtiene el tipo de fuego de un elemento
-- col: Elemento

function getFireType(col)
    if (table.size(fires) >= 1) then
        for i, fire in pairs(fires) do
            if (fire["colFire"] == col) then
                return fire["type"]
            end
        end
    end
    return 0
end

-- Devuelve verdadero si el jugador tiene un vehículo de bomberos
-- player: Jugador

function firemanHasVehicle(player)
    for i, data in pairs(vehiculosBombero) do
        if (data["owner"] == player) then
            return true
        end
    end
    return false
end

-- Obtiene el vehículo de bomberos de un jugador
-- player: Jugador

function getFiremanVehicle(player)
    for i, data in pairs(vehiculosBombero) do
        if (data["owner"] == player) then
            return data["vehicle"]
        end
    end
    return false
end
