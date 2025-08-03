------------------------------------------------------------
--  Convert to lua for HappinessMP By LeChapellierFou     --
--                  03/08/2025                            --
--          Automatic barrier police station              --
--            Original script from Rockstar               --
--              Please Respect Credits                    --
------------------------------------------------------------

-- Important !
-- If the objects are broken, the script does not repair them.
-- Only episode 0 police car detected 
-- hash main object : 21350196 

local ObjectRot = 0.00000000
local WantedLoop = true
local SwitchLoop = 0
local ObjectBarrier1 = nil
local ObjectBarrier2 = nil
local ObjectMain = nil

local LoadModels = function(model)
    
    local hash
    if isNumber(model) then 
        hash = model
    else
        hash = Game.GetHashKey(model)
    end
    
    if(Game.IsModelInCdimage(hash)) then 
        Game.RequestModel(hash)
        Game.LoadAllObjectsNow()
        while not Game.HasModelLoaded(hash) do
            Game.RequestModel(hash)
            Thread.Pause(0)
        end

        return true
    else
        return false
    end
end

local function SwitchMod(iParam0)

    if (SwitchLoop ~= iParam0) then 
        SwitchLoop = iParam0
        Console.Log("Script Switch : "..SwitchLoop)
    end
end

local GetPlayerIndex = function()
    return Game.ConvertIntToPlayerindex(Game.GetPlayerId()) 
end

local GetPlayerPed = function()
    return Game.GetPlayerChar(Game.GetPlayerId())
end

local sub_1662 = function()
    
    if (not (Game.IsCharInjured( GetPlayerPed() ))) then 
        if (Game.IsCharInAnyCar( GetPlayerPed() )) then 
            
            local Veh = Game.GetCarCharIsUsing( GetPlayerPed());
            if ((not (Game.IsCarOnFire( Veh ))) and (Game.IsVehDriveable( Veh ))) then 
                
                local Driver = Game.GetDriverOfCar( Veh);
                if (not (Game.IsCarModel( Veh, 1491375716 ))) then 
                    if (Driver == GetPlayerPed()) then 
                        return true
                    end
                end
            end
        end
    end
    return false
end

local sub_1432 = function(ped)
    
    if (not (Game.IsCharInjured( ped ))) then 
        if (Game.IsCharInAnyCar( ped )) then 
            
            local Veh = Game.GetCarCharIsUsing(ped);
            if ((Game.IsCarModel( Veh, 562680400 )) or ((Game.IsCarModel( Veh, -283209848 )) or ((Game.IsCarModel( Veh, -1627000575 )) or ((Game.IsCarModel( Veh, -1900572838 )) or ((Game.IsCarModel( Veh, -350085182 )) or ((Game.IsCarModel( Veh, 2046537925 )) or ((Game.IsCarModel( Veh, 1911513875 )) or ((Game.IsCarModel( Veh, 148777611 )) or ((Game.IsCarModel( Veh, 1938952078 )) or ((Game.IsCarModel( Veh, 1127131465 )) or (Game.IsCarModel( Veh, 1171614426 )))))))))))) then 
                if (ped == GetPlayerPed()) then 
                    if (sub_1662()) then 
                        return true
                    end
                else
                    return true
                end
            end
        end
    end
    return false
end

local sub_1410 = function()
    if (WantedLoop) then 
        if (sub_1432( GetPlayerPed() )) then 
            return true
        end
    else
        return true
    end

    return false
end

local sub_2317 = function(obj)
    
    if(obj ~= nil) then 
        if (Game.DoesObjectExist( obj )) then 
            local HealthObj = Game.GetObjectHealth( obj);
            if (HealthObj < 1000.00000000) then 
                return true
            end

            local objx, objy, objz = Game.GetObjectCoordinates( obj);
            
            if (Game.IsClosestObjectOfTypeSmashedOrDamaged( objx, objy, objz, 5.00000000, -869586478, true, true )) then 
                return true
            end
            
            if (Game.IsClosestObjectOfTypeSmashedOrDamaged( objx, objy, objz, 5.00000000, -1046467484, true, true )) then 
                return true
            end
        else
            return true
        end
        return false
    end
end

