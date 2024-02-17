Config = {

-- ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗     
--██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║     
--██║  ███╗██║     ██║   ██║██████╔╝███████║██║     
--██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║     
--╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗
-- ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

framework = "newesx", -- esx ou newesx (newesx = nouveau export)        
Banniere =  { -- Changer la bannière des différents menu RageUI
    ytdname = "blackoutmenu",
    nameimage = "blackoutbanner"
},
Devise = "$",
usetarget = true,
DureeBlackout = 1, -- temps en minutes
Cinematique = false,
useVsync = true,
TempsLock = 3, -- Temps avant de pouvoir refaire un blackout
TempsPourSortir = 30, -- Temps avant fermeture automatique de la porte de la central après le blackout (en seconde)
prixContrat = 5000, -- Prix pour obtenir le contrat
moneytype = "money", -- si vous voulez argent sale : black_money

--	███╗   ███╗ █████╗ ██████╗ ██╗  ██╗███████╗██████╗     ██████╗  ██████╗ ██╗███╗   ██╗████████╗
--	████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗    ██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
--	██╔████╔██║███████║██████╔╝█████╔╝ █████╗  ██████╔╝    ██████╔╝██║   ██║██║██╔██╗ ██║   ██║   
--	██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗ ██╔══╝  ██╔══██╗    ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║   
--	██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗███████╗██║  ██║    ██║     ╚██████╔╝██║██║ ╚████║   ██║   
--	╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝   
		
drawdistance = 3.0, -- Distance d'affichage des markers
MarkerType = 0, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
MarkerSizeLargeur = 0.5, -- Largeur du marker
MarkerSizeEpaisseur = 0.5, -- Épaisseur du marker
MarkerSizeHauteur = 0.5, -- Hauteur du marker
MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
MarkerColorR = 255, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorG = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorB = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerOpacite = 255, -- Opacité du marker (min: 0, max: 255)
MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
MarkerTourne = false, -- Si le marker tourne (true = oui, false = non)

--██████╗  ██████╗ ███████╗██╗████████╗██╗ ██████╗ ███╗   ██╗
--██╔══██╗██╔═══██╗██╔════╝██║╚══██╔══╝██║██╔═══██╗████╗  ██║
--██████╔╝██║   ██║███████╗██║   ██║   ██║██║   ██║██╔██╗ ██║
--██╔═══╝ ██║   ██║╚════██║██║   ██║   ██║██║   ██║██║╚██╗██║
--██║     ╚██████╔╝███████║██║   ██║   ██║╚██████╔╝██║ ╚████║
--╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

position = {x = 2710.1870117188, y = 1657.0223388672, z = 24.48796081543},
pedmodel = "s_m_y_dealer_01", 
pedposition = {x = 2710.1394042969, y = 1657.6224365234, z = 24.408487243652, h = 180.82925415039065},

-- NE PAS TOUCHER SI VOUS N'AVEZ PAS DE CONNAISSANCE
camcoords = {x = 781.76721191406, y = 108.33898162842, z = 78.615837097168},
hendingview = {x = 733.99084472656, y = 127.01542663574, z = 87.679290771484},
camobjectif = {x = 712.76184082031, y = 132.57429504395, z = 80.754425048828},
hendingobjectif = {x = 711.23541259766, y = 128.14360046387, z = 80.819160461426},
--

blipcoords = {x = 736.32092285156, y = 132.51953125, z = 80.718170166016},
hackingPosition = {x = 711.41516113281, y = 128.52052307129, z = 80.754432678223},
                                                           
--█████╗ ██╗     ███████╗██████╗ ████████╗███████╗    ██████╗  ██████╗ ██╗     ██╗ ██████╗███████╗
--██╔══██╗██║     ██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ██╔══██╗██╔═══██╗██║     ██║██╔════╝██╔════╝
--███████║██║     █████╗  ██████╔╝   ██║   █████╗      ██████╔╝██║   ██║██║     ██║██║     █████╗  
--██╔══██║██║     ██╔══╝  ██╔══██╗   ██║   ██╔══╝      ██╔═══╝ ██║   ██║██║     ██║██║     ██╔══╝  
--██║  ██║███████╗███████╗██║  ██║   ██║   ███████╗    ██║     ╚██████╔╝███████╗██║╚██████╗███████╗
--╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝╚══════╝
           
jobname = {
    "police",
},
TempsAlerte = 80, -- Temps en secondes pour le blip

usecustomdispatch = false, -- Si vous voulez intégrer un custom dispatch
customdispatchfunction = function(coords)
end,

--██╗  ██╗ █████╗  ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗ 
--██║  ██║██╔══██╗██╔════╝██║ ██╔╝██║████╗  ██║██╔════╝ 
--███████║███████║██║     █████╔╝ ██║██╔██╗ ██║██║  ███╗
--██╔══██║██╔══██║██║     ██╔═██╗ ██║██║╚██╗██║██║   ██║
--██║  ██║██║  ██║╚██████╗██║  ██╗██║██║ ╚████║╚██████╔╝
--╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 

nombreEchecHacking = 3, -- Nombre d'echec, si il atteind votre nombre d'echec alors le systeme ce bloque 
nombreErreur = 2, -- Nombre d'erreur accepter dans le hacking (si l'utilisateur fait le nombre d'erreur inscrit, alors ce dernier comptera 1 echec de hacking)
                                                      
}