ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)
  end
end)


Config = {
    Rewards = {
      "bread",
      "water",
      "battery",
      "bread",
      "water",
      "phone",
      "smartwatch",
      "bread",
      "water",
      "bread",
      "water",
      "rusty_tools",
      "bread",
      "water",
      "bread",
      "water",
      "hammerwirecutter",
      "screwdriver",
      "bread",
      "water",
      "bread",
      "water",
      "emptywinebottle",
      "clothe",
      "bag",
      "bread",
      "water",
      "boosterpack"

    }
  }
  
  ESX.RegisterUsableItem("rubber_gloves", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    if xPlayer.getInventoryItem("rubber_gloves").count > 0 then
      TriggerClientEvent("vehicle:search", source)
    else
      TriggerClientEvent("esx:showNotification", source, "You do not have any rubber gloves.")
    end
  end)
  
  RegisterNetEvent("vehicle:searcher")
  AddEventHandler("vehicle:searcher", function()
    local xPlayer = ESX.GetPlayerFromId(source)
  
    -- Generate a random reward and give it to the player
    local rewardIndex = math.random(1, #Config.Rewards)
    local reward = Config.Rewards[rewardIndex]
  
    xPlayer.addInventoryItem(reward, 1)
    xPlayer.removeInventoryItem("rubber_gloves",1)
  
    TriggerClientEvent("vehicle:search:success", source, reward)
  end)