-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 32704 characters

local ScriptFunctions = {
function(script,require)
local isOn = true

function on()
 isOn = true
 script.Parent.Transparency = 0
 script.Parent.CanCollide = true
end

function off()
 isOn = false
 script.Parent.Transparency = 1
 script.Parent.CanCollide = false
end

function onClicked()

 if isOn == true then off() else on() end

end

script.Parent.ClickDetector.MouseClick:connect(onClicked)

on()
end,
function(script,require)
local UserInputService = game:GetService("UserInputService")

local gui = script.Parent

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

end,
function(script,require)
local UserInputService = game:GetService("UserInputService")

local gui = script.Parent

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

end,
function(script,require)
local UserInputService = game:GetService("UserInputService")

local gui = script.Parent

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

end,
function(script,require)
local UserInputService = game:GetService("UserInputService")

local gui = script.Parent

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

end,
function(script,require)
--<< Gate Studios© Plane Kit by: Rengate >>--
------------------------------------------------------------------------------------------------------------------
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local input = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Plane = script.Parent.Plane.Value
local EventsFolder = Plane.Parent:WaitForChild("Events")
local TakeoffEvent = EventsFolder:WaitForChild("Takeoff")
local Settings = require(Plane.Parent.Settings.Config)
------------------------------------------------------------------------------------------------------------------
--LOOP VALUES DO NOT TOUCH!!!
local SpeedUp = false
local SpeedDown = false
local Up = false
local Down = false
local RollLeft = false
local RollRight = false
local Left = false
local Right = false
------------------------------------------------------------------------------------------------------------------
local active = false
local EngineOn = false
local CurrentCFrame = CFrame.new(0,0,0)
------------------------------------------------------------------------------------------------------------------
-- KEY INPUTS
input.InputBegan:connect(function(inp,CanWork)
------------------------------------------------------------------------------------------------------------------
	-- FLIGHT FUNCTIONS
	if inp.KeyCode == Settings.EngineKey and EngineOn == false and CanWork == false then
		TakeoffEvent:FireServer("On", mouse.Hit)
		EngineOn = true
-----------------------------------------------------
	elseif inp.KeyCode == Settings.EngineKey and EngineOn == true and CanWork == false then	
		TakeoffEvent:FireServer("Off")
		EngineOn = false
		active = false
-----------------------------------------------------
	elseif inp.KeyCode == Settings.ThrottleUp and CanWork == false then
		SpeedUp = true
		while SpeedUp do
			wait()
			TakeoffEvent:FireServer("Speed")
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.ThrottleDown and CanWork == false then
		SpeedDown = true
		while SpeedDown do
			wait()
			TakeoffEvent:FireServer("Slow")
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.RollLeft and CanWork == false then
		RollLeft = true
		while RollLeft do
			wait()
			TakeoffEvent:FireServer("RollLeft")
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.RollRight and CanWork == false then
		RollRight = true
		while RollRight do
			wait()
			TakeoffEvent:FireServer("RollRight")
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.PitchUp and CanWork == false then
		Up = true
		while Up do
			wait()
			TakeoffEvent:FireServer("PitchUp")
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.PitchDown and CanWork == false then
		Down = true
		while Down do
			wait()
			TakeoffEvent:FireServer("PitchDown")
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.YawLeft and CanWork == false then
		Left = true
		while Left do
			wait()
			TakeoffEvent:FireServer("Left")
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.YawRight and CanWork == false then
		Right = true
		while Right do
			wait()
			TakeoffEvent:FireServer("Right")
		end
------------------------------------------------------------------------------------------------------------------
	end
end)
------------------------------------------------------------------------------------------------------------------
-- KEY INPUT ENDED
input.InputEnded:connect(function(inp)
	if inp.KeyCode == Settings.ThrottleUp then
		SpeedUp = false
	elseif inp.KeyCode == Settings.ThrottleDown then
		SpeedDown = false
	elseif inp.KeyCode == Settings.RollLeft then
		RollLeft = false
	elseif inp.KeyCode == Settings.RollRight then
		RollRight = false
	elseif inp.KeyCode == Settings.PitchUp then
		Up = false
	elseif inp.KeyCode == Settings.PitchDown then
		Down = false
	elseif inp.KeyCode == Settings.YawLeft then
		Left = false
	elseif inp.KeyCode == Settings.YawRight then
		Right = false
	end
end)

end,
function(script,require)
--<< Gate Studios© Plane Kit by: Rengate >>--
------------------------------------------------------------------------------------------------------------------
local engine = script.Parent.Parent.Engine
local plane = engine.Parent
local Settings = require(script.Parent.Parent.Parent.Settings.Config)
local MiscScripts = script.Parent.Parent.Parent.MiscScripts
local bg = Instance.new("BodyGyro")
local bv = Instance.new("BodyVelocity")
local RunService = game:GetService("RunService")
local vacant = true
local Events = script.Parent.Parent.Parent.Events
local StartingUp = false
local Running = false
--[[
	- Body Gyro:
	  X = Up and Down
	  Y = Yaw
	  Z = Roll
--]]
------------------------------------------------------------------------------------------------------------------
local baseSpeed = script.Parent:FindFirstChild("BaseSpeed")
local MaxSpeed = Settings.MaxSpeed
local StallSpeed = Settings.StallSpeed
local RollSpeed = Settings.RollSpeed
local PitchSpeed = Settings.PitchSpeed
local YawSpeed = Settings.YawSpeed
local StartUpTime = Settings.StartUpTime
local Acceleration = Settings.Acceleration
local Airborne = false
------------------------------------------------------------------------------------------------------------------
controller = script.Parent:FindFirstChild("FlightControls")
controller:FindFirstChild("Plane").Value = plane
------------------------------------------------------------------------------------------------------------------
local addon = Instance.new("ObjectValue")
addon.Name = "Plane"
addon.Value = plane
------------------------------------------------------------------------------------------------------------------
bg.Parent = engine
bv.Parent = engine
bv.maxForce = Vector3.new(0,0,0)
bg.maxTorque = Vector3.new(0,0,0)
bg.cframe = engine.CFrame
------------------------------------------------------------------------------------------------------------------
local direction = nil
------------------------------------------------------------------------------------------------------------------
local EngineFunctions = require(MiscScripts.EngineFunctions)
------------------------------------------------------------------------------------------------------------------
function CheckGroup(val, player)
	if Settings.isGroupOnly == true then
		if player:GetRankInGroup(Settings.GroupID) >= Settings.MinGroupRank then
			val = true
		end
	elseif Settings.isGroupOnly == false then
		val = true
	end
	return val
end
function CheckTeam(val, player)
	if Settings.isTeamOnly == true then
		if player.Team == game.Teams:FindFirstChild(Settings.TeamName) then
			val = true
		end
	elseif Settings.isTeamOnly == false then
		val = true
	end
	return val
end
------------------------------------------------------------------------------------------------------------------
-- GIVE UI
engine_con = script.Parent.ChildAdded:connect(function(child)
	if child.Name == "SeatWeld" then
		local character = child.Part1.Parent
		player = game.Players:GetPlayerFromCharacter(character)
		local Val1 = CheckGroup(false,player)
		local Val2 = CheckTeam(false,player)
		if Val1 == true and Val2 == true then
			vacant = false
			addon.Parent = character		
			controller:Clone().Parent=player.PlayerGui
			for _,s in pairs(script.Parent.Parent.Parent.MiscLocalScripts:GetChildren()) do
                local sclone = s:Clone()
                sclone.Parent = player.PlayerGui.FlightControls
                if sclone:IsA("Script") or sclone:IsA("LocalScript") then
                    sclone.Disabled = false
                end
            end
			script.Parent.Parent.Owner.Value = player
		elseif Val1 == false or Val2 == false then
			wait()
			child:Destroy()
			character.Humanoid.Jump = true
		end
	end
end)
-- REMOVE UI
seat_con = script.Parent.ChildRemoved:connect(function(child)
	if child.Name == "SeatWeld" and vacant == false then
		local character = child.Part1.Parent
		addon.Parent = nil
		vacant = true
		bv.maxForce = Vector3.new(0,0,0)
		bg.maxTorque = Vector3.new(0,0,0)
		player.PlayerGui.FlightControls:Destroy()
		local CamS = script.CameraReset:Clone()
		CamS.Parent = player.PlayerGui
		CamS.Disabled = false
		EngineFunctions.Stop()
		StartingUp = false
		Running = false
		script.Parent.Parent.Owner.Value = nil
		bv.maxForce = Vector3.new(0,0,0)
		bg.maxTorque = Vector3.new(0,0,0)
	end
end)
------------------------------------------------------------------------------------------------------------------
function FlyIt()
	direction = bg.CFrame.lookVector
	bv.Velocity = direction*baseSpeed.Value
	if baseSpeed.Value > StallSpeed then
		bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
		Airborne = true
	elseif baseSpeed.Value < StallSpeed and baseSpeed.Value >= (StallSpeed/(StallSpeed*0.5)) and Airborne == true then
		bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = Vector3.new(direction.X,direction.Y-0.2/((baseSpeed.Value)/StallSpeed)*1.4,direction.Z)*baseSpeed.Value
	elseif baseSpeed.Value < (StallSpeed/(StallSpeed*0.5)) or baseSpeed.Value <= 0 then
		Airborne = false
		bv.maxForce = Vector3.new(math.huge, 0, math.huge)
		bg.maxTorque = Vector3.new(0, math.huge, 0)
	end
end
------------------------------------------------------------------------------------------------------------------
-- ENGINE START/MOVEMENT
Events.Takeoff.OnServerEvent:connect(function(client, event, data)
	FlyIt()
	if event == "On" and client == player and StartingUp == false then
		StartingUp = true
		EngineFunctions.StartUp()
		StartingUp = false
		Running = true
		bg.cframe = engine.CFrame
		bv.maxForce = Vector3.new(math.huge, 0, math.huge)
		bg.maxTorque = Vector3.new(0, math.huge, 0)
-----------------------------------------------------------------------
	elseif event == "Speed" and client == player and baseSpeed.Value < MaxSpeed and Running == true then	
		baseSpeed.Value = baseSpeed.Value + Acceleration / 10
-----------------------------------------------------------------------
	elseif event == "Slow" and client == player and baseSpeed.Value > 0 then	
		baseSpeed.Value = baseSpeed.Value - Acceleration / 10
-----------------------------------------------------------------------
	elseif event == "RollLeft" and client == player and baseSpeed.Value > (StallSpeed - 50) and Running == true then
		bg.CFrame = bg.CFrame * CFrame.Angles(0, 0, RollSpeed / 100)
-----------------------------------------------------------------------
	elseif event == "RollRight" and client == player and baseSpeed.Value > (StallSpeed - 50) and Running == true then
		bg.CFrame = bg.CFrame * CFrame.Angles(0, 0, -RollSpeed / 100)
-----------------------------------------------------------------------
	elseif event == "PitchUp" and client == player and baseSpeed.Value > (StallSpeed - 50) and Running == true then
		bg.CFrame = bg.CFrame * CFrame.Angles(PitchSpeed / 666, 0, 0)
-----------------------------------------------------------------------
	elseif event == "PitchDown" and client == player and baseSpeed.Value > (StallSpeed - 50) and Running == true then
		bg.CFrame = bg.CFrame * CFrame.Angles(-PitchSpeed / 666, 0, 0)
-----------------------------------------------------------------------
	elseif event == "Left" and client == player and Running == true then
		bg.CFrame = bg.CFrame * CFrame.Angles(0, YawSpeed / 1000, 0)
-----------------------------------------------------------------------
	elseif event == "Right" and client == player and Running == true then
		bg.CFrame = bg.CFrame * CFrame.Angles(0, -YawSpeed / 1000, 0)
-----------------------------------------------------------------------
	elseif event == "Off" and client == player then
		EngineFunctions.Stop()
		baseSpeed.Value = 0
		StartingUp = false
		Running = false
		bv.maxForce = Vector3.new(0,0,0)
		bg.maxTorque = Vector3.new(0,0,0)
	end
end)
------------------------------------------------------------------------------------------------------------------
end,
function(script,require)
local player = game.Players.LocalPlayer
local cam = workspace.CurrentCamera
cam.CameraType="Custom"
cam.FieldOfView = 70
cam.CameraSubject = player.Character.Humanoid

wait(1)
script:Destroy()
end,
function(script,require)
-->> PROPERTY OF GATE STUDIOS© <<--

--[[
	If you are reading this then hello! I am Rengate.
	I hope you enjoy this plane system. It's been a lot
	of work and fun to make. I made this system due to
	a lot of the old ones breaking after the FE update.
	Its very simple and the controls are listed in the UI
	and in the Settings Module. Feel free to edit anything.
	I threw this together pretty quick so theres bound to
	be some issues. If you find any be sure to send me a 
	PM! Well thanks for reading. Ta-ta! ~Rengate, GS© CEO
	
	-->> Version Notes:
	
		> V.0.9 [Current Version]
			- Minor Bug Fixes
	
		> V.0.8
			- Implemented loading of scripts
			
		> V.0.7
			- Added Eject System (To Planes that Apply)
			- Minor Bug Fixes
			- Added Basic GUI (Feel Free to edit, Be sure to modify GUIController too)
			
		> V.0.6
			- MAJOR BUG FIXES (Hmmm Wonder Why? *Looks at weapon systems*)
			- Tuned Weapon Systems
			
		> V.0.5
			- Added Weapon Systems (To Planes that Apply)
			- Added Health System (To Planes that Apply)
			- Minor Bug Fixes
			- Added Engine Functions (Now you can easly change what happens)
			
		> V.0.4
			- Added Changable Settings
			- Switched all scripts over to use settings
			- Added more advanced Functions (To Planes that Apply)
			- Minor Bug Fixes
			
		> V.0.3
			- Added Engine Noise and Effects
			- Added Basic Functions like Gear etc.
			- Added Camera Functions
			- Minor Bug Fixes
			
		> V.0.2
			- Implemented Roll,Pitch,Yaw
			- Added Start Time
			- Minor Bug Fixes
		
		> V.0.1
			- Made the brick fly
			- Stable Speed
			- Stall Speed
			- Mouse Guidence[DEPRECIATED] 
--]]
end,
function(script,require)
--<< Gate Studios© Plane Kit by: Rengate >>--
------------------------------------------------------------------------------------------------------------------
local player = game.Players.LocalPlayer
local input = game:GetService("UserInputService")
local Plane = script.Parent.Plane.Value
local EventsFolder = Plane.Parent:WaitForChild("Events")
local Settings = require(Plane.Parent.Settings.Config)
------------------------------------------------------------------------------------------------------------------
-- VALUES
local Gear = true
local NavLights = false
local SpotLights = false
local Canopy = true
local Wings = false
------------------------------------------------------------------------------------------------------------------
-- KEY INPUTS
input.InputBegan:connect(function(inp,CanWork)
------------------------------------------------------------------------------------------------------------------
	-- FLIGHT FUNCTIONS
	if inp.KeyCode == Settings.GearKey and CanWork == false then
		if Gear == true then
			EventsFolder.GearEvent:FireServer("In")
			Gear = false
		elseif Gear == false then
			EventsFolder.GearEvent:FireServer("Out")
			Gear = true
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.WingKey and CanWork == false then
		if Wings == true then
			EventsFolder.GearEvent:FireServer("WingOut")
			Wings = false
		elseif Wings == false then
			EventsFolder.GearEvent:FireServer("WingIn")
			Wings = true
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.CanopyKey and CanWork == false then
		if Canopy == true then
			EventsFolder.CanopyEvent:FireServer("Close")
			Canopy = false
		elseif Canopy == false then
			EventsFolder.CanopyEvent:FireServer("Open")
			Canopy = true
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.SpotLights and CanWork == false then
		if SpotLights == false then
			EventsFolder.LightsEvent:FireServer("SpotOn")
			SpotLights = true
		elseif SpotLights == true then
			EventsFolder.LightsEvent:FireServer("SpotOff")
			SpotLights = false
		end
-----------------------------------------------------
	elseif inp.KeyCode == Settings.NavLights and CanWork == false then
		if NavLights == false then
			EventsFolder.LightsEvent:FireServer("NavOn")
			NavLights = true
		elseif NavLights == true then
			EventsFolder.LightsEvent:FireServer("NavOff")
			NavLights = false
		end
-----------------------------------------------------		
	elseif inp.KeyCode == Settings.EjectKey and CanWork == false then
			EventsFolder.CanopyEvent:FireServer("EJECT")
-----------------------------------------------------
	end
end)

------------------------------------------------------------------------------------------------------------------
-- KEY INPUT ENDED
--[[input.InputEnded:connect(function(inp)
end)]]

end,
function(script,require)
local player = game.Players.LocalPlayer
local input = game:GetService("UserInputService")
local Plane = script.Parent.Plane.Value
local Settings = require(Plane.Parent.Settings.Config)
local MainFrame = script.Parent:WaitForChild("MainFrame")
local WeaponAmmo = script.Parent:WaitForChild("WeaponAmmo")
local WeaponControls = script.Parent:WaitForChild("WeaponControls")
local GUI = script.Parent
------------------------------------------------------------------------------------------------------------------
local Gear = false
local NavLights = false
local SpotLights = false
local Canopy = false
local Camera = false
local Weapons = false
local MG = false
local Rocket = false
local Misisle = false
local Bomb = false
------------------------------------------------------------------------------------------------------------------
local ConVisible = false
local WeapConVisible = false
local WeapAmmoVisible = false
------------------------------------------------------------------------------------------------------------------
if Plane.Parent:FindFirstChild("WeaponSpawns") ~= nil then
	Weapons = true
	MainFrame.WeaponsAmmo.Visible = true
	MainFrame.WeaponsButton.Visible = true
	if Plane.Parent.WeaponSpawns:FindFirstChild("MG")~= nil then
		MG = true
		local Temp = script.Template:Clone()
		Temp.Parent = WeaponControls
		Temp.Text = "MG: "..Settings.MGKey.Name
		local Temp2 = script.Template:Clone()
		Temp2.Parent = WeaponAmmo
		Temp2.Text = "MG AMMO: "..Settings.MGAmmo
		Temp2.Name = "MGAmmo"
	end
	if Plane.Parent.WeaponSpawns:FindFirstChild("RocketSpawn")~= nil then
		Rocket = true
		local Temp = script.Template:Clone()
		Temp.Parent = WeaponControls
		Temp.Text = "ROCKET: "..Settings.RocketKey.Name
		local Temp2 = script.Template:Clone()
		Temp2.Parent = WeaponAmmo
		Temp2.Text = "ROCKETS: "..Settings.RocketAmmo
		Temp2.Name = "RocketAmmo"
	end
	if Plane.Parent.WeaponSpawns:FindFirstChild("MissileSpawn")~= nil then
		Misisle = true
		local Temp = script.Template:Clone()
		Temp.Parent = WeaponControls
		Temp.Text = "MISSILE: "..Settings.MissileKey.Name
		local Temp2 = script.Template:Clone()
		Temp2.Parent = WeaponAmmo
		Temp2.Text = "MISSILES: "..Settings.MissileAmmo
		Temp2.Name = "MissileAmmo"
	end
	if Plane.Parent.WeaponSpawns:FindFirstChild("BombSpawn")~= nil then
		Bomb = true
		local Temp = script.Template:Clone()
		Temp.Parent = WeaponControls
		Temp.Text = "BOMBS: "..Settings.BombKey.Name
		local Temp2 = script.Template:Clone()
		Temp2.Parent = WeaponAmmo
		Temp2.Text = "BOMBS: "..Settings.Bombs
		Temp2.Name = "BombAmmo"
	end
elseif Plane.Parent:FindFirstChild("WeaponSpawns") == nil then
	Weapons = false
	MainFrame.WeaponsAmmo.Visible = false
	MainFrame.WeaponsButton.Visible = false
end
---------------------------------------------------------
local Engine = script.Template:Clone()
Engine.Parent = GUI.Controls
Engine.Text = "ENGINE: "..Settings.EngineKey.Name

local Throttle = script.Template:Clone()
Throttle.Parent = GUI.Controls
Throttle.Text = "THROTTLE: "..Settings.ThrottleUp.Name.."/"..Settings.ThrottleDown.Name
Throttle.TextScaled = true

local Yaw = script.Template:Clone()
Yaw.Parent = GUI.Controls
Yaw.Text = "YAW: "..Settings.YawLeft.Name.."/"..Settings.YawRight.Name

local Roll = script.Template:Clone()
Roll.Parent = GUI.Controls
Roll.Text = "ROLL: "..Settings.RollLeft.Name.."/"..Settings.RollRight.Name

local Pitch = script.Template:Clone()
Pitch.Parent = GUI.Controls
Pitch.Text = "PITCH: "..Settings.PitchUp.Name.."/"..Settings.PitchDown.Name

local Eject = script.Template:Clone()
Eject.Parent = GUI.Controls
Eject.Text = "EJECT: "..Settings.EjectKey.Name

---------------------------------------------------------
if Plane.Parent.Misc:FindFirstChild("LandingGear") ~= nil then
	Gear = true 
	local Temp = script.Template:Clone()
	Temp.Parent = GUI.Controls
	Temp.Text = "GEAR: "..Settings.GearKey.Name
	Temp.Name = "GEAR"
end
---------------------------------------------------------
if Plane.Parent.Misc:FindFirstChild("Lights")~= nil then
	if Plane.Parent.Misc.Lights:FindFirstChild("Light")~= nil then
		SpotLights = true
		local Temp = script.Template:Clone()
		Temp.Parent = GUI.Controls
		Temp.Text = "SPOTLIHGTS: "..Settings.SpotLights.Name
		Temp.Name = "SPOT"
	end
	if Plane.Parent.Misc.Lights:FindFirstChild("Strobe")~= nil then
		NavLights = true
		local Temp = script.Template:Clone()
		Temp.Parent = GUI.Controls
		Temp.Text = "NAVLIGHTS: "..Settings.NavLights.Name
		Temp.Name = "NAV"
	end
end
---------------------------------------------------------
if script.Parent:FindFirstChild("CameraController")~= nil then
	Camera = true
	local Temp = script.Template:Clone()
	Temp.Parent = GUI.Controls
	Temp.Text = "CAMERA: "..Settings.CameraKey.Name
	Temp.Name = "GEAR"
end
---------------------------------------------------------
if Plane.Parent.Misc:FindFirstChild("Canopy")~= nil then
	Canopy = true
	local Temp = script.Template:Clone()
	Temp.Parent = GUI.Controls
	Temp.Text = "CANOPY: "..Settings.CanopyKey.Name
	Temp.Name = "CANOPY"
end
------------------------------------------------------------------------------------------------------------------
MainFrame.WeaponsButton.MouseButton1Click:Connect(function()
	if WeapConVisible == false then
		WeapConVisible = true
		WeaponControls.Visible = true
	elseif WeapConVisible == true then
		WeapConVisible = false
		WeaponControls.Visible = false
	end
end)

MainFrame.WeaponsAmmo.MouseButton1Click:Connect(function()
	if WeapAmmoVisible == false then
		WeapAmmoVisible = true
		WeaponAmmo.Visible = true
	elseif WeapAmmoVisible == true then
		WeapAmmoVisible = false
		WeaponAmmo.Visible = false
	end
end)

MainFrame.TControlsButton.MouseButton1Click:Connect(function()
	if ConVisible == false then
		ConVisible = true
		GUI.Controls.Visible = true
	elseif ConVisible == true then
		ConVisible = false
		GUI.Controls.Visible = false
	end
end)
------------------------------------------------------------------------------------------------------------------
while true do
	local Frame = MainFrame
	local Engine = Plane:FindFirstChild("Engine")
	local vSpeed = math.sqrt((Engine.Velocity.x)^2+(Engine.Velocity.y)^2+(Engine.Velocity.z)^2)
	wait()
	if Weapons == true then
		if MG == true then
			WeaponAmmo.MGAmmo.Text = "MG AMMO: "..Settings.MGAmmo
		end
		if Rocket == true then
			WeaponAmmo.RocketAmmo.Text = "ROCKETS: "..Settings.RocketAmmo
		end
		if Misisle == true then
			WeaponAmmo.MissileAmmo.Text = "MISSILES: "..Settings.MissileAmmo
		end
		if Bomb == true then
			WeaponAmmo.BombAmmo.Text = "BOMBS: "..Settings.Bombs
		end
	end
	Frame.ALT.Text = ' ALTITUDE: ' .. math.ceil(Plane.Engine.Position.Y -5)
	if math.floor(vSpeed) <= Settings.StallSpeed then
		Frame.SPD.TextColor3 = Color3.new(255, 0, 0)
	elseif math.floor(vSpeed) > Settings.StallSpeed then
		Frame.SPD.TextColor3 = Color3.new(255, 255, 255)
	end
	Frame.SPD.Text = " SPEED:  ".. math.floor(vSpeed).." Kt"
	Frame.COORDS.Text = "COORDS:("..math.ceil(Engine.Position.X)..","..math.ceil(Engine.Position.Z)..")"
end
end,
function(script,require)
script.Parent:WaitForChild("Plane")
local mouse = game.Players.LocalPlayer:GetMouse()

------------------------------------------------------
local plane = script.Parent.Plane.Value
local cam = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local CamV = "third"
local run = false
local AimPart = plane.AimPart
local input = game:GetService("UserInputService")
local Settings = require(plane.Parent.Settings.Config)
cam.CameraSubject = plane.PilotSeat
	
--========================CAMERA========================--
input.InputBegan:connect(function(inp,CanWork)
	if inp.KeyCode == Settings.CameraKey and CanWork == false then
		if CamV == ("second") then
			cam.CameraType = "Custom"
			cam.FieldOfView = 70
			cam.CameraSubject = plane.PilotSeat
			CamV = ("third")
			script.Parent.HUD.Visible = false
			run=false
		elseif CamV == ("third") then
			run=true
			CamV = ("first")
			cam.FieldOfView = 100
			script.Parent.HUD.Visible = true
		elseif CamV == ("first") then
			run=true
			CamV = ("second")
			cam.FieldOfView = 100
		end
	end
end)
	
-- Used for cars, de activates when the user jumps --
plane.PilotSeat.ChildRemoved:connect(function(child)
	run=false
	cam.CameraType="Custom"
	cam.FieldOfView = 70
	CamV = ("third") 
end)
	
game:GetService("RunService").RenderStepped:connect(function()
	if run and CamV == "first" then
		local XLook=math.max(math.min(((mouse.X-(mouse.ViewSizeX/2))/200)^3,1),-1)
		local YLook=math.max(math.min(((mouse.Y-(mouse.ViewSizeY/2))/200)^3,1),-1)
		local LookOffset=player.Character.Head.CFrame:toWorldSpace(CFrame.new(0,0,-1)*CFrame.Angles(-YLook,-XLook,0))
		cam.CameraType="Scriptable"
		cam.CameraSubject=player.Character.Humanoid
		cam.CoordinateFrame=LookOffset
		
	elseif run and CamV == "second" then
		local XLook=math.max(math.min(((mouse.X-(mouse.ViewSizeX/2))/200)^3,1),-1)
		local YLook=math.max(math.min(((mouse.Y-(mouse.ViewSizeY/2))/200)^3,1),-1)
		local LookOffset=AimPart.CFrame:toWorldSpace(CFrame.new(0,0,0))
		cam.CameraType="Scriptable"
		cam.CameraSubject=player.Character.Humanoid
		cam.CoordinateFrame=LookOffset
	end
end)
	
--Zoom function--

mouse.WheelBackward:connect(function()
	if CamV ~= "third" then
		if cam.FieldOfView <= 100 then
			cam.FieldOfView = cam.FieldOfView + 5
		end
	end
end)
			
mouse.WheelForward:connect(function()
	if CamV ~= "third" then
		if cam.FieldOfView >= 20 then
			cam.FieldOfView = cam.FieldOfView - 5
		end
	end
end)
	
-----------------
	
end,
function(script,require)
--<< Gate Studios© Plane Kit by: Rengate >>--
------------------------------------------------------------------------------------------------------------------
local player = game.Players.LocalPlayer
local input = game:GetService("UserInputService")
local Plane = script.Parent.Plane.Value
local Engine = Plane:WaitForChild("Engine")
local EventsFolder = Plane.Parent:WaitForChild("Events")
local Settings = require(Plane.Parent.Settings.Config)
local WeaponSpawn = Plane.Parent:WaitForChild("WeaponSpawns")
local FX = Plane.Parent:WaitForChild("FX")
local Offset = Settings.RoundOffset
local Mouse = player:GetMouse()
Mouse.TargetFilter = Plane.Parent
local TargetFrame = script.Parent:WaitForChild("TargetFrame")
------------------------------------------------------------------------------------------------------------------
--// VALUES
local MG = false
local Rocket = false
local Missle = false
local Bomb = false
--// FIRING VALUES
local MGFiring = false
local RocketFiring = false
local MissleFiring = false
local BombFiring = false
--// MISSILE VALUES
local ReadyToLock = false
local MissileTarget = nil
local Locked = false
------------------------------------------------------------------------------------------------------------------
local BulletTick = 0
------------------------------------------------------------------------------------------------------------------
if WeaponSpawn:FindFirstChild("MG") then MG = true end
if WeaponSpawn:FindFirstChild("RocketSpawn") then Rocket = true end
if WeaponSpawn:FindFirstChild("MissileSpawn") then Missle = true end
if WeaponSpawn:FindFirstChild("BombSpawn") then Bomb = true end
------------------------------------------------------------------------------------------------------------------
--// KEY INPUTS
input.InputBegan:connect(function(inp,CanWork)
------------------------------------------------------------------------------------------------------------------
	--// WEAPON FUNCTIONS
	if inp.KeyCode == Settings.MGKey and MG == true and Settings.MGAmmo > 0 and CanWork == false then
		MGFiring = true
		EventsFolder.WeaponsEvent:FireServer("FireMG")
		for _,w in pairs(WeaponSpawn:GetChildren()) do
			if w.Name == "MG" then
				spawn(function ()
					FireMG(player,w)
				end)
			end
		end
	elseif inp.KeyCode == Settings.RocketKey and Rocket == true and Settings.RocketAmmo > 0 and CanWork == false then
		for _,w in pairs(WeaponSpawn:GetChildren()) do
			if w.Name == "RocketSpawn" then
				FireRocket(player,w)
			end
		end
		Rocket = false
		wait(Settings.RocketFireRate)
		Rocket = true
	elseif inp.KeyCode == Settings.MissileKey and Missle == true and Settings.MissileAmmo > 0 and CanWork == false then
		local w = WeaponSpawn:FindFirstChild("MissileSpawn")
		FireMissile(player,w)
		Missle = false
		wait(Settings.RocketFireRate+5)
		Missle = true
	elseif inp.KeyCode == Settings.BombKey and Bomb == true and Settings.Bombs > 0 and CanWork == false then
		for _,w in pairs(WeaponSpawn:GetChildren()) do
			if w.Name == "BombSpawn" then
				DropBomb(player,w)
			end
		end
		Bomb = false
		wait(Settings.RocketFireRate)
		Bomb = true
	elseif inp.UserInputType == Settings.MisisleLock and Missle == true and CanWork == false then
		MissileTarget = nil
		if ReadyToLock == false then
			ReadyToLock = true
			TargetFrame.Visible = true
			input.MouseIconEnabled = false
		else
			TargetFrame.LockRet.Visible = false
			Locked = false
			ReadyToLock = false
			TargetFrame.Visible = false
			input.MouseIconEnabled = true
			TargetFrame.MainRet.ImageColor3 = Color3.fromRGB(255,255,255)
		end
	elseif inp.UserInputType == Enum.UserInputType.MouseButton1 and Missle == true and CanWork == false and ReadyToLock == true then
		if MissileTarget ~= nil then
			Locked = true
			TargetFrame.LockRet.Visible = true
		end
	end
end)

------------------------------------------------------------------------------------------------------------------
--// KEY INPUT ENDED
input.InputEnded:connect(function(inp)
	if inp.KeyCode == Settings.MGKey then
		MGFiring = false
		EventsFolder.WeaponsEvent:FireServer("StopMG")	
	end
end)
--========================================================================--
function CheckForHuman(val,hit)
	if hit.Parent ~= nil then
		if hit.Parent:FindFirstChild("Humanoid") ~= nil then
			val = true
		end
		return val
	end
end
--========================================================================--
--// FIRE MG FUNCTION
function FireMG(plr,w)
	while MGFiring do
		if Settings.MGAmmo > 0 then
			Settings.MGAmmo = Settings.MGAmmo - 1
			w.Flash.Enabled = true
			
			local Bullet = WeaponSpawn:FindFirstChild("MG"):Clone()
			Bullet.Parent = game.Workspace
			Bullet.Fire:Destroy()
			Bullet.Flame:Destroy()
			Bullet.Flash:Destroy()
			Bullet.Smoke:Destroy()
			Bullet.Size = Vector3.new(0.6, 0.6, 1.2)
			Bullet.BrickColor = BrickColor.new("Olivine")
			Bullet.Material = Enum.Material.Neon
			Bullet.CFrame = w.CFrame * CFrame.new(0,0,-Offset)
			Bullet.Name = "MGBullet"
			Bullet.CanCollide = true
			Bullet.Transparency = 1
			BulletTick = BulletTick + 1
			if BulletTick == 3 then
				Bullet.Transparency = 0
				BulletTick = 0
			end
			
			local Velo = Instance.new("BodyVelocity", Bullet)
			Velo.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			Velo.P = 10
			Velo.Velocity = Bullet.CFrame.lookVector.unit * Settings.BulletSpeed
			
			Bullet.Touched:Connect(function(hit)
				local Pos = Bullet.Position
				local Human = CheckForHuman(false,hit)
				if Human == true then
					EventsFolder.WeaponsFunction:InvokeServer("MG", "Human", Pos, hit.Parent.Humanoid)
			elseif Human == false and hit.Name ~= "MGBullet" then
					Bullet.Anchored = true
					Bullet.Anchored = true
					Bullet.Transparency = 1
					if Settings.ExplosiveRounds == true then
						EventsFolder.WeaponsFunction:InvokeServer("MG", "Explosive", Pos, Bullet)
					else
						EventsFolder.WeaponsFunction:InvokeServer("MG", "NonExplosive", Pos, Bullet)
					end
				end
				Bullet:Destroy()
			end)
			game.Debris:AddItem(Bullet,5)
			wait(Settings.MGFireRate)
			w.Flash.Enabled = false
		end
	end
end
--========================================================================--
--========================================================================--
function FireRocket(plr,w)
	if Settings.RocketAmmo > 0 then
		Settings.RocketAmmo = Settings.RocketAmmo - 1
			
		local Rocket = WeaponSpawn:FindFirstChild("RocketSpawn"):Clone()
		Rocket.Parent = game.Workspace
		Rocket.Size = Vector3.new(1, 1, 15)
		Rocket.BrickColor = BrickColor.new("Fossil")
		Rocket.Material = Enum.Material.Metal
		Rocket.CFrame = w.CFrame * CFrame.new(0,0,-Offset)
		Rocket.Name = "Rocket"
		Rocket.CanCollide = true
		Rocket.Transparency = 0
		
		local Attach = Instance.new("Attachment",Rocket)
		Attach.Position = Vector3.new(0,0,8)
		
		local Trail = FX.RocketTrail:Clone()
		Trail.Parent = Attach
		Trail.Enabled = true
			
		FX.RocketMesh:Clone().Parent = Rocket
			
		local Velo = Instance.new("BodyVelocity", Rocket)
		Velo.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		Velo.P = 10
		Velo.Velocity = Rocket.CFrame.lookVector.unit * Settings.RocketSpeed
			
		Rocket.Touched:Connect(function(hit)
			if hit.Name ~= "Rocket" then
				local Pos = Rocket.Position
				Rocket.Anchored = true
				Rocket.Transparency = 1
				EventsFolder.WeaponsFunction:InvokeServer("Rocket", "Explosive", Pos, Rocket)
				Rocket:Destroy()
			end	
		end)
		game.Debris:AddItem(Rocket,10)
	end
end
--========================================================================--
--========================================================================--
function FireMissile(plr,w)
	if Settings.MissileAmmo > 0 and MissileTarget ~= nil and Locked == true then
		Settings.MissileAmmo = Settings.MissileAmmo - 1
			
		local MissilePart = WeaponSpawn:FindFirstChild("MissileSpawn"):Clone()
		MissilePart.Parent = game.Workspace
		MissilePart.Size = Vector3.new(1, 1, 15)
		MissilePart.BrickColor = BrickColor.new("Fossil")
		MissilePart.Material = Enum.Material.Metal
		MissilePart.CFrame = w.CFrame * CFrame.new(0,0,-Offset)
		MissilePart.Name = "Rocket"
		MissilePart.CanCollide = true
		MissilePart.Transparency = 0
		
		local Attach = Instance.new("Attachment",MissilePart)
		Attach.Position = Vector3.new(0,0,8)
		
		local Trail = FX.RocketTrail:Clone()
		Trail.Parent = Attach
		Trail.Enabled = true
			
		FX.RocketMesh:Clone().Parent = MissilePart
			
		local Velo = Instance.new("BodyVelocity", MissilePart)
		Velo.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		Velo.P = 10
		Velo.Velocity = MissilePart.CFrame.lookVector.unit * Settings.RocketSpeed
		
		local Gyro = Instance.new("BodyGyro", MissilePart)
		Gyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
		Gyro.CFrame = MissilePart.CFrame
		
		game.Debris:AddItem(MissilePart,10)
		local MissileFired = true
		MissilePart.Touched:Connect(function(hit)
			if hit.Name ~= "Rocket" then
				MissileFired = false
				local Pos = MissilePart.Position
				MissilePart.Anchored = true
				MissilePart.Transparency = 1
				EventsFolder.WeaponsFunction:InvokeServer("Rocket", "Explosive", Pos, MissilePart)
				MissilePart:Destroy()
			end
			TargetFrame.MainRet.ImageColor3 = Color3.fromRGB(255,255,255)
			TargetFrame.LockRet.Visible = false	
			Locked = false
			MissileTarget = nil
		end)
		while MissileFired do
			wait()
			if MissileTarget ~= nil then
				local Direction = (MissileTarget.Position - MissilePart.Position).unit 	
				local Pos = MissilePart.Position + (Direction * 1)
				Gyro.CFrame = CFrame.new(Pos,Pos+Direction)
				if MissileTarget.Velocity.magnitude < 800 then
					Velo.Velocity = MissilePart.CFrame.lookVector.unit * 800
				else
					Velo.Velocity = MissilePart.CFrame.lookVector.unit * MissileTarget.Velocity.lookVector*5
				end
			end
		end
	end
end
--========================================================================--
--========================================================================--
function DropBomb(plr,w)
	if Settings.Bombs > 0 then
		Settings.Bombs = Settings.Bombs - 1
		
		local Bomb = WeaponSpawn:FindFirstChild("BombSpawn"):Clone()
		Bomb.Parent = game.Workspace
		Bomb.Size = Vector3.new(3.5, 3.5, 8.458)
		Bomb.BrickColor = BrickColor.new("Slime green")
		Bomb.Material = Enum.Material.Metal
		Bomb.CFrame = w.CFrame * CFrame.new(0,-10,0)
		Bomb.Name = "Bomb"
		Bomb.CanCollide = false
		Bomb.Transparency = 0
			
		FX.BombMesh:Clone().Parent = Bomb
			
		local Velo = Instance.new("BodyVelocity", Bomb)
		Velo.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		Velo.P = 10
		Velo.Velocity = Vector3.new(Plane.Engine.Velocity.x,-190,Plane.Engine.Velocity.z)
		
		local Gyro = Instance.new("BodyGyro", Bomb)
		Gyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
		Gyro.CFrame = Bomb.CFrame
		
		game.Debris:AddItem(Bomb,10)
			
		Bomb.Touched:Connect(function(hit)
			if hit.Name ~= "Bomb" then
				local Pos = Bomb.Position
				Bomb.Anchored = true
				Bomb.Transparency = 1
				EventsFolder.WeaponsFunction:InvokeServer("Bomb", "Explosive", Pos, Bomb)
				Bomb:Destroy()
			end
		end)
	end
end

game:GetService("RunService").RenderStepped:Connect(function()
	local X = Mouse.X
	local Y = Mouse.Y
	
	local FoundPlayer = false
	local ClosestRatio = 0.02
	
	TargetFrame.Position = UDim2.new(0,X-20,0,Y-20)
	
	if ReadyToLock == true then
	for _,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "Humanoid" and v.Parent:findFirstChild("Torso") and v.Parent.Torso:IsA("BasePart") then
			if game.Players:GetPlayerFromCharacter(v.Parent) ~= nil then
				local TargetPlr = game.Players:GetPlayerFromCharacter(v.Parent)
				if ((TargetPlr.TeamColor ~= player.TeamColor) or TargetPlr.Neutral) then
					local TorsoPos = v.Parent.Torso.CFrame
					local Distance = (Engine.CFrame.p - TorsoPos.p).magnitude
					local MDirection = (Mouse.Hit.p - Engine.CFrame.p).unit
					local Offset = (((MDirection * Distance) + Engine.CFrame.p) - TorsoPos.p).magnitude
					if (not Locked) then
						if (Offset / Distance) < ClosestRatio and Distance < Settings.MaxLockRange then
							ClosestRatio = (Offset / Distance)
							FoundPlayer = true
							MissileTarget = v.Parent:findFirstChild("Torso")
							TargetFrame.MainRet.ImageColor3 = Color3.fromRGB(255,0,0)
							TargetFrame.LockRet.ImageColor3 = Color3.fromRGB(255,0,0)
						end
					end
				end
			end
		elseif v.Name == "LaserMark" then
			local TorsoPos = v.CFrame
			local Distance = (Engine.CFrame.p - TorsoPos.p).magnitude
			local MDirection = (Mouse.Hit.p - Engine.CFrame.p).unit
			local Offset = (((MDirection * Distance) + Engine.CFrame.p) - TorsoPos.p).magnitude
			if (not Locked) then
				if (Offset / Distance) < ClosestRatio and Distance < Settings.MaxLockRange then
					ClosestRatio = (Offset / Distance)
					FoundPlayer = true
					MissileTarget = v
					TargetFrame.MainRet.ImageColor3 = Color3.fromRGB(85,255,0)
					TargetFrame.LockRet.ImageColor3 = Color3.fromRGB(85,255,0)
				end
			end
		end
	end
	end
end)
end,
function(script,require)
--<< Gate Studios© Plane Kit by: Rengate >>--
------------------------------------------------------------------------------------------------------------------
local MainParts = script.Parent.Parent.MainParts
local engine = MainParts.Engine
local Events = script.Parent.Parent.Events
local Misc = script.Parent.Parent.Misc
local Debris = game:GetService("Debris")
local EngineFunctions = require(script.Parent.EngineFunctions)
local Settings = require(script.Parent.Parent.Settings.Config)
local OriginalSpeed = Settings.MaxSpeed
------------------------------------------------------------------------------------------------------------------
local NavOn = true
local Strobes = {}
------------------------------------------------------------------------------------------------------------------
for _,i in pairs(Misc.Lights:GetChildren())do
	if i.Name == "Strobe" then
		table.insert(Strobes,i)
	end
end
------------------------------------------------------------------------------------------------------------------
function change(i,on)
	if on then
		i.Material = Enum.Material.Neon
		i.Transparency = 0
	else
		i.Material = Enum.Material.Glass
		i.Transparency = 0.1
	end
end

function Eject(char)
	
	local Part = Instance.new("Part",char)
	Part.Transparency = 1
	Part.CanCollide = false
	Part.Anchored = false
	Part.CFrame = char.Torso.CFrame
	Part.BrickColor = BrickColor.new("Black")
	Part.Material = Enum.Material.Sand
	
	local w = Instance.new('Weld')
	w.Part0, w.Part1 = Part, char.Torso
	w.C1 = char.Torso.CFrame:inverse() * Part.CFrame
	w.Parent = Part
	
	local BV = Instance.new("BodyVelocity")
	BV.Parent = Part
	BV.maxForce = Vector3.new(0,math.huge,0)
	
	local Sound = MainParts.Parent.FX.EjectSound:Clone()
	Sound.Parent = Part
	Sound:Play()
	
	char.Humanoid.Jump = true	
	BV.velocity = Vector3.new(0,300,0)	
	wait(0.2)
	BV.maxForce = Vector3.new(0,0,0)	
	wait(1.5)
	
	local Parachute = MainParts.Parent.FX.ParachuteMesh:Clone()
	Parachute.Parent = Part
	Part.Transparency = 0
	
	BV.maxForce = Vector3.new(0,math.huge,0)
	BV.velocity = Vector3.new(0,-50,0)
	
	local Scr = script.Ejected:Clone()
	Scr.Parent = Part
	Scr.Disabled = false
	
	Debris:AddItem(MainParts.Parent,5)
	
end
------------------------------------------------------------------------------------------------------------------
-- ENGINE START/MOVEMENT
Events.GearEvent.OnServerEvent:connect(function(client, val)
	if val == "In" then
		for _,g in pairs(Misc.LandingGear.Open:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 1
				g.CanCollide = false
			end
		end
		for _,g in pairs(Misc.LandingGear.Closed:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 0
				g.CanCollide = true
			end
		end
	elseif val == "Out" then
		for _,g in pairs(Misc.LandingGear.Open:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 0
				g.CanCollide = true
			end
		end
		for _,g in pairs(Misc.LandingGear.Closed:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 1
				g.CanCollide = false
			end
		end
	end
------------------------------------------------------------
	if val == "WingIn" then
		Settings.MaxSpeed = Settings.MaxSpeed + 300
		for _,g in pairs(Misc.Wings.Out:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 1
				g.CanCollide = false
			end
		end
		for _,g in pairs(Misc.Wings.In:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 0
				g.CanCollide = true
			end
		end
	elseif val == "WingOut" then
		Settings.MaxSpeed = OriginalSpeed
		for _,g in pairs(Misc.Wings.Out:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 0
				g.CanCollide = true
			end
		end
		for _,g in pairs(Misc.Wings.In:GetDescendants()) do
			if g:IsA("BasePart") then
				g.Transparency = 1
				g.CanCollide = false
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------
Events.CanopyEvent.OnServerEvent:connect(function(client, val)
	if val == "Open" then
		for _,g in pairs(Misc:GetDescendants()) do
			if g.Name == "Canopy" then
				g.Door.DoorHinge.Motor.DesiredAngle = -0.8
				if g:FindFirstChild("Trans") then
					for _,t in pairs(g.Trans:GetChildren()) do
						t.Transparency = 0
						t.CanCollide = true
					end
				end
			end
		end
	elseif val == "Close" then
		for _,g in pairs(Misc:GetDescendants()) do
			if g.Name == "Canopy" then
				g.Door.DoorHinge.Motor.DesiredAngle = 0
				if g:FindFirstChild("Trans") then
					for _,t in pairs(g.Trans:GetChildren()) do
						t.Transparency = 1
						t.CanCollide = false
					end
				end
			end
		end
	elseif val == "EJECT" then
		for _,g in pairs(Misc:GetDescendants()) do
			if g.Name == "Canopy" then
				g:Destroy()
			end
		end
		wait(0.1)
		for _,s in pairs(MainParts.Parent:GetDescendants())do
			if s:IsA("Seat") or s:IsA("VehicleSeat") then
				if s:FindFirstChild("SeatWeld") ~= nil then
					spawn(function ()
						Eject(s.SeatWeld.Part1.Parent)
					end)
				end
			end
		end
		EngineFunctions.Stop()
	end
end)
------------------------------------------------------------------------------------------------------------------
Events.LightsEvent.OnServerEvent:connect(function(client, val)
	if val == "NavOn" then
		NavOn = true
		repeat 
			for _, i in pairs (Strobes) do
				change(i, true)
			end
			wait(0.1)
			for _, i in pairs (Strobes) do
				change(i, false)
			end
			wait(0.1)
		until NavOn == false
	elseif val == "NavOff" then
		NavOn = false
		for _, i in pairs (Strobes) do
			change(i, false)
		end
	elseif val == "SpotOn" then
		for _,l in pairs (Misc.Lights:GetChildren()) do
			if l.Name == "Light" then
				change(l, true)
				if l:FindFirstChild("SpotLight") then
					l.SpotLight.Enabled = true
				end
				if l:FindFirstChild("Beam") then
					l.Beam.Enabled = true
				end
			end
		end
	elseif val == "SpotOff" then
		for _,l in pairs (Misc.Lights:GetChildren()) do
			if l.Name == "Light" then
				change(l, false)
				if l:FindFirstChild("SpotLight") then
					l.SpotLight.Enabled = false
				end
				if l:FindFirstChild("Beam") then
					l.Beam.Enabled = false
				end
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------
end,
function(script,require)
for _,i in pairs(script.Parent.Parent:GetChildren())do
	if i:IsA("BasePart") then
		i.Touched:Connect(function(hit)
			if hit ~= script.Parent then
				script.Parent:Destroy()
			end	
		end)
	end
end
end,
function(script,require)
--<< Gate Studios© Plane Kit by: Rengate >>--
------------------------------------------------------------------------------------------------------------------
local MainParts = script.Parent.Parent.MainParts
local engine = MainParts.Engine
local Events = script.Parent.Parent.Events
local Misc = script.Parent.Parent.Misc
local Settings = require(script.Parent.Parent.Settings.Config)
local StartUpTime = Settings.StartUpTime
------------------------------------------------------------------------------------------------------------------
-- USE THIS SCRIPT TO EDIT WHAT HAPPENS WHEN THE ENGINE STARTS AND STOPS
------------------------------------------------------------------------------------------------------------------
local EngineModule = {}
----------------------------------------------------------------------- 
	EngineModule.Stop = function()
		engine.Flying:Stop()
		engine.StartUp:Stop()
		for _,e in pairs(Misc:GetChildren()) do
			if e.Name == "FlameEmitter" then
				e.Emitter.Enabled = false
			elseif e.Name == "Vents" then
				e.Smoke.Enabled = false
			end
		end
	end
-----------------------------------------------------------------------
	EngineModule.StartUp = function()
		engine.StartUp:Play()
		for _,s in pairs(Misc:GetChildren()) do
			if s.Name == "Vents" then
				s.Smoke.Enabled = true
			end
		end
		wait(StartUpTime)
		engine.Flying:Play()
		engine.StartUp:Stop()
		for _,e in pairs(Misc:GetChildren()) do
			if e.Name == "FlameEmitter" then
				e.Emitter.Enabled = true
			elseif e.Name == "Vents" then
				e.Smoke.Enabled = false
			end
		end
	end
-----------------------------------------------------------------------
 
return EngineModule

end,
function(script,require)
for _,i in pairs(script.Parent.Parent:GetDescendants())do
	if i:IsA("Seat") or i:IsA("VehicleSeat") then
		i.ChildAdded:connect(function(child)
			if child.Name == "SeatWeld" then
				child.Part1.Parent["Left Arm"].Transparency = 1
				child.Part1.Parent["Right Arm"].Transparency = 1
			end
		end)
		i.ChildRemoved:connect(function(child)
			if child.Name == "SeatWeld" then
				child.Part1.Parent["Left Arm"].Transparency = 0
				child.Part1.Parent["Right Arm"].Transparency = 0
			end
		end)
	end
end
end,
function(script,require)
local Bricks = {}
local Going = true
local Settings = require(script.Parent.Parent.Settings.Config)
local EngineFunctions = require(script.Parent.EngineFunctions)
local Debris = game:GetService("Debris")

for _,i in pairs(script.Parent.Parent:GetDescendants()) do
	if i:IsA("UnionOperation") 
	or i:IsA("MeshPart") 
	or i:IsA("BasePart") then	
		table.insert(Bricks, i)
	end
end

function Kill()
	Going = false
	EngineFunctions.Stop()
	local Fire = script.Fire:Clone()
	Fire.Parent = script.Parent.Parent.MainParts.Engine
	Fire.Enabled = true
	local Sound = script.Alert:Clone()
	Sound.Parent = script.Parent.Parent.MainParts.Engine
	Sound:Play()
	Debris:AddItem(script.Parent.Parent,10)
end

function TakeDamage(hit,Damage)
	hit:Destroy()
	if Going == true then
		Going = false
		Settings.CurrentHealth = Settings.CurrentHealth - Damage
		if Settings.CurrentHealth <= 0 then
			Kill()
		end
		Going = true
	end
end

for _,b in pairs(Bricks) do
	b.Touched:Connect(function(hit) 
		if hit.Name == "MGBullet" then
			TakeDamage(hit,5)
		elseif hit.Name == "RocketHit" then
			TakeDamage(hit,300)
		end
	end)
end
end,
function(script,require)
--<< Gate Studios© Plane Kit by: Rengate >>--
------------------------------------------------------------------------------------------------------------------
local WeaponSpawn = script.Parent.Parent:WaitForChild("WeaponSpawns")
local Events = script.Parent.Parent:WaitForChild("Events")
local MainParts = script.Parent.Parent.MainParts
local Debris = game:GetService("Debris")
local Settings = require(script.Parent.Parent.Settings.Config)
local FX = script.Parent.Parent.FX
------------------------------------------------------------------------------------------------------------------
Events.WeaponsEvent.OnServerEvent:Connect(function(plr,val)
	if plr == MainParts.Owner.Value then
		if val == "FireMG" then
			for _,w in pairs(WeaponSpawn:GetChildren()) do
				if w.Name == "MG" then
					w.Fire:Play()
					w.Flame.Enabled = true
					w.Smoke.Enabled = true
				end
			end
		elseif val == "StopMG" then
			for _,w in pairs(WeaponSpawn:GetChildren()) do
				if w.Name == "MG" then
					w.Fire:Stop()
					w.Flame.Enabled = false
					w.Smoke.Enabled = false
				end
			end
		end
	end
end)

Events.WeaponsFunction.OnServerInvoke = function(plr,Weapon, Type, Pos, Bullet)
	if Weapon == "MG" and Type == "Explosive" then
		local Explo = Instance.new("Explosion")
		Explo.ExplosionType = Enum.ExplosionType.NoCraters
		Explo.Position = Pos
		Explo.BlastRadius = 8
		Explo.BlastPressure = 1000
		Explo.Visible = false
		local Part = Instance.new("Part", game.Workspace)
		Part.Position = Pos
		Part.Transparency = 1
		Part.Name = "MGBullet"
		Part.CanCollide = false
		local Sound = FX.ExplosionSound:Clone()
		Sound.Parent = Part
		Sound:Play()
		Explo.Parent = Part
		Debris:AddItem(Part,3)
	elseif Weapon == "MG" and Type == "NonExplosive" then
		local Part = Instance.new("Part", game.Workspace)
		Part.Position = Pos
		Part.Transparency = 1
		Part.Name = "MGBullet"
		Part.CanCollide = false
		Debris:AddItem(Part,0.5)
	elseif Weapon == "MG" and Type == "Human" then
		local Part = Instance.new("Part", game.Workspace)
		Part.Position = Pos
		Part.Transparency = 1
		Part.CanCollide = false
		local Blood = FX.Blood:Clone()
		Blood.Parent = Part
		local Sound = FX.BodyHit:Clone()
		Sound.Parent = Part
		Sound:Play()
		Blood:Emit(1)
		Bullet.Health = Bullet.Health - 110
		Debris:AddItem(Part,0.3)
	elseif Weapon == "Rocket" then
		local Explo = Instance.new("Explosion")
		Explo.ExplosionType = Enum.ExplosionType.NoCraters
		Explo.Position = Pos
		Explo.BlastRadius = Settings.BlastRadius
		Explo.BlastPressure = 1000
		local Part = Instance.new("Part", game.Workspace)
		Part.Position = Pos
		Part.Transparency = 1
		Part.Name = "RocketHit"
		Part.CanCollide = false
		local Sound = FX.ExplosionSound:Clone()
		Sound.Parent = Part
		Sound:Play()
		Explo.Parent = Part
		Debris:AddItem(Part,3)
	elseif Weapon == "Bomb" then
		local Explo = Instance.new("Explosion")
		Explo.ExplosionType = Enum.ExplosionType.NoCraters
		Explo.Position = Pos
		Explo.BlastRadius = Settings.BlastRadius * 1.5
		Explo.BlastPressure = 1500
		local Part = Instance.new("Part", game.Workspace)
		Part.Position = Pos
		Part.Transparency = 1
		Part.CanCollide = false
		local Sound = FX.ExplosionSound:Clone()
		Sound.Parent = Part
		Sound:Play()
		Explo.Parent = Part
		Debris:AddItem(Part,0.2)
	end
end
end,
function(script,require)
local Config = {
	--// FLIGHT MECHANICS
		MaxSpeed = 439;
		StallSpeed = 150;
		
		PitchSpeed = 17;
		RollSpeed = 10;
		YawSpeed = 10;
		
		Acceleration = 10;
		
		StartUpTime = 10;
		
	--//FLIGHT CONTROLS
		EngineKey = Enum.KeyCode.Y;
		ThrottleUp = Enum.KeyCode.LeftControl;
		ThrottleDown = Enum.KeyCode.Z;
		PitchUp = Enum.KeyCode.S;
		PitchDown = Enum.KeyCode.W;
		RollLeft = Enum.KeyCode.A;
		RollRight = Enum.KeyCode.D;
		YawLeft = Enum.KeyCode.Q;
		YawRight = Enum.KeyCode.E;
		
	--// GROUP ONLY
		isGroupOnly = false;
		GroupID = 0;
		MinGroupRank = 1;
		
	--// TEAM ONLY
		isTeamOnly = false;
		TeamName = "TeamNameHere";
	
	--// WEAPON CONFIGS
	
		MGAmmo = 2000;
		RocketAmmo = 40;
		MissileAmmo = 8;
		Bombs = 8;
		
		MGFireRate = 0.08;
		BulletSpeed = 2200;
		ExplosiveRounds = true; -- WARNING!!! WILL CAUSE LAG IF NOT FIRED IN SHORT BURSTS
		
		RocketSpeed = 2200;
		RocketFireRate = 1;
		BlastRadius = 20;
		
		MaxLockRange = 10000;
		
		MisisleLock = Enum.UserInputType.MouseButton3;
		
	--//HEALTH OPTIONS
		MaxHealth = 1000;
		CurrentHealth = 1000;
		
	--//ADJUST THIS IF YOUR BULLETS ARE HITTING YOUR OWN PLANE
		RoundOffset = 40;
		
	--//WEAPON CONTROLS
		MGKey = Enum.KeyCode.C;
		RocketKey = Enum.KeyCode.R;
		MissileKey = Enum.KeyCode.F;
		BombKey = Enum.KeyCode.B;
		
	--//SPECIAL CONTROLS
		SpotLights = Enum.KeyCode.L;
		NavLights = Enum.KeyCode.K;
		CanopyKey = Enum.KeyCode.T;
		GearKey = Enum.KeyCode.U;
		CameraKey = Enum.KeyCode.P;
		EjectKey = Enum.KeyCode.V;
		WingKey = Enum.KeyCode.H;
}
return Config

end,
function(script,require)
-- Simple Weld Script by Rengate, Gate Studios©
wait()
local IgnoreList = { --PUT THE NAME OF ITEMS YOU WANT IGNORED IN THE WELD AND THEN WHAT TYPE
	--	1 = If item is a parent model and you want everything in that ignored
	--  2 = If you want that specfic part ignored
	--  Example: {"Name", 1};
	{"Door",2};
	{"RotorModel",2};
}

local ModelsToIgnore = {}
--------------------------------------------------------------------------------------------------
-- WELD FUNCTION
function weldit(p1, p2)
	local w = Instance.new('Weld')
	w.Part0, w.Part1 = p1, p2
	w.C1 = p2.CFrame:inverse() * p1.CFrame
	w.Parent = p1
	w.Name = p2.Name
end
--------------------------------------------------------------------------------------------------
-- CHECKS IGNORE LIST
function CheckIgnore(Thing)
	local found = false
	for _,p in pairs(ModelsToIgnore) do
		if Thing == p or Thing:IsDescendantOf(p) then
			found = true
			break;
		end
	end
	for _,g in pairs(IgnoreList) do
		if g[2] == 1 then
			if Thing.Name == g[1] then
				found = true
				table.insert(ModelsToIgnore,Thing)
	            break;
			end
		elseif g[2] == 2 then
			if Thing.Parent.Name == g[1] then
				found = true
				table.insert(ModelsToIgnore,Thing.Parent)
				break;
			end
		end
	end
	return (found)
end
--------------------------------------------------------------------------------------------------
-- LOOKS FOR PARTS
function FindParts(Item)
	for _,i in pairs(Item:GetDescendants()) do
		local NoWeld = CheckIgnore(i)
		if NoWeld == false then
			if i:IsA("BasePart") then
				weldit(script.Parent.MainParts.Engine,i)
			end
		end
	end
end
FindParts(script.Parent)

function UnAnchor(Item)
	for _,i in pairs(Item:GetDescendants()) do
		local NoWeld = CheckIgnore(i)
		if NoWeld == false then
			if i:IsA("BasePart") then
				i.Anchored = false
			end
		end
	end
end
UnAnchor(script.Parent)
end
}
local ScriptIndex = 0
local Scripts,ModuleScripts,ModuleCache = {},{},{}
local _require = require
function require(obj,...)
	local index = ModuleScripts[obj]
	if not index then
		local a,b = pcall(_require,obj,...)
		return not a and error(b,2) or b
	end
	
	local res = ModuleCache[index]
	if res then return res end
	res = ScriptFunctions[index](obj,require)
	if res==nil then error("Module code did not return exactly one value",2) end
	ModuleCache[index] = res
	return res
end
local function Script(obj,ismodule)
	ScriptIndex = ScriptIndex + 1
	local t = ismodule and ModuleScripts or Scripts
	t[obj] = ScriptIndex
end

function RunScripts()
	for script, index in pairs(Scripts) do
		coroutine.wrap(function()
			ScriptFunctions[index](script, require)
		end)()
	end
end


local function DecodeUnion(Values,Flags,Parse,data)
	local m = Instance.new("Folder")
	m.Name = "UnionCache ["..tostring(math.random(1,9999)).."]"
	m.Archivable = false
	m.Parent = game:GetService("ServerStorage")
	local Union,Subtract = {},{}
	if not data then
		data = Parse('B')
	end
	local ByteLength = (data % 4) + 1
	local Length = Parse('I'..ByteLength)
	local ValueFMT = ('I'..Flags[1])
	for i = 1,Length do
		local data = Parse('B')
		local part
		local isNegate = bit32.band(data,0b10000000) > 0
		local isUnion =  bit32.band(data,0b01000000) > 0
		if isUnion then
			part = DecodeUnion(Values,Flags,Parse,data)
		else
			local isMesh = data % 2 == 1
			local ClassName = Values[Parse(ValueFMT)]
			part = Instance.new(ClassName)
			part.Size = Values[Parse(ValueFMT)]
			part.Position = Values[Parse(ValueFMT)]
			part.Orientation = Values[Parse(ValueFMT)]
			if isMesh then
				local mesh = Instance.new("SpecialMesh")
				mesh.MeshType = Values[Parse(ValueFMT)]
				mesh.Scale = Values[Parse(ValueFMT)]
				mesh.Offset = Values[Parse(ValueFMT)]
				mesh.Parent = part
			end
		end
		part.Parent = m
		table.insert(isNegate and Subtract or Union,part)
	end
	local first = table.remove(Union,1)
	if #Union>0 then
		first = first:UnionAsync(Union)
	end
	if #Subtract>0 then
		first = first:SubtractAsync(Subtract)
	end
	m:Destroy()
	return first
end

local function Decode(str)
	local StringLength = #str
	
	-- Base64 decoding
	do
		local decoder = {}
		for b64code, char in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split('')) do
			decoder[char:byte()] = b64code-1
		end
		local n = StringLength
		local t,k = table.create(math.floor(n/4)+1),1
		local padding = str:sub(-2) == '==' and 2 or str:sub(-1) == '=' and 1 or 0
		for i = 1, padding > 0 and n-4 or n, 4 do
			local a, b, c, d = str:byte(i,i+3)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8),bit32.extract(v,0,8))
			k = k + 1
		end
		if padding == 1 then
			local a, b, c = str:byte(n-3,n-1)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8))
		elseif padding == 2 then
			local a, b = str:byte(n-3,n-2)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000
			t[k] = string.char(bit32.extract(v,16,8))
		end
		str = table.concat(t)
	end
	
	local Position = 1
	local function Parse(fmt)
		local Values = {string.unpack(fmt,str,Position)}
		Position = table.remove(Values)
		return table.unpack(Values)
	end
	
	local Settings = Parse('B')
	local Flags = Parse('B')
	Flags = {
		--[[ValueIndexByteLength]] bit32.extract(Flags,6,2)+1,
		--[[InstanceIndexByteLength]] bit32.extract(Flags,4,2)+1,
		--[[ConnectionsIndexByteLength]] bit32.extract(Flags,2,2)+1,
		--[[MaxPropertiesLengthByteLength]] bit32.extract(Flags,0,2)+1,
		--[[Use Double instead of Float]] bit32.band(Settings,0b1) > 0
	}
	
	local ValueFMT = ('I'..Flags[1])
	local InstanceFMT = ('I'..Flags[2])
	local ConnectionFMT = ('I'..Flags[3])
	local PropertyLengthFMT = ('I'..Flags[4])
	
	local ValuesLength = Parse(ValueFMT)
	local Values = table.create(ValuesLength)
	local CFrameIndexes = {}
	
	local ValueDecoders = {
		--!!Start
		[1] = function(Modifier)
			return Parse('s'..Modifier)
		end,
		--!!Split
		[2] = function(Modifier)
			return Modifier ~= 0
		end,
		--!!Split
		[3] = function()
			return Parse('d')
		end,
		--!!Split
		[4] = function(_,Index)
			table.insert(CFrameIndexes,{Index,Parse(('I'..Flags[1]):rep(3))})
		end,
		--!!Split
		[5] = {CFrame.new,Flags[5] and 'dddddddddddd' or 'ffffffffffff'},
		--!!Split
		[6] = {Color3.fromRGB,'BBB'},
		--!!Split
		[7] = {BrickColor.new,'I2'},
		--!!Split
		[8] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = ColorSequenceKeypoint.new(Parse('f'),Color3.fromRGB(Parse('BBB')))
			end
			return ColorSequence.new(kpts)
		end,
		--!!Split
		[9] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = NumberSequenceKeypoint.new(Parse(Flags[5] and 'ddd' or 'fff'))
			end
			return NumberSequence.new(kpts)
		end,
		--!!Split
		[10] = {Vector3.new,Flags[5] and 'ddd' or 'fff'},
		--!!Split
		[11] = {Vector2.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[12] = {UDim2.new,Flags[5] and 'di2di2' or 'fi2fi2'},
		--!!Split
		[13] = {Rect.new,Flags[5] and 'dddd' or 'ffff'},
		--!!Split
		[14] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Axes.new(unpack(t))
		end,
		--!!Split
		[15] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Faces.new(unpack(t))
		end,
		--!!Split
		[16] = {PhysicalProperties.new,Flags[5] and 'ddddd' or 'fffff'},
		--!!Split
		[17] = {NumberRange.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[18] = {UDim.new,Flags[5] and 'di2' or 'fi2'},
		--!!Split
		[19] = function()
			return Ray.new(Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')),Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')))
		end
		--!!End
	}
	
	for i = 1,ValuesLength do
		local TypeAndModifier = Parse('B')
		local Type = bit32.band(TypeAndModifier,0b11111)
		local Modifier = (TypeAndModifier - Type) / 0b100000
		local Decoder = ValueDecoders[Type]
		if type(Decoder)=='function' then
			Values[i] = Decoder(Modifier,i)
		else
			Values[i] = Decoder[1](Parse(Decoder[2]))
		end
	end
	
	for i,t in pairs(CFrameIndexes) do
		Values[t[1]] = CFrame.fromMatrix(Values[t[2]],Values[t[3]],Values[t[4]])
	end
	
	local InstancesLength = Parse(InstanceFMT)
	local Instances = {}
	local NoParent = {}
	
	for i = 1,InstancesLength do
		local ClassName = Values[Parse(ValueFMT)]
		local obj
		local MeshPartMesh,MeshPartScale
		if ClassName == "UnionOperation" then
			obj = DecodeUnion(Values,Flags,Parse)
			obj.UsePartColor = true
		elseif ClassName:find("Script") then
			obj = Instance.new("Folder")
			Script(obj,ClassName=='ModuleScript')
		elseif ClassName == "MeshPart" then
			obj = Instance.new("Part")
			MeshPartMesh = Instance.new("SpecialMesh")
			MeshPartMesh.MeshType = Enum.MeshType.FileMesh
			MeshPartMesh.Parent = obj
		else
			obj = Instance.new(ClassName)
		end
		local Parent = Instances[Parse(InstanceFMT)]
		local PropertiesLength = Parse(PropertyLengthFMT)
		local AttributesLength = Parse(PropertyLengthFMT)
		Instances[i] = obj
		for i = 1,PropertiesLength do
			local Prop,Value = Values[Parse(ValueFMT)],Values[Parse(ValueFMT)]
			
			-- ok this looks awful
			if MeshPartMesh then
				if Prop == "MeshId" then
					MeshPartMesh.MeshId = Value
					continue
				elseif Prop == "TextureID" then
					MeshPartMesh.TextureId = Value
					continue
				elseif Prop == "Size" then
					if not MeshPartScale then
						MeshPartScale = Value
					else
						MeshPartMesh.Scale = Value / MeshPartScale
					end
				elseif Prop == "MeshSize" then
					if not MeshPartScale then
						MeshPartScale = Value
						MeshPartMesh.Scale = obj.Size / Value
					else
						MeshPartMesh.Scale = MeshPartScale / Value
					end
					continue
				end
			end
			
			obj[Prop] = Value
		end
		if MeshPartMesh then
			if MeshPartMesh.MeshId=='' then
				if MeshPartMesh.TextureId=='' then
					MeshPartMesh.TextureId = 'rbxasset://textures/meshPartFallback.png'
				end
				MeshPartMesh.Scale = obj.Size
			end
		end
		for i = 1,AttributesLength do
			obj:SetAttribute(Values[Parse(ValueFMT)],Values[Parse(ValueFMT)])
		end
		if not Parent then
			table.insert(NoParent,obj)
		else
			obj.Parent = Parent
		end
	end
	
	local ConnectionsLength = Parse(ConnectionFMT)
	for i = 1,ConnectionsLength do
		local a,b,c = Parse(InstanceFMT),Parse(ValueFMT),Parse(InstanceFMT)
		Instances[a][Values[b]] = Instances[c]
	end
	
	return NoParent
end


local Objects = Decode('AFR7BCEFTW9kZWwhBE5hbWUhBEEtMTAhCldvcmxkUGl2b3QE2gPbA9wDIQZGb2xkZXIhBEJvZHkhDlVuaW9uT3BlcmF0aW9uIQpCcmlja0NvbG9yB+sDIQZDRnJhbWUEFgDdA94DIQpDYW5Db2xsaWRlAiEFQ29sb3IGERERIQhNYXRlcmlhbAMAAAAAAACRQCELT3JpZW50YXRpb24KpHDlQA'
..'rXI7y4Hk1BIQhQb3NpdGlvbgphhr1CjnlbQd5yscMhCFJvdGF0aW9uIQRTaXplCo9LET6MSxE+3XjoPSEEUGFydAqOSxE+iUsRPtp46D0K43joPd146D3WeOg9ClOKvUJtrFtBuHqxwwqkcOVACtcjPLgeTUEhBFdlbGQhCE1haW5XZWxkB/kDBCQA3QPeAwb/rwAK4oq9QqqbW0FedrHDCuh4'
..'6D3deOg9zcxMPQrkeOg92HjoPZqiKj4K4Iq9QtV9W0H2brHDCrhI7j7Piqg+mKIqPgrxb71C0zdcQchnscMKpHDlQArXozy4Hk1BBC4A3wPgAwMAAAAAAICUQAqux6PCrkcKQrgeCcIK4Ra/QvypWkGvcLHDCriepsJI4ZJACtejPAop6xg/aD/yPmg/8j4hDEN5bGluZGVyTWVzaCEFU2NhbG'
..'UKE4NAPhODQD4Sg8A+IQpNYW51YWxXZWxkIRpQYXJ0LXRvLVVuaW9uIFN0cm9uZyBKb2ludAQ3AN8D4AMKnlG/QmC4WkF+cLHDBDoA3QPeAwb4+PgK4RW9QumsWkG/c7HDCo5LET6LSxE+2njoPQrjeOg93HjoPdZ46D0K0xm9QsjfWkGZe7HDCo5LET6JSxE+2HjoPQcYAARDAOED4gMG9c0w'
..'CgAAXMIfBbrCAAAAAAp1S8ZCkmcAQansssMKMzO4wo/CC8IKV7vCCvDmBkDsLm1AJV4UQQoAAABAzcxMPs3MTD4KThnFQm+1PkEN97LDAwAAAAAAABBACgAAgD8AAIA/AACAPwoAAAAAAAAAAAAAAAAKEPTDQtPQS0Hn+rLDCpZpx0JQliRBMe+ywwpYRMZCs7ExQQvzssMK/P8/QM3MTD7NzE'
..'w+CrDFxULQJzhBEGizwwoAAAAA16NAwAAAXMIK+/8/QM3MTD7NzEw+CrCSxULjJzhBMnWywwoAAOBAzcxMPs3MTD4K7BvIQvNb2UCHYLPDCgrXI7zXo0DAAACqwgrS6MdCjV3ZQKltssMKlZXHQriIFEH37rLDCgAAqsL2KLrCKVyPPQoDacdCIHkkQZHvssMKaHXIQr+uiUD167LDCvqhyELg'
..'m1NAW+uywwrxTchCt5apQHzsssMKXyHIQod3yUAW7bLDCrXvx0IsUelAwO2ywwojw8dCAZkEQVrussMhDUNsaWNrRGV0ZWN0b3IhBlNjcmlwdCEOT3BlbkRvb3JTY3JpcHQEZQDjA+QDCgAAAADD9bPCCtcjPAqsML9Cm4GYQD+5z8MKCtcjvAAAtMIAAAAACqvaaEA0DgdBq9roPyEMVHJhbn'
..'NwYXJlbmN5AwAAAAAAAPA/IQRTbmFwIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAB/YDBHIA5QPkAwaqVQADAAAAAAAAckAKAAAAAD0KtEIK1yO8CqWrsUJWxU1BYbXGwwoK1yO8AAC0QgAAAAAKcoENQOhAhkCOLWRAIQpUb3BTdXJmYWNlIQVTaGFwZQMAAAAAAAAAQAR5AOUD5AMKpXPMQuLF'
..'TUE3tcbDB20BBH4A5gPnAwZqOQkKuB6mQhTuM0Ok8DNDCiKavkKkmFFBjGSxwwpI4cFCCtcjPArXIzwKyXmlPvPXzj6OeSU+IQxVc2VQYXJ0Q29sb3IiCoh5JT7w184+iHklPgrJw75CwitUQQliscMK8NfOPoh5pT6HeSU+CmyavkIy41JBSmOxwwoK1yM8HwW0wnsU3sAKD3G+QqKaUUGLZL'
..'HDCgxxvkKtK1RBCmKxwwq4HqbCKVyPvUjhs8IKzMO+QreaUUGKZLHDCvDXzj/q184+8CGbPwoHXL5CXYpVQT48scMHwgAEkgDoA+kDBqOipQoUrs9ACtejvAAAAAAKZI+9QslJU0GOebHDCnJnND+Byyw/n2crPgpT4yU+VeMlPv7jJT4K0ia+QqO9T0EdfbHDAwAAAAAAABhACgD8fz///38/'
..'AACAPwpU4yU+VeMlPv3jJT4K/iq+Qi1qUUGXe7HDCujwvUI0alFBmHuxwwrTJr5CnXlTQbd5scMKU+MlPlXjJT794yU+CixpvkIlalFBlnuxwwrSJr5C7lBSQcV6scMK/iq+Qnj9U0E/ebHDCujwvUJ//VNBQHmxwwrTJr5C6AxWQV93scMKLGm+QnD9U0E+ebHDClbjvELOvU9BJX2xwwqC57'
..'xCWGpRQZ97scMKbK28Ql9qUUGge7HDClfjvELIeVNBv3mxwwqwJb1CUGpRQZ57scMKVuO8QhlRUkHNerHDCoLnvEKj/VNBR3mxwwpsrbxCqv1TQUh5scMKV+O8QhMNVkFnd7HDCrAlvUKb/VNBRnmxwwpT4yU+VeMlPvzjJT4KYgC9Qk8/TEHVf7HDClTjJT5V4yU+/OMlPgqOBL1C2etNQU9+'
..'scMKeMq8QuDrTUFQfrHDCmMAvUJJ+09Bb3yxwwq8Qr1C0etNQU5+scMKU1O9QkQ/TEHTf7HDCn9XvULO601BTX6xwwppHb1C1etNQU5+scMKVFO9Qj77T0FtfLHDCq2VvULG601BTH6xwwpFpr1COT9MQdF/scMKcaq9QsPrTUFLfrHDCltwvULK601BTH6xwwpGpr1CM/tPQWt8scMKn+i9Qr'
..'vrTUFKfrHDCjb5vUIuP0xBz3+xwwpi/b1CuOtNQUl+scMKTMO9Qr/rTUFKfrHDCjf5vUIo+09BaXyxwwqQO75CsOtNQUh+scMKZAC9QuHQVUHrdrHDCpAEvUJrfVdBZXWxwwp6yrxCcn1XQWZ1scMKZQC9QtuMWUGFc7HDCr5CvUJjfVdBZHWxwwpVU71C1tBVQel2scMKgVe9QmB9V0FjdbHD'
..'CmsdvUJnfVdBZHWxwwpWU71C0IxZQYNzscMKr5W9Qlh9V0FidbHDCkemvULL0FVB53axwwpzqr1CVX1XQWF1scMKXXC9Qlx9V0FidbHDCkimvULFjFlBgXOxwwqh6L1CTX1XQWB1scMKOPm9QsDQVUHldrHDCmT9vUJKfVdBX3WxwwpOw71CUX1XQWB1scMKOfm9QrqMWUF/c7HDCpI7vkJCfV'
..'dBXnWxwyEbVW5pb24tdG8tVW5pb24gU3Ryb25nIEpvaW50BNoA6gPrAwqPwuVAAAAAAHsUnsAK4M+/QsblW0FecrHDCo9LET6KSxE+2njoPQrjeOg93njoPdZ46D0KW9S/QkAOXEFDerHDCnsU5kAK16M8exSewAThAOwD7QMKSOFPQkhhwkKPwqHCCiSMv0Jb90pBCnWxwwoULr9CUrgWQlL4'
..'M8MK0izXPmbeRT534sI+Con6FD6D+hQ+h/oUPgrsxb9C9hBLQQZ4scMKgvqUPoL6FD7Jd98+Cji/v0I/30pBcHWxwwpI4RVC9qi8wo/C/UAKOdcWP3/6FD58+hQ+Cuw3wEL+DVBB8ISxwwquR8nASOESwXsUFcIKOtcWP3/6FD6F+hQ+Ci8pwEJes09BOIWxwwqK+hQ+gvoUPo36FD4Kel6/Qt'
..'oQS0EJeLHDCmZmWMJIYaRC7NGgwgqC+pQ+iPoUPsl33z4KXWW/Qi7hSkFxdbHDCq5HDUKk8LtCSCEewwo91xY/f/oUPnz6FD4KSqq+QsVHTUEnh7HDCpqZjUGamRHBrkeHQgo61xY/hvoUPoT6FD4Kc7m+QqPxTEFqh7HDCn/nMz555zM+dGTKPgokjL9C2fNKQexzscMKCtcjvMP1s0LNzKjC'
..'BP4A7gPvAwq4HvVBM7O6wsP1pkIK48m+QmopS0H8f7HDCo9Cv0KPwmzCUvgzwwqK+hQ+zcxMPYf6FD4KivoUPsC5rj6H+hQ+Ct3JvkIq70pBb22xwwqX3ik/xjwZPsp33z4KhsW+QgwVS0HjZrHDCsP1asKkcKHCXI+KwAoh3ho/tUAVPpHeqT4K/1S/QpBSR0HCl7HDCilcD0Bcj7JAwzUGww'
..'oq/qs/wzwZPoT6FD4KdUu/QurRR0Ffl7HDBxUABA4B6gPrAwbEKBwK4TPAQgJrW0Huc7HDCuZ46D3beOg9XRmXPQqpWq4+olquPi3rHD4K2zPAQuEwW0GEZbHDCuJ46D3YeOg93HjoPQrhM8BC1WBbQWhxscMhCE1lc2hQYXJ0IQlTaW5nZVhBR00EGAHwA/EDCgrXI7wAAAAAAAAAAAr5bq9C'
..'1b6hQKe6vcMKc4gbQNq0LkCmpz1BIQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8xMTEzMDI4MDAyIQhNZXNoU2l6ZQoAAEhCNq9TQvSPZ0MhCVRleHR1cmVJRCEXcmJ4YXNzZXRpZDovLzExMTMwNDMwNDIEIQHjA+QDCovQv0I60jBBdeXBwwoUc2BCSNC/QCfq80AEJAHjA+QDCnd+v0JVSCZBN2'
..'S+wwqsvklB0gEYQBnMoUIEKAHyA/MDCnsUoMIK1yO9CtejPAqib7xCCBNSQT1sscMKexSgwgrXI7wK16O8Ckxppj565zM+IesYPwqf3Xs+dOczPjNugj4KYW28QgoFVEGAbbHDCoXri8Jx/TNDcf0zQwpJaaY+deczPiDrGD8hBVNoZWxsBDEB9AP1Awrw3r5C6RNHQbr6vcMKnqGgQpGmdUGL'
..'G5JCIRdyYnhhc3NldGlkOi8vMTEwODQzMTE3MgrBx4JDAABIQkXpbUMhB0NvY2twaXQHGgAEOQHwA/EDBhsqNQo+dL5CzmMwQXVJtcMKZAPIQAgiK0EqesxBIRdyYnhhc3NldGlkOi8vMTExMjg2OTkwNgoAAEhC50OpQn8bSUMhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9Mj'
..'EwMjc5MjgxNyEMV2VhcG9uUG9ydGVyBEAB8APxAwo5cb9CBeDWQNaXvcMKYGUTQh3jfkDwQT9BIRdyYnhhc3NldGlkOi8vMTEwOTI0NTk5MArs8vBDAABIQoQSFkMhBEdhdTgERgHwA/EDCuAcvEII/NlASBavwwq7z55AFJKDQFSmcEEhF3JieGFzc2V0aWQ6Ly8xMTA5MjYwMDUxCgeCdUIB'
..'AEhClMk3QyEIVHVyYmluZXMETAHwA/EDCvcDv0KjejRBxibJwwpAH5pBl/QrQQwz5UEhF3JieGFzc2V0aWQ6Ly8xMTEyNzU3MTYwCmQIs0L+/0dCm6gFQyEKRnJvbnQgUGFkcwRSAfAD8QMK6sq+QkINAEG7hLvDCgobnUG9XQpAtO7ZPyEXcmJ4YXNzZXRpZDovLzExMTI4NTM0MDIK2szWQ4'
..'BIOEIwERlCBFcB3QPeAwriGb1CBsVaQbB0scMKq1quPqFarj4r6xw+CtoZvULtilpBRmaxwwrieOg91XjoPd146D0K4Rm9Qty6WkEqcrHDBF0B6gPrAwpgL8BCZl5bQe5yscMK4njoPdx46D3WeOg9CtszwELghltB03qxwwqOSxE+iUsRPtd46D0hBVBhcnQxB0ABBGYB8APxAwbKy9EDAAAA'
..'AACAmEAKZqi+Qm6jaEHxgbLDCtnqg0DH0n5AxBBgQQMAAACgmZnpPyEXcmJ4YXNzZXRpZDovLzExMTI4NzU1NDYKaKdRQgAASEJABTNDIQlsZWZ0bGlnaHQHMwEEbwHwA/EDBhAq3AqfZgdDqlIoQXVNv8MK8PzMPhqmqD4KqC4/IRdyYnhhc3NldGlkOi8vMTExMjkyMTM4NgqAknpBUKiCQY'
..'CU8kEhBnJsaWdodAfsAwR3AfAD8QMG/wAACvngXUKA+i1Bl3m/wwq77Mw+n52oPj+jLj8hF3JieGFzc2V0aWQ6Ly8xMTEyOTcxNjM3CoCpfUGQSINBgO3yQSEFUmZsYXAEfQHwA/EDCr54lULoBRZB/yu/wwoZvAFC1AKSQJU7N0EhF3JieGFzc2V0aWQ6Ly8xMTEyOTkzNDIyCro2sUP//0dC'
..'1uP8QiEFTGZsYXAEgwHwA/EDCv446ELqxBBBHiK/wwr7uwFC1gKSQAWvNUEhF3JieGFzc2V0aWQ6Ly8xMTEzMDE0OTI0CqYzukMAAEhCs2UGQyEEVGFpbASJAfAD8QMKVSS/QlrWW0HPx87DCqxv3UEWqklBqDn2QCEXcmJ4YXNzZXRpZDovLzExMTMwMTk2NTIKi9KEQwwK8UIAAEhCIQ9TdG'
..'FuZGFyZE1pc3NpbGUEjwHwA/EDCjhJ9EL4ydBAcWq9wwpBbDNAX15yQGahkkEhF3JieGFzc2V0aWQ6Ly8xMTEzMDI1NzMyCgBaL0J63mxCnk2PQyEXcmJ4YXNzZXRpZDovLzExMTMwNDA2NjYhBFhBR00ElgHwA/EDCnzb4UL0/adANKq9wwpSnGxAyzYXQFrrKkEhF3JieGFzc2V0aWQ6Ly8x'
..'MTEzMDI2NDg1CuBAkkIBAEhCXrcIQwSbAfAD8QMKPA2dQlcPsUCfqr3DBJ0B8APxAwo4OIlCFMDTQBprvcMEnwHwA/EDCj2Hz0I+wKFAarq9wwSiAfYD9wMKAAAAAD0KtELs0ajCCuLIvkJ480pB+nOxwwrs0ajCAAC0QgAAAAAKzcxMPs3MTD7NzEw+IQlCbG9ja01lc2gKW+FgP1DhYD9Q4W'
..'A/BKgB3wPgAwohfr9CojlcQf9uscMKteiqPmg/8j5oP/I+B/wDBK0B8gPzAwYA/wAKIW28Qu77U0FuaLHDCqHdez7NzEw+hGqdPgoAAIA/UOFgPwAAgD8EsQHyA/MDCqHUwEIU/FNBPGixwwSzAfID8wMKYtfAQgwTUkH7a7HDCiHVwEIOBVRBPm2xwwS2AfYD9wMK4ka9QozSSkH7c7HDBzIB'
..'BLsB+AP5AwYzWIIKuB6mwilcj73D9TPDCuKZvkJmKVRBLGKxwwq4HqbCCtcjvFL4M0MKiHklPvLXzj6HeSU+CjtwvkJMllFBsGSxwwrx184+h3mlPoh5JT4KmJm+QtjeUkFuY7HDCgAAAACk8LNCXA8twwr1wr5CZSdUQSxiscMK+MK+QlqWUUGtZLHDCvHXzj6IeaU+hnklPgq4HqZCFO4zQ3'
..'sUtMIKOHC+QlcnVEEvYrHDCvDXzj/p184+8SGbPwrh175Ckx9PQZtCscMHdwAEzQH6A/sDBqS9RwoUrs9ACtejvArXI7wKYqW/QgIwU0GccbHDCv7U+D7+1Pg+zcxMPgoAAIA/AACAPyhcTz8H9AME0wH6A/sDBiFUuQpiib1C8i9TQR5xscME1QHsA+0DCiMKvkLM1UpB+3SxwwrrQ75CZ+9K'
..'Qfd3scMKNz2+QrC9SkFhdbHDCuu1vkJv7E9B4YSxwwoup75Cz5FPQSmFscMKedy9QkvvSkH6d7HDClzjvUKfv0pBYnWxwwpJKL1CNiZNQRiHscMKcje9QhTQTEFbh7HDCiMKvkJK0kpB3XOxwwTgAe4D7wMKpEe9QsQIS0H8f7HDCp5HvUKEzkpBb22xwwpHQ71CZvRKQeNmscMKwNK9QuoxR0'
..'HCl7HDCjbJvUJEsUdBX5exwwTmAfoD+wMKYqm/QthPU0GdebHDClPjJT5W4yU+/uMlPgrKQMBCfMNPQS19scMKVOMlPlbjJT794yU+CvlEwEIFcFFBp3uxwwrjCsBCIXBRQah7scMK0EDAQnZ/U0HHebHDClPjJT5W4yU+/eMlPgong8BC5m9RQaZ7scMKzkDAQsdWUkHVerHDCv1EwEJQA1RB'
..'T3mxwwrnCsBCbANUQVB5scMK1EDAQsESVkFvd7HDCiuDwEIxA1RBTnmxwwpP/b5CGsRPQTR9scMKfgG/QqNwUUGue7HDCmjHvkK/cFFBr3uxwwpV/b5CFIBTQc55scMKrD+/QoRwUUGte7HDClP9vkJlV1JB3HqxwwqCAb9C7gNUQVZ5scMKbMe+QgoEVEFXebHDCln9vkJfE1ZBdnexwwqwP7'
..'9CzwNUQVV5scMKU+MlPlbjJT784yU+ClYav0KQRUxB5H+xwwpU4yU+VuMlPvzjJT4KhR6/QhnyTUFefrHDCm/kvkI18k1BX36xwwpcGr9CigFQQX58scMKs1y/QvrxTUFdfrHDCkdtv0JoRUxB4n+xwwp2cb9C8fFNQVx+scMKYDe/Qg3yTUFdfrHDCk1tv0JiAVBBfHyxwwqkr79C0vFNQVt+'
..'scMKOMC/Qj9FTEHgf7HDCmfEv0LI8U1BWn6xwwpRir9C5PFNQVt+scMKPsC/QjkBUEF6fLHDCpUCwEKp8U1BWX6xwwoqE8BCF0VMQd5/scMKWRfAQqDxTUFYfrHDCkPdv0K88U1BWX6xwwowE8BCEQFQQXh8scMKh1XAQoHxTUFXfrHDCmUav0Ii11VB+naxwwqUHr9Cq4NXQXR1scMKfuS+Qs'
..'eDV0F1dbHDCmsav0Ick1lBlHOxwwrCXL9CjINXQXN1scMKVm2/QvrWVUH4drHDCoVxv0KDg1dBcnWxwwpvN79Cn4NXQXN1scMKXG2/QvSSWUGSc7HDCrOvv0Jkg1dBcXWxwwpHwL9C0dZVQfZ2scMKdsS/QlqDV0FwdbHDCmCKv0J2g1dBcXWxwwpNwL9Cy5JZQZBzscMKpALAQjuDV0FvdbHD'
..'CjkTwEKp1lVB9HaxwwpoF8BCMoNXQW51scMKUt2/Qk6DV0FvdbHDCj8TwEKjkllBjnOxwwqWVcBCE4NXQW11scMEKgL8A/0DCriepsIK16O/uB6lPwphKr5CAwdcQY1ascMK16OmwpqZGb4K16M8CqRlwT5qP/I+KQqVPQqe7QY/eV9uP3LnMz4KgiK+QobaXUGlTrHDCo/CxcCkcDJDpPAzww'
..'qiZcE+aT/yPnTnMz4KUCq+QlnYXEHJWbHDBDQC/gP/AwoAgKbCj8LlQB+F48AKYS2/QjAxXEFfWrHDCriepsI9Clc/CtejPAo6boI+aj/yPs3MTD0KO26CPmg/8j5U5Uw+CvEtv0JzYl1BQFmxwwpSLQk/vWpHP/jnMz4KLVa/QjQtXkGYWbHDCilcx8AzczJDM/MywwQ9AuoD6wMK4dS/Ql/8'
..'W0H/dbHDCuZ46D3ZeOg9maIqPgrh1L9CgN5bQZduscMKuEjuPs+KqD6Xoio+ClzDv0KRz1xBMWexwwp7FOZAj8L1PHsUnsAHNwEERgLfA+ADBp+hrAohfr9CJEZaQe9wscMESALfA+ADCuHtvULWkFpBn3CxwwoEqSg/aD/yPmg/8j4ESwLfA+ADCp41vkLzflpBrnCxwwqxrA0/aD/yPmg/8j'
..'4ETgLfA+ADCuJtvkKY0lpBfnCxwwrP484+aD/yPmg/8j4hCU1haW5QYXJ0cyELT2JqZWN0VmFsdWUhBU93bmVyIQRTZWF0IQlQaWxvdFNlYXQhC0JhY2tTdXJmYWNlBFoCAAQBBCEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoK1yM8AAA0QwAAAAAK7pu+QvQaOEEHyLLDIQxSaWdodFN1'
..'cmZhY2UKcf0zQwAAAAAAADRDCniq5j/SJYA+pp6+PyEJU2NyZWVuR3VpIQ5GbGlnaHRDb250cm9scyEFUGxhbmUhBVZhbHVlIQVGcmFtZSEDSFVEIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAIA/AAAAAIA/AAAhB1Zpc2libGUhBk9yaWVudAwAAA'
..'A/2P8AAAA/9v8MAAAAAFAAAAAAABQAIQZaSW5kZXghCVRleHRMYWJlbCEETGluZQYAyAAhD0JvcmRlclNpemVQaXhlbAwAAAAAAAAAAAA//v8MAAAAABkAAAAAAAQAIQRGb250AwAAAAAAAAhAIQRUZXh0IQAhCFRleHRTaXplAwAAAAAAACxAIQpJbWFnZUxhYmVsIQVBcnJvdwwAAAA/8f8A'
..'AAA/9v8MAAAAAB4AAAAAABQAIQVJbWFnZSEpaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0xNDA4NDY2NTIMAACAP+f/AAAAP/7/IQ5TY3JvbGxpbmdGcmFtZSEKV2VhcG9uQW1tbwZ/f38DAAAAAAAA4D8DAAAAAAAAFEAMCU7WPgAAzsyMPgAADAAAAAC+AAAAAABQACEYSG9yaX'
..'pvbnRhbFNjcm9sbEJhckluc2V0IRJTY3JvbGxCYXJUaGlja25lc3MhDFVJTGlzdExheW91dCEJU29ydE9yZGVyIQlVSVBhZGRpbmchC1BhZGRpbmdMZWZ0EgAAAAAFACELTG9jYWxTY3JpcHQhCEdVSSBEcmFnIQlNYWluRnJhbWUMH+qhPgAAkiQJPgAADAAAAACuAQAAAAAtACEDQUxUDK9b'
..'hTwAAAAAAAAAAAwAAAAAmwAAAAAAGgADAAAAAAAAJEAhCiBBTFRJVFVERTohClRleHRDb2xvcjMDAAAAAAAAKkAhFlRleHRTdHJva2VUcmFuc3BhcmVuY3khDlRleHRYQWxpZ25tZW50IQxVSUdyaWRMYXlvdXQhE0hvcml6b250YWxBbGlnbm1lbnQhC0NlbGxQYWRkaW5nDAAAAAACAAAAAA'
..'ACACEIQ2VsbFNpemUMAAAAAIwAAAAAABQAIQNTUEQhByBTUEVFRDohBkNPT1JEUyEQQ2xpcHNEZXNjZW5kYW50cyEVQ09PUkRTOiAoMDAwMDAsMDAwMDApIQpUZXh0QnV0dG9uIQ1XZWFwb25zQnV0dG9uBhsqNQwAAAAAyAAAAAAAMgADAAAAAAAAIkAhEFdFQVBPTlMgQ09OVFJPTFMDAAAA'
..'AAAALkAhD1RDb250cm9sc0J1dHRvbiEIQ09OVFJPTFMhC1dlYXBvbnNBbW1vIQxXRUFQT05TIEFNTU8hCENvbnRyb2xzDMHKoT4AAM7MjD4AACEOV2VhcG9uQ29udHJvbHMM9jgKPwAAzsyMPgAAIRNGbGlnaHRDb250cm9sQ2xpZW50IQlDb3B5cmlnaHQMAQ7gOwAAAABcPwAADAAAAAA4AA'
..'AAAAA4ACEXcmJ4YXNzZXRpZDovLzM0MTA1Nzg5OTUhEUltYWdlVHJhbnNwYXJlbmN5DAAAgD8AANu2bT4AAAwAAAAAeAAAAAAAKwADAAAAAAAAMUAhH1BMQU5FIFNDUklQVFMgQlkgR0FURSBTVFVESU9TwqkDAAAAAAAAKEAhC1RleHRXcmFwcGVkIQtOdW1iZXJWYWx1ZSEJQmFzZVNwZWVk'
..'IRNGbGlnaHRDb250cm9sU2VydmVyIQtDYW1lcmFSZXNldCEIRGlzYWJsZWQhDENIQU5HRSBOT1RFUyEHQWltUGFydATMAgIEAwQGGyo1CoXrkb/h+jPDAAAAAAqPUL9CLQ/PQOUurMMKKdwywwrXo7wAADRDCgpmNj+3MnM+tzJzPiEGRW5naW5lBNECBAQFBApr675Chsv5QDqpu8MKFjvIQE'
..'YvoD9bKYxBIQVTb3VuZCEGRmx5aW5nIQZMb29wZWQhElJvbGxPZmZNYXhEaXN0YW5jZQMAAAAAAGr4QCESUm9sbE9mZk1pbkRpc3RhbmNlIQtSb2xsT2ZmTW9kZSEHU291bmRJZCEXcmJ4YXNzZXRpZDovLzE1NzE0MDgzNTAhBlZvbHVtZSEPRWNob1NvdW5kRWZmZWN0IQhGZWVkYmFjayEH'
..'U3RhcnRVcAMAAAAAAECPQCElaHR0cDovL3JvYmxveC5jb20vYXNzZXQvP2lkPTE1MDQ4NTkxMwMAAABAMzPjPyEIQm9keUd5cm8EBgQHBAgEIQlNYXhUb3JxdWUhDEJvZHlWZWxvY2l0eSEITWF4Rm9yY2UhBVVuaW9uIQJDMQQJBAoECwQhBVBhcnQwBAwECgQLBAQNBA4EDwQEEAQOBA8EBB'
..'EECgQLBAQSBBMEFAQEFQQWBBcEBBgEGQQaBAQbBBkEGgQEHAQdBB4EBB8EIAQhBAQiBCMEJAQEJQQmBCcEBCgEKQQqBAQrBCMEJAQELAQtBC4EBC8EFgQXBAQwBBYEFwQEMQQyBDMEBDQELQQuBAQ1BC0ELgQENgQtBC4EBDcELQQuBAQ4BC0ELgQEOQQtBC4EBDoECgQLBAQ7BCMEJAQEPAQt'
..'BC4EBD0ELQQuBAQ+BC0ELgQEPwQtBC4EBEAELQQuBARBBC0ELgQEQgQtBC4EBEMELQQuBAREBC0ELgQERQQtBC4EBEYELQQuBARHBEgESQQESgQOBA8EBEsEMgQzBARMBDIEMwQETQQyBDMEBE4ESARJBARPBFAEUQQEUgRTBFQEBFUEUwRUBARWBCYEJwQEVwQpBCoEBFgEUwRUBARZBFoEWw'
..'QEXARdBF4EBF8EIwQkBARgBA4EDwQEYQQOBA8EBGIEDgQPBARjBA4EDwQEZARlBGYEBGcEaARpBARKAGUEZgQhB0Nsb3NlUkcEagQtBC4EIQdDbG9zZUZHBGsELQQuBCEER2VhcgRsBGUEZgQhBUxpZ2h0IQJNRwRtBG4EbwQhCUJvbWJTcGF3bgRwBHEEcgQhDE1pc3NpbGVTcGF3bgRzBHEE'
..'cgQEdARxBHIEIQtSb2NrZXRTcGF3bgR1BGUEZgQEdgRlBGYEBHcEcQRyBCEETWlzYyELTGFuZGluZ0dlYXIhBkNsb3NlZAQ+A/AD8QMDAAAAAACAiUAKdsG+QtCutUCzhLzDCrqVzEE5g49A4YtCQSEXcmJ4YXNzZXRpZDovLzExMTI5MDY0OTEKaNGfQwAASEIu4BFDBEMD8APxAwroJLtCH9'
..'TnQLp3sMMKXO3tP9/Uiz+67TxBIRdyYnhhc3NldGlkOi8vMTExMjg5ODc5OAoA/BtCAGKmQfWJgEMhBE9wZW4ESQMABAEECp3EvkK2uXlAvTy4wwpBfMVBOtX5QA7o5kEhF3JieGFzc2V0aWQ6Ly8xMTEzMTk5Nzk1CgxoEkMAAEhCQzQmQyEGTGlnaHRzIQZFdmVudHMhC1JlbW90ZUV2ZW50'
..'IQdUYWtlb2ZmIQlHZWFyRXZlbnQhC0Nhbm9weUV2ZW50IQtMaWdodHNFdmVudCEMV2VhcG9uc0V2ZW50IQ5SZW1vdGVGdW5jdGlvbiEPV2VhcG9uc0Z1bmN0aW9uIQJGWCEORXhwbG9zaW9uU291bmQhFnJieGFzc2V0aWQ6Ly8yNjg4Njk3MTchD1BhcnRpY2xlRW1pdHRlciEFQmxvb2QoAg'
..'AAAAD/AAAAAIA//wAAIQdFbmFibGVkIQhMaWZldGltZREAAIA/AACAPyEEUmF0ZSEIUm90U3BlZWQRAACgQAAAoEERAABIQgAAoEIpAwAAAADg1vw9AAAAACFboz3W2ENAAAAAAAAAgD8dxzFAAAAAACEFU3BlZWQRAAAAQAAAAEAhC1NwcmVhZEFuZ2xlCwAAIEEAACBBIQdUZXh0dXJlIRZy'
..'Ynhhc3NldGlkOi8vMTcyODQxOTAwKQMAAAAAAAAAAAAAAAChxAw/AAAAAAAAAAAAAIA/AACAPwAAAAAhB0JvZHlIaXQhF3JieGFzc2V0aWQ6Ly8xNTY1NzI1MDI4IQtTcGVjaWFsTWVzaCEKUm9ja2V0TWVzaCELVmVydGV4Q29sb3IhF3JieGFzc2V0aWQ6Ly8zNjg2MjY0MTIwIQhNZXNoVH'
..'lwZSEIQm9tYk1lc2ghF3JieGFzc2V0aWQ6Ly8zNjg2MzUzMTY3IQtSb2NrZXRUcmFpbCgCAAAAAP//fgAAgD8AAAARMzOzPjMzsz4hDUxpZ2h0RW1pc3Npb24DAAAAAAAAWUApAgAAAABmZmY/AAAAAAAAgD9mZmY/AAAAACEpaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0yNDE2'
..'ODU0ODQhDVBhcmFjaHV0ZU1lc2ghBk9mZnNldAoAAAAAAACgQAAAAAAhKWh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTE5NzgwNTE3IQpFamVjdFNvdW5kIRdyYnhhc3NldGlkOi8vMjcwNjIyODQzMAMAAAAAAAD4PyEQTWlzY0xvY2FsU2NyaXB0cyEUQmFzaWNGdW5jdGlvbn'
..'NDbGllbnQhDUdVSUNvbnRyb2xsZXIhCFRlbXBsYXRlDAAAAACbAAAAAAAUACEDTi9BAwAAAAAAADJAIRBDYW1lcmFDb250cm9sbGVyIRVXZWFwb25GdW5jdGlvbnNDbGllbnQhC1RhcmdldEZyYW1lDFEP9T4AAKfg5T4AAAwAAAAAKAAAAAAAKAAhB01haW5SZXQhF3JieGFzc2V0aWQ6Ly8z'
..'MzA4NTY2MDkyIQdMb2NrUmV0AwAAAAAAgEZAIQtJbWFnZUNvbG9yMyELTWlzY1NjcmlwdHMhDkJhc2ljRnVuY3Rpb25zIQdFamVjdGVkIQxNb2R1bGVTY3JpcHQhD0VuZ2luZUZ1bmN0aW9ucyEIQXJtVHJhbnMhDEhlYWx0aFNjcmlwdCEFQWxlcnQhF3JieGFzc2V0aWQ6Ly8xNDAzMjU3MT'
..'I5IQRGaXJlIQRIZWF0AwAAAAAAAD5AIQ9XZWFwb25GdW5jdGlvbnMhCFNldHRpbmdzIQZDb25maWchDFdlYXBvblNwYXducwfHAASoA3gEeQQGY19iCoXrkb9S+DPDCtcjPAqG6r5CtyHnQLf5qsMKKdwyw4/C9bxx/TPDCs3MzD3NzMw9zczMPSEKUG9pbnRMaWdodCEFRmxhc2ghCkJyaWdo'
..'dG5lc3MG//9/IQdTaGFkb3dzIQVSYW5nZSEFRmxhbWUoAgAAAAD/qgAAAIA/////IRFFbWlzc2lvbkRpcmVjdGlvbhHNzMw9zczMPSEOTGlnaHRJbmZsdWVuY2UDAAAAAABAf0ARAAAqQwAAKkMRAAC0wwAAtEMpAgAAAAD8/98+9P+/PgAAgD/w//898P//PREAAOBAAADgQCEWcmJ4YXNzZX'
..'RpZDovLzM2OTQyMDg4MCkEAAAAAAAAAAAAAAAAZmZmPwAAAAAAAAAAmpl5PwAAgD4AAAAAAACAPwAAgD8AAAAAIQdaT2Zmc2V0IQVTbW9rZQMAAAAAAABUQBEAAMjCAADIQhEAADTDAAA0QykCAAAAAEzT3z4AAAAAAACAP3Tepz40mzc+CwAA8EEAAPBBISxyYnhhc3NldDovL3RleHR1cmVz'
..'L3BhcnRpY2xlcy9zbW9rZV9tYWluLmRkcykCAAAAAFs5YT8AAAAAAACAPwAAgD8AAAAAAwAAAACAhC5BIRdyYnhhc3NldGlkOi8vNTE4ODkzNjA5NAeNAATMA3oEewQGJ0YtCgAAtMIAADRDAAAAAAo8UK9CYL6Dv+bFu8MKHwW0wgAAAAAAADRDCs3MTD3NzMw9zczMPQTQA3oEewQKvOqIQh'
..'MMeUBBIr3DBNIDegR7BAp8TPRC6hR5QIghvcME1AMABAEECsI6nUIwPDBAJva9wwTWAwAEAQQKgh/iQupBMECr9b3DBNgDegR7BAo8UM9CuLaDv5bGu8MhBkdTV2VsZApvd79CyI5wQaLTvcMKAACAP5pxvK/IKK8gCppxvK8AAIA/JfkHsQq1nnk/UGJhPoWN5DwK+S9jvsiqdz8UTfk9CrEt'
..'fz9kvqK9SigevArrq6q5JbruPTpBfr8KV75WvbiWMzffpX8/Cl1sUT+60hI/yOMvPQobL605JbPZOAAAgD8Kcq9ztwAAgD8Rudm4Chsfrbkks9m4AACAvwr//38/v3ACOVK2YTkK9EdQud2Z971JH34/CgAAgD92cIe4zOTAOQqBLr03fVt+P7qh5z0Kawx/P18Ir72MGjC8ClhpsD3QC30/Gi'
..'z/PQpenEq/mLgbvxqxdb0KeQy/OZcEyD2xxn6/CiEeA79101o/mHSrPQqCLJs5mvzHPcnGfr8KAACAP3u5dDcVy8M3Cta6dLcAAIA/kSjauAoAAIA/+nWJOPygzTkKoJPEOV8uMT6CI3y/CgAAgD9fv3Q3FcvDNwrytHS3AACAP1Ek2rgKp7OUt+HHfr/oo8e9ChwTrbnqo8c94Md+vwr9/3+/'
..'UGisuGA4E7oKfYgPus2Z971GH34/CgAAgD9nnHm5OI22OQqPtk45fVt+P8Kh5z0Kxv9/P7paKzvuubC3CoSGqrmEX+49kUJ+vwrw+H8/Z1FuvJxYBbsK646quUq67j07QX6/CgAAgL/OQXO3GsvDtwosQ3O3AACAP5Hh2bgKAACAvzGmcrdOw6o5CiGLBbfw8n8/VJCjPAoAAIC/wERztxrLw7'
..'cKOkBztwAAgD9x39m4ChPrvkL5IVVBLKm7wwoAAIC/BJO8M0LwLqUKJBq7MwAAgD994As0CgBwmL8wwQXBsDacwQr2nnm/jStjPgzjOTkK2V1hPiqqdz/Z+f+9CgCsmb+QzAXBAP2bwQqAEhQ/UPScQYDuAsEKmi1/v2HwtTlE+aO9CnHFor0+8O49s299PwoAv+0+kPacQRAjA8EKgCl3v3i/'
..'BcGgNZzBCvALisEAInnAAFAdQArmpVY9+mxRv0SeEj8Kl4PBuKjREj/ttlE/CnCAIEKgT0JAAAgYPgoAbLm5lGzeMgAAgD8KEnmqswAAgD9Q49KyCtDFsMG40qHAAMDTQAoAXLk5nGzeMgAAgL8KEHmqMwAAgD9R49IyCiC6sME40qHAAMDYwAoAXh0+sPedwVSb90AK//9/vyTTOTnbuAq5Cj'
..'Nu5jjtz/e9dR5+vwoALyw/uGf1wOAMncEKAACAv4AYJripMLg5Ckbspbi4Wn4/19fnvQoAoZA+cD4HwZA0nMEKUgx/v2NysL2JQjs2ClwPr73iCn0/YioAvgooGY5AAKueQWAup0AKCp1KP9ics7kSeRy/Cm63G7/KOsg95aVJvwqwUL3AwPqdQYBYXUAKMB0DP9i8j7kO4Fs/CmDTWj/NMsg9'
..'7noCvwoAeK49yAMHwXAjnMEKQMj3QHwQMEAAXIRACgAAgL92T70z+My7pQqyXbozAACAP5jACTQKYIVHQfjGT8AAQuc+CkC8rkCAkyXAAP2TPgrA350/wPmZQTiVDMEKAACAv/TWubmYSe84Cp7xVTgxSTE+VCJ8PwoAAMg8QGCUwABclEAKAABuPoDiTcAA+kvBCgDAhb74oIs/AFB3QAoAkL'
..'M/ACZ/PwAvycEKAABCvXiBXsAA2NdBCgAAgj1A2Em+AACSvgqAZHm/CMwFwTAlnMEKABDAPTD4BsEQNJzBCgCABT7Aa9fAAHaSwQqCwx/CeLYtwAAU6UAKAPYfQoBpRMAADfRACgDLpUEAI8m/AKzgQAoANqXBCAefvwA83kAKAADivcABvsAI9BhCCgB31cEAB6Q/AKhgQAoAwIvBfJgjQABE'
..'gEAKAHmHQXxtEUAAWIBACgDN1kH4FJg/AOhgQAoA3gTBgBEwQABQhEAKgAzbQOC+nkEAzJc9ClhtEDgng7g5AACAvwo3x36/H9rHPT2CmDMKAEPFPgD4nEGMwgTBCkB/nj+AC5pB2IsOwQqAwXa/4AyaQeCLDsEKgCB4vyD8mUF4lQzBCtjK2kDwv55BgPlTPwoAyha+0PWdwZDF/MAK/f9/P0'
..'nrCTo7two5CrPhjbjcz/e9dh5+PwoA87y+tG71wNCLncEKAACAv9+WYLmpMLg5CuFshLm4Wn4/19fnvQqAhi8/eHD1wICUncEKELF1QCCunkHQuLVACiB2ycDQ/J1BQJ4zQAoA8MC+FHT1wNAKncEKAE25PlBCnkGk4wTBCsf/f79gy7U5RugoOwqJZyo7nZXuPY1Bfj8KAAB4uSBAnkEQHAXB'
..'Cuv4f79h07U5GNxwvApRjW68Y/DuPXM5fj8KALuLPsRJB8GQ+ZvBCgA6wD5Q9pxB2MwCwQqA/JM/YPacQaIXAsEKgBCCP5D2nEGmMwLBCoCBaD/A9JxBLqsCwQoAgB6+lLZswAAUjkEKAACAPwBwPDD7yFcoCgBwPDAAAIA/APmHMQoA8D8+gJc3P3DP90EKAACAP0gJ67Y997Y5Cq+0NDDN8n'
..'8/LWqkPAoA+Kc9fDYIQACA2z8KAJDxPwBSED8AGLPBCgAAm7346HlAABzbQAoA8JS8gFyqvTCBBUIK/v9/PzoFLbkeAwc6CvclIjnN8n8/OWqkPAoAtPnAACBmPgBdDUEKAACAP+fbdqgA0UEwCgAQNzAwKMqyAACAPwoAA9jBAIA8QIx/ekAKAITVQQA4PEB4g3pACgDDhsGEp6FAADyTwAoA'
..'0IxBvqihQAAkk8AKACYDQQAAbD7+XA1BCv7/f78fABM5k7oBOgo+VB058PJ/PzeQozwKAACAv+RBc7cay8O3ClbOw7dfztk4AACAPzgBAQAAAAIAAgADAAQABQAGAAEAAQACAAcACABAAgAaABsAFgAUAIAaABwAHQAeAAIACQAJAAoACwAMAA0ADgAPABAAEQASABMAFAAVABYAFwAUABgAGQ'
..'AfAAMAAQACACAACABAAgAaACYAJwAUAIAaACgAKQAqAAIACQAJACEACwAiAA0ADgAPACMAEQASABMAFAAVACQAFwAUABgAJQAfAAUAAQACACAAGgACAAcACwArAA0ADgARACwAEwAtABUALgAXAC8AGAAwADEABwABADIAMwA0AAcAAQACADUANAAHAAEAAgA1AB8ABwABAAIAIAAaAAIABwAL'
..'ADYADQAOABEALAATAC0AFQA3ABcALwAYADAAMQAMAAEAMgAzAB8ADAABAAIAIAAIAEACgBoAPAA9AB4AABoAPgA6ABQAAgAIAAsAOAANAA4ADwA5ABEAEgATABQAFQA6ABcAFAAYADsAHwAPAAEAAgAgAAgAQAJAAkACARoARgBHAEIASABJAEoAARoARgBLAEIASABJAEoAQAJAAgEaAEYATA'
..'BCAEgASQBKAAEaAEYATQBCAEgASQBKAEACARoATgBPAFAASABJAEoAARoAUQBSAFAASABJAEoAQAJAAgEaAFMAVABVAEgASQBKAAEaAFMAVgBVAEgASQBKAEACQAIBGgBGAFcAWABIAEkASgABGgBGAFkAWABIAEkASgBAA0ACARoARgBaAFgASABJAEoAARoARgBbAFgASABJAEoAQAIBGgBG'
..'AFwAWABIAEkASgABGgBGAF0AWABIAEkASgBAAgEaAEYAXgBYAEgASQBKAAEaAEYAXwBYAEgASQBKAAIACAAJAD8ACwBAAA8AQQARABIAEwBCABUAQwAXAEQAGABFAGAAEQAAAGEAEQABAAIAYgAaAAIACAALAGMADQAOABEALAATAGQAFQBlABcAZgAYAGcAaABpAGoAFAAAAB8AFAABAAIAIA'
..'AaAAIADABrAGwACQBtAAsAbgANAA4ADwBvABEAcAATAHEAFQByABcAcwAYAHQAdQBsAHYAdwAfABcAAQACACAAGgACAAwAawBsAAkAbQALAHgADQAOAA8AbwARAHAAEwBxABUAeQAXAHMAGAB0AHUAbAB2AHcAHwAZAAEAAgAgAAgAQAJABgEaAIMAhAB9AEgASQBKAAAaAIUAhgCHAAEaAIMA'
..'iAB9AEgASQBKAAEaAIMAiQB9AEgASQBKAAAaAIUAhgCKAAEaAIMAiwB9AEgASQBKAIEaAIwAjQCHAEgASQBKAAIACgAJAHoACwB7AA0ADgAPAHwAEQASABMAfQAVAH4AFwB/ABgAgACBAIIAHwAbAAEAAgAgAAgAQARAAkAFgRoAlACVAJEAlgCXAEoAARoAmACZAJEAlgCXAEoAgRoAlACaAJ'
..'EAlgCXAEoAgRoAlACbAJEAlgCXAEoAgRoAnACdAJEAlgCXAEoAQAWBGgCUAJ4AkQCWAJcASgABGgCYAJ8AkQCWAJcASgCBGgCUAKAAkQCWAJcASgCBGgCUAKEAkQCWAJcASgCBGgCcAKIAkQCWAJcASgBAAkAFgRoAlACjAJEAlgCXAEoAARoAmACkAJEAlgCXAEoAgRoAlAClAJEAlgCXAEoA'
..'gRoAlACmAJEAlgCXAEoAgRoAnACnAJEAlgCXAEoAQAWBGgCUAKgAkQCWAJcASgABGgCYAKkAkQCWAJcASgCBGgCUAKoAkQCWAJcASgCBGgCUAKsAkQCWAJcASgCBGgCcAKwAkQCWAJcASgBABEAFgRoArQCuAJEAlgCXAEoAARoArwCwAJEAlgCXAEoAgRoArQCxAJEAlgCXAEoAgRoArQCyAJ'
..'EAlgCXAEoAgRoArQCzAJEAlgCXAEoAQAWBGgCtALQAkQCWAJcASgABGgCvALUAkQCWAJcASgCBGgCtALYAkQCWAJcASgCBGgCtALcAkQCWAJcASgCBGgCtALgAkQCWAJcASgBABYEaAJwAuQCRAJYAlwBKAAEaAK8AugCRAJYAlwBKAIEaAJwAuwCRAJYAlwBKAIEaAJwAvACRAJYAlwBKAIEa'
..'AJwAvQCRAJYAlwBKAEAFgRoAnAC+AJEAlgCXAEoAARoArwC/AJEAlgCXAEoAgRoAnADAAJEAlgCXAEoAgRoAnADBAJEAlgCXAEoAgRoAnADCAJEAlgCXAEoAQARABYEaAK0AwwCRAJYAlwBKAAEaAK0AxACRAJYAlwBKAIEaAK0AxQCRAJYAlwBKAIEaAK0AxgCRAJYAlwBKAIEaAK0AxwCRAJ'
..'YAlwBKAEAFgRoArQDIAJEAlgCXAEoAARoArQDJAJEAlgCXAEoAgRoArQDKAJEAlgCXAEoAgRoArQDLAJEAlgCXAEoAgRoArQDMAJEAlgCXAEoAQAWBGgCcAM0AkQCWAJcASgABGgCtAM4AkQCWAJcASgCBGgCcAM8AkQCWAJcASgCBGgCcANAAkQCWAJcASgCBGgCcANEAkQCWAJcASgBABYEa'
..'AJwA0gCRAJYAlwBKAAEaAK8A0wCRAJYAlwBKAIEaAJwA1ACRAJYAlwBKAIEaAJwA1QCRAJYAlwBKAIEaAJwA1gCRAJYAlwBKAAIACQAJAI4ACwCPAA0ADgAPAJAAEQASABMAkQAVAJIAFwCRABgAkwA0AB0AAQACANcANAAdAAEAAgDXAB8AHQABAAIAIAAIAEACABoA2wDaANkAgBoA3ADdAN'
..'4AAgAJAAkACgALANgADQAOAA8AEAARABIAEwDZABUA2gAXANkAGAAZAB8AIQABAAIAIAAIAEADQAJAAgEaAOQA5QDgAEgASQBKAIEaAOYA5wDoAEgASQBKAMACgBoA6QDqAOsAABoA7ADtAOgAQAJAAgEaAO4A7wDwAEgASQBKAIEaAPEA8gDzAEgASQBKAMACgBoA9AD1APYAABoA9wD4APMA'
..'ABoA+QD6APsAAgAIAAsA3wANAA4ADwA5ABEAEgATAOAAFQDhABcA4gAYAOMAHwAjAAEAAgAgAAgAQAJAAgEaAAEBAgH9AEgASQBKAIEaAAMBBAEFAUgASQBKAMACgBoABgEHAQgBABoACQEKAQUBAgAIAAsA/AANAA4ADwA5ABEAEgATAP0AFQD+ABcA/wAYAAABHwAlAAEAAgAgAAgAQAKAGg'
..'AQAREB3gAAGgASARMB2QACAAkACQALAQsADAENAA4ADwANAREAEgATANkAFQAOARcA2QAYAA8BHwAnAAEAAgAgABQBAgALAAIAFQELABYBDQAOABEALAATABcBFQAYARcAFwEYABkBGgEbARwBHQEeAR8BHwApAAEAAgAgABoAAgAIAAsAIAENAA4AEQAsABMAZAAVACEBFwBmABgAIgFoAGkA'
..'HwArAAEAAgAgABoAAgAIAAsAIwENAA4AEQAsABMAZAAVACQBFwBmABgAJQFoAGkAHwAtAAEAAgAgAAgAQAKAGgArASwBLQEAGgAuASgBJwECAAkACQCOAAsAJgENAA4ADwCQABEAEgATACcBFQAoARcAKQEYACoBHwAvAAEAAgAgABQBAgAMAAIALwEJAAoACwAwAQ0ADgAPABAAEQASABMAFw'
..'EVADEBFwAXARgAMgEaATMBHAE0AR8AMQABAAIAIAAUAQIADQACADUBCQA2AQsANwENAA4ADwA4AREALAATABcBFQA5ARcAFwEYADoBGgE7ARwBPAEeAT0BHwAzAAEAAgAgABQBAgAMAAIAPgEJAAoACwA/AQ0ADgAPABAAEQASABMAFwEVAEABFwAXARgAQQEaAUIBHAFDAR8ANQABAAIAIAAU'
..'AQIADQACAEQBCQA2AQsARQENAA4ADwA4AREALAATABcBFQBGARcAFwEYAEcBGgFIARwBSQEeAT0BHwA3AAEAAgAgABQBAgAMAAIASgEJAAoACwBLAQ0ADgAPABAAEQASABMAFwEVAEwBFwAXARgATQEaAU4BHAFPAR8AOQABAAIAIAAUAQIACwACAFABCwBRAQ0ADgARACwAEwAXARUAUgEXAB'
..'cBGABTARoBVAEcAVUBHgE9AR8AOwABAAIAIAAIAEACgBoAWAFZAR4AABoAWgFbARQAAgAJAAkACwELAFYBDQAOAA8ADQERABIAEwAUABUAVwEXABQAGAAPAR8APQABAAIAIAAIAEACgBoAXgFfAd4AABoAYAFdAdkAAgAIAAsAXAENAA4ADwA5ABEAEgATANkAFQBdARcA2QAYADsAHwA/AAEA'
..'AgAgABQBAgANAAIAYQEJAGIBCwBjAQ0ADgAPAGQBEQBlARMAFwEVAGYBFwAXARgAZwFoAGgBGgFpARwBagEUAQIADAACAGsBCQBsAQsAbQENAA4ADwBuAREAcAATABcBFQBvARcAFwEYAHABGgFxARwBcgEfAEIAAQACACAAFAECAAwAAgBzAQkAdAELAHUBDQAOAA8AdgERAHAAEwAXARUAdw'
..'EXABcBGAB4ARoBeQEcAXoBHwBEAAEAAgAgABQBAgAMAAIAewEJAAoACwB8AQ0ADgAPABAAEQASABMAFwEVAH0BFwAXARgAfgEaAX8BHAGAAR8ARgABAAIAIAAUAQIADAACAIEBCQAKAAsAggENAA4ADwAQABEAEgATABcBFQCDARcAFwEYAIQBGgGFARwBhgEfAEgAAQACACAAFAECAAwAAgCH'
..'AQkACgALAIgBDQAOAA8AEAARABIAEwAXARUAiQEXABcBGACKARoBiwEcAYwBHwBKAAEAAgAgABQBAgALAAIAjQELAI4BDQAOABEALAATABcBFQCPARcAFwEYAJABGgGRARwBkgEeAZMBHwBMAAEAAgAgABQBAgALAAIAlAELAJUBDQAOABEALAATABcBFQCWARcAFwEYAJcBGgGYARwBmQEeAR'
..'8BHwBOAAEAAgAgABQBAgALAAIAlAELAJoBDQAOABEALAATABcBFQCbARcAFwEYAJcBGgGYARwBmQEeAR8BHwBQAAEAAgAgABQBAgALAAIAjQELAJwBDQAOABEALAATABcBFQCdARcAFwEYAJABGgGRARwBkgEeAZMBHwBSAAEAAgAgABQBAgALAAIAFQELAJ4BDQAOABEALAATABcBFQCfARcA'
..'FwEYABkBGgEbARwBHQEeAR8BHwBUAAEAAgAgABoAAgAHAAsAoAENAA4AEQAsABMAoQEVAKIBFwCjARgApAGlAVYAAQAyAKYBHwBWAAEAAgAgABoAAgAHAAsApwENAA4AEQAsABMALQAVAKgBFwAvABgAqQExAFkAAQAyADMAHwBZAAEAAgAgABoAAgAJAAkAqgELAKsBDQAOAA8ArAERACwAEw'
..'AnARUArQEXACkBGACuAaUBXAABADIArwEfAFwAAQACACAAGgACAAkACQCqAQsAsAENAA4ADwCsAREALAATACcBFQCxARcAKQEYAK4BpQFfAAEAMgCvAR8AXwABAAIAIAAIAEACgBoAKwG0AS0BABoALgGzAScBAgAJAAkAjgALALIBDQAOAA8AkAARABIAEwAnARUAswEXACkBGAAqAR8AYgAB'
..'AAIAIAAaAAIABwALALUBDQAOABEALAATAKEBFQC2ARcAowEYAKQBpQFkAAEAMgCmAR8AZAABAAIAIAAIAEACQAYBGgC9Ab4BugFIAEkASgAAGgC/AcABwQEBGgC9AcIBugFIAEkASgABGgC9AcMBugFIAEkASgAAGgDEAcABxQEBGgC9AcYBugFIAEkASgCBGgDHAcgBwQFIAEkASgACAAoACQ'
..'C3AQsAuAENAA4ADwC5AREAEgATALoBFQC7ARcAvAEYAIAAgQCCAB8AZwABAAIAIAAaAAIACQAJAMkBCwDKAQ0ADgAPAMsBEQAsABMAzAEVAM0BFwDMARgAzgGlAWkAAQAyAM8BHwBpAAEAAgAgABoAAgAJAAkA0AELANEBDQAOAA8A0gERACwAEwDMARUA0wEXAMwBGADOAaUBbAABADIAzwEf'
..'AGwAAQACACAACABAA0ACQAIBGgDkANYB4ABIAEkASgCBGgDmANcB6ABIAEkASgDAAoAaAOkA2AHrAAAaAOwA2QHoAEACQAIBGgDuANoB8ABIAEkASgCBGgDxANsB8wBIAEkASgDAAoAaAPQA3AH2AAAaAPcA3QHzAAAaAPkA3gH7AAIACAALANQBDQAOAA8AOQARABIAEwDgABUA1QEXAOIAGA'
..'DjAB8AbwABAAIAIAAIAEACQAIBGgABAeEB/QBIAEkASgCBGgADAeIBBQFIAEkASgDAAoAaAAYB4wEIAQAaAAkB5AEFAQIACAALAN8BDQAOAA8AOQARABIAEwD9ABUA4AEXAP8AGAAAAR8AcQABAAIAIAAIAEAEQAJABYEaAOcB6AHMAZYAlwBKAAEaAOkB6gHMAZYAlwBKAIEaAOcB6wHMAZYA'
..'lwBKAIEaAOcB7AHMAZYAlwBKAIEaAO0B7gHMAZYAlwBKAEAFgRoA5wHvAcwBlgCXAEoAARoA6QHwAcwBlgCXAEoAgRoA5wHxAcwBlgCXAEoAgRoA5wHyAcwBlgCXAEoAgRoA7QHzAcwBlgCXAEoAQAJABYEaAOcB9AHMAZYAlwBKAAEaAOkB9QHMAZYAlwBKAIEaAOcB9gHMAZYAlwBKAIEaAO'
..'cB9wHMAZYAlwBKAIEaAO0B+AHMAZYAlwBKAEAFgRoA5wH5AcwBlgCXAEoAARoA6QH6AcwBlgCXAEoAgRoA5wH7AcwBlgCXAEoAgRoA5wH8AcwBlgCXAEoAgRoA7QH9AcwBlgCXAEoAQARABYEaAP4B/wHMAZYAlwBKAAEaAAACAQLMAZYAlwBKAIEaAP4BAgLMAZYAlwBKAIEaAP4BAwLMAZYA'
..'lwBKAIEaAP4BBALMAZYAlwBKAEAFgRoA/gEFAswBlgCXAEoAARoAAAIGAswBlgCXAEoAgRoA/gEHAswBlgCXAEoAgRoA/gEIAswBlgCXAEoAgRoA/gEJAswBlgCXAEoAQAWBGgDtAQoCzAGWAJcASgABGgAAAgsCzAGWAJcASgCBGgDtAQwCzAGWAJcASgCBGgDtAQ0CzAGWAJcASgCBGgDtAQ'
..'4CzAGWAJcASgBABYEaAO0BDwLMAZYAlwBKAAEaAAACEALMAZYAlwBKAIEaAO0BEQLMAZYAlwBKAIEaAO0BEgLMAZYAlwBKAIEaAO0BEwLMAZYAlwBKAEAEQAWBGgD+ARQCzAGWAJcASgABGgD+ARUCzAGWAJcASgCBGgD+ARYCzAGWAJcASgCBGgD+ARcCzAGWAJcASgCBGgD+ARgCzAGWAJcA'
..'SgBABYEaAP4BGQLMAZYAlwBKAAEaAP4BGgLMAZYAlwBKAIEaAP4BGwLMAZYAlwBKAIEaAP4BHALMAZYAlwBKAIEaAP4BHQLMAZYAlwBKAEAFgRoA7QEeAswBlgCXAEoAARoA/gEfAswBlgCXAEoAgRoA7QEgAswBlgCXAEoAgRoA7QEhAswBlgCXAEoAgRoA7QEiAswBlgCXAEoAQAWBGgDtAS'
..'MCzAGWAJcASgABGgAAAiQCzAGWAJcASgCBGgDtASUCzAGWAJcASgCBGgDtASYCzAGWAJcASgCBGgDtAScCzAGWAJcASgACAAkACQCOAAsA5QENAA4ADwCQABEAEgATAMwBFQDmARcAzAEYAJMAHwBzAAEAAgAgAAgAQAKAGgAtAi4CLwIAGgAwAjECKQICAAkACQCOAAsAKAINAA4ADwCQABEA'
..'EgATACkCFQAqAhcAKwIYACwCHwB1AAEAAgAgAAgAQAIAGgA3AjgCMwKAGgA5AjoCOwICAAkACQCOAAsAMgINAA4ADwCQABEAEgATADMCFQA0AhcANQIYADYCHwB3AAEAAgAgAAgAQAIAGgA+Aj8C2QCAGgBAAkECQgICAAkACQAhAAsAPAINAA4ADwAjABEAEgATANkAFQA9AhcA2QAYACUAHw'
..'B5AAEAAgAgABoAAgAJAAkAQwILAEQCDQAOAA8ARQIRACwAEwAtABUARgIXAC8AGACpATEAewABADIAMwAfAHsAAQACACAAGgACAAcACwBHAg0ADgARACwAEwAtABUASAIXAC8AGABJAjEAfgABADIAMwAfAH4AAQACACAAGgACAAcACwBKAg0ADgARACwAEwAtABUASwIXAC8AGABMAjEAgQAB'
..'ADIAMwAfAIEAAQACACAAGgACAAcACwBNAg0ADgARACwAEwAtABUATgIXAC8AGABPAjEAhAABADIAMwAfAIQAAQACACAABgABAAEAAgBQAlEChwABAAIAUgJTAocADgACAFQCVQJ3AGsAdwAJAAoACwBWAg8AEABXAncAWAJ3ABMAWQIVAFoCWwJ3ABcAXAIYAF0CdQB3AF4CiQABAAIAXwJRAo'
..'oAAQACAGACYgKKAAUAAgBjAmQCZQJmAmkAGABnAmgCDgBiAowABgACAGkCZAJlAmYCaQAVAGoCGABrAmwCdwBtAo0ACQACAG4CZAJvAnACbAAVAHECGAByAmwCdwBzAnQCdQJ2AncCeAJ5Ao0ABwACAHoCZAJlAmYCaQAVAHsCGAB8AmwCdwB9An4CbQKNAAkAAgBuAmQCbwJwAmwAFQB/AhgA'
..'cgJsAncAcwJ0AnUCdgJ3AngCgAKKAAkAAgCBAmQCggJmAoMCcAKEAhUAhQIYAIYCaAIOAIcCdwCIAoQCiQKRAAEAigJ3AIsCkQABAIwCjQKOApEAAQACAI8CYgKKAAYAAgCQAmQCggJmAoMCcAKEAhUAkQIYAJICbQKVAAsAAgCTAmQCZQJmAmkAFQCUAhgAlQJzApYCdQKXApgCZQJ3ApkCmg'
..'JoAZsCbACcApUAAwCdAmwAngKfAqACoQJtApUACwACAKICZAJlAmYCaQAVAJQCGACVAnMClgJ1AqMCmAJlAncCmQKaAmgBmwJsAG0ClQAMAAIApAJkAmUCZgJpAKUCggAVAJQCGACVAnMClgJ1AqYCmAJlAncCmQKaAmgBmwJsAKcClQAJAAIAqAJkAqkCZgJoARgAqgJzAqsCdQKsApgCZQJ3'
..'Aq0CmgJoAacClQAJAAIArgJkAqkCZgJoARgAqgJzAqsCdQKvApgCZQJ3Aq0CmgJoAacClQAJAAIAsAJkAqkCZgJoARgAqgJzAqsCdQKxApgCZQJ3Aq0CmgJoAY4ClQABAAIAjwKAAooACQACALICZAKCAmYCgwJwAoQCFQCzAhgAhgJoAg4AhwJ3AIgChAKJAp4AAQCKAncAiwKeAAEAjAKNAo'
..'4CngABAAIAjwKAAooACQACALQCZAKCAmYCgwJwAoQCFQC1AhgAhgJoAg4AhwJ3AIgChAKJAqIAAQCKAncAiwKiAAEAjAKNAo4CogABAAIAjwKOAooAAQACALYCeQKKAAcAAgC3AmQCZQJmAmkAFQC4AhgAuQJ9AroCuwKDAm0CpwAKAGQCZQJmAmkAFQC8AhgAvQJzAr4CdQK/ApgCZQJ3AsAC'
..'mgJoAcECggDCAokAAQACAMMCYQCJAAEAAgDEAo4CqgACAAIAxQLGAoIAYQCqAAIAAgDHAsYCggAaAIcADwACAMgCVQJ3AGsAdwAJADYBCwDJAg8AygJXApYAWAJ3ABMAywIVAMwCWwJ3ABcAzQIYAM4CdQB3AGgAaQAaAIcACwACAM8CawB3AAsA0AJYAncAEwBZAhUA0QJbAncAFwBcAhgA0g'
..'J1AHcAaABpAKUBrgAAANMCrgAHAAIA1ALVAoIA1gLXAtgChALZAnQC2gLbAtwCaAHdArAAAQDeAmkA0wKuAAUAAgDfAtUCggDWAuAC2gLhAtwC4gLjAq4AAgALAOQC5QJKAOYCrgABAOcCSgAfAK4AAgACAOgC6QLqAh8ArgACAAIA6ALpAuwCHwCuAAIAAgAaAOkC7QIfAK4AAgACABoA6QLu'
..'Ah8ArgACAAIA6ALpAu8CHwCuAAIAAgDoAukC8AIfAK4AAgACABoA6QLxAh8ArgACAAIAGgDpAvICHwCuAAIAAgAaAOkC8wIfAK4AAgACAOgC6QL0Ah8ArgACAAIA6ALpAvUCHwCuAAIAAgDoAukC9gIfAK4AAgACAOgC6QL3Ah8ArgACAAIA6ALpAvgCHwCuAAIAAgDoAukC+QIfAK4AAgACAB'
..'UB6QL6Ah8ArgACAAIAGgDpAvsCHwCuAAIAAgAaAOkC/AIfAK4AAgACAOgC6QL9Ah8ArgACAAIALwHpAv4CHwCuAAIAAgA1AekC/wIfAK4AAgACAD4B6QIAAx8ArgACAAIARAHpAgEDHwCuAAIAAgBKAekCAgMfAK4AAgACAFAB6QIDAx8ArgACAAIA6ALpAgQDHwCuAAIAAgDoAukCBQMfAK4A'
..'AgACAGEB6QIGAx8ArgACAAIAawHpAgcDHwCuAAIAAgBzAekCCAMfAK4AAgACAHsB6QIJAx8ArgACAAIAgQHpAgoDHwCuAAIAAgCHAekCCwMfAK4AAgACAI0B6QIMAx8ArgACAAIAlAHpAg0DHwCuAAIAAgCUAekCDgMfAK4AAgACAI0B6QIPAx8ArgACAAIAFQHpAhADHwCuAAIAAgAaAOkCEQ'
..'MfAK4AAgACABoA6QISAx8ArgACAAIAGgDpAhMDHwCuAAIAAgAaAOkCFAMfAK4AAgACAOgC6QIVAx8ArgACAAIAGgDpAhYDHwCuAAIAAgDoAukCFwMfAK4AAgACABoA6QIYAx8ArgACAAIAGgDpAhkDHwCuAAIAAgDoAukCGgMfAK4AAgACAOgC6QIbAx8ArgACAAIA6ALpAhwDHwCuAAIAAgDo'
..'AukCHQMfAK4AAgACAOgC6QIeAx8ArgACAAIA6ALpAh8DHwCuAAIAAgAaAOkCIAMfAK4AAgACABoA6QIhAx8ArgACAAIAGgDpAiIDHwCuAAIAAgAaAOkCIwMfAK4AAgACAFQC6QIkAx8ArgACAAIAyALpAiUDHwCuAAIAAgDPAukCJgMfAK4AAgACACcD6QIoAx8ArgACAAIAKQPpAioDHwCuAA'
..'IAAgArA+kCLAMfAK4AAgACAC0D6QIBAx8ArgACAAIALgPpAi8DHwCuAAIAAgAwA+kCMQMfAK4AAgACADID6QIzAx8ArgACAAIAMgPpAjQDHwCuAAIAAgA1A+kCNgMfAK4AAgACADUD6QI3Ax8ArgACAAIAMAPpAjgDBgABAAEAAgA5AwYA/AABAAIAOgMGAP0AAQACADsDFAH+AAwAAgAnAwsA'
..'PAMNAA4AEQA9AxMAFwEVAD4DFwAXARgAPwNoAGkAGgFAAxwBQQMeAT0BHwD/AAEAAgAgABQB/gAMAAIAKQMLAEIDDQAOABEAEgATABcBFQBDAxcAFwEYAEQDaABpABoBRQMcAUYDHgE9AR8AAQEBAAIAIAAGAP0AAQACAEcDFAEDAQoAAgArAwsASAMRAD0DEwBZAhUASQMXAFwCGABKAxoBSw'
..'McAUwDHgE9AR8ABAEBAAIAIAAGAPwAAQACAE0DFAEGAQ0AAgAtAwkANgELAEUBDQAOAA8AygIRABIAEwAXARUARgEXABcBGABHAWgAaQAaAUgBHAFJAQYAAQABAAIATgNPAwgBAQACAFADTwMIAQEAAgBRA08DCAEBAAIAUgNPAwgBAQACAFMDTwMIAQEAAgBUA1UDCAEBAAIAVgMGAAEAAQAC'
..'AFcD0wIPAQMAAgBYA9oCWQPcAmkAWgMPAQwAAgBbAw8AXANdAw4AXgNfA2ADrQJhA2IDFwBjAxgAZANlA2YDZwNoA2kDagNoAGsD0wIPAQMAAgBsA9oCbQPcAmkAbgMPAQQAAgBvA3ADSgAaAXEDcgOEAm4DDwEEAAIAcwNwA0oAGgF0A3IDhAJaAw8BCQACAHUDDwB2A10DDgBeA3cDeANpAG'
..'ADeQMYAHoDZQNmA2kDewNuAw8BBAACAHwDfQN+AxoBfwNyA4QC0wIPAQQAAgCAA9YCeQPaAoED3AKCAwYAAQABAAIAgwOOAhgBAQACAIQDjgIYAQEAAgCFA20CGgELAAIAhgNkAmUCZgJpABUAlAIYAIcDcwKWAnUCiAOYAmUCdwKJA5oCaAGbAmwAjgIYAQEAAgCKA44CGAEBAAIAiwNiAhgB'
..'BgACAIwDZAJlAmYCaQAVAI0DGACOA2gCDgB5Ah4BBQACAI8DZAJlAmYCaQAYAGcCfQKQA3kCHgEIAAIAkQNkAmUCZgJpABcAkgMYAGcCaAIOAH0CkAOTA3YBBgABAAEAAgCUA2EAIQEBAAIAlQNhACIBAgACAJYDxgKCAJcDIQEBAAIAmANhACEBAQACAJkDYQAhAQEAAgCaA9MCJgEEAAIAmw'
..'PVAoIA1gJ5A9oCnAOdAyYBAwBdAw4AngOEAhgAnwNhACEBAQACAKADBgABAAEAAgChA5cDKgEBAAIAogMGAAEAAQACAKMDGgAsAQwAAgAuA2sAbAAJAKQDCwClAw8ApgMRABIAEwCnAxUAqAMXAKkDGACqA3UAbABoAGkAqwMtAQYAAgCsA60DlgIPAK4DXQMOAK8DggCwA5YAWgMtAQ8AAgCx'
..'Aw8AsgOzA4QCXQMOAF4DtAN4A2kAtQNpAGADtgNhA7cDFwC4AxgAuQNlA7oDaQO7A2gAvAO9A4MCWgMtAQsAAgC+A7MDhAJdAw4AXgNfA2ADvwNhA8ADFwDBAxgAwgNnA8MDaQPEA2gAxQPTAi0BBQACAJ0D1QKCANYCxgPaAscD3AKWAhoALAEMAAIAMANrAGwACQDIAwsAyQMNAA4ADwDKAx'
..'MAywMVAMwDFwDNAxgAzgN1AGwAaABpABoALAEKAAIAMgNrAGwACwDPAw0ADgATAMsDFQDQAxcAzQMYAM4DdQBsAGgAaQAaACwBCgACADIDawBsAAsA0QMNAA4AEwDLAxUA0gMXAM0DGADOA3UAbABoAGkAGgAsAQwAAgA1A2sAbAAJAAoACwDTAw0ADgAPABAAEwBZAhUA1AMXAFwCGADOA3UA'
..'bABoAGkAGgAsAQwAAgA1A2sAbAAJAAoACwDVAw0ADgAPABAAEwBZAhUA1gMXAFwCGADOA3UAbABoAGkAGgAsAQwAAgAwA2sAbAAJAMgDCwDXAw0ADgAPAMoDEwDLAxUA2AMXAM0DGADOA3UAbABoAGkAYQABAAEAAgDZA48AiwBhAocAtQDrAq4AtQBhAQMAtgDrAq4AtgBhAQUAtwDrAq4Atw'
..'BhAQcAuADrAq4AuABhAQwAuQDrAq4AuQBhAQ8AugDrAq4AugBhAREAuwDrAq4AuwBhARQAvADrAq4AvABhARcAvQDrAq4AvQBhARkAvgDrAq4AvgBhARsAvwDrAq4AvwBhAR0AwADrAq4AwABhASEAwQDrAq4AwQBhASMAwgDrAq4AwgBhASUAwwDrAq4AwwBhAScAxADrAq4AxABhASkAxQDr'
..'Aq4AxQBhASsAxgDrAq4AxgBhAS0AxwDrAq4AxwBhAS8AyADrAq4AyABhATEAyQDrAq4AyQBhATMAygDrAq4AygBhATUAywDrAq4AywBhATcAzADrAq4AzABhATkAzQDrAq4AzQBhATsAzgDrAq4AzgBhAT0AzwDrAq4AzwBhAT8A0ADrAq4A0ABhAUEA0QDrAq4A0QBhAUIA0gDrAq4A0gBhAU'
..'QA0wDrAq4A0wBhAUYA1ADrAq4A1ABhAUgA1QDrAq4A1QBhAUoA1gDrAq4A1gBhAUwA1wDrAq4A1wBhAU4A2ADrAq4A2ABhAVAA2QDrAq4A2QBhAVIA2gDrAq4A2gBhAVQA2wDrAq4A2wBhAVYA3ADrAq4A3ABhAVkA3QDrAq4A3QBhAVwA3gDrAq4A3gBhAV8A3wDrAq4A3wBhAWIA4ADrAq4A'
..'4ABhAWQA4QDrAq4A4QBhAWcA4gDrAq4A4gBhAWkA4wDrAq4A4wBhAWwA5ADrAq4A5ABhAW8A5QDrAq4A5QBhAXEA5gDrAq4A5gBhAXMA5wDrAq4A5wBhAXUA6ADrAq4A6ABhAXcA6QDrAq4A6QBhAXkA6gDrAq4A6gBhAXsA6wDrAq4A6wBhAX4A7ADrAq4A7ABhAYEA7QDrAq4A7QBhAYQA7g'
..'DrAq4A7gBhAYkA7wDrAq4A7wBhAa0A8ADrAq4A8ABhAa4A8QDrAq4A8QBhAf8A8gDrAq4A8gBhAQEB8wDrAq4A8wBhAQQB9ADrAq4A9ABhAQcB9QDrAq4A9QBhAS0B9gDrAq4A9gBhATIB9wDrAq4A9wBhATMB+ADrAq4A+ABhATQB+QDrAq4A+QBhATUB+gDrAq4A+gBhATYB+wDrAq4A+wBh'
..'ATcB')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
