local ConfigFBlock = {
    ["Jungle Redzone"] = {
        location = { x =459.3, y =-1528.99, z =29.23},
        diameter = (22 * 3.25),
        visabilitydistance = 1000.0,
        color = {r = 136, g = 37, b = 202, a = 100},
        restrictions = {
            showinfo = true,
        },
        customrestrictions = {
            enabled = true,
            loop = false,
            run = function(zone)
            end, 
            stop = function(zone)
            end, 
        },
    },
  }
  local ped = PlayerPedId()
  p = print 
  p("Prosper ReMade this")
  ---Do not touch These
  local inside_zone = false
  local greenzones = ConfigFBlock
  local function ShowInfo(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, false)
  end
  local function ShowFBlockInfo()
    local x = 0.95
    local y = 0.505
    local width = 1.0
    local height = 1.0
    local scale = 0.50
      local text = "~p~You are in the ~p~Dior ~p~Redzone~w~ (It's Kill On Sight)"
      ped = PlayerPedId()
      GiveWeaponToPed(PlayerPedId(), "WEAPON_COMBATPISTOL", 9999, false, true)
      SetTextCentre(true)
      SetTextFont(6)
      SetTextProportional(0)
      SetTextScale(scale, scale)
      SetTextColour(255, 0, 0, 255)
      SetTextDropShadow(0, 0, 0, 0,255)
      SetTextEdge(2, 0, 0, 0, 255)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry("STRING")
      AddTextComponentString(text)
      DrawText(x - width/2, y - height/2 + 0.005)
  end
  Citizen.CreateThread(function()
    while true do
      local playerPed = PlayerPedId()
      local plyCoords = GetEntityCoords(playerPed, false)
      for k, v in pairs(greenzones) do
        local location = vector3(v.location.x, v.location.y, v.location.z)
        if #(plyCoords - location) < (v.diameter) - (v.diameter / 150) then
          if (not inside_zone) then
            local temp_append = ""
            --ShowInfo("You are ~r~not allowed~w~ to do any ~r~violent~w~ or ~r~illegal~w~ roleplay in this area.")
            inside_zone = true
            if (v.customrestrictions.enabled and v.customrestrictions.loop == false) then
              ConfigFBlock[k].customrestrictions.run(v)
            end
          end
          if (v.restrictions.showinfo) then
              ShowFBlockInfo(k)
          end
          if (v.customrestrictions.enabled and v.customrestrictions.loop == true) then
            ConfigFBlock[k].customrestrictions.run(v)
          end
        elseif (inside_zone) then
          TriggerEvent('esx:showNotification', 'Get back inZone And Shit On These Kids')
          RemoveWeaponFromPed(PlayerPedId(), "WEAPON_COMBATPISTOL")
          -- SetEntityCoords(ped, 399.62, -1574.1, 29.34, false)
          -- TriggerEvent('esx_ambulancejob:BlixyXProsperDevhatesmoddersrevive1209')
          SetEntityCanBeDamaged(playerPed, true)
          SetEntityMaxSpeed(GetVehiclePedIsIn(playerPed, false), 99999.9)
          ConfigFBlock[k].customrestrictions.stop(v)
          inside_zone = false
        end
      end
      Citizen.Wait(5)
    end
  end)
  Citizen.CreateThread(function()
    while true do
      local playerPed = PlayerPedId()
      local plyCoords = GetEntityCoords(playerPed, false)
      for k, v in pairs(greenzones) do
        local location = vector3(v.location.x, v.location.y, v.location.z)
        if #(plyCoords - location) < (v.diameter) - (v.diameter / 150) then
          DrawMarker(28, v.location.x, v.location.y, v.location.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, 150, 0, 0, 0, 0)
        elseif (#(plyCoords - location) < (v.diameter) - (v.diameter / 150) + v.visabilitydistance) then
          DrawMarker(28, v.location.x, v.location.y, v.location.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, v.color.a, 0, 0, 0, 0)
        end
      end
      Citizen.Wait(5)
    end
  end)