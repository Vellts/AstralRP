---------------- FUNCTION ----------------


local playerClothes = {}

local function refreshClothes(player)
    -- TODO
end

local function updateClothes(player, clothes)
    --  TODO
    playerClothes[player] = clothes
    triggerClientEvent(player, "player::changeClothes", player, player, getPlayerSkin(player), clothes)
    -- triggerClientEvent(root, "player::updateClothes", root, playerClothes)
end 

---------------- EVENTS ----------------




---------------- TEST ----------------

-- addCommandHandler("setclothes", function(player, cmd)
--     updateClothes(player, defaultClothes[14])
--     -- iprint(defaultClothes[14])
-- end)

addEventHandler("onResourceStart", resourceRoot, function()
    for _, player in ipairs(getElementsByType("player")) do
        setTimer(function()
            updateClothes(player, defaultClothes[14])
        end, 2000, 1)
    end
end)