if rx.UsePujcovnaMesto then
    
    local pujcovna_mesto = BoxZone:Create(vector3(rx.PedMesto),  30.0, 15.0, { name="pujcovna_mesto", heading=25,  debugPoly= rx.Zone.UseDebug, minZ = -2, maxZ= 5 })
    local RNT = RegisterNetEvent
    local AEH = AddEventHandler
    local q = exports['qtarget']

    pujcovna_mesto:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            TriggerEvent('rx_carrent:client:SpawnNPC2')
        else
            DeleteEntity(ped)
        end
    end)

    RNT('rx_carrent:client:SpawnNPC2')
    AEH('rx_carrent:client:SpawnNPC2', function()
        local npc = GetHashKey(rx.PedMestoHash)
        if not HasModelLoaded(npc) then
            lib.requestModel(npc, 5000)
            Wait(0)
        end
        while not HasModelLoaded(npc) do 
            Wait(0)
        end

        ped = CreatePed(5, npc, rx.PedMesto, rx.PedMestoHeading, false, false)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetModelAsNoLongerNeeded(npc)
        TaskStartScenarioInPlace(ped,'CODE_HUMAN_CROSS_ROAD_WAIT',0,true)
        q:AddTargetEntity(ped, {
            options = {
                {
                    label = 'Promluvit si',
                    icon = "far fa-comment",
                    event = 'rx_carrent:client:OpenMenuMesto',
                },
            },
            job = {"all"},
            distance = 2.5
        })
    end)

    RNT('rx_carrent:client:OpenMenuMesto')
    AEH('rx_carrent:client:OpenMenuMesto', function()
        lib.registerContext({
            id = 'pujcovna_mestoreal',
            title = rx.PedNames[math.random(1, #rx.PedNames)],
            options = {
                {
                    title =  'Čtyřkolka',
                    icon = 'fa-solid fa-ship',
                    description = 'Chceš si půjčit čtyřkolku? Dobrá, ale stojí $'..rx.Ceny.Ctyrkolka.price,
                    event = 'rx_carrent:client:SpawnCarMesto',
                    args = { car = "blazer" },
                    metadata = { 
                        'Vybereš si čtyřkolku za '..rx.Ceny.Ctyrkolka.price..'$' },
                    image = 'https://docs.fivem.net/vehicles/dinghy2.webp',
                    arrow = false,
                },
                {
                    title =  'Vodní skůtr',
                    icon = 'fa-solid fa-tornado',
                    description = 'Chceš si půjčit vodní skůtr? Dobrá, ale stojí $'..rx.Ceny.Skutr.price,
                    event = 'rx_carrent:client:SpawnCarMesto',
                    args = { car = "seashark" },
                    metadata = { 
                        'Vybereš si vodní skůtr za '..rx.Ceny.Skutr.price..'$' },
                    image = 'https://docs.fivem.net/vehicles/seashark.webp',
                    arrow = false,
                },
                {
                    title =  'Zavřít menu',
                    event = 'rx_carrent:client:HideMenuMesto',
                    arrow = true,
                }
            },
        })
        lib.showContext('pujcovna_mestoreal')
    end)

    RNT('rx_carrent:client:HideMenuMesto')
    AEH('rx_carrent:client:HideMenuMesto', function()
        lib.hideContext('pujcovna_mestoreal')
    end)

    RegisterNetEvent('rx_carrent:client:SpawnCarMesto')
    AddEventHandler('rx_carrent:client:SpawnCarMesto', function(data)
        local count = exports.ox_inventory:Search('count', 'money')
        if count >= rx.Ceny.Ctyrkolka.price then
            if ESX.Game.IsSpawnPointClear(vector3(-1627.4645, -1142.1801, 0.9983), 15) then
                if data.car == "blazer" then
                        local player = PlayerPedId()
                        ESX.Game.SpawnVehicle('blazer', vector3(-1617.9353, -1131.1794, 2.1185), 217.0030, function(vehicle)
                        if rx.TeleportToCar then 
                            TaskWarpPedIntoVehicle(player, vehicle, -1)
                        end
                        Entity(vehicle).state.fuel = 100
                        lib.notify({ title = 'Čtyřkolka byla přistavena!', position = 'top'})
                        TriggerServerEvent('rx:server:PayForBlazer')
                    end)
                elseif data.car == "seashark" then
                    if count >= rx.Ceny.Skutr.price then
                        local player = PlayerPedId()
                        ESX.Game.SpawnVehicle('seashark', vector3(-1630.8088, -1144.6152, 0.6410), 144.0555, function(vehicle)
                        if rx.TeleportToCar then 
                            TaskWarpPedIntoVehicle(player, vehicle, -1)
                        end
                        Entity(vehicle).state.fuel = 100
                        lib.notify({ title = 'Vodní skůtr byl přistaven!', position = 'top'})
                        TriggerServerEvent('rx:server:PayForSkutr')
                        end)
                    else 
                        lib.notify({ title = 'Nemáš dostatek hotovosti u sebe!', position = 'top' })
                    end
                end
            else
                lib.notify({ title = 'Místo není přístupné!', position = 'top' })
            end
        else
            lib.notify({ title = 'Nemáš dostatek hotovosti u sebe!', position = 'top' })
        end
    end)
end