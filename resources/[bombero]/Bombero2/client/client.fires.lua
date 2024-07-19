firesEffect = {}
local firesType = {
    [1] = "fire",       -- small
    [2] = "fire_med",   -- medium
    [3] = "fire_bike", -- big
}

------------------- [ Evento: Crea el efecto de fuego ] -------------------

-- Genera el efecto de fuego en el lado del cliente.
-- x: Coordenada X del fuego.
-- y: Coordenada Y del fuego.
-- z: Coordenada Z del fuego.
-- type: Tipo de fuego.
-- fire: Elemento del fuego.

function createFire(x, y, z, type, fire)
    if (not x) or (not y) or (not z) or (not type) then return end
    local fireEffect = createEffect(firesType[type], x, y, z - 0.5, 0, 0, 0, 100)
    firesEffect[fire] = fireEffect
end
addEvent("fireman>>createFire", true)
addEventHandler("fireman>>createFire", root, createFire)

------------------- [ Evento: Elimina el efecto de fuego ] -------------------

-- Elimina el efecto de fuego en el lado del cliente.
-- fire: Elemento del fuego.

function removeFire(fire)
    if type(fire) == "table" then
        for k, v in pairs(fire) do
            if (firesEffect[v["col"]]) then
                destroyElement(firesEffect[v["col"]])
                firesEffect[v["col"]] = nil
            end
        end
        firesEffect = {}
    else
        if (firesEffect[fire]) then
            destroyElement(firesEffect[fire])
            firesEffect[fire] = nil
        end
    end
end
addEvent("fireman>>removeFire", true)
addEventHandler("fireman>>removeFire", root, removeFire)
