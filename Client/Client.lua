
local ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    while true do
        local wait = 500

        local ped = PlayerPedId()
        local pedC = GetEntityCoords(ped)
            for k,v in pairs(Config.Zones) do
                for i = 1, #v.coords, 1 do
                    local dist = #(pedC - v.coords[i])
                    if dist < 10 then
                        wait = 0
                        DrawMarker(2, v.coords[i].x, v.coords[i].y, v.coords[i].z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 0, 0, 100, false, true, 2, true, nil, nil, false) -- Create marker on coords
                        if dist < 3 then
                            ShowFloatingHelpNotification('Press ~r~E~w~ to buy weapons.', vector3(v.coords[i].x, v.coords[i].y, v.coords[i].z + 1.2))
                            if dist < 2 then
                                if IsControlJustPressed(0, 38) then
                                    OpenShop(v.Weapons, v.categories, v.license)
                                end
                            end
                        end
                    end
                end
            end
        Wait(wait)
    end
end)

ShowFloatingHelpNotification = function(msg, coords) 
    AddTextEntry('qbcoreFloatingHelpNotification', msg) 
    SetFloatingHelpTextWorldPosition(1, coords) 
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0) 
    BeginTextCommandDisplayHelp('qbcoreFloatingHelpNotification') 
    EndTextCommandDisplayHelp(2, false, false, -1) 
end

local open = false
local armasP = {}
local cats = {}	

function OpenShop(armas, categorias, license)
    if license ~= nil then 
        ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
            if hasWeaponLicense then
                if not open then 
                    SetTimecycleModifier('hud_def_blur') -- blur
                    SetNuiFocus(true, true)
                    for k,v in pairs(categorias) do 
                        SendNUIMessage({
                            action = 'openShop',
                            label = v.label,
                            name = v.name,
                        })
                    end
                    open = true
                    armasP = armas
                    cats = categorias
                end
            else
                ESX.ShowNotification("You don't have a license!")
            end
        end, GetPlayerServerId(PlayerId()), license)
    else
        if not open then 
            SetTimecycleModifier('hud_def_blur') -- blur
            SetNuiFocus(true, true)
            for k,v in pairs(categorias) do 
                SendNUIMessage({
                    action = 'openShop',
                    label = v.label,
                    name = v.name,
                })
            end
            open = true
            armasP = armas
            cats = categorias
        end
    end
end

RegisterNUICallback('exit', function(data, cb)
  SetNuiFocus(false, false)
  open = false
  SetTimecycleModifier('default')
end)

RegisterNUICallback('RequestWeapons', function(data, cb)
    for k,v in pairs(armasP) do 
        if v.category == data.cat then
            SendNUIMessage({
                action = 'AppendWeapons',
                name = v.name,
                label = ESX.GetWeaponLabel(v.name),
                price = v.price,
                numero = k
            })
        end
    end
end)


RegisterNUICallback('RequestStats', function(data, cb)
	local _,hudDamage,hudSpeed,hudCapacity,hudAccuracy,hudRange = GetWeaponStats(GetHashKey(data.arma))
    SendNUIMessage({
        action = 'ShowStats',
        damage = hudDamage,
        speed = hudSpeed,
        accuracy = hudAccuracy,
        range = hudRange
    })
end)

RegisterNUICallback('BuyWeapon', function(data, cb)
    local arma = ESX.GetWeaponLabel(data.arma)
    ESX.TriggerServerCallback('Roda_WeaponShop:BuyWeapon', function(valid)
        if valid == 'good' then
            ShowNoti('Buy Weapon', 'You bought a '..arma..'', 'success')
        elseif valid == 'ya' then
            ShowNoti('Already Weapon', 'You already have a '..arma..'', 'error')
        else
            ShowNoti('No Money', 'You don\'t have enough money.', 'error')
        end
    end, data.price, data.tipo, data.arma)
end)

CreateThread(function()
    for k,v in pairs(Config.Zones) do 
        for i = 1, #v.coords, 1 do
            local blip = AddBlipForCoord(v.coords[i])
    
            SetBlipSprite (blip, 110)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.6)
            SetBlipColour (blip, 4)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName('Weapon Shop')
            EndTextCommandSetBlipName(blip)
        end
    end
end)

