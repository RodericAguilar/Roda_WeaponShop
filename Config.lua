Config = {}


Config.Zones = {
    {
        license = 'weapon', -- You can put the license here, or nil if you don't need it.
        categories = {
            {label = 'Melee', name = 'melee'},
            {label = 'Pistol', name = 'pistol'}
        },
        Weapons = {
            {name = 'WEAPON_KNIFE',  price = 1200, category = 'melee'},
            {name = 'WEAPON_BAT',  price = 1000, category = 'melee'}
        },
        coords = {
            vector3(166.0615, -1871.38, 23.0564)
        }
    },
    {
        license = nil, -- You can put the license here, or nil if you don't need it.
        categories = {
            {label = 'Snipers', name = 'sniper'}, -- you can make the categories that u want.
            {label = 'ShotGuns', name = 'shotguns'},
            {label = 'Pistols', name = 'pistol'},
            {label = 'Grenades', name = 'grenade'},
        },
        Weapons = {
            {name = 'WEAPON_SNIPERRIFLE', price = 100, category = 'sniper'},  -- category need to call the name of the category above.
            {name = 'weapon_heavysniper',  price = 100, category = 'sniper'},
            {name = 'weapon_marksmanrifle',  price = 100, category = 'sniper'},
            {name = 'WEAPON_PUMPSHOTGUN',  price = 100, category = 'shotguns'},
            {name = 'weapon_heavyshotgun',  price = 100, category = 'shotguns'},
            {name = 'weapon_assaultshotgun',  price = 100, category = 'shotguns'},
            {name = 'weapon_bullpupshotgun',  price = 100, category = 'shotguns'},
            {name = 'weapon_compactrifle',  price = 100, category = 'shotguns'},
            {name = 'WEAPON_PISTOL', price = 100, category = 'pistol'},
            {name = 'WEAPON_APPISTOL', price = 40, category = 'pistol'},
            {name = 'weapon_heavypistol', price = 2140, category = 'pistol'},
            {name = 'weapon_vintagepistol', price = 2240, category = 'pistol'},
            {name = 'weapon_flaregun', price = 2402, category = 'pistol'},
            {name = 'weapon_revolver', price = 240, category = 'pistol'},
            {name = 'weapon_marksmanpistol', price = 1000, category = 'pistol'},
            {name = 'weapon_grenade', price = 100, category = 'grenade'},
            {name = 'weapon_bzgas', price = 100, category = 'grenade'},
            {name = 'weapon_molotov', price = 100, category = 'grenade'},
            {name = 'weapon_stickybomb', price = 100, category = 'grenade'},
            {name = 'weapon_proxmine', price = 100, category = 'grenade'},
            {name = 'weapon_snowball', price = 100, category = 'grenade'},
            {name = 'weapon_ball', price = 100, category = 'grenade'},
        },
        coords = {
            vector3(-662.1, -935.3, 20.8),
			vector3(810.2, -2157.3, 28.6),
			vector3(1693.4, 3759.5, 33.7),
			vector3(-330.2, 6083.8, 30.4),
			vector3(252.3, -50.0, 68.9),
			vector3(22.0, -1107.2, 28.8),
			vector3(2567.6, 294.3, 107.7),
			vector3(-1117.5, 2698.6, 17.5),
			vector3(842.4, -1033.4, 27.1)
        }
    }
}
