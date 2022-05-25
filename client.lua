IsEngineOn = true
autolock = false
autolockVeh = nil

RegisterCommand("eng", function(source, args, raw)
    local player = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(player) then 
		local vehicle = GetVehiclePedIsIn(player,false)
		if IsEngineOn then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
		end
		while not IsEngineOn do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end)
TriggerEvent("chat:addSuggestion", "/eng", "Quickly toggle the engine in your current vehicle.")

RegisterCommand("engine", function(source, args, raw)
    local player = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(player) then 
		local vehicle = GetVehiclePedIsIn(player,false)
		if IsEngineOn then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
		end
		while not IsEngineOn do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end)
TriggerEvent("chat:addSuggestion", "/engine", "Quickly toggle the engine in your current vehicle.")
RegisterKeyMapping('engine', 'Toggle engine on or off', 'keyboard', '')

RegisterCommand("trunk", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5
    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ShowNotification( "~g~Success. ~w~Trunk closed." )
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ShowNotification( "~g~Success. ~w~Trunk opened." )
        end
    else
        if distanceToVeh < 10 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ShowNotification( "~g~Success. ~w~Trunk closed." )
        	else	
            	SetVehicleDoorOpen(vehLast, door, false, false)
            	ShowNotification( "~g~Success. ~w~Trunk opened." )
            end
        else
            ShowNotification("~r~You must be near your vehicle to do that.")
        end
    end
end)
TriggerEvent("chat:addSuggestion", "/trunk", "Quickly toggle the trunk in your current vehicle.")

RegisterCommand("hood", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4
    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ShowNotification( "~g~Success. ~w~Hood closed." )
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ShowNotification( "~g~Success. ~w~Hood opened." )
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ShowNotification( "~g~Success. ~w~Hood closed." )
        	else	
            	SetVehicleDoorOpen(vehLast, door, false, false)
            	ShowNotification( "~g~Success. ~w~Hood opened." )
        	end
        else
            ShowNotification("~r~You must be near your vehicle to do that.")
        end
    end
end)
TriggerEvent("chat:addSuggestion", "/hood", "Quickly toggle the hood in your current vehicle.")

RegisterCommand("door", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    if args[1] == "1" then
        door = 0
    elseif args[1] == "2" then
        door = 1
    elseif args[1] == "3" then
        door = 2
    elseif args[1] == "4" then
        door = 3
    else
        door = nil
        ShowInfo("Usage: ~n~~b~/door [door]")
        ShowInfo("~y~Possible doors:")
        ShowInfo("1 (Front Left Door), 2 (Front Right Door)")
        ShowInfo("3 (Back Left Door), 4 (Back Right Door)")
    end
    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                ShowNotification( "~g~Success. ~w~Door closed." )
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                ShowNotification( "~g~Success. ~w~Door opened." )
            end
        else
            if distanceToVeh < 8 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    ShowNotification( "~g~Success. ~w~Door closed." )
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    ShowNotification( "~g~Success. ~w~Door opened." )
                end
            else
                ShowNotification("~r~You must be near your vehicle to do that.")
            end
        end
    end
end)
TriggerEvent("chat:addSuggestion", "/door", "Quickly toggle a door of your current vehicle.")

local frontwindowup = true
RegisterCommand("frontwindows", function(source, args, raw)
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if GetPedInVehicleSeat(playerCar, -1) == playerPed then 
            SetEntityAsMissionEntity(playerCar, true, true)
			if frontwindowup then
				RollDownWindow(playerCar, 0)
				RollDownWindow(playerCar, 1)
				ShowNotification("~g~Success. ~w~You rolled down your front windows.")
				frontwindowup = false
			else
				RollUpWindow(playerCar, 0)
				RollUpWindow(playerCar, 1)
				ShowNotification("~g~Success. ~w~You rolled up your front windows.")
				frontwindowup = true
			end
		end
	end
end, false)
TriggerEvent("chat:addSuggestion", "/frontwindows", "Quickly toggle the front windows up or down in your current vehicle.")
RegisterKeyMapping('frontwindows', 'Toggle the front windows', 'keyboard', '')

