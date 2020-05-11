local menu = false

RegisterNetEvent("VehicleInteraction:Option")
AddEventHandler("VehicleInteraction:Option", function(option, coords, distanceAmount, cb)
	cb(Menu.Option(option, coords, distanceAmount))
end)

RegisterNetEvent("VehicleInteraction:Update")
AddEventHandler("VehicleInteraction:Update", function()
	Menu.updateSelection()
end)

function GetVehicleInDirectionSphere(coordFrom, coordTo)
    local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 2.0, 10, GetPlayerPed(-1), 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

RegisterNetEvent("VehicleInteractionGetBool:Option")
AddEventHandler("VehicleInteractionGetBool:Option", function(option)
	if option == true then
		menu = true
	else
		menu = false
	end
end)

RegisterNetEvent("VehicleInteraction:UpdateOption")
AddEventHandler("VehicleInteraction:UpdateOption", function()
    Menu.UpdateOption() 
end)

Citizen.CreateThread(function()
	
    while true do
        if IsControlJustPressed(0, 46) then
            menu = true
        elseif IsControlJustReleased(0, 46) then
            TriggerEvent('VehicleInteraction:UpdateOption')
            menu = false
        end
    

		if(menu) then
			local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
			local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
			local vehicle = GetVehicleInDirectionSphere(coordA, coordB)
			local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
			local Hoodpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "neon_f"))
			local distanceToHood = GetDistanceBetweenCoords(Hoodpos, playerpos, 1)
			local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "neon_b"))
			local distanceToTrunk = GetDistanceBetweenCoords(trunkpos, playerpos, 1)
			local leftpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "neon_l"))
			local distanceToLeft = GetDistanceBetweenCoords(leftpos, playerpos, 1)
			local rightpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "neon_r"))
			local distanceToRight = GetDistanceBetweenCoords(rightpos, playerpos, 1)

			if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
				if distanceToTrunk <= 1.5 then
					if GetVehicleDoorAngleRatio(vehicle, 5) <= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Open Trunk", {trunkpos.x, trunkpos.y, trunkpos.z + 0.3}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorOpen(vehicle, 5, false, false)
							else
							end
						end)
					elseif GetVehicleDoorAngleRatio(vehicle, 5) >= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Close Trunk", {trunkpos.x, trunkpos.y, trunkpos.z + 0.3}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorShut(vehicle, 5, false)
							else
							end
						end)
					end
				elseif distanceToHood <= 1.5 then
					if GetVehicleDoorAngleRatio(vehicle, 4) <= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Open Hood", {Hoodpos.x, Hoodpos.y, Hoodpos.z + 0.3}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorOpen(vehicle, 4, false, false)
							else
							end
						end)
					elseif GetVehicleDoorAngleRatio(vehicle, 4) >= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Close Hood", {Hoodpos.x, Hoodpos.y, Hoodpos.z + 0.3}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorShut(vehicle, 4, false)
							else	
							end
						end)
					end
				elseif distanceToLeft <= 1.5 then
                    if GetVehicleDoorAngleRatio(vehicle, 0) <= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Open Driver door", {leftpos.x, leftpos.y, leftpos.z + 0.22}, 1.5, function(cb)
                            if(cb) then
								SetVehicleDoorOpen(vehicle, 0, false, false)
                            else
							end
						end)
                    elseif GetVehicleDoorAngleRatio(vehicle, 0) >= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Close Driver door", {leftpos.x, leftpos.y, leftpos.z + 0.22}, 1.5, function(cb)
                            if(cb) then
								SetVehicleDoorShut(vehicle, 0, false)
							else
							end
						end)
                    end
                    
                    if GetVehicleDoorAngleRatio(vehicle, 2) <= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Open Rear door", {leftpos.x, leftpos.y, leftpos.z}, 1.5, function(cb)
                            if(cb) then
								SetVehicleDoorOpen(vehicle, 2, false, false)
                            else
							end
						end)
                    elseif GetVehicleDoorAngleRatio(vehicle, 2) >= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Close Rear door", {leftpos.x, leftpos.y, leftpos.z }, 1.5, function(cb)
                            if(cb) then
								SetVehicleDoorShut(vehicle, 2, false)
							else
							end
						end)
					end
				elseif distanceToRight <= 1.5 then
					if GetVehicleDoorAngleRatio(vehicle, 1) <= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Open Passenger door", {rightpos.x, rightpos.y, leftpos.z + 0.22}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorOpen(vehicle, 1, false, false)
							else
							end
						end)
					elseif GetVehicleDoorAngleRatio(vehicle, 1) >= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Close Passenger door", {rightpos.x, rightpos.y, rightpos.z + 0.22}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorShut(vehicle, 1, false)
							else
							end
						end)
                    end
                    
                    if GetVehicleDoorAngleRatio(vehicle, 3) <= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Open Rear door", {rightpos.x, rightpos.y, rightpos.z}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorOpen(vehicle, 3, false, false)
							else
							end
						end)
					elseif GetVehicleDoorAngleRatio(vehicle, 3) >= 0.1 then
						TriggerEvent("VehicleInteraction:Option", "Close Rear door", {rightpos.x, rightpos.y, rightpos.z}, 1.5, function(cb)
							if(cb) then
								SetVehicleDoorShut(vehicle, 3, false)
							else
							end
						end)
					end
				end
			end
			TriggerEvent("VehicleInteraction:Update")
		end
		Wait(10)
	end
end)
