if Config.framework == "newesx" then
    ESX = exports["es_extended"]:getSharedObject()
else
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(10)
        end
        while ESX.GetPlayerData().job == nil do
              Citizen.Wait(10)
        end
        if ESX.IsPlayerLoaded() then
  
            ESX.PlayerData = ESX.GetPlayerData()
  
         end
      end)
end

looptarget = true
setWait = 100
startmissionstatut = false
startnaration1 = false
startnaration2 = false
statutlock = true
lockmenu = false
function startmission()
    if Config.Cinematique == true then 
        playerPed = PlayerPedId()
        lastCoords = GetEntityCoords(playerPed)

        -- Fade
        DisplayRadar(false)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)

        -- Start camera for tutorial
        SetEntityVisible(playerPed, false, 0)

        camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(camera, Config.camcoords.x, Config.camcoords.y, Config.camcoords.z)
        PointCamAtCoord(camera, Config.hendingview.x, Config.hendingview.y, Config.hendingview.z)
        SetCamNearDof(camera, 10)
        RenderScriptCams(1, 1, 2000, 1, 1)
        SetCamShakeAmplitude(camera, 130.0)
        SetEntityCoords(GetPlayerPed(-1), Config.camcoords.x, Config.camcoords.y, Config.camcoords.z)

        -- Stop Fade
        Citizen.Wait(3000)
        DoScreenFadeIn(1000)


        -- Text 
        startnaration1 = true

    -- Wait
    Wait(3000)

    -- Fade
    DoScreenFadeOut(1000)
    Citizen.Wait(1000) 

    -- stat othercam
    RenderScriptCams(0, 1, 750, 1, 1)
    DestroyCam(camera, true)
    camGo = true
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(camera, Config.camobjectif.x, Config.camobjectif.y, Config.camobjectif.z)
    PointCamAtCoord(camera, Config.hendingobjectif.x, Config.hendingobjectif.y, Config.hendingobjectif.z)
    SetCamNearDof(camera, 10)
    RenderScriptCams(1, 1, 2000, 1, 1)
    SetCamShakeAmplitude(camera, 130.0)
    SetEntityCoords(GetPlayerPed(-1), Config.camobjectif.x, Config.camobjectif.y, Config.camobjectif.z)

    -- Stop Fade
    Citizen.Wait(2000)
    DoScreenFadeIn(1000)
    
    -- Text
    startnaration1 = false
    startnaration2 = true

    -- Wait
    Wait(3000)

    -- Fade
    DoScreenFadeOut(1000)
    Citizen.Wait(1000) 

    -- stop event
    startnaration2 = false
    SetEntityCoords(GetPlayerPed(-1), lastCoords)
    SetEntityVisible(playerPed, true, 0)
    RenderScriptCams(0, 1, 750, 1, 1)
    DestroyCam(camera, true)
    camGo = true

    -- Stop Fade
    Citizen.Wait(3000)
    DoScreenFadeIn(1000)
    DisplayRadar(true)
   end
   startmissionstatut = true
   TriggerServerEvent('pawal:lockinteractionstart', GetPlayerServerId(PlayerId()))
   setpoint()
end

Citizen.CreateThread(function()
    while true do
        if startnaration1 then
            RageUI.Text({message = "[~r~Informateur~s~] Rendez-vous à la ~r~central électrique"})
        end

        if startnaration2 then
            RageUI.Text({message = "[~r~Informateur~s~] Pirater ce générateur pour faire sauter le courrant"})
        end
        Citizen.Wait(Timer)
    end
end)