local rearwindowup = true
RegisterCommand("rearwindows", function(source, args, raw)
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if GetPedInVehicleSeat( playerCar, -1 ) == playerPed then 
            SetEntityAsMissionEntity(playerCar, true, true)
			if rearwindowup then
				RollDownWindow(playerCar, 2)
				RollDownWindow(playerCar, 3)
				ShowNotification("~g~Success. ~w~You rolled down your rear windows.")
				rearwindowup = false
			else
				RollUpWindow(playerCar, 2)
				RollUpWindow(playerCar, 3)
				ShowNotification("~g~Success. ~w~You rolled up your rear windows.")
				rearwindowup = true
			end
		end
	end
end, false)
TriggerEvent("chat:addSuggestion", "/rearwindows", "Quickly toggle the rear windows up or down in your current vehicle.")
RegisterKeyMapping('rearwindows', 'Toggle the rear windows', 'keyboard', '')

RegisterCommand("dv", function()
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(ped) and not IsEntityDead(ped) then 
        local pos = GetEntityCoords(ped)
        if IsPedSittingInAnyVehicle(ped) then 
            local vehicle = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(vehicle, -1) == ped then 
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
                if DoesEntityExist(vehicle) then 
                	ShowNotification("~r~Unable to delete vehicle, try again.")
                else 
                	ShowNotification("~g~Success. ~w~Vehicle successfully deleted.")
                end 
            else 
                ShowNotification("~r~You must be in the driver's seat.")
            end 
        else
            local ply = GetPlayerPed(-1)
            local plyCoords = GetEntityCoords(ply, 0)
            local entityWorld = GetOffsetFromEntityInWorldCoords(ply, 0.0, 10.0, 0.0)
            local rayHandle = CastRayPointToPoint(plyCoords["x"], plyCoords["y"], plyCoords["z"], entityWorld.x, entityWorld.y, entityWorld.z, 2, ply, 0)
            local a, b, c, d, targetVehicle = GetRaycastResult(rayHandle)
            if targetVehicle ~= nil then
                if DoesEntityExist(targetVehicle) then 
                    print("Found closest vehicle of hash: " .. targetVehicle .. ", deleting.")
                    SetEntityAsMissionEntity(targetVehicle, true, true)
                    deleteCar(targetVehicle)
                    if DoesEntityExist(targetVehicle) then 
                        ShowNotification("~r~Unable to delete vehicle, try again.")
                    else 
                        ShowNotification("~g~Success. ~w~Vehicle successfully deleted.")
                    end 
                else 
                    print("Error finding closest vehicle, unable to delete.")
                    ShowNotification("~r~You must be in or near a vehicle to delete it.")
                end 
            end 
        end 
    end 
end, false )
TriggerEvent("chat:addSuggestion", "/dv", "Delete the vehicle you are currently facing or inside.")

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

RegisterCommand('extra', function(source, args, rawCommand)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local extraID = tonumber(args[1])
    local isExtraEnabled = IsVehicleExtraTurnedOn(veh, extraID)
    if veh ~= nil then
        if DoesExtraExist(veh, extraID) then
            if isExtraEnabled == false then
                SetVehicleAutoRepairDisabled(veh, false)
                SetVehicleExtra(veh, extraID, 0)
                ShowNotification("Vehicle extra ~b~" .. extraID .. " ~w~has been ~g~enabled.")
            elseif isExtraEnabled == 1 then
                SetVehicleAutoRepairDisabled(veh, false)
                SetVehicleExtra(veh, extraID, 1)
                ShowNotification("Vehicle extra ~b~" .. extraID .. " ~w~has been ~r~disabled.")
            end
        else
            ShowNotification("~r~That extra does not exist on this vehicle.")
        end
    end
end, false)
TriggerEvent("chat:addSuggestion", "/extra", "Quickly toggle an extra in your current vehicle.")

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterCommand("anchor", function()
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)
    if IsPedInAnyBoat(plyPed) then
        local boat = GetVehiclePedIsIn(plyPed, false)
        if GetEntitySpeed(boat) >= 5 then
            ShowNotification('~d~Anchor: ~w~You are going too fast to drop the anchor.')
            return
        end
        if IsBoatAnchoredAndFrozen(boat) then
            SetBoatAnchor(boat, false)
            SetBoatFrozenWhenAnchored(boat, false)
            ShowNotification('~d~Anchor: ~w~Disabled boat anchor.')  
        else
            SetBoatAnchor(boat, true)
            SetBoatFrozenWhenAnchored(boat, true)
            ShowNotification('~d~Anchor: ~w~Enabled boat anchor.')  
        end
    else
        ShowNotification('~d~Anchor: ~w~You are not in a boat.')
    end
