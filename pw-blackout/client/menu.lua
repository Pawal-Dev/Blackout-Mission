--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝                              

 local mainMenu = RageUI.CreateMenu("Informateur", "Action") 
 local open = false
 
 mainMenu.X = 0 
 mainMenu.Y = 0
 
 mainMenu.Closed = function() 
     open = false 
 end 

 function menublackout()
     if open then 
         open = false 
             RageUI.Visible(mainMenu, false) 
             return 
     else 
         open = true 
         local fait = false
             RageUI.Visible(mainMenu, true)
         Citizen.CreateThread(function()
             while open do 
                 RageUI.IsVisible(mainMenu, function()
                    if lockmenu == false then 
                        RageUI.Button("Prendre le contrat", "~r~Si vous annulez le contrat, vous récuperez la moitier de la somme du prix du contrat", {RightLabel = "~r~"..Config.prixContrat..""..Config.Devise}, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('pawal:contratcallback', function(booltarif)   
                                    if booltarif == true then
                                        RageUI.CloseAll()
                                        open = false
                                        if Config.usetarget then
                                            startstartmissiontarget(false)
                                            startstopmissiontarget(true)
                                        end
                                        TriggerServerEvent('pawal:sendlogs')
                                        startmission()
                                    else
                                        ESX.ShowNotification('~r~Vous n\'avez pas assez d\'argent sur vous pour prendre le contrat')
                                    end               
                                end)
                            end
                        })
                    else
                        RageUI.Separator('')
                        RageUI.Separator('~r~Mission indisponible pour le moment')
                        RageUI.Separator('')
                    end
              end)
             Wait(0)
             end
         end)
     end
 end

 Citizen.CreateThread(function()
    if Config.usetarget then
        startstartmissiontarget(true)
    end
    while true do
        local Timer = 800
           local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
           local pos = Config.position
           local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
           if dist3 <= Config.drawdistance then
               Timer = 0
               if dist3 <= 1.0 and open == false and Config.usetarget == false then 
                   Timer = 0
                   if startmissionstatut == false then
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour parler avec l'informateur")
                        if IsControlJustPressed(1,51) then   
                                menublackout()
                        end 
                    else
                        ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour stopper la mission")
                        if IsControlJustPressed(1,51) then   
                                RemoveBlip(pointcentral)
                                TriggerServerEvent('pawal:givemoneyforstopcontrat')
                                startmissionstatut = false
                                TriggerServerEvent('pawal:unlockinteractionstart')
                        end 
                    end
                end      
            end
        Citizen.Wait(Timer)
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey(Config.pedmodel)
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", Config.pedmodel, Config.pedposition.x, Config.pedposition.y, Config.pedposition.z-0.92, Config.pedposition.h, false, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)  