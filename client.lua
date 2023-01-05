ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)
  end
end)
    

local searched_vehicles = {}

RegisterNetEvent("vehicle:search")
AddEventHandler("vehicle:search", function()
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local plate = GetVehicleNumberPlateText(vehicle)

    local hasSearched = false
    for i, searchedPlate in pairs(searched_vehicles) do
      if searchedPlate == plate then
        hasSearched = true
        break
      end
    end

    if not hasSearched then
      table.insert(searched_vehicles, plate)

      -- Load the "veh@handler"  anim libraries
      RequestAnimDict("veh@handler@base")

      -- Play the "hotwire" animation from the anim libraries
      TaskPlayAnim(playerPed, 'veh@handler@base', 'hotwire', 8.0, 8.0, -1, 0, 0, 0, 0, 0)


      -- Set off the car alarm
      SetVehicleAlarm(vehicle, true)
      StartVehicleAlarm(vehicle)

      -- Start the minigame
      exports["mf-inventory"]:startMinigame(3,1,function(res)
        TaskPlayAnim(playerPed, 'veh@handler@base', 'hotwire', 8.0, 8.0, -1, 0, 0, 0, 0, 0)
        
        -- Callback function for the minigame
        if res then
            TriggerServerEvent('vehicle:searcher')
          -- Minigame was successful
          TriggerEvent("esx:showNotification", "You found something in the glovebox!")
          ClearPedTasks(playerPed)
        else
          -- Minigame was unsuccessful
          TriggerEvent("esx:showNotification", "You were unable to search the vehicle.")
          ClearPedTasks(playerPed)
        end
      end)
    else
      TriggerEvent("esx:showNotification", "You have already searched this vehicle.")
    end
  else
    TriggerEvent("esx:showNotification", "You are not in a vehicle.")
  end
end)