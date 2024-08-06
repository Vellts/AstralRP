--[[
    Esta función se encarga de transformar los valores para el cielo.
]]
---@param a number
---@param time number
---@return number
function Clr(a, time)
    return (a - (a*(time-20)/3))
end

--[[
    Esta es otra función se encarga de transformar los valores para el cielo.
]]
---@param a number
---@param time number
---@return number
function Uclr(a, time)
    return (a*(time-2)/3)
end

--[[
    Función la cual retorna la longitud total de una tabla.
]]
---@param tab table
---@return number
function table.size(tab)
    if not tab then return 0 end
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

--[[
    Verifica si todos los elementos de la tabla son iguales
]]
---@param t table
---@return boolean
function table.isEquals(t)
    local isSame = true
    for i = 1, table.size(t) do
        if (t[i] ~= t[1]) then
            isSame = false
            break
        end
    end
    return isSame
end