function setpoint()
    looptarget = true
    pointcentral = AddBlipForCoord(Config.blipcoords.x, Config.blipcoords.y, Config.blipcoords.z)
    SetBlipDisplay(pointcentral, 4)
    SetBlipScale(pointcentral, 1.0)
    SetBlipColour(pointcentral, 1)
    SetBlipAsShortRange(pointcentral, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Central électrique")
    EndTextCommandSetBlipName(pointcentral)
    SetBlipRoute(pointcentral, true)

    while DoesBlipExist(pointcentral) do
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local pos = Config.blipcoords
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
        if dist3 > 20.0 then
            RageUI.Text({message = "[~r~Objectif 1/3~s~] Rejoignez la destination GPS"})
        end
        if dist3 <= 20.0 then
            RageUI.Text({message = "[~r~Objectif 2/3~s~] Lockpick la porte de la central"})
            setWait = 0
            if Config.usetarget == false then
                DrawMarker(Config.MarkerType, Config.blipcoords.x, Config.blipcoords.y, Config.blipcoords.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end
        end
        if Config.usetarget == false then
        if dist3 <= 2.0 then
            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour lockpick la porte")
            if IsControlJustPressed(1,51) then   
                local result = exports['lockpick']:startLockpick()
                if result == true then
                    RemoveBlip(pointcentral)
                    TriggerServerEvent('changedoorsstatuts', false)
                    setobjectif()
                    setWait = 100
                end
            end
        end
    else
        if looptarget == true then
            startlockpicktarget(true)
            looptarget = false 
        end
    end
        Wait(setWait)
    end
end

function setobjectif()
    essai = 0
    looptarget = true
    pointobjectif = AddBlipForCoord(Config.hackingPosition.x, Config.hackingPosition.y, Config.hackingPosition.z)
    SetBlipDisplay(pointobjectif, 4)
    SetBlipScale(pointobjectif, 1.0)
    SetBlipColour(pointobjectif, 1)
    SetBlipAsShortRange(pointobjectif, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Générateur")
    EndTextCommandSetBlipName(pointobjectif)
    SetBlipRoute(pointobjectif, true)

    while DoesBlipExist(pointobjectif) do
        RageUI.Text({message = "[~r~Objectif 3/3~s~] Rejoignez le générateur a piraté"})
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local pos = Config.hackingPosition
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pos.x, pos.y, pos.z)
        if dist3 <= 25.0 then
            setWait = 0
            if Config.usetarget == false then
                DrawMarker(Config.MarkerType, Config.hackingPosition.x, Config.hackingPosition.y, Config.hackingPosition.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end
        end
        if dist3 <= 2.0 then
            if Config.usetarget == false then
            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour pirater le générateur")
            if IsControlJustPressed(1,51) then
                if essai == 0 then   
                    if Config.usecustomdispatch == false then
                        TriggerServerEvent('police:startalerte')
                    else
                        Config.customdispatchfunction(Config.hackingPosition.x, Config.hackingPosition.y, Config.hackingPosition.z)
                    end
                end
                TriggerEvent("utk_fingerprint:Start", 3, Config.nombreErreur, 3, function(outcome, reason)
                    if outcome == true then 
                        Wait(4000)
                        ESX.ShowNotification('~g~Piratage réussi !')
                        RemoveBlip(pointobjectif)
                        setWait = 100
                        blackoutfunction()
                        EnableAllControlActions(0)
                        startmissionstatut = false
                        TriggerServerEvent('pawal:lockinteraction')
                        starttimer()
                    elseif outcome == false then
                        Wait(4000)
                        ESX.ShowNotification('~r~Piratage échouer !')
                        essai = essai + 1
                        EnableAllControlActions(0)
                    end
               end)
                
                if essai == Config.nombreEchecHacking then
                    ESX.ShowNotification('~r~Le système administrateur viens de bloquer les générateurs. Vous avez échouer !')
                    RemoveBlip(pointobjectif)
                    TriggerServerEvent('pawal:unlockinteractionstart')
                    startmissionstatut = false
                    setWait = 100
                end
           end 
        else      
            if essai == Config.nombreEchecHacking then
                ESX.ShowNotification('~r~Le système administrateur viens de bloquer les générateurs. Vous avez échouer !')
                startstartmissiontarget(true)
                startstopmissiontarget(false)
                starttimer()
                starthackingtarget(false)
                RemoveBlip(pointobjectif)
                TriggerServerEvent('pawal:unlockinteractionstart')
                startmissionstatut = false
                setWait = 100
            end

            if looptarget == true then
                starthackingtarget(true)
                looptarget = false 
            end  
        end
        end
        Wait(setWait)
    end
end

function blackoutfunction()
    start()
    if Config.useVsync == false then
        Wait(Config.DureeBlackout * 1000 * 60)
        stop()
    end
end

function start()
    if Config.useVsync == false then
        SetArtificialLightsState(true)
        SetArtificialLightsStateAffectsVehicles(false)
    else
        TriggerServerEvent('vsyncPawal:startblackout')
    end
    TriggerServerEvent('pawal:serverstartsound')
end

function stop()
    if Config.useVsync == false then
        SetArtificialLightsState(false) 
        SetArtificialLightsStateAffectsVehicles(true)
    end
end

RegisterNetEvent('pawal:startsound')
AddEventHandler('pawal:startsound', function()
    PlaySoundFrontend(-1, 'Power_Down' , 'DLC_HEIST_HACKING_SNAKE_SOUNDS')    
end)

RegisterNetEvent('pawal:startsoundreturn')
AddEventHandler('pawal:startsoundreturn', function()
    PlaySoundFrontend(-1, 'Mission_Pass_Notify' , 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS')    
end)
    
startsync = false
RegisterNetEvent('police:alertefunction')
AddEventHandler('police:alertefunction', function()
    ESX.ShowAdvancedNotification('Central 911', '~r~Alerte~s~', 'Une tentative de ~r~Blackout~s~ à la central électrique est ~r~en cours~s~ ! \n[~r~VOIR GPS~s~]', 'CHAR_CALL911', 1)
    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
    Wait(1000)
    PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    local blipId = AddBlipForCoord(Config.hackingPosition.x, Config.hackingPosition.y)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('~r~Tentative de blackout')
    EndTextCommandSetBlipName(blipId)
    Wait(Config.TempsAlerte * 1000)
    RemoveBlip(blipId)
end)

RegisterNetEvent('pawal:lockmenu')
AddEventHandler('pawal:lockmenu', function()
    lockmenu = true 
end)

RegisterNetEvent('pawal:unlockmenu')
AddEventHandler('pawal:unlockmenu', function()
    lockmenu = false 
end)

Citizen.CreateThread(function()
    while true do
        wait = 100
        if startsync == true then
            wait = 0
        end
        Citizen.Wait(wait)
    end
end)


Citizen.CreateThread(function()
    while true do
        local doorsCentral = GetClosestObject({}, vector3(735.1982, 132.4122, 80.90654))
        FreezeEntityPosition(doorsCentral, statutlock)
        Citizen.Wait(100)
    end
end)

RegisterNetEvent('changedoorsstatusclient')
AddEventHandler('changedoorsstatusclient', function(active)
    statutlock = active  
end)

function starttimer()
    Citizen.CreateThread(function()
        time = Config.TempsPourSortir
        ESX.ShowNotification('~r~Vous avez '..Config.TempsPourSortir..' secondes pour sortir de la central !')
        while (time ~= 0) do
            Wait( 1000 )
            time = time - 1
        end
        TriggerServerEvent('changedoorsstatuts', true)
    end)
end

AddEventHandler("playerSpawned", function(spawn)
    TriggerServerEvent('pawal:verifstatut')
end)

-- Auteur : https://github.com/APTRiskyBiz/risky-doorlock/blob/master/client/main.lua
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
function GetClosestObject(filter, coords)
	local objects         = GetObjects()
	local closestDistance = -1
	local closestObject   = -1
	local filter          = filter
	local coords          = coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					foundObject = true
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance     = GetDistanceBetweenCoords(objectCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestObject   = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end

function GetObjects()
	local objects = {}

	for object in EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------