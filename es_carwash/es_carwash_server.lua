--Settings--

enableprice = true -- true = carwash is paid, false = carwash is free

price = 100 -- you may edit this to your liking. if "enableprice = false" ignore this one

--DO-NOT-EDIT-BELLOW-THIS-LINE--

RegisterServerEvent('carwash:checkmoney')
AddEventHandler('carwash:checkmoney', function ()
	TriggerEvent('es:getPlayerFromId', source, function (user)
		if enableprice == true then
			userMoney = user.getMoney()
			if userMoney >= price then
				user.removeMoney(price)
				TriggerClientEvent('carwash:success', source, price)
			else
				moneyleft = price - userMoney
				TriggerClientEvent('carwash:notenoughmoney', source, moneyleft)
			end
		else
			TriggerClientEvent('carwash:free', source)
		end
	end)
end)