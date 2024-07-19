local ClothesInUsing = {}

function refreshPlayerClothes(target, clothesTable)
    local clothes = clothesTable
    if type(clothes) == "table" and #clothes ~= 0 then
        ClothesInUsing[target] = clothes
    end
end

function UpdatePlayerClothes(element, clothes, clothesTable)
    refreshPlayerClothes(element, clothesTable)
    ClothesInUsing[element] = clothes
    triggerClientEvent(root, "setPlayerClothe", root, element, clothes["skin"], ClothesInUsing[element])
    triggerClientEvent(element, "setPlayerClothes", element, ClothesInUsing)
end

function loadClothes()
end

addEventHandler("onPlayerQuit", getRootElement(), 
    function()
        ClothesInUsing[source] = nil
    end
)

addCommandHandler("cropa", function(player, cmd, type, id_1, id_2)
    UpdatePlayerClothes(player, {
        ["skin"] = 14,
		[type] = { tonumber(id_1), tonumber(id_2) },
    })
end)
