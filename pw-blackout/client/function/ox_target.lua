if Config.usetarget == true then
adoxstart = nil
function startstartmissiontarget(bool)
    if bool == true then
        adoxstart = exports.ox_target:addBoxZone({
            coords = vec3(Config.pedposition.x, Config.pedposition.y, Config.pedposition.z+1.0),

            size = vec3(2,2,2),
            rotation = 45,
            debug = drawZones,
            options = {
                {
                    name = 'blackout',
                    event = 'pawal:openmenublackout',
                    icon = 'fa-solid fa-circle-exclamation',
                    label = 'Parler à l\'informateur'
                }
            }
        })

    else
        exports.ox_target:removeZone(adoxstart)
    end
end

RegisterNetEvent('pawal:openmenublackout')
AddEventHandler('pawal:openmenublackout', function()
        menublackout()
end)

addoxlockpick = nil
addoxhacking = nil
function startlockpicktarget(bool)
    if bool == true then
        addoxlockpick = exports.ox_target:addBoxZone({
            coords = vec3(Config.blipcoords.x, Config.blipcoords.y, Config.blipcoords.z+1.0),
    
            size = vec3(2,2,2),
            rotation = 45,
            debug = drawZones,
            options = {
                {
                    name = 'lockpick',
                    event = 'pawal:lockpicktarget',
                    icon = 'fa-solid fa-lock',
                    label = 'Lockpick la porte'
                }
            }
        })
    else
        exports.ox_target:removeZone(addoxlockpick)
    end
end

RegisterNetEvent('pawal:lockpicktarget')
AddEventHandler('pawal:lockpicktarget', function()
    local result = exports['lockpick']:startLockpick()
    if result == true then
        RemoveBlip(pointcentral)
        TriggerServerEvent('changedoorsstatuts', false)
        startlockpicktarget(false)
        setobjectif()
        setWait = 100
    end        
end)

function starthackingtarget(bool)
    if bool == true then
        addoxhacking = exports.ox_target:addBoxZone({
            coords = vec3(Config.hackingPosition.x, Config.hackingPosition.y, Config.hackingPosition.z+1.0),
    
            size = vec3(2,2,2),
            rotation = 45,
            debug = drawZones,
            options = {
                {
                    name = 'hacking',
                    event = 'pawal:hackingtarget',
                    icon = 'fa-brands fa-hackerrank',
                    label = 'Pirater le générateur'
                }
            }
        })
    else
        exports.ox_target:removeZone(addoxhacking)
    end
end

RegisterNetEvent('pawal:hackingtarget')
AddEventHandler('pawal:hackingtarget', function()  
        if essai == 0 then
            if Config.usecustomdispatch == false then
                TriggerServerEvent('police:startalerte')
            else
                Config.customdispatchfunction(Config.hackingPosition.x, Config.hackingPosition.y, Config.hackingPosition.z)
            end
        end
        if essai < Config.nombreEchecHacking then
            TriggerEvent("utk_fingerprint:Start", 3, Config.nombreErreur, 3, function(outcome, reason)
                if outcome == true then 
                    Wait(4000)
                    ESX.ShowNotification('~g~Piratage réussi !')
                    RemoveBlip(pointobjectif)
                    setWait = 100
                    blackoutfunction()
                    EnableAllControlActions(0)
                    startmissionstatut = false
                    startlockpicktarget(false)
                    TriggerServerEvent('pawal:lockinteraction')
                    startstartmissiontarget(true)
                    startstopmissiontarget(false)
                    starttimer()
                elseif outcome == false then
                    Wait(4000)
                    ESX.ShowNotification('~r~Piratage échouer !')
                    essai = essai + 1
                    EnableAllControlActions(0)
                end
            end)
        end
end)

adoxstop = nil

RegisterNetEvent('pawal:stopmissiontarget')
AddEventHandler('pawal:stopmissiontarget', function()  
    startstartmissiontarget(true)
    startstopmissiontarget(false)
    starthackingtarget(false)
    startlockpicktarget(false)
    TriggerServerEvent('pawal:givemoneyforstopcontrat')
    RemoveBlip(pointcentral)
    startmissionstatut = false
    TriggerServerEvent('pawal:unlockinteractionstart') 
end)

function startstopmissiontarget(bool)
    if bool == true then
        adoxstop = exports.ox_target:addBoxZone({
            coords = vec3(Config.pedposition.x, Config.pedposition.y, Config.pedposition.z+1.0),
    
            size = vec3(2,2,2),
            rotation = 45,
            debug = drawZones,
            options = {
                {
                    name = 'stopmission',
                    event = 'pawal:stopmissiontarget',
                    icon = 'fa-solid fa-circle-exclamation',
                    label = 'Stopper la mission'
                }
            }
        })
    else
        exports.ox_target:removeZone(adoxstop)
    end
end
end
