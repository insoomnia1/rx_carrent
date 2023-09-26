local pujcovna_lodi = BoxZone:Create(vector3(rx.PedCoords),  25.0, 25.0, { name="npc_pujcovna_lodi", heading=270,  debugPoly=true, minZ = rx.Zone.minZ, maxZ= rx.Zone.maxZ })
local RNT = RegisterNetEvent
local AEH = AddEventHandler
local q = exports['qtarget']

pujcovna_lodi:onPlayerInOut(function(isPointInside, point)
    if isPointInside then
        TriggerEvent('rx_carrent:client:SpawnNPC')
    else
        DeleteEntity(ped)
    end
end)

RNT('rx_carrent:client:SpawnNPC')
AEH('rx_carrent:client:SpawnNPC', function()
    local npc = GetHashKey(rx.PedHash)
    if not HasModelLoaded(npc) then
        lib.requestModel(npc, 5000)
        Wait(0)
    end
    while not HasModelLoaded(npc) do 
        Wait(0)
    end

    ped = CreatePed(5, npc, rx.PedCoords, rx.PedHeading, false, false)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetModelAsNoLongerNeeded(npc)
    TaskStartScenarioInPlace(ped,'WORLD_HUMAN_SMOKING',0,true)
    q:AddTargetEntity(ped, {
        options = {
            {
                label = 'Promluvit si',
                icon = "far fa-comment",
                event = 'rx_carrent:client:OpenMenu',
            },
        },
        job = {"all"},
        distance = 2.5
    })
end)

RNT('rx_carrent:client:OpenMenu')
AEH('rx_carrent:client:OpenMenu', function()
    lib.registerContext({
        id = 'carrent_lode',
        title = rx.PedNames[math.random(1, #rx.PedNames)],
        options = {
            {
                title =  'Dingy',
                icon = 'fa-solid fa-ship',
                description = 'Chceš si půjčit loď? Dobrá, ale stojí $'..rx.Ceny.Dingy.price,
                event = 'rx_carrent:client:SpawnCar',
                args = { car = "dinghy3" },
                metadata = { 
                    'Vybereš si Dingy za '..rx.Ceny.Dingy.price..'$' },
                image = 'https://docs.fivem.net/vehicles/dinghy2.webp',
                arrow = false,
            },
            {
                title =  'Vodní skůtr',
                icon = 'fa-solid fa-tornado',
                description = 'Chceš si půjčit vodní skůtr? Dobrá, ale stojí $'..rx.Ceny.Skutr.price,
                event = 'rx_carrent:client:SpawnCar',
                args = { car = "seashark" },
                metadata = { 
                    'Vybereš si vodní skůtr za '..rx.Ceny.Skutr.price..'$' },
                image = 'https://docs.fivem.net/vehicles/seashark.webp',
                arrow = false,
            },
            {
                title =  'Zavřít menu',
                event = 'rx_carrent:client:HideMenu',
                arrow = true,
            }
        },
    })
    lib.showContext('carrent_lode')
end)

RNT('rx_carrent:client:HideMenu')
AEH('rx_carrent:client:HideMenu', function()
    lib.hideContext('carrent_lode')
end)


RegisterNetEvent('rx_carrent:client:SpawnCar')
AddEventHandler('rx_carrent:client:SpawnCar', function(data)
    local count = exports.ox_inventory:Search('count', 'money')
    if count >= rx.Ceny.Dingy.price then
        if ESX.Game.IsSpawnPointClear(vector3(4933.7124, -5171.7271, 0.1192), 3) then
            if data.car == "dinghy3" then
                    local player = PlayerPedId()
                    ESX.Game.SpawnVehicle('dinghy3', vector3(4933.7124, -5171.7271, 0.1192), 63.2830, function(vehicle)
                    if rx.TeleportToCar then 
                        TaskWarpPedIntoVehicle(player, vehicle, -1)
                    end
                    Entity(vehicle).state.fuel = 100
                    lib.notify({ title = 'Loď byla přistavena!', position = 'top'})
                    TriggerServerEvent('rx:server:PayForDinghy')
                end)
            elseif data.car == "seashark" then
                if count >= rx.Ceny.Skutr.price then
                    local player = PlayerPedId()
                    ESX.Game.SpawnVehicle('seashark', vector3(4933.7124, -5171.7271, 0.1192), 63.2830, function(vehicle)
                    if rx.TeleportToCar then 
                        TaskWarpPedIntoVehicle(player, vehicle, -1)
                    end
                    Entity(vehicle).state.fuel = 100
                    lib.notify({ title = 'Vodní skůtr byl přistaven!', position = 'top'})
                    TriggerServerEvent('rx:server:PayForSkutr')
                    end)
                end
            end
        else
            lib.notify({
                title = 'Místo není přístupné!',
                position = 'top',
            })
        end
    else
        lib.notify({
            title = 'Nemáš dostatek hotovosti u sebe!',
            position = 'top',
        })
    end
end)



if rx.UseBlip then
    local blip = AddBlipForCoord(rx.PedCoords.x, rx.PedCoords.y, rx.PedCoords.z)

    SetBlipSprite(blip, rx.Blip.Pujcovna.Sprite)
    SetBlipDisplay(blip, rx.Blip.Pujcovna.Display)
    SetBlipScale(blip, rx.Blip.Pujcovna.Scale)
    SetBlipColour(blip, rx.Blip.Pujcovna.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(rx.Blip.Pujcovna.txt)
    EndTextCommandSetBlipName(blip)
end

if rx.UseBlip then
    local blip = AddBlipForCoord(rx.VraceniLodi.x, rx.VraceniLodi.y, rx.VraceniLodi.z)

    SetBlipSprite(blip, rx.Blip.Vraceni.Sprite)
    SetBlipDisplay(blip, rx.Blip.Vraceni.Display)
    SetBlipScale(blip, rx.Blip.Vraceni.Scale)
    SetBlipColour(blip, rx.Blip.Vraceni.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(rx.Blip.Vraceni.txt)
    EndTextCommandSetBlipName(blip)
end



CreateThread(function()
    local vraceni_lodi = BoxZone:Create(vector3(rx.VraceniLodi),  300.0, 115.0, { name="VraceniLodi", heading=25,  debugPoly=true, minZ = -10, maxZ= 5 })
    exports.ox_target:addGlobalVehicle({
        {
            icon = 'fa-solid fa-wrench',
            label = "Store vehicle",
            bones = 'engine',
            canInteract = function(entity)
                local entityCoords = GetEntityCoords(entity)   
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local closecar = GetClosestVehicle(coords, 8.0, 0, 71)
                local model = GetEntityModel(closecar)
                if model == GetHashKey('dinghy3') or GetHashKey('seashark') and vraceni_lodi:isPointInside(entityCoords)    then
                    return true
                end
            end,
            onSelect = function()
                TriggerEvent('rx_carrent:client:DespawnCar')
            end,
            distance = 2.5
        }
    })

end)

RegisterNetEvent("rx_carrent:client:DespawnCar")
AddEventHandler("rx_carrent:client:DespawnCar", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    vehicle = ESX.Game.GetClosestVehicle(coords)
    if GetEntityModel(vehicle) == GetHashKey('dinghy3') or GetEntityModel(vehicle) == GetHashKey('seashark') then
        DeleteEntity(vehicle)
        lib.notify({
            description = 'Vozidlo bylo zaparkováno',
            type = 'success'
        }) 
    else
        lib.notify({
            title = 'Žádno vozidlo není poblíž',
            position = 'top-right',
        })
    end
end)