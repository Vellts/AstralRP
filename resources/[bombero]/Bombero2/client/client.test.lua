-- local effectNames = {
-- 	"blood_heli", "boat_prop", "camflash", "carwashspray", "cement", "cloudfast", "coke_puff", "coke_trail", "cigarette_smoke",
-- 	"explosion_barrel", "explosion_crate", "explosion_door", "exhale", "explosion_fuel_car", "explosion_large", "explosion_medium",
-- 	"explosion_molotov", "explosion_small", "explosion_tiny", "extinguisher", "flame", "fire", "fire_med", "fire_large", "flamethrower",
-- 	"fire_bike", "fire_car", "gunflash", "gunsmoke", "insects", "heli_dust", "jetpack", "jetthrust", "nitro", "molotov_flame",
-- 	"overheat_car", "overheat_car_electric", "prt_blood", "prt_boatsplash", "prt_bubble", "prt_cardebris", "prt_collisionsmoke",
-- 	"prt_glass", "prt_gunshell", "prt_sand", "prt_sand2", "prt_smokeII_3_expand", "prt_smoke_huge", "prt_spark", "prt_spark_2",
-- 	"prt_splash", "prt_wake", "prt_watersplash", "prt_wheeldirt", "petrolcan", "puke", "riot_smoke", "spraycan", "smoke30lit", "smoke30m",
-- 	"smoke50lit", "shootlight", "smoke_flare", "tank_fire", "teargas", "teargasAD", "tree_hit_fir", "tree_hit_palm", "vent", "vent2",
-- 	"water_hydrant", "water_ripples", "water_speed", "water_splash", "water_splash_big", "water_splsh_sml", "water_swim", "waterfall_end",
-- 	"water_fnt_tme", "water_fountain", "wallbust", "WS_factorysmoke"
-- }

-- 43

-- function createEff(_, effectID)
-- 	effectID = tonumber(effectID)

-- 	if effectID then
-- 		local validID = effectID > 0 and effectID <= #effectNames

-- 		if validID then
-- 			local effectName = effectNames[effectID]
-- 			local playerX, playerY, playerZ = getElementPosition(localPlayer)

-- 			createEffect(effectName, playerX, playerY, playerZ, 0, 0, 0)
-- 		end
-- 	else
-- 		outputChatBox("Invalid effect ID", 255, 0, 0)
-- 	end
-- end
-- addCommandHandler("effect", createEff)

addCommandHandler("devmode",
    function()
        setDevelopmentMode(true)
		outputDebugString("Development mode enabled")
    end
)

-- with processLineOfSight detect fire effects
-- local px, py, pz = getElementPosition(localPlayer)
-- local tx, ty, tz = getElementsWithinRange(px, py, pz, 100, "object")
-- local hit, x, y, z, element = processLineOfSight(px, py, pz, tx, ty, tz)
-- if hit then
--     outputChatBox ( "Looking at " .. x .. ", " .. y .. ", " ..  z )
--     if elementHit then
--         outputChatBox ( "Hit element " .. getElementType(elementHit) )
--     end
-- end
-- local fire = createEffect("fire", 2037.2172851562,1529.2813720703,10.8203125)
-- local px, py, pz = getElementPosition(localPlayer)
-- local elements = getElementsWithinRange(px, py, pz, 100, "object")
-- iprint(elements)
-- local hit, x, y, z, element = processLineOfSight(px, py, pz, 2037.2172851562,1529.2813720703,10.8203125)
-- if hit then
-- 	outputChatBox ( "Looking at " .. x .. ", " .. y .. ", " ..  z )
-- 	if element then
-- 		outputChatBox ( "Hit element " .. getElementType(element) )
-- 	end
-- end
