addCommandHandler("tanim", function(player)
    -- do an animation
    -- the animation must be like jf the player is wearing clothes

    setPedAnimation(player, "shop", "rob_shifty", -1, false, false, false, false)
    setTimer(function()
        setPedAnimationProgress(player, "rob_shifty", 0.5)
    end, 50, 1)
end)

function setCustomHandling(player)
    -- Handling configuration for Mercedes Benz AMG 250
    local handlingData = {
        -- mass = 260,
        -- turnMass = 350,
        -- dragCoeff = 1.4,
        -- centerOfMass = {0.0, 0.0, -0.20},
        -- percentSubmerged = 95,
        -- tractionMultiplier = 1.4,
        -- tractionLoss = 0.85,
        -- tractionBias = 0.50,
        -- numberOfGears = 5,
        maxVelocity = 190, -- Max velocity set to a reasonable value below 150 km/h
        engineAcceleration = 28, -- High acceleration for motocross bike
        engineInertia = 15,
        -- driveType = 'awd',
        -- engineType = 'petrol',
        -- brakeDeceleration = 10.0,
        -- brakeBias = 0.50,
        -- steeringLock = 40.0,
        -- suspensionForceLevel = 1.7,
        -- suspensionDamping = 0.4,
        -- suspensionHighSpeedDamping = 0.0,
        -- suspensionUpperLimit = 0.25,
        -- suspensionLowerLimit = -0.20,
        -- suspensionFrontRearBias = 0.55,
        -- suspensionAntiDiveMultiplier = 0.3,
        -- seatOffsetDistance = 0.2,
        -- collisionDamageMultiplier = 0.50,
        -- monetary = 8000,
        -- modelFlags = 0x20002,
        -- handlingFlags = 0x0000000,
        -- headLight = 1,
        -- tailLight = 1,
        -- animGroup = 0
    }

    -- Apply handling to the specified vehicle model
    local player = getRandomPlayer()
    local vehicleModel = getPedOccupiedVehicle(player) -- Replace with the model ID for the Mercedes Benz AMG 250
    for k, v in pairs(handlingData) do
        setVehicleHandling(vehicleModel, k, v)
    end
    iprint("Handling set for vehicle model")
end
addCommandHandler("aphand", setCustomHandling)

-- loadstring(exports.assetify_library:import("*"))()

-- local randomFunc = function( )
--     local cPromise = promise()
--     async(function(self) 
--         print('sleeping zzzz')
--         sleep(5000)
--         print('looping')
--         for i=1, 50 do 
--             print(i)
--             self:pause( )
--         end
--         print('finally it ended')
--         --cPromise.reject("some error if you have")
--         cPromise.resolve('we ended here')
--     end):resume({executions=1, frames=200})
--     return cPromise
-- end

-- async(function(self)
--     local tryResult = try({
--         exec = function(self) 
--             local res = await(randomFunc())
--             return res 
--         end,
--         catch = function(error)
--             print('got an exception on the execution', error)
--             return error 
--         end 
--     })
--     iprint('the main result', tryResult)
-- end):resume( )
