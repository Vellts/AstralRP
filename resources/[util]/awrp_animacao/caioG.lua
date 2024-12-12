config = {
    notifyS = function (player, message, type)
        exports['[FANTASY]Infobox']:send(player, message, type)
    end
}

IFPS = {
	"abdominal",
	"breakdance1",
	"breakdance2",
	"continencia",
	"flexao",
	"fortnite1",
	"fortnite2",
	"fortnite3",
	"newAnims",
	"render",
    "sex",
}

ANIMATIONS = {
	{
		Name = "Estilo de andar",
		Icon = "walk_style",
        sizeIcon = {14.36, 12.77},
		WalkStyles = {
			{Name = "Padrão", Command = "ws1", Style = 0},
			{Name = "Padrão 2", Command = "ws2", Style = 56},
			{Name = "Bebado", Command = "ws3", Style = 126},
			{Name = "Gordo", Command = "ws4", Style = 55},
			{Name = "Gordo 2", Command = "ws5", Style = 124},
			{Name = "Gang", Command = "ws6", Style = 121},
			{Name = "Idoso", Command = "ws7", Style = 120},
			{Name = "Idoso 2", Command = "ws8", Style = 123},
			{Name = "SWAT", Command = "ws9", Style = 128},
			{Name = "Feminino", Command = "ws10", Style = 129},
			{Name = "Feminino 2", Command = "ws11", Style = 131},
			{Name = "Feminino 3", Command = "ws12", Style = 132},
			{Name = "Feminino 4", Command = "ws13", Style = 136}
		}
	},
	{
		Name = "Social",
		Icon = "social",
        sizeIcon = {10.37, 12.77},
		Animations = {
            {Name = "Triste", Command = "scc", Anim = {"Interações", "Triste", 500, false, false, true}, Custom = true},
            {Name = "Pensando", Command = "scc2", Anim = {"Interações", "Pensativo 2", 500, false, false, true}, Custom = true},
            {Name = "Fumando", Command = "sc2", Anim = {"SMOKING", "M_smkstnd_loop", -1, true, false, false}},
            {Name = "Fumando 2", Command = "sc3", Anim = {"LOWRIDER", "M_smkstnd_loop", -1, true, false, false}},
            {Name = "Fumando 3", Command = "sc4", Anim = {"GANGS", "smkcig_prtl", -1, true, false, false}},
            {Name = "Esperando", Command = "sc5", Anim = {"COP_AMBIENT", "Coplook_loop", -1, true, false, false}},
            {Name = "Esperando 2", Command = "sc6", Anim = {"COP_AMBIENT", "Coplook_shake", -1, true, false, false}},
            {Name = "Comemorando", Command = "sc7", Anim = {"CASINO", "manwinb", -1, true, false, false}},
            {Name = "Comemorando 2", Command = "sc8", Anim = {"CASINO", "manwind", -1, true, false, false}},
            {Name = "Cansado", Command = "sc9", Anim = {"FAT", "idle_tired", -1, true, false, false}},
            {Name = "Rindo", Command = "sc10", Anim = {"RAPPING", "Laugh_01", -1, true, false, false}}
		}
	},
	{
		Name = "Interações",
		Icon = "interactions",
        sizeIcon = {12.87, 12.85},
		Animations = {
            {Name = "Cruzar os braços", Command = "cin", Anim = {"Ações", "Cruzar Braços", 500, false, false, true}, Custom = true},
            {Name = "Rendido 2", Command = "cin2", Anim = {"Ações", "Render 2", 500, false, false, true}, Custom = true},
            {Name = "Rendido 3", Command = "cin3", Anim = {"Ações", "Render 3", 500, false, false, true}, Custom = true},
            {Name = "Rendido", Command = "in", Anim = {"Ações", "Render", 500, false, false, true}, Custom = true},
            {Name = "Comprimentar", Command = "in2", Anim = {"GANGS", "hndshkaa", -1, true, false, false}},
            {Name = "Comprimentar 2", Command = "in3", Anim = {"GANGS", "hndshkba", -1, true, false, false}},
            {Name = "Conversando", Command = "in4", Anim = {"GANGS", "prtial_gngtlkA", -1, true, false, false}},
            {Name = "Conversando 2", Command = "in5", Anim = {"GANGS", "prtial_gngtlkB", -1, true, false, false}},
            {Name = "Empurrão", Command = "in6", Anim = {"GANGS", "shake_cara", -1, true, false, false}},
            {Name = "Flexão", Command = "in7", Anim = {"flexao", "flexao", -1, true, false, false}, IFP = true},
            {Name = "Abdominal", Command = "in8", Anim = {"abdominal", "abdominal", -1, true, false, false}, IFP = true},
            {Name = "Continência", Command = "in9", Anim = {"continencia", "continencia", -1, true, false, false}, IFP = true},
		}
	},
	{
		Name = "Danças",
		Icon = "dances",
        sizeIcon = {10.82, 12.85},
		Animations = {
			{Name = "Dança", Command = "dance1", Anim = {"DANCING", "dance_loop", -1, true, false, false}},
            {Name = "Dança 2", Command = "dance2", Anim = {"DANCING", "DAN_Down_A", -1, true, false, false}},
            {Name = "Dança 3", Command = "dance3", Anim = {"DANCING", "DAN_Left_A", -1, true, false, false}},
            {Name = "Dança 4", Command = "dance4", Anim = {"DANCING", "DAN_Right_A", -1, true, false, false}},
            {Name = "Dança 5", Command = "dance5", Anim = {"DANCING", "DAN_Up_A", -1, true, false, false}},
            {Name = "Dança 6", Command = "dance6", Anim = {"DANCING", "dnce_M_a", -1, true, false, false}},
            {Name = "Dança 7", Command = "dance7", Anim = {"DANCING", "dnce_M_b", -1, true, false, false}},
            {Name = "Dança 8", Command = "dance8", Anim = {"DANCING", "dnce_M_c", -1, true, false, false}},
            {Name = "Dança 9", Command = "dance9", Anim = {"DANCING", "dnce_M_d", -1, true, false, false}},
            {Name = "Dança 10", Command = "dance10", Anim = {"DANCING", "dnce_M_e", -1, true, false, false}},
            {Name = "Dança 11", Command = "dance11", Anim = {"fortnite1", "baile 1", -1, true, false, false}, IFP = true},
            {Name = "Dança 12", Command = "dance12", Anim = {"fortnite1", "baile 2", -1, true, false, false}, IFP = true},
            {Name = "Dança 13", Command = "dance13", Anim = {"fortnite1", "baile 3", -1, true, false, false}, IFP = true},
            {Name = "Dança 14", Command = "dance14", Anim = {"fortnite1", "baile 4", -1, true, false, false}, IFP = true},
            {Name = "Dança 15", Command = "dance15", Anim = {"fortnite1", "baile 5", -1, true, false, false}, IFP = true},
            {Name = "Dança 16", Command = "dance16", Anim = {"fortnite1", "baile 6", -1, true, false, false}, IFP = true},
            {Name = "Dança 17", Command = "dance17", Anim = {"fortnite2", "baile 7", -1, true, false, false}, IFP = true},
            {Name = "Dança 18", Command = "dance18", Anim = {"fortnite2", "baile 8", -1, true, false, false}, IFP = true},
            {Name = "Dança 19", Command = "dance19", Anim = {"fortnite3", "baile 9", -1, true, false, false}, IFP = true},
            {Name = "Dança 20", Command = "dance20", Anim = {"fortnite3", "baile 10", -1, true, false, false}, IFP = true},
            {Name = "Dança 21", Command = "dance21", Anim = {"fortnite3", "baile 11", -1, true, false, false}, IFP = true},
            {Name = "Dança 22", Command = "dance22", Anim = {"fortnite3", "baile 12", -1, true, false, false}, IFP = true},
            {Name = "Dança 23", Command = "dance23", Anim = {"fortnite3", "baile 13", -1, true, false, false}, IFP = true},
            {Name = "Dança 24", Command = "dance24", Anim = {"breakdance1", "break_D", -1, true, false, false}, IFP = true},
            {Name = "Dança 25", Command = "dance25", Anim = {"breakdance2", "FightA_1", -1, true, false, false}, IFP = true},
            {Name = "Dança 26", Command = "dance26", Anim = {"breakdance2", "FightA_2", -1, true, false, false}, IFP = true},
            {Name = "Dança 27", Command = "dance27", Anim = {"breakdance2", "FightA_3", -1, true, false, false}, IFP = true},
            {Name = "Dança 28", Command = "dance28", Anim = {"newAnims", "dance1", -1, true, false, false}, IFP = true},
            {Name = "Dança 29", Command = "dance29", Anim = {"newAnims", "dance2", -1, true, false, false}, IFP = true},
            {Name = "Dança 30", Command = "dance30", Anim = {"newAnims", "dance3", -1, true, false, false}, IFP = true},
            {Name = "Dança 31", Command = "dance31", Anim = {"newAnims", "dance4", -1, true, false, false}, IFP = true},
            {Name = "Dança 32", Command = "dance32", Anim = {"newAnims", "dance5", -1, true, false, false}, IFP = true},
            {Name = "Dança 33", Command = "dance33", Anim = {"newAnims", "dance6", -1, true, false, false}, IFP = true},
            {Name = "Dança 34", Command = "dance34", Anim = {"newAnims", "dance7", -1, true, false, false}, IFP = true},
            {Name = "Dança 35", Command = "dance35", Anim = {"newAnims", "dance8", -1, true, false, false}, IFP = true}
		}
	},
	{
		Name = "Outras",
		Icon = "others",
        sizeIcon = {11.6, 12.85},
		Animations = {
            {Name = "Santo", Command = "con9", Anim = {"Interações", "Santo", 500, false, false, true}, Custom = true},
            {Name = "Assobiar", Command = "con10", Anim = {"Ações", "Assobiar", 600, false, false, false}, Custom = true},
            {Name = "Falando radinho", Command = "con", Anim = {"Ações", "Falando radinho", 500, false, false, true}, Custom = true},
            {Name = "Segurando arma", Command = "con2", Anim = {"Ações", "Segurar arma", 500, false, false, true}, Custom = true},
            {Name = "Segurando arma 2", Command = "con3", Anim = {"Ações", "Segurar arma 2", 500, false, false, true}, Custom = true},
            {Name = "Segurando revolver", Command = "con4", Anim = {"Ações", "Segurar pistola", 500, false, false, true}, Custom = true},
            {Name = "Meditando", Command = "con8", Anim = {"Interações", "Meditando", 800, false, false, true}, Custom = true},
			{Name = "Levantar", Command = "oh", Anim = {"INT_HOUSE", "wash_up", -1, true, false, false}},
            {Name = "Sentar", Command = "oh2", Anim = {"INT_HOUSE", "LOU_Loop", -1, true, false, false}},
            {Name = "Sentar 2", Command = "oh3", Anim = {"INT_HOUSE", "LOU_In", -1, false, false, false}},
            {Name = "Sentar 3", Command = "oh4", Anim = {"ped", "SEAT_idle", -1, true, false, false}},
            {Name = "Deitar", Command = "oh6", Anim = {"CRACK", "crckidle2", -1, true, false, false}},
            {Name = "Deitar 2", Command = "oh7", Anim = {"CRACK", "crckidle4", -1, true, false, false}},
            {Name = "Cartão", Command = "oh8", Anim = {"HEIST9", "Use_SwipeCard", -1, true, false, false}},
			{Name = "Assustado", Command = "oh9", Anim = {"ped", "cower", -1, true, false, false}},
			{Name = "Punheta", Command = "oh10", Anim = {"PAULNMAC", "wank_out", -1, true, false, false}},
			{Name = "Mijando", Command = "oh11", Anim = {"PAULNMAC", "Piss_out", -1, true, false, false}}
		}
	},
	{
		Name = "Objetos",
		Icon = "object",
        sizeIcon = {11.5, 11.93},
		Animations = {
            {Name = "Garrafa", Command = "oc", Anim = {"Ações", "Segurando garrafa", 500, false, false, true}, Custom = true},
            {Name = "Caixa", Command = "oc2", Anim = {"Ações", "Segurando caixa", 500, false, false, true}, Custom = true},
            {Name = "Buquê", Command = "oc3", Anim = {"Ações", "Segurar buquê", 500, false, false, true}, Custom = true},
            {Name = "Prancha", Command = "oc4", Anim = {"Ações", "Segurar prancha", 500, false, false, true}, Custom = true},
            {Name = "Guarda-Chuvas", Command = "oc5", Anim = {"Ações", "Segurar guarda chuvas", 500, false, false, true}, Custom = true},
            {Name = "Câmera", Command = "oc6", Anim = {"Ações", "Segurando camera", 500, false, false, true}, Custom = true},
            {Name = "Prancheta", Command = "oc7", Anim = {"Ações", "Segurando prancheta", 500, false, false, true}, Custom = true},
            {Name = "Maleta", Command = "oc8", Anim = {"Ações", "Segurando maleta", 500, false, false, true}, Custom = true},
        }
	}
}

