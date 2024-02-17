if Config.framework == "newesx" then
	ESX = exports["es_extended"]:getSharedObject()
else
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝

local function sendToDiscordWithSpecialURL(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Blackout Mission",
	            },
	        }
	    }
	PerformHttpRequest(Config.webhook.logs, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

lockstatut = nil
missionencours = nil
identifierMissisonEnCours = nil
RegisterServerEvent('vsyncPawal:startblackout')
AddEventHandler('vsyncPawal:startblackout', function()
	ExecuteCommand('blackout')
	Wait(200)
	TriggerEvent('vSync:requestSync')
	Wait(Config.DureeBlackout * 1000*60)
	ExecuteCommand('blackout')
	Wait(200)
	TriggerEvent('vSync:requestSync')
	TriggerEvent('pawal:serverstartsound2')
end)

RegisterServerEvent('vsyncPawal:stopblackout')
AddEventHandler('vsyncPawal:stopblackout', function()
	ExecuteCommand('blackout')
	Wait(200)
	TriggerEvent('vSync:requestSync')
	TriggerClientEvent('mb_blackout:triggerblackout', -1)
	Wait(Config.DureeBlackout * 1000*60)
	ExecuteCommand('blackout')
	Wait(200)
	TriggerEvent('vSync:requestSync')
	TriggerEvent('pawal:serverstartsound2')
end)

RegisterServerEvent('pawal:sendlogs')
AddEventHandler('pawal:sendlogs', function()
	xPlayer = ESX.GetPlayerFromId(source)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	sendToDiscordWithSpecialURL(16711680, "``🔴`` Lancement Mission\n\n``👨‍🔧`` Nom : "..xPlayer.getName().."\n``🕚`` Date : " .. date.day .. "/" .. date.month .. "/" .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min ")
end)

RegisterServerEvent('pawal:serverstartsound')
AddEventHandler('pawal:serverstartsound', function()
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:startsound', playerId)
	end
end)

RegisterServerEvent('pawal:serverstartsound2')
AddEventHandler('pawal:serverstartsound2', function()
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:startsoundreturn', playerId)
	end
end)

RegisterServerEvent('changedoorsstatuts')
AddEventHandler('changedoorsstatuts', function(actif)
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('changedoorsstatusclient', playerId, actif)
	end
end)

RegisterServerEvent('pawal:lockinteractionstart')
AddEventHandler('pawal:lockinteractionstart', function(target)
	local xTarget = ESX.GetPlayerFromId(target)
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end
	identifierMissisonEnCours = xTarget.identifier
	lockstatut = true
	missionencours = true
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:lockmenu', playerId)
	end
end)

RegisterServerEvent('pawal:unlockinteractionstart')
AddEventHandler('pawal:unlockinteractionstart', function()
	lockstatut = false
	identifierMissisonEnCours = nil
	missionencours = false
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:unlockmenu', playerId)
	end
end)

RegisterServerEvent('pawal:lockinteraction')
AddEventHandler('pawal:lockinteraction', function()
	missionencours = false
	identifierMissisonEnCours = false
	lockstatut = true
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:lockmenu', playerId)
	end
	Citizen.Wait(Config.TempsLock*1000*60)
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:unlockmenu', playerId)
	end
end)

RegisterServerEvent('pawal:verifstatut')
AddEventHandler('pawal:verifstatut', function()
	if lockstatut == true then
		TriggerClientEvent('pawal:lockmenu', source)
	end
end)

AddEventHandler("playerDropped", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.identifier == identifierMissisonEnCours and missionencours == true then
		lockstatut = false
		TriggerServerEvent('pawal:unlockinteractionstart')
	end
end)

RegisterServerEvent('police:startalerte')
AddEventHandler('police:startalerte', function()
	for _, playerId in ipairs(GetPlayers()) do
		local xTarget = ESX.GetPlayerFromId(playerId)
		for k,v in pairs(Config.jobname) do
			if xTarget.job.name == v then
				TriggerClientEvent('police:alertefunction', playerId)
			end
		end
	end
end)

ESX.RegisterServerCallback("pawal:contratcallback", function(source, cb)
	xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

	if tonumber(money) >= Config.prixContrat then
		xPlayer.removeAccountMoney(Config.moneytype, Config.prixContrat)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('pawal:givemoneyforstopcontrat')
AddEventHandler('pawal:givemoneyforstopcontrat', function()
	xPlayer.addAccountMoney(Config.moneytype, Config.prixContrat / 2)
end)
