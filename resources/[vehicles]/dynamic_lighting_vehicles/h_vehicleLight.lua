gLightTheta = math.rad(6)
gLightPhi = math.rad(45)
gLightFalloff = 2
gLightAttenuation = 20

t = { -- Таблица с настройкой фар 
	[1] = { --Ближний свет
		gLightPhi = math.rad(45),
		gLightFalloff = 2,
		gLightAttenuation = 20,
	},
	[2] = { --Дальний
		gLightPhi = math.rad(18),
		gLightFalloff = 1.5,
		gLightAttenuation = 100,
	},
	[3] = { --Противотуманки
		gLightPhi = math.rad(45),
		gLightFalloff = 2,
		gLightAttenuation = 100,
	},
}

lightMaxDistance = 60

keyChangeLights = "z"