local function getClosestObject(posX, posY, posZ, maxDistance)
    local closestObj = -1
    local smallestDistance = maxDistance
    
    local Objs = {}
    for i = 1, 100 do Objs[i] = 0 end
    local count = Game.GetAllObjects(Objs)

    for i = 1, count do
        if (Objs[i] ~= nil and Game.DoesObjectExist(Objs[i])) then
            local objX, objY, objZ = Game.GetObjectCoordinates(Objs[i])
            local distance = Game.GetDistanceBetweenCoords3d(posX, posY, posZ, objX, objY, objZ)

            if distance <= smallestDistance then
                smallestDistance = distance
                closestObj = Objs[i]
            end
        end
    end

    return closestObj
end

local function Manager()

    if(ObjectMain == nil) then 
        local obj = getClosestObject(-935.48070000, 1329.52700000, 23.33290000, 50)
        -- 2nd police station 65.0, 1235.0, 18.0
				
        if(obj ~= nil ) then 
            if(Game.DoesObjectExist(obj)) then 
                local model = Game.GetObjectModel(obj)
                
                if(model == 21350196) then 
                    ObjectMain = obj
                    Console.Log("Object Found")
                    SwitchMod( 0 );
                end
            end
        end
    end

    if(ObjectMain ~= nil) then  
        if (Game.DoesObjectExist( ObjectMain )) then 
            
            if (WantedLoop) then 
            
                if (Game.IsPlayerPlaying( GetPlayerIndex() )) then
                
                    if (not (Game.IsWantedLevelGreater( GetPlayerIndex(), 0 ))) then
                    
                        local objx, objy, objz = Game.GetObjectCoordinates( ObjectMain);
                        if (Game.LocateCharInCar3d( GetPlayerPed(), objx, objy, objz, 4.00000000, 4.00000000, 3.00000000, false )) then
                        
                            if ((Game.IsClosestObjectOfTypeSmashedOrDamaged( objx, objy, objz, 5.00000000, -1046467484, true, true )) or (Game.IsClosestObjectOfTypeSmashedOrDamaged( objx, objy, objz, 5.00000000, -869586478, true, true ))) then
                            
                                if (not sub_1410()) then
                                    Game.AlterWantedLevelNoDrop( GetPlayerIndex(), 1 );
                                    Game.ApplyWantedLevelChangeNow( GetPlayerIndex() );
                                end
                                WantedLoop = false
                            end
                        end
                    end
                end
            end

            if (not Game.WantedStarsAreFlashing()) then 
                WantedLoop = true
            end

            if (SwitchLoop == 0) then
                local HeadingObj = Game.GetObjectHeading(ObjectMain);
                local uVar1x, uVar1y, uVar1z = Game.GetOffsetFromObjectInWorldCoords( ObjectMain, 3.97000000, -0.10100000, 0.45800000);
                if(ObjectBarrier1 == nil) then 
                    if(LoadModels(-1046467484)) then 
                        local obj = Game.CreateObjectNoOffset( -1046467484, uVar1x, uVar1y, uVar1z, true );
                        ObjectBarrier1 = obj
                        Game.SetObjectDynamic( ObjectBarrier1, true );
                        Game.SetObjectRotation( ObjectBarrier1, 0.00000000, 0.00000000, HeadingObj );
                    end
                end
                
                local uVar2x, uVar2y, uVar2z = Game.GetOffsetFromObjectInWorldCoords( ObjectMain, -3.97000000, -0.17800000, 0.45800000);
                if(ObjectBarrier2 == nil) then 
                    if(LoadModels(-869586478)) then 
                        local obj = Game.CreateObjectNoOffset( -869586478, uVar2x, uVar2y, uVar2z, true );
                        ObjectBarrier2 = obj
                        Game.SetObjectDynamic( ObjectBarrier2, true );
                        Game.SetObjectRotation( ObjectBarrier2, 0.00000000, 0.00000000, HeadingObj );
                    end
                end
                
                SwitchMod( 2 );
            elseif (SwitchLoop == 2) then
                if (sub_1410()) then
                
                    if (not sub_2317( ObjectBarrier1 )) then
                    
                        local uVar2x, uVar2y, uVar2z = Game.GetOffsetFromObjectInWorldCoords( ObjectMain, 3.97000000, -0.10100000, 0.45800000);
                        Game.SetObjectCoordinates( ObjectBarrier1, uVar2x, uVar2y, uVar2z );
                    end

                    if (not sub_2317( ObjectBarrier2 )) then
                    
                        local uVar2x, uVar2y, uVar2z = Game.GetOffsetFromObjectInWorldCoords( ObjectMain, -3.97000000, -0.17800000, 0.45800000);
                        Game.SetObjectCoordinates( ObjectBarrier2, uVar2x, uVar2y, uVar2z );
                    end

                    local uVar2x, uVar2y, uVar2z = Game.GetOffsetFromObjectInWorldCoords( ObjectMain, 0.00000000, -4.00000000, 0.00000000);
                    if (Game.IsPlayerPlaying( GetPlayerIndex() )) then
                    
                        if (Game.LocateCharInCar3d( GetPlayerPed(), uVar2x, uVar2y, uVar2z, 4.00000000, 4.00000000, 3.00000000, false )) then
                        
                            local Veh = Game.GetCarCharIsUsing( GetPlayerPed());
                            local SpeedV = Game.GetCarSpeed(Veh);
                            if (SpeedV < 5.00000000) then
                                SwitchMod( 3 );
                            end
                        end
                    end
                    
                    local uVar2x, uVar2y, uVar2z = Game.GetOffsetFromObjectInWorldCoords( ObjectMain, 0.00000000, 4.00000000, 0.00000000);
                    if (Game.IsPlayerPlaying( GetPlayerIndex() )) then
                    
                        if (Game.LocateCharInCar3d( GetPlayerPed(), uVar2x, uVar2y, uVar2z, 4.00000000, 4.00000000, 3.00000000, false )) then
                        
                            local Veh = Game.GetCarCharIsUsing( GetPlayerPed());
                            local SpeedV = Game.GetCarSpeed(Veh);
                            if (SpeedV < 5.00000000) then
                            
                                SwitchMod( 3 );
                            end
                        end
                    end
                end
            elseif (SwitchLoop == 3) then
                local FrameTime = Game.GetFrameTime();
                ObjectRot = ObjectRot + (84.00000000 / 5.00000000) * FrameTime;
                local HeadingObj = Game.GetObjectHeading(ObjectMain);
                
                if (not (sub_2317( ObjectBarrier2 ))) then
                    Game.SetObjectRotation( ObjectBarrier2, 0.00000000, ObjectRot * -1.00000000, HeadingObj );
                end
                
                if (not (sub_2317( ObjectBarrier1 ))) then
                    Game.SetObjectRotation( ObjectBarrier1, 0.00000000, ObjectRot, HeadingObj );
                end
                
                if (ObjectRot > 84.00000000) then
                    SwitchMod( 4 );
                end
            elseif (SwitchLoop == 4) then
                if (Game.IsPlayerPlaying( GetPlayerIndex() )) then
                    local uVar2x, uVar2y, uVar2z = Game.GetObjectCoordinates( ObjectMain);
                    if (not (Game.LocateCharInCar3d( GetPlayerPed(), uVar2x, uVar2y, uVar2z, 8.00000000, 8.00000000, 3.00000000, false ))) then 
                        SwitchMod( 5 );
                    end
                end
            elseif (SwitchLoop == 5) then
                local FrameTime = Game.GetFrameTime();
                ObjectRot = ObjectRot - (84.00000000 / 5.00000000) * FrameTime;
                local HeadingObj = Game.GetObjectHeading(ObjectMain);
                
                if (not (sub_2317( ObjectBarrier2 ))) then
                    Game.SetObjectRotation( ObjectBarrier2, 0.00000000, ObjectRot * -1.00000000, HeadingObj );
                end
                
                if (not (sub_2317( ObjectBarrier1 ))) then
                    Game.SetObjectRotation( ObjectBarrier1, 0.00000000, ObjectRot, HeadingObj );
                end
                
                if (ObjectRot <= 0.00000000) then
                    SwitchMod( 2 );
                end
            end
        end
    end
end

Events.Subscribe("scriptInit", function()
    
    Thread.Create(function()
       
        while true do   
            Thread.Pause(0) 
            Manager() 
        end
    end)

end)
