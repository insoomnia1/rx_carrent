if rx.UseBlip and rx.UsePujcovnaCayo then
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

if rx.UseBlip and rx.UseVraceniMesto then
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

if rx.UseBlip and rx.UsePujcovnaMesto then
    local blip = AddBlipForCoord(rx.PedMesto.x, rx.PedMesto.y, rx.PedMesto.z)

    SetBlipSprite(blip, rx.Blip.PujceniMesto.Sprite)
    SetBlipDisplay(blip, rx.Blip.PujceniMesto.Display)
    SetBlipScale(blip, rx.Blip.PujceniMesto.Scale)
    SetBlipColour(blip, rx.Blip.PujceniMesto.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(rx.Blip.PujceniMesto.txt)
    EndTextCommandSetBlipName(blip)
end