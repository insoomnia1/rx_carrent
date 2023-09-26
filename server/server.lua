RegisterServerEvent('rx:server:PayForDinghy')
AddEventHandler('rx:server:PayForDinghy', function()
    if rx.Items == "ESX" then
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        local money = xPlayer.getMoney()
        if money >= rx.Ceny.Dingy.price then
            xPlayer.removeInventoryItem('money', rx.Ceny.Dingy.price)
        end
    elseif rx.Items == "OX" then
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        local cash = exports.ox_inventory:Search(xPlayer.source, 'count', 'money')
        if cash >= rx.Ceny.Dingy.price then
            exports.ox_inventory:RemoveItem(xPlayer.source, 'money', rx.Ceny.Dingy.price)
        end
    elseif rx.Items == "standalone" then
        -- do it yourself xdd
    end
end)


RegisterServerEvent('rx:server:PayForSkutr')
AddEventHandler('rx:server:PayForSkutr', function()
    if rx.Items == "ESX" then
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        local money = xPlayer.getMoney()
        if money >= rx.Ceny.Skutr.price then
            xPlayer.removeInventoryItem('money', rx.Ceny.Skutr.price)
        end
    elseif rx.Items == "OX" then
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        local cash = exports.ox_inventory:Search(xPlayer.source, 'count', 'money')
        if cash >= rx.Ceny.Skutr.price then
            exports.ox_inventory:RemoveItem(xPlayer.source, 'money', rx.Ceny.Skutr.price)
        end
    elseif rx.Items == "standalone" then
        -- do it yourself xdd
    end
end)

RegisterServerEvent('rx:server:PayForBlazer')
AddEventHandler('rx:server:PayForBlazer', function()
    if rx.Items == "ESX" then
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        local money = xPlayer.getMoney()
        if money >= rx.Ceny.Ctyrkolka.price then
            xPlayer.removeInventoryItem('money', rx.Ceny.Ctyrkolka.price)
        end
    elseif rx.Items == "OX" then
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        local cash = exports.ox_inventory:Search(xPlayer.source, 'count', 'money')
        if cash >= rx.Ceny.Ctyrkolka.price then
            exports.ox_inventory:RemoveItem(xPlayer.source, 'money', rx.Ceny.Ctyrkolka.price)
        end
    elseif rx.Items == "standalone" then
        -- do it yourself xdd
    end
end)