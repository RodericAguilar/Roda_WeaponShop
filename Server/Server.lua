

local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('Roda_WeaponShop:BuyWeapon', function(source, cb, shopid, tipo, arma)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sid = tonumber(shopid)
    local precio = 0
    for k,v in pairs(Config.Zones) do
            if k == sid then
                for i,j in ipairs(v.Weapons) do
                    if j.name == arma then
                        precio = j.price
                    end
                end
            end
    end
    if tipo == 'money' then 
        if xPlayer.getMoney() >= precio then
            if xPlayer.hasWeapon(arma) then 
                cb('ya')
            else
                xPlayer.removeMoney(precio)
                xPlayer.addWeapon(arma, 100)
                cb('good')
            end
        else
            cb(false)
        end
    elseif tipo == 'bank' then 
        if xPlayer.getAccount('bank').money >= precio then
            if xPlayer.hasWeapon(arma) then 
                cb('ya')
            else
                xPlayer.removeAccountMoney('bank', precio)
                xPlayer.addWeapon(arma, 10)
                cb('good')
            end
        else
            cb(false)
        end
    else
        DropPlayer(source, 'Buy weapons with other methods.')
    end
end)
