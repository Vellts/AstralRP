VehiclesAvailable = {
    ["cars"] = {
        [1] = {
            vehicle_id = 80001,
            base_id = 426,
            path = {
                dff = "models/vehicles/mbamg250.dff",
                txd = "models/vehicles/mbamg250.txd"
            },
            name = "Mercedes Benz AMG 250",
            handling = {
                mass = 1450,
                turnMass = 3800,
                dragCoeff = 1.0,
                centerOfMass = {0.0, 0.0, -0.15},
                percentSubmerged = 75,
                tractionMultiplier = 0.85,
                tractionLoss = 0.85,
                tractionBias = 0.52,
                numberOfGears = 5,
                maxVelocity = 120, -- 146km/h
                engineAcceleration = 15,
                engineInertia = 15,
                driveType = 'rwd',
                engineType = 'petrol',
                brakeDeceleration = 8.0,
                brakeBias = 0.55,
                steeringLock = 35.0,
                suspensionForceLevel = 1.2,
                suspensionDamping = 0.15,
                suspensionHighSpeedDamping = 0.0,
                suspensionUpperLimit = 0.15,
                suspensionLowerLimit = -0.10,
                suspensionFrontRearBias = 0.55,
                suspensionAntiDiveMultiplier = 0.3,
                seatOffsetDistance = 0.20,
                collisionDamageMultiplier = 0.60,
                monetary = 35000,
                modelFlags = 0x20002,
                handlingFlags = 0x0000000,
                headLight = 1,
                tailLight = 1,
                animGroup = 0
            }
        },
        [2] = {
            vehicle_id = 80002,
            base_id = 429,
            path = {
                dff = "models/vehicles/ff12berlinetta.dff",
                txd = "models/vehicles/ff12berlinetta.txd"
            },
            name = "Ferrari F12 Berlinetta",
            handling = {
                mass = 1525,
                turnMass = 4000,
                dragCoeff = 2.1,
                centerOfMass = {0.0, 0.0, -0.20},
                percentSubmerged = 70,
                tractionMultiplier = 0.95,
                tractionLoss = 0.88,
                tractionBias = 0.48,
                numberOfGears = 5,
                maxVelocity = 150,
                engineAcceleration = 10,
                engineInertia = 15,
                driveType = 'rwd',
                engineType = 'petrol',
                brakeDeceleration = 10.0,
                brakeBias = 0.60,
                steeringLock = 32.0,
                suspensionForceLevel = 1.3,
                suspensionDamping = 0.20,
                suspensionHighSpeedDamping = 0.0,
                suspensionUpperLimit = 0.12,
                suspensionLowerLimit = -0.14,
                suspensionFrontRearBias = 0.55,
                suspensionAntiDiveMultiplier = 0.35,
                seatOffsetDistance = 0.25,
                collisionDamageMultiplier = 0.50,
                monetary = 50000,
                modelFlags = 0x20002,
                handlingFlags = 0x0000000,
                headLight = 1,
                tailLight = 1,
                animGroup = 0
            }
        },
        [3] = {
            vehicle_id = 80003,
            base_id = 411,
            path = {
                dff = "models/vehicles/laventador.dff",
                txd = "models/vehicles/laventador.txd"
            },
            name = "Lamborghini Aventador",
            handling = {
                mass = 1525,
                turnMass = 4000,
                dragCoeff = 2.1,
                centerOfMass = {0.0, 0.0, -0.20},
                percentSubmerged = 70,
                tractionMultiplier = 0.95,
                tractionLoss = 0.88,
                tractionBias = 0.48,
                numberOfGears = 5,
                maxVelocity = 150,
                engineAcceleration = 10,
                engineInertia = 15,
                driveType = 'rwd',
                engineType = 'petrol',
                brakeDeceleration = 10.0,
                brakeBias = 0.60,
                steeringLock = 32.0,
                suspensionForceLevel = 1.3,
                suspensionDamping = 0.20,
                suspensionHighSpeedDamping = 0.0,
                suspensionUpperLimit = 0.12,
                suspensionLowerLimit = -0.14,
                suspensionFrontRearBias = 0.55,
                suspensionAntiDiveMultiplier = 0.35,
                seatOffsetDistance = 0.25,
                collisionDamageMultiplier = 0.50,
                monetary = 50000,
                modelFlags = 0x20002,
                handlingFlags = 0x0000000,
                headLight = 1,
                tailLight = 1,
                animGroup = 0
            }
        },
        [4] = {
            vehicle_id = 80004,
            base_id = 602,
            path = {
                dff = "models/vehicles/p911turbos.dff",
                txd = "models/vehicles/p911turbos.txd"
            },
            name = "Porsche 911 Turbo S",
            handling = {
                mass = 1600,
                turnMass = 4200,
                dragCoeff = 2.0,
                centerOfMass = {0.0, 0.0, -0.20},
                percentSubmerged = 70,
                tractionMultiplier = 1.0,
                tractionLoss = 0.85,
                tractionBias = 0.50,
                numberOfGears = 6,
                maxVelocity = 140, -- Max velocity set to a reasonable value below 150 km/h
                engineAcceleration = 8,
                engineInertia = 13,
                driveType = 'awd',
                engineType = 'petrol',
                brakeDeceleration = 9.0,
                brakeBias = 0.60,
                steeringLock = 32.0,
                suspensionForceLevel = 1.3,
                suspensionDamping = 0.25,
                suspensionHighSpeedDamping = 0.0,
                suspensionUpperLimit = 0.12,
                suspensionLowerLimit = -0.14,
                suspensionFrontRearBias = 0.55,
                suspensionAntiDiveMultiplier = 0.35,
                seatOffsetDistance = 0.25,
                collisionDamageMultiplier = 0.50,
                monetary = 60000,
                modelFlags = 0x20002,
                handlingFlags = 0x0000000,
                headLight = 1,
                tailLight = 1,
                animGroup = 0
            }
        }
    },
    ["bikes"] = {
        [1] = {
            vehicle_id = 80005,
            base_id = 468,
            path = {
                dff = "models/vehicles/sanchez.dff",
                txd = "models/vehicles/sanchez.txd"
            },
            name = "Sanchez",
            handling = {
                mass = 135,
                turnMass = 300,
                dragCoeff = 1.0,
                centerOfMass = {0.0, 0.0, -0.15},
                percentSubmerged = 75,
                tractionMultiplier = 0.85,
                tractionLoss = 0.85,
                tractionBias = 0.52,
                numberOfGears = 5,
                maxVelocity = 120, -- 146km/h
                engineAcceleration = 15,
                engineInertia = 15,
                driveType = 'rwd',
                engineType = 'petrol',
                brakeDeceleration = 8.0,
                brakeBias = 0.55,
                steeringLock = 35.0,
                suspensionForceLevel = 1.2,
                suspensionDamping = 0.15,
                suspensionHighSpeedDamping = 0.0,
                suspensionUpperLimit = 0.15,
                suspensionLowerLimit = -0.10,
                suspensionFrontRearBias = 0.55,
                suspensionAntiDiveMultiplier = 0.3,
                seatOffsetDistance = 0.20,
                collisionDamageMultiplier = 0.60,
                monetary = 35000,
                modelFlags = 0x20002,
                handlingFlags = 0x0000000,
                headLight = 1,
                tailLight = 1,
                animGroup = 0
            }
        },
    }
}