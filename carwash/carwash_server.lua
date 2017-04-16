RegisterServerEvent('carwash:checkmoney')

AddEventHandler('carwash:checkmoney', function(price)
	TriggerEvent('es:getPlayerFromId', source, function(player)
		if(tonumber(player:money) >= tonumber(price)) then
			player:removeMoney((price))
			TriggerClientEvent('carwash:success', source, price)
		else
			moneyleft = price - player:money
			TriggerClientEvent('carwash:notenoughmoney', source, moneyleft)
		end
	end)
end)