CUSTOM_ANIMATIONS = {
    ['Ações'] = {
        ['Cruzar Braços'] = {
            BonesRotation = {
                [32] = {0, -110, 25},
                [33] = {0, -100, 0},
                [34] = {-75, 0, -40},
                [22] = {0, -90, -25},
                [23] = {0, -100, 0},
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
        },
        ['Falando radinho'] = {
            BonesRotation = {
                [5] = {0, 0, -30},
                [32] = {-30, -30, 50},
                [33] = {0, -160, 0},
                [34] = {-120, 0, 0}
            },
            skipAnimation = true,
        },
        ['Render'] = {
            BonesRotation = {
                [22] = {0, -15, 60},
                [32] = {0, -10, -60},
                [23] = {80, -10, 120},
                [33] = {-80, -10, -120},
                [5] = {0, 8, 0}
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
        },
        ['Render 2'] = {
            BonesRotation = {
                [22] = {-30, -55, 30},
                [23] = {10, -20, 60},
                [24] = {120, 0, 0},
                [25] = {0, 0, 0},
                [26] = {0, 0, 0},
                [32] = {-30, -55, -30},
                [33] = {-10, -80, -30},
                [34] = {-70, 0, 0},
                [35] = {0, 0, 0},
                [36] = {0, 0, 0},
                [5] = {0, 8, 0}
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
        },
        ['Render 3'] = {
            BonesRotation = {
                [22] = {0, -15, 70},
                [32] = {0, -10, -60},
                [23] = {80, -10, 130},
                [33] = {-80, -10, -130},
                [5] = {0, -20, 0}
            },

            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
        },
        ['Segurar arma'] = {
            BonesRotation = {
                [23] = {-10, -100, 10},
                [24] = {120, 10, -50},
                [32] = {0, 0, 60},
                [33] = {0, -45, 35},
            },
            blockAttack = true,
            blockVehicle = true,
        },
        ['Segurar arma 2'] = {
            BonesRotation = {
                [5] = {0, 0, 0},
                [22] = {80, 0, 0},
                [23] = {0, -160, 0},
                [32] = {0, 0, 70},
                [33] = {0, -10, 20},
                [34] = {-80, 0, 0},
            },
            blockAttack = true,
            blockVehicle = true,
        },
        ['Segurar pistola'] = {
            BonesRotation = {
                [22] = {0, -30, -35},
                [23] = {20, -125, -10},
                [24] = {90, 40, -10},
                [32] = {-5, -70, 60},
                [33] = {-70, -90, -5},
            },
            blockAttack = true,
            blockVehicle = true,
        },
        ['Equipar máscara'] = {
            BonesRotation = {
                [22] = {0, -80, -5},
                [23] = {0, -125, 30},
                [24] = {160, 0, 0},
            },
            blockAttack = true,
        },
        ['Equipar óculos'] = {
            BonesRotation = {
                [5] = {10, 5, 0},
                [22] = {0, -80, -5},
                [23] = {0, -155, 50},
                [24] = {60, 0, 0},
                [32] = {0, -80, 5},
                [33] = {0, -155, -55},
                [34] = {-60, 0, 0},
            },
            blockAttack = true,
        },

        ['Equipar bolsa'] = {
            BonesRotation = {
                [22] = {0, -35, -30},
                [23] = {0, -140, -10},

                [32] = {0, -35, 30},
                [33] = {0, -140, 10},
            },
            blockAttack = true,
            blockJump = true,
        },
        ['Segurar escudo'] = {
            BonesRotation = {
                [201] = {0, 0, 0},
                [32] = {-80, -100, 13},
                [33] = {-10, -10, 80},
            },
            onDuck = {
                [201] = {0, 0, 0},
                [32] = {-100, -15, -25},
                [33] = {35, 50, 110},
                [34] = {-30, 0, 0},
            },
            blockVehicle = true,
        },

        ['Colocar capacete'] = {
            BonesRotation = {
                [5] = {0, 20, 0},
                [22] = {0, -90, 0},
                [23] = {50, -170, 60},
                [24] = {0, 0, 0},
                [25] = {-40, 0, 0},
                [32] = {0, -110, 0},
                [33] = {0, -170, -55},
                [34] = {0, 0, 0},
                [35] = {40, 0, 0},
            },
            blockAttack = true,
            Sound = {
                File = 'capacete',
                MaxDistance = 10,
                Volume = 0.2,
            },
        },

        ['Segurando garrafa'] = {
            BonesRotation = {
                [32] = {30, -20, 60},
                [33] = {0, -90, 0},
                [34] = {-90, 0, 0},
                [35] = {-10, 0, 0},
            },
            onDuck = {
                [32] = {-30, 0, 60},
                [33] = {0, -90, 0},
                [34] = {-90, 0, 0},
                [35] = {-10, 0, 0},
            },
            Object = {
                Model = 1484,
                Offset = {34, 0.07, 0.03, 0.05, 0, -180, 0},
                Scale = 0.9,
            },
        },
        ['Segurando prancheta'] = {
            BonesRotation = {
                [5] = {0, 5, 0},
                [32] = {-10, -60, 20},
                [33] = {-30, -80, 0},

                [34] = {-120, 0, 0},
                [35] = {-40, 30, -10},
            },
            onDuck = {
                [5] = {0, -30, 0},
                [32] = {-10, -20, -5},
                [33] = {-40, -90, 0},

                [34] = {-140, 0, 0},
                [35] = {-40, 30, -10},
            },
            Object = {
                Model = 1933,
                Offset = {35, 0.07, 0.065, 0.005, -80, -80, -100},
            },
            blockJump = true,
        },
        ['Segurando maleta'] = {
            BonesRotation = {},
            Object = {
                Model = 1934,
                Offset = {35, 0.18, -0.09, 0, -90, -40, -70},
                Scale = 0.7,
            }
        },
        ['Segurar buquê'] = {
            BonesRotation = {
                [32] = {30, -20, 60},
                [33] = {0, -90, 0},
                [34] = {-90, 0, 0},
                [35] = {-10, 0, 0},
            },
            
            onDuck = {
                [32] = {-90, -30, -10},
                [33] = {0, -90, 0},
                [34] = {-95, 30, 0},
                [35] = {-10, 0, 0},
            },
            Object = {
                Model = 325,
                Offset = {34, 0.01, 0.03, 0.05, 0, -200, 0},
                Scale = 0.9,
            },
        },
        ['Segurar guarda chuvas'] = {
            BonesRotation = {
                [32] = {30, -20, 60},
                [33] = {0, -90, 0},
                [34] = {-80, -30, 0},
                [35] = {-30, 0, 0},
            },
            onDuck = {
                [32] = {30, -20, 10},
                [33] = {0, -80, -80},
                [34] = {-90, -30, 0},
                [35] = {-30, 0, 0},
            },
            Object = {
                Model = 14864,
                Offset = {34, 0.05, 0.03, 0.05, 0, -210, 30},
                Scale = 0.9,
            },

            blockJump = true,
            blockVehicle = true,
        },

        ['Segurar prancha'] = {
            BonesRotation = {
                [32] = {30, -20, 40},
                [33] = {0, -60, 30},
                [34] = {-130, 0, 0}
            },
            Object = {
                Model = 2404,
                Offset = {33, 0.2, -0.02, 0.08, 0, -160, -20},
                Scale = 0.7,
            },
            blockDuck = true,
            blockJump = true,
            blockVehicle = true,
        },

        ['Segurando caixa'] = {
            BonesRotation = {
                [22] = {60, -30, -70},
                [23] = {-10, -70, -50},
                [24] = {160, 0, 0},
                [25] = {0, -10, 0},
                [32] = {-60, -40, 70},
                [33] = {10, -70, 50},
                [34] = {-160, 0, 0},
                [35] = {0, -10, 0},
                [201] = {0, 0, 0},
            },

            onDuck = {
                [22] = {60, -30, 0},
                [23] = {-10, -70, -50},
                [24] = {160, 0, 0},
                [25] = {0, -10, 0},
                [32] = {-60, -40, 0},
                [33] = {10, -70, 50},
                [34] = {-160, 0, 0},
                [35] = {0, -10, 0},
                [201] = {0, 0, 0},
            },
            Object = {
                Model = 2912,
                Offset = {24, 0.08, 0.4, -0.02, 0, 120, 10},
                Scale = 0.5,
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
        },
        ['Assobiar'] = {
            BonesRotation = {
                [32] = {-90, -70, 0},
                [33] = {10, 30, 125},
            },
            Sound = {
                File = 'assobio',
                MaxDistance = 50,
            },
        },
        ['Segurando camera'] = {
            BonesRotation = {
                [22] = {0, -60, 0},
                [23] = {80, -90, 80},
                [24] = {80, 30, 0},

                [32] = {0, -85, 10},
                [33] = {-70, -100, -20},
            },
            onDuck = {
                [22] = {0, -80, 0},
                [23] = {80, -70, 80},
                [24] = {90, 30, 0},

                [32] = {0, 0, 10},
                [33] = {-70, -100, -20},
                [34] = {-20, 0, 0},
            },
            Object = {
                Model = 367,
                Offset = {24, -0.16, 0.03, 0.28, 50, -5, -30},
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
        }
    },
    ['Interações'] = {
        ['Triste'] = {
            BonesRotation = {
                [5] = {0, 20, 0}
            }
        },
        ['Pensativo 2'] = {
            BonesRotation = {
                [5] = {0, 8, 0},
                [32] = {0, -110, 25},
                [33] = {0, -100, 0},
                [22] = {60, -95, -30},
                [23] = {8, -135, 8}
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
        },
        ['Santo'] = {
            BonesRotation = {
                [32] = {0, -60, 60},
                [33] = {0, -60, 20},
                [34] = {-100, 0, 0},
                [22] = {0, -40, -60},
                [23] = {0, -70, -30},
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
            blockDuck = true,
        },
        ['Meditando'] = {
            BonesRotation = {
                [22] = {30, -60, -45},
                [23] = {20, -60, 40},
                [24] = {-220, 0, 0},
                [32] = {-30, -60, 45},
                [33] = {20, -60, -40},
                [34] = {-220, 0, 0},
            },
            blockAttack = true,
            blockJump = true,
            blockVehicle = true,
            blockDuck = true,
        },
    }
}