end, false)
TriggerEvent("chat:addSuggestion", "/anchor", "Toggle the boat anchor.")

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

RegisterCommand("shuffleseat", function(_, args)
    local seatIndex = table.unpack(args)
    seatIndex = tonumber(seatIndex)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local doors = GetNumberOfVehicleDoors(veh)
    if seatIndex < 1 or seatIndex >= doors + 1 then
        ShowNotification("~y~Shuffle Seats~w~: " .. (seatIndex) .. "~w~ is not a valid seat number to shuffle to.")
    else
        if veh ~= nil and veh > 0 then
            if IsVehicleSeatFree(veh, seatIndex - 2) then
                CreateThread(function()
                    SetPedIntoVehicle(PlayerPedId(), veh, seatIndex - 2)
                    ShowNotification("~y~Shuffle Seats~w~: Shuffled into Seat " .. (seatIndex) .. ".")
                    Wait(50)
                end)
            else
                ShowNotification("~y~Shuffle Seats~w~: Seat " .. (seatIndex) .. " already has someone sat in it.")
            end
        end
    end
end)
TriggerEvent("chat:addSuggestion", "/shuffleseat", "Shuffle to another specified seat within your vehicle.")

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("shuff", function(source, args, raw)
    TriggerEvent("SeatShuffle")
end, false)
TriggerEvent("chat:addSuggestion", "/shuff", "Shuffle seats into the drivers seat from the passenger seat.")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(PlayerId())
        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(autolockVeh), 1)
        local vehLockStat = GetVehicleDoorLockStatus(autolockVeh)
        local veh = GetVehiclePedIsIn(ped, false)
        local VehStopped = IsVehicleStopped(veh)
        DisablePlayerVehicleRewards(PlayerId())
        if autolock and GetLastPedInVehicleSeat(autolockVeh, -1) == ped and GetVehicleDoorAngleRatio(autolockVeh, 0) <= 0 and GetVehicleDoorAngleRatio(autolockVeh, 1) <= 0 then
            if distanceToVeh <= 5 then
                if vehLockStat == 2 then
                    SetVehicleDoorsLocked(autolockVeh, 0)
                    SetVehicleDoorsLockedForAllPlayers(autolockVeh, false)
                    PlaySoundFromEntity(-1, "Remote_Control_Fob", ped, "PI_Menu_Sounds", 0, 0)
                    StartVehicleHorn(autolockVeh, 500, 0, false)
                    SetVehicleIndicatorLights(autolockVeh, 0, true)
                    SetVehicleIndicatorLights(autolockVeh, 1, true)
                    ShowNotification("~y~[Autolock]:~w~ Your vehicle has been ~g~unlocked~w~.")
                    Citizen.Wait(750)
                    SetVehicleIndicatorLights(autolockVeh, 0, false)
                    SetVehicleIndicatorLights(autolockVeh, 1, false)
                end
            else
                if vehLockStat == 1 or vehLockStat == 0 then
                    SetVehicleDoorsLocked(autolockVeh, 2)
                    SetVehicleDoorsLockedForAllPlayers(autolockVeh, true)
                    PlaySoundFromEntity(-1, "Remote_Control_Fob", ped, "PI_Menu_Sounds", 0, 0)
                    StartVehicleHorn(autolockVeh, 500, 0, false)
                    SetVehicleIndicatorLights(autolockVeh, 0, true)
                    SetVehicleIndicatorLights(autolockVeh, 1, true)
                    ShowNotification("~y~[Autolock]:~w~ Your vehicle has been ~r~locked~w~.")
                    Citizen.Wait(750)
                    SetVehicleIndicatorLights(autolockVeh, 0, false)
                    SetVehicleIndicatorLights(autolockVeh, 1, false)
                end
            end
        end
        if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and VehStopped then
            Citizen.Wait(150)
            if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and VehStopped then
                SetVehicleEngineOn(veh, true, true, false)
                TaskLeaveVehicle(ped, veh, 256)
            end
        end
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleClass(veh) == 18 then
                if IsToggleModOn(veh, 18) then
                    ShowNotification("~r~Turbo modifications are not allowed on Emergency Vehicles.")
                    ToggleVehicleMod(veh, 18, false)
                end
                if GetVehicleMod(veh, 11) ~= -1 then
                    ShowNotification("~r~Engine modifications are not allowed on Emergency Vehicles.")
                    SetVehicleMod(veh, 11, -1, false)
                end
                if GetVehicleMod(veh, 12) ~= -1 then
                    ShowNotification("~r~Brake modifications are not allowed on Emergency Vehicles.")
                    SetVehicleMod(veh, 12, -1, false)
                end
                if GetVehicleMod(veh, 13) ~= -1 then
                    ShowNotification("~r~Transmission modifications are not allowed on Emergency Vehicles.")
                    SetVehicleMod(veh, 13, -1, false)
                end
                if GetVehicleMod(veh, 15) ~= -1 then
                    ShowNotification("~r~Suspension modifications are not allowed on Emergency Vehicles.")
                    SetVehicleMod(veh, 15, -1, false)
                end
            elseif GetVehicleClass(veh) == 4 then
                local wheelieState = GetVehicleWheelieState(veh)
                if wheelieState == 65 then
                    SetVehicleWheelieState(veh, 1)
                elseif wheelieState == 129 then
                    SetVehicleWheelieState(veh, 1)
                end
            end
        end
    end
