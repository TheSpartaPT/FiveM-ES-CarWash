--DO-NOT-EDIT-BELLOW-THIS-LINE--

Key = 201 -- ENTER

vehicleWashStation = {
	{26.5906,  -1392.0261,  27.3634},
	{167.1034,  -1719.4704,  27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-699.6325,  -932.7043,  17.0139}
}


Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

function es_carwash_DrawSubtitleTimed(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function es_carwash_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function ()
	hasShownNotification = {}
	for i = 1, #vehicleWashStation do
		hasShownNotification[i] = false
	end
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					--es_carwash_DrawSubtitleTimed("Press [~g~ENTER~s~] to wash your vehicle!")
					if not hasShownNotification[i] then
						TriggerEvent("pNotify:SendNotification",{
							text = "<font color=lightblue>Car Wash</font>:<br /> Welcome!<br />Press <font color=lightgreen>ENTER</font> to wash your car.",
							type = "error",
							timeout = (7000),
							layout = "centerLeft",
							queue = "global"
						})
						hasShownNotification[i] = true
					end
					if IsControlJustPressed(1, Key) then
						TriggerServerEvent('es_carwash:checkmoney')
					end
				else
					hasShownNotification[i] = false
				end
			end
		end
	end
end)

RegisterNetEvent('es_carwash:success')
AddEventHandler('es_carwash:success', function (price)
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	-- es_carwash_DrawNotification("Your vehicle was ~y~cleaned~s~! ~g~-$" .. price .. "~s~!")
	TriggerEvent("pNotify:SendNotification",{
            text = "<font color=lightblue>Car Wash</font>:<br /> We cleaner 'er up for ya!<br />That'll be $<font color=lightgreen>" .. price .. ".00</font> please.",
            type = "error",
            timeout = (7000),
            layout = "centerLeft",
            queue = "global"
        })
end)

RegisterNetEvent('es_carwash:notenoughmoney')
AddEventHandler('es_carwash:notenoughmoney', function (moneyleft)
	--es_carwash_DrawNotification("~h~~r~You don't have enough money! $" .. moneyleft .. " left!")
	TriggerEvent("pNotify:SendNotification",{
            text = "<font color=lightblue>Car Wash</font>:<br /> You can't afford our prices, get out of here!",
            type = "error",
            timeout = (7000),
            layout = "centerLeft",
            queue = "global"
        })
end)

RegisterNetEvent('es_carwash:free')
AddEventHandler('es_carwash:free', function ()
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	--es_carwash_DrawNotification("Your vehicle was ~y~cleaned~s~ for free!")
	TriggerEvent("pNotify:SendNotification",{
            text = "<font color=lightblue>Car Wash</font>:<br />Every once in a while, we help out a charity case.<br />Enjoy!",
            type = "error",
            timeout = (7000),
            layout = "centerLeft",
            queue = "global"
        })
end)
