-- Devuelve el tamaño de una tabla.
-- tab: Tabla.

function table.size(tab)
    if not tab then return 0 end
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

-- Devuelve (true) si la tabla está vacía, (false) en caso contrario.
-- p: Jugador.
-- table: Tabla.

function table.isPlayerInTable(p, table)
    for _, v in ipairs(table) do
        if v == p then
            return true
        end
    end
    return false
end

-- Devuelve un valor si existe en la tabla.
-- table: Tabla.
-- value: Valor.

function table.find(table, value)
    for k, v in pairs(table) do
        if v == value then
            return k
        end
    end
    return nil
end