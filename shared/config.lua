rx = {}

rx.Items = "OX" -- OX/standalone/ESX
rx.UsePujcovnaMesto = false
rx.UsePujcovnaCayo = false
rx.UseVraceniMesto = false
rx.PedHash = 'a_f_m_prolhost_01'
rx.PedCoords = vector3(4763.3809, -4781.4297, 3.8015 - 1)
rx.VraceniLodi = vector3(-1548.9388, -1285.5642, 5.1977 - 1)
rx.PedMesto = vector3(-1612.7595, -1127.5608, 2.3089 - 1)
rx.PedMestoHeading = 137.1523
rx.PedMestoHash = 'a_f_m_beach_01'
rx.TeleportToCar = true
rx.Zone = {
    minZ = -4,
    maxZ = 10,
}
rx.PedHeading = 336.1706
rx.PedNames = {
    [1] = "Natasha",
    [2] = "Ella",
    [3] = "Adele",
    [4] = "Sophie",
    [5] = "Brenda"
}
rx.Ceny = {
    Dingy = {
        price = 1000
    },
    Skutr = {
        price = 1100
    },
    Ctyrkolka = {
        price = 400
    },
}
rx.UseBlip = true
rx.Blip = {
    Pujcovna = {
        Sprite  = 410,
        Display = 4,
        Scale   = 0.8,
        Colour  = 38,
        txt = '<FONT FACE="Josefin"> Půjčovna lodí a skůtrů - CAYO</FONT>'
    },
    Vraceni = {
        Sprite  = 410,
        Display = 4,
        Scale   = 0.8,
        Colour  = 38,
        txt = '<FONT FACE="Josefin"> Vrácení půjčených lodí/skůtrů </FONT>'
    },
    PujceniMesto = {
        Sprite  = 410,
        Display = 4,
        Scale   = 0.8,
        Colour  = 38,
        txt = '<FONT FACE="Josefin"> Půjčení  lodí/skůtrů - MĚSTO </FONT>'
    }
}