end)

RegisterCommand("autolock", function(source, args, raw)
    autolock = not autolock
    if autolock == true then
        local ped = GetPlayerPed(PlayerId())
        autolockVeh = GetVehiclePedIsIn(ped, true)
        if autolockVeh ~= nil then
            ShowNotification("~y~[Autolock]:~w~ Vehicle autolock has been ~g~enabled~w~.")
        else
            ShowNotification("~y~[Autolock]:~r~ Autolock failed to enable, you must be in a vehicle.")
        end
    elseif autolock == false then
        SetVehicleDoorsLocked(autolockVeh, 0)
        SetVehicleDoorsLockedForAllPlayers(autolockVeh, false)
        autolockVeh = nil
        ShowNotification("~y~[Autolock]:~w~ Vehicle autolock has been ~r~disabled~w~.")
    end
    return autolock, autolockVeh
end, false)
TriggerEvent("chat:addSuggestion", "/autolock", "Toggles automatic locking of your last vehicle.")

AddEventHandler('playerDropped', function(source)
    local currentveh = GetVehiclePedIsIn(ped, false)
    local lastveh = GetVehiclePedIsIn(ped, true)
    if DoesEntityExist(currentveh) or DoesEntityExist(lastveh) then 
        SetEntityAsMissionEntity(currentveh, true, true)
        SetEntityAsMissionEntity(lastveh, true, true)
        deleteCar(currentveh)
        deleteCar(lastveh)
    end
end)

local onroof = false
RegisterCommand("vehflip", function(source)
    local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
    local coords = GetEntityCoords(ped)
    if not onroof then
        SetPedCoordsKeepVehicle(ped, coords+1.0)
        SetEntityRotation(vehicle, 180.0, 0.0, 0.0, 0, true)
        ShowNotification("~b~[Vehicle Flip]~w~: Vehicle flipped onto its ~y~roof~w~.")
        onroof = true
    elseif onroof then
        SetEntityRotation(vehicle, 0.0, 0.0, 0.0, 0, true)
        ShowNotification("~b~[Vehicle Flip]~w~: Vehicle flipped back onto its ~b~wheels~w~.")
        onroof = false
    end
end, false)
TriggerEvent("chat:addSuggestion", "/vehflip", "Flip your current vehicle on its roof and back.")