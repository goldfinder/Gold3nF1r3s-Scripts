-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 43568 characters

local ScriptFunctions = {
function(script,require)
grp1 = script.Parent.G1:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = true
	end
	
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = true
	end
else
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = false
	end
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = false
	end

end
end
end,
function(script,require)
grp1 = script.Parent.G1:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = true
	end
	
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = true
	end
else
	for i = 1,#grp1 do
	grp1[i].Braking.Enabled = false
	end
	for i = 1,#grp1 do
	grp1[i].Lights.Enabled = false
	end

end
end
end,
function(script,require)
bin = script.Parent

function onClicked(mouse)

script.Parent.Parent.Light.Lamp.Enabled = true

end

bin.ClickDetector.MouseClick:connect(onClicked)
 

--Made By Amaysingcaleb
end,
function(script,require)
bin = script.Parent

function onClicked(mouse)

script.Parent.Parent.Light.Lamp.Enabled = false

end

bin.ClickDetector.MouseClick:connect(onClicked)
 
--Made By Amaysingcaleb
end,
function(script,require)
bin = script.Parent

function onClicked(mouse)

script.Parent.Parent.Light.Lamp.Enabled = true

end

bin.ClickDetector.MouseClick:connect(onClicked)
 

--Made By Amaysingcaleb
end,
function(script,require)
bin = script.Parent

function onClicked(mouse)

script.Parent.Parent.Light.Lamp.Enabled = false

end

bin.ClickDetector.MouseClick:connect(onClicked)
 
--Made By Amaysingcaleb
end,
function(script,require)
On=false
function onClicked() 
if On then On=false else 
On=true 
while On do 

script.Parent.Parent.A.Transparency = 0
script.Parent.Parent.A.PointLight.Enabled = true
wait(.2)
script.Parent.Parent.A.Transparency = 0.5
script.Parent.Parent.A.PointLight.Enabled = false
wait(.2)
script.Parent.Parent.A.Transparency = 0
script.Parent.Parent.A.PointLight.Enabled = true
wait(.2)
script.Parent.Parent.A.Transparency = 0.5
script.Parent.Parent.A.PointLight.Enabled = false
wait(.2)
script.Parent.Parent.A.Transparency = 0
script.Parent.Parent.A.PointLight.Enabled = true
wait(.2)
script.Parent.Parent.A.Transparency = 0.5
script.Parent.Parent.A.PointLight.Enabled = false


script.Parent.Parent.B.Transparency = 0
script.Parent.Parent.B.PointLight.Enabled = true
wait(.2)
script.Parent.Parent.B.Transparency = 0.5
script.Parent.Parent.B.PointLight.Enabled = false
wait(.2)
script.Parent.Parent.B.Transparency = 0
script.Parent.Parent.B.PointLight.Enabled = true
wait(.2)
script.Parent.Parent.B.Transparency = 0.5
script.Parent.Parent.B.PointLight.Enabled = false
wait(.2)
script.Parent.Parent.B.Transparency = 0
script.Parent.Parent.B.PointLight.Enabled = true
wait(.2)
script.Parent.Parent.B.Transparency = 0.5
script.Parent.Parent.B.PointLight.Enabled = false



end 
	end 
		end 

script.Parent.ClickDetector.MouseClick:connect(onClicked) 
end,
function(script,require)
function onClicked()
	
	script.Parent.Parent.J.BrickColor=BrickColor.new("Bright orange")
	wait(0.01)
	script.Parent.Parent.J.B.Disabled=true
	script.Parent.Parent.J.C.Disabled=false
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)
end,
function(script,require)
function onClicked()
	
	script.Parent.Parent.J.BrickColor=BrickColor.new("Mid gray")
	wait(0.01)
	script.Parent.Parent.J.B.Disabled=false
	script.Parent.Parent.J.C.Disabled=true
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.src2.Value=script.Parent
			g.src3.Value=script.Parent
			g.Lights3.Disabled=false
		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="s" then 
		src:Play()
		src.Parent.Parent.Body.Brakes.on.Value = true
	end
end)
mouse.KeyUp:connect(function(key)
	if key=="s" then 
		src:Play()
		src.Parent.Parent.Body.Brakes.on.Value = false
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.src2.Value=script.Parent
			g.src3.Value=script.Parent
			g.Lights3.Disabled=false
		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="x" then 
		src:Play()
		if src.Parent.Parent.Body.Hazards.on.Value == false then
			src.Parent.Parent.Body.Hazards.on.Value = true
		else
			src.Parent.Parent.Body.Hazards.on.Value = false
		end
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.src2.Value=script.Parent
			g.src3.Value=script.Parent
			g.Lights3.Disabled=false
		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="l" then 
		src:Play()
		if src.Parent.Parent.Body.Light.on.Value == true then
		src.Parent.Parent.Body.Light.on.Value = false
		else
			src.Parent.Parent.Body.Light.on.Value = true
		end
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.src2.Value=script.Parent
			g.src3.Value=script.Parent
			g.Lights3.Disabled=false
		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="z" then 
		src:Play()
		if src.Parent.Parent.Body.Left.on.Value == true then
		src.Parent.Parent.Body.Left.on.Value = false
		else
			src.Parent.Parent.Body.Left.on.Value = true
		end
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.src2.Value=script.Parent
			g.src3.Value=script.Parent
			g.Lights3.Disabled=false
		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="c" then 
		src:Play()
		if src.Parent.Parent.Body.Right.on.Value == true then
		src.Parent.Parent.Body.Right.on.Value = false
		else
			src.Parent.Parent.Body.Right.on.Value = true
		end
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.Horn.Disabled=false		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src")
src=script.Parent.src.Value
mouse.KeyDown:connect(function(key)
	if key=="f" then 
		src:Play()
	end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		src:Stop()
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.Horn.Disabled=false		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src")
src=script.Parent.src.Value
mouse.KeyDown:connect(function(key)
	if key=="h" then 
		src:Play()
	end
end)
mouse.KeyUp:connect(function(key)
	if key=="h" then 
		src:Stop()
	end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		src:Stop()
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
local VehicleSeat = script.Parent
 
VehicleSeat.Changed:connect(function(prop)
	if prop == "Occupant" then
		local humanoid = VehicleSeat.Occupant
		if humanoid then
			local player = game:GetService("Players"):GetPlayerFromCharacter(humanoid.Parent)
			if player then
				VehicleSeat:SetNetworkOwner(player)
			end
		else
			VehicleSeat:SetNetworkOwnershipAuto()
		end
	end
end)
end,
function(script,require)
if script.Parent.Parent:IsA("VehicleSeat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.src2.Value=script.Parent
			g.src3.Value=script.Parent
			g.Lights3.Disabled=false
		
		end
	end)
end
end,
function(script,require)
local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="k" then 
		src:Play()
		if src.Parent.Parent.Body.HiLight.on.Value == true then
		src.Parent.Parent.Body.HiLight.on.Value = false
		else
			src.Parent.Parent.Body.HiLight.on.Value = true
		end
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)
end,
function(script,require)
script.Parent.ChildAdded:connect(function(child)
	if child:IsA("Weld") then
		child.C0 = CFrame.new(0,-0.6,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0) --// Reposition player
		if child.Part1.Name == "HumanoidRootPart" then
			script.Parent.Startup:Play()
			end
		end
	end)
end,
function(script,require)
wait(2)
script.Parent.Disabled = false
end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]

local Tune = {}

--[[Misc]]
	Tune.LoadDelay		= .1		-- Delay before initializing chassis (in seconds)
	Tune.AutoStart		= true		-- Set to false if using manual ignition plugin
	Tune.AutoFlip		= true		-- Set to false if using manual flip plugin
	
--[[Wheel Alignment]]
	--[Don't physically apply alignment to wheels]
	--[Values are in degrees]
	Tune.FCamber		= -1
	Tune.RCamber		= -1
	Tune.FToe			= 0
	Tune.RToe			= 0
	
--[[Weight and CG]]
	Tune.Weight			= 3000		-- Total weight (in pounds)
	Tune.WeightBSize	= {			-- Size of weight brick (dimmensions in studs ; larger = more stable)
	 --[[Width]]		6		,
	 --[[Height]]		3.5		,
	 --[[Length]]		14		}
	Tune.WeightDist		= 50		-- Weight distribution (0 - on rear wheels, 100 - on front wheels, can be <0 or >100)
	Tune.CGHeight		= .8		-- Center of gravity height (studs relative to median of all wheels)
	Tune.WBVisible		= false		-- Makes the weight brick visible
	
	--Unsprung Weight
	Tune.FWheelDensity	= .1		-- Front Wheel Density
	Tune.RWheelDensity	= .1		-- Rear Wheel Density
	Tune.FWLgcyDensity	= 1			-- Front Wheel Density [PGS OFF]
	Tune.RWLgcyDensity	= 1			-- Rear Wheel Density [PGS OFF]
	
	Tune.AxleSize		= 2			-- Size of structural members (larger = more stable/carry more weight)
	Tune.AxleDensity	= .1		-- Density of structural members
	
--[[Susupension]]
	Tune.SusEnabled		= true		-- works only in with PGSPhysicsSolverEnabled, defaults to false when PGS is disabled
	
	--Front Suspension
	Tune.FSusDamping	= 500		-- Spring Dampening
	Tune.FSusStiffness	= 9000		-- Spring Force
	Tune.FSusLength		= 2			-- Suspension length (in studs)
	Tune.FSusMaxExt		= .3		-- Max Extension Travel (in studs)
	Tune.FSusMaxComp	= .1		-- Max Compression Travel (in studs)
	Tune.FSusAngle		= 80		-- Suspension Angle (degrees from horizontal)
		
	Tune.FWsBoneLen		= 5			-- Wishbone Length
	Tune.FWsBoneAngle	= 0			-- Wishbone angle (degrees from horizontal)
	Tune.FAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.4		,	-- positive = outward
	 --[[Vertical]]		-.5		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward
	
	--Rear Suspension
	Tune.RSusDamping	= 500		-- Spring Dampening
	Tune.RSusStiffness	= 9000		-- Spring Force
	Tune.RSusLength		= 2			-- Suspension length (in studs)
	Tune.RSusMaxExt		= .3		-- Max Extension Travel (in studs)
	Tune.RSusMaxComp	= .1		-- Max Compression Travel (in studs)
	Tune.RSusAngle		= 80		-- Suspension Angle (degrees from horizontal)
		
	Tune.RWsBoneLen		= 5			-- Wishbone Length
	Tune.RWsBoneAngle	= 0			-- Wishbone angle (degrees from horizontal)
	Tune.RAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.4		,	-- positive = outward
	 --[[Vertical]]		-.5		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward

	--Aesthetics	
	Tune.SusVisible		= true			-- Spring Visible
	Tune.WsBVisible		= false			-- Wishbone Visible
	Tune.SusRadius		= .2			-- Suspension Coil Radius
	Tune.SusThickness	= .1			-- Suspension Coil Thickness
	Tune.SusColor		= "Really black"	-- Suspension Color [BrickColor]
	Tune.SusCoilCount	= 6				-- Suspension Coil Count
	Tune.WsColor		= "Black"		-- Wishbone Color [BrickColor]
	Tune.WsThickness	= .1			-- Wishbone Rod Thickness
	
--[[Wheel Stabilizer Gyro]]
	Tune.FGyroDamp		= 100		-- Front Wheel Non-Axial Dampening
	Tune.RGyroDamp		= 100		-- Rear Wheel Non-Axial Dampening
	
--[[Steering]]
	Tune.SteerInner		= 36		-- Inner wheel steering angle (in degrees)
	Tune.SteerOuter		= 37		-- Outer wheel steering angle (in degrees)
	Tune.SteerSpeed		= .05		-- Steering increment per tick (in degrees)
	Tune.ReturnSpeed	= .1		-- Steering increment per tick (in degrees)
	Tune.SteerDecay		= 320		-- Speed of gradient cutoff (in SPS)
	Tune.MinSteer		= 10		-- Minimum steering at max steer decay (in percent)
	Tune.MSteerExp		= 1			-- Mouse steering exponential degree
	
	--Steer Gyro Tuning
	Tune.SteerD			= 1000		-- Steering Dampening
	Tune.SteerMaxTorque	= 50000		-- Steering Force
	Tune.SteerP			= 100000	-- Steering Aggressiveness
	
--[[Engine]]
	--Torque Curve
	Tune.Horsepower		= 200		--	[TORQUE CURVE VISUAL]
	Tune.IdleRPM		= 700		--		https://www.desmos.com/calculator/2uo3hqwdhf
	Tune.PeakRPM		= 6000		--		Use sliders to manipulate values
	Tune.Redline		= 6700		--		Copy and paste slider values into the respective tune values
	Tune.EqPoint		= 5500
	Tune.PeakSharpness	= 7.5
	Tune.CurveMult		= 0.16
	
	--Incline Compensation
	Tune.InclineComp	= 4.7			-- Torque compensation multiplier for inclines (applies gradient from 0-90 degrees)
	
	--Misc
	Tune.RevAccel		= 150		-- RPM acceleration when clutch is off
	Tune.RevDecay		= 75		-- RPM decay when clutch is off
	Tune.RevBounce		= 500		-- RPM kickback from redline
	Tune.IdleThrottle	= 3			-- Percent throttle at idle
	Tune.ClutchTol		= 500		-- Clutch engagement threshold (higher = faster response)
	
--[[Drivetrain]]	
	Tune.Config			= "FWD"		--"FWD" , "RWD" , "AWD"
	
	--Differential Settings	
	Tune.FDiffSlipThres	= 50		-- 1 - 100%				(Max threshold of applying full lock determined by deviation from avg speed)
	Tune.FDiffLockThres	= 50		-- 0 - 100%				(0 - Bias toward slower wheel, 100 - Bias toward faster wheel)
	Tune.RDiffSlipThres	= 50		-- 1 - 100%
	Tune.RDiffLockThres	= 50		-- 0 - 100%
	Tune.CDiffSlipThres	= 50		-- 1 - 100%				[AWD Only]
	Tune.CDiffLockThres	= 50		-- 0 - 100%				[AWD Only]
	
	--Traction Control Settings
	Tune.TCSEnabled		= true		-- Implements TCS
	Tune.TCSThreshold	= 20		-- Slip speed allowed before TCS starts working (in SPS)
	Tune.TCSGradient	= 20		-- Slip speed gradient between 0 to max reduction (in SPS)
	Tune.TCSLimit		= 10		-- Minimum amount of torque at max reduction (in percent)
	
--[[Transmission]]
	Tune.TransModes		= {"Auto", "Semi", "Manual"}								--[[
	[Modes]
		"Auto"		: Automatic shifting
		"Semi"		: Clutchless manual shifting, dual clutch transmission
		"Manual"	: Manual shifting with clutch
		
		>Include within brackets
			eg: {"Semi"} or {"Auto", "Manual"}								
		>First mode is default mode													]]
	
	--Automatic Settings
	Tune.AutoShiftMode	= "Speed"												--[[
	[Modes]
		"Speed"		: Shifts based on wheel speed
		"RPM"		: Shifts based on RPM											]]	
	Tune.AutoUpThresh	= -200		--Automatic upshift point 	(relative to peak RPM, positive = Over-rev)
	Tune.AutoDownThresh = 1400		--Automatic downshift point (relative to peak RPM, positive = Under-rev)
	
	--Gear Ratios
	Tune.FinalDrive		= 3.06			-- Gearing determines top speed and wheel torque
	Tune.Ratios			= {				-- Higher ratio = more torque, Lower ratio = higher top speed
		--[[Reverse]]	3.70		,	-- Copy and paste a ratio to add a gear
		--[[Neutral]]	0			,	-- Ratios can also be deleted
		--[[ 1 ]]		3.53		,	-- Reverse, Neutral, and 1st gear are required
		--[[ 2 ]]		2.04		,
		--[[ 3 ]]		1.38		,
		--[[ 4 ]]		1.03		,
		--[[ 5 ]]		0.81		,
		--[[ 6 ]]		0.64		,
	}
	Tune.FDMult			= 1.5			-- Ratio multiplier (Change this value instead of FinalDrive if car is struggling with torque ; Default = 1)
	
--[[Brakes]]
	Tune.ABSEnabled		= true		-- Implements ABS
	Tune.ABSThreshold	= 20		-- Slip speed allowed before ABS starts working (in SPS) 

	Tune.FBrakeForce	= 1500		-- Front brake force
	Tune.RBrakeForce	= 1000		-- Rear brake force
	Tune.PBrakeForce	= 5000		-- Handbrake force
	
	Tune.FLgcyBForce	= 15000		-- Front brake force [PGS OFF]
	Tune.RLgcyBForce	= 10000		-- Rear brake force [PGS OFF]
	Tune.LgcyPBForce	= 25000		-- Handbrake force [PGS OFF]
	
--[[[Default Controls]]
	--Peripheral Deadzones
	Tune.Peripherals = {
		MSteerWidth				= 67		,	-- Mouse steering control width	(0 - 100% of screen width)
		MSteerDZone				= 10		,	-- Mouse steering deadzone (0 - 100%)
		
		ControlLDZone			= 5			,	-- Controller steering L-deadzone (0 - 100%)
		ControlRDZone			= 5			,	-- Controller steering R-deadzone (0 - 100%)
	}
	
	--Control Mapping
	Tune.Controls = {
		
	--Keyboard Controls
		--Mode Toggles
		ToggleTCS				= Enum.KeyCode.T					,
		ToggleABS				= Enum.KeyCode.Y					,
		ToggleTransMode			= Enum.KeyCode.M					,
		ToggleMouseDrive		= Enum.KeyCode.R					,
		
		--Primary Controls
		Throttle				= Enum.KeyCode.Up					,
		Brake					= Enum.KeyCode.Down					,
		SteerLeft				= Enum.KeyCode.Left					,
		SteerRight				= Enum.KeyCode.Right				,
		
		--Secondary Controls
		Throttle2				= Enum.KeyCode.W					,
		Brake2					= Enum.KeyCode.S					,
		SteerLeft2				= Enum.KeyCode.A					,
		SteerRight2				= Enum.KeyCode.D					,
		
		--Manual Transmission
		ShiftUp					= Enum.KeyCode.E					,
		ShiftDown				= Enum.KeyCode.Q					,
		Clutch					= Enum.KeyCode.LeftShift			,
		
		--Handbrake
		PBrake					= Enum.KeyCode.P					,
		
	--Mouse Controls
		MouseThrottle			= Enum.UserInputType.MouseButton1	,
		MouseBrake				= Enum.UserInputType.MouseButton2	,
		MouseClutch				= Enum.KeyCode.W					,
		MouseShiftUp			= Enum.KeyCode.E					,
		MouseShiftDown			= Enum.KeyCode.Q					,
		MousePBrake				= Enum.KeyCode.LeftShift			,
		
	--Controller Mapping
		ContlrThrottle			= Enum.KeyCode.ButtonR2				,
		ContlrBrake				= Enum.KeyCode.ButtonL2				,
		ContlrSteer				= Enum.KeyCode.Thumbstick1			,
		ContlrShiftUp			= Enum.KeyCode.ButtonY				,
		ContlrShiftDown			= Enum.KeyCode.ButtonX				,
		ContlrClutch			= Enum.KeyCode.ButtonR1				,
		ContlrPBrake			= Enum.KeyCode.ButtonL1				,
		ContlrToggleTMode		= Enum.KeyCode.DPadUp				,
		ContlrToggleTCS			= Enum.KeyCode.DPadDown				,
		ContlrToggleABS			= Enum.KeyCode.DPadRight			,
	}
	
--[[Weight Scaling]]
	--[Cubic stud : pounds ratio]
	--[STANDARDIZED: Don't touch unless needed]
	Tune.WeightScaling = 1/50	--Default = 1/50 (1 cubic stud = 50 lbs)
	Tune.LegacyScaling = 1/10	--Default = 1/10 (1 cubic stud = 10 lbs) [PGS OFF]
	
return Tune

end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare


*I assume you know what you're doing if you're gonna change something here.* ]]--

--[[START]]

	script.Parent:WaitForChild("Car")
	script.Parent:WaitForChild("IsOn")
	script.Parent:WaitForChild("ControlsOpen")
	script.Parent:WaitForChild("Values")

--[[Dependencies]]

	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	local UserInputService = game:GetService("UserInputService")
	local car = script.Parent.Car.Value
	local _Tune = require(car["A-Chassis Tune"])



--[[Output Scaling Factor]]

	local hpScaling = _Tune.WeightScaling*10
	local FBrakeForce = _Tune.FBrakeForce
	local RBrakeForce = _Tune.RBrakeForce
	local PBrakeForce = _Tune.PBrakeForce
	if not workspace:PGSIsEnabled() then
		hpScaling = _Tune.LegacyScaling*10
		FBrakeForce = _Tune.FLgcyBForce
		RBrakeForce = _Tune.RLgcyBForce
		PBrakeForce = _Tune.LgcyPBForce
	end

--[[Status Vars]]

	local _IsOn = _Tune.AutoStart
	if _Tune.AutoStart then script.Parent.IsOn.Value=true end
	
	local _GSteerT=0
	local _GSteerC=0
	local _GThrot=0
	local _GBrake=0
	
	local _ClutchOn = true
	local _ClPressing = false
	local _RPM = 0
	local _HP = 0
	local _OutTorque = 0
	local _CGear = 0
	
	local _TMode = _Tune.TransModes[1]
	
	local _MSteer = false
	local _SteerL = false
	local _SteerR = false
	local _PBrake = false
	local _TCS = _Tune.TCSEnabled
	local _TCSActive = false
	local _ABS = _Tune.ABSEnabled
	local _ABSActive = false
	
	local FlipWait=tick()
	local FlipDB=false
	
	local _InControls = false



--[[Shutdown]]

	car.DriveSeat.ChildRemoved:connect(function(child)
		if child.Name=="SeatWeld" and child:IsA("Weld") then
			script.Parent:Destroy()
		end
	end)



--[[Controls]]

	local _CTRL = _Tune.Controls
	local Controls = Instance.new("Folder",script.Parent)
	Controls.Name = "Controls"
	for i,v in pairs(_CTRL) do
		local a=Instance.new("StringValue",Controls)
		a.Name=i
		a.Value=v.Name
		a.Changed:connect(function()
			if i=="MouseThrottle" or i=="MouseBrake" then
				if a.Value == "MouseButton1" or a.Value == "MouseButton2" then
					_CTRL[i]=Enum.UserInputType[a.Value]
				else
					_CTRL[i]=Enum.KeyCode[a.Value]
				end
			else
				_CTRL[i]=Enum.KeyCode[a.Value]
			end
		end)
	end
	
	--Deadzone Adjust
	local _PPH = _Tune.Peripherals
		for i,v in pairs(_PPH) do
		local a = Instance.new("IntValue",Controls)
		a.Name = i
		a.Value = v
		a.Changed:connect(function() 
			a.Value=math.min(100,math.max(0,a.Value))
			_PPH[i] = a.Value
		end)
	end
	
	--Input Handler
	function DealWithInput(input,IsRobloxFunction)
		if (UserInputService:GetFocusedTextBox()==nil) and not _InControls then --Ignore when UI Focus
			--Shift Down [Manual Transmission]
			if _IsOn and  (input.KeyCode ==_CTRL["ContlrShiftDown"] or (_MSteer and input.KeyCode==_CTRL["MouseShiftDown"]) or ((not _MSteer) and input.KeyCode==_CTRL["ShiftDown"])) and (_TMode=="Semi" or (_TMode=="Manual" and (not _ClutchOn))) and input.UserInputState == Enum.UserInputState.Begin then
				if _CGear == 0 and (_TMode=="Auto" or not _ClPressing) then _ClutchOn = true end
				_CGear = math.max(_CGear-1,-1)
				
			--Shift Up [Manual Transmission]
			elseif _IsOn and  (input.KeyCode ==_CTRL["ContlrShiftUp"] or (_MSteer and input.KeyCode==_CTRL["MouseShiftUp"]) or ((not _MSteer) and input.KeyCode==_CTRL["ShiftUp"])) and (_TMode=="Semi" or (_TMode=="Manual" and (not _ClutchOn))) and input.UserInputState == Enum.UserInputState.Begin then
				if _CGear == 0 and (_TMode=="Auto" or not _ClPressing) then _ClutchOn = true end
				_CGear = math.min(_CGear+1,#_Tune.Ratios-2)
				
			--Toggle Clutch
			elseif _IsOn and  (input.KeyCode ==_CTRL["ContlrClutch"] or (_MSteer and input.KeyCode==_CTRL["MouseClutch"]) or ((not _MSteer) and input.KeyCode==_CTRL["Clutch"])) and _TMode=="Manual" then
				if input.UserInputState == Enum.UserInputState.Begin then
					_ClutchOn = false
					_ClPressing = true
				elseif input.UserInputState == Enum.UserInputState.End then
					_ClutchOn = true
					_ClPressing = false
				end
				
			--Toggle PBrake
			elseif _IsOn and  input.KeyCode ==_CTRL["ContlrPBrake"] or (_MSteer and input.KeyCode==_CTRL["MousePBrake"]) or ((not _MSteer) and input.KeyCode==_CTRL["PBrake"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_PBrake = not _PBrake
				elseif input.UserInputState == Enum.UserInputState.End then
					if car.DriveSeat.Velocity.Magnitude>5 then
						_PBrake = false
					end
				end
				
			--Toggle Transmission Mode
			elseif (input.KeyCode == _CTRL["ContlrToggleTMode"] or input.KeyCode==_CTRL["ToggleTransMode"]) and input.UserInputState == Enum.UserInputState.Begin then
				local n=1
				for i,v in pairs(_Tune.TransModes) do
					if v==_TMode then n=i break end
				end
				n=n+1
				if n>#_Tune.TransModes then n=1 end
				_TMode = _Tune.TransModes[n]
				
			--Throttle
			elseif _IsOn and ((not _MSteer) and (input.KeyCode==_CTRL["Throttle"] or input.KeyCode == _CTRL["Throttle2"])) or ((((_CTRL["MouseThrottle"]==Enum.UserInputType.MouseButton1 or _CTRL["MouseThrottle"]==Enum.UserInputType.MouseButton2) and input.UserInputType == _CTRL["MouseThrottle"]) or input.KeyCode == _CTRL["MouseThrottle"])and _MSteer) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GThrot = 1
				else
					_GThrot = _Tune.IdleThrottle/100
				end
				
			--Brake
			elseif ((not _MSteer) and (input.KeyCode==_CTRL["Brake"] or input.KeyCode == _CTRL["Brake2"])) or ((((_CTRL["MouseBrake"]==Enum.UserInputType.MouseButton1 or _CTRL["MouseBrake"]==Enum.UserInputType.MouseButton2) and input.UserInputType == _CTRL["MouseBrake"]) or input.KeyCode == _CTRL["MouseBrake"])and _MSteer) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GBrake = 1
				else
					_GBrake = 0
				end
				
			--Steer Left
			elseif (not _MSteer) and (input.KeyCode==_CTRL["SteerLeft"] or input.KeyCode == _CTRL["SteerLeft2"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GSteerT = -1
					_SteerL = true
				else
					if _SteerR then
						_GSteerT = 1
					else
						_GSteerT = 0
					end
					_SteerL = false
				end
				
			--Steer Right
			elseif (not _MSteer) and (input.KeyCode==_CTRL["SteerRight"] or input.KeyCode == _CTRL["SteerRight2"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GSteerT = 1
					_SteerR = true
				else
					if _SteerL then
						_GSteerT = -1
					else
						_GSteerT = 0
					end
					_SteerR = false
				end
				
			--Toggle Mouse Controls
			elseif input.KeyCode ==_CTRL["ToggleMouseDrive"] then
				if input.UserInputState == Enum.UserInputState.End then
					_MSteer = not _MSteer
					_GThrot = _Tune.IdleThrottle/100
					_GBrake = 0
					_GSteerT = 0
					_ClutchOn = true
				end
				
			--Toggle TCS
			elseif  _Tune.TCSEnabled and _IsOn and input.KeyCode == _CTRL["ToggleTCS"] or input.KeyCode == _CTRL["ContlrToggleTCS"] then
				if input.UserInputState == Enum.UserInputState.End then
					_TCS = not _TCS
				end
			
			--Toggle ABS
			elseif  _Tune. ABSEnabled and _IsOn and input.KeyCode == _CTRL["ToggleABS"] or input.KeyCode == _CTRL["ContlrToggleABS"] then
				if input.UserInputState == Enum.UserInputState.End then
					_ABS = not _ABS
				end
			end
			
			--Variable Controls
			if input.UserInputType.Name:find("Gamepad") then
				--Gamepad Steering
				if input.KeyCode == _CTRL["ContlrSteer"] then
					if input.Position.X>= 0 then
						local cDZone = math.min(.99,_Tune.Peripherals.ControlRDZone/100)
						if math.abs(input.Position.X)>cDZone then
							_GSteerT = (input.Position.X-cDZone)/(1-cDZone)
						else
							_GSteerT = 0
						end
					else
						local cDZone = math.min(.99,_Tune.Peripherals.ControlLDZone/100)
						if math.abs(input.Position.X)>cDZone then
							_GSteerT = (input.Position.X+cDZone)/(1-cDZone)
						else
							_GSteerT = 0
						end
					end
					
				--Gamepad Throttle
				elseif _IsOn and input.KeyCode == _CTRL["ContlrThrottle"] then
					_GThrot = math.max(_Tune.IdleThrottle/100,input.Position.Z)
					
				--Gamepad Brake
				elseif input.KeyCode == _CTRL["ContlrBrake"] then
					_GBrake = input.Position.Z
				end
			end
		else
			_GThrot = _Tune.IdleThrottle/100
			_GSteerT = 0
			_GBrake = 0
			if _CGear~=0 then _ClutchOn = true end
		end
	end
	UserInputService.InputBegan:connect(DealWithInput)
	UserInputService.InputChanged:connect(DealWithInput)
	UserInputService.InputEnded:connect(DealWithInput)



--[[Drivetrain Initialize]]

	local Drive={}
	
	--Power Front Wheels
	if _Tune.Config == "FWD" or _Tune.Config == "AWD" then
		for i,v in pairs(car.Wheels:GetChildren()) do
			if v.Name=="FL" or v.Name=="FR" or v.Name=="F" then
				table.insert(Drive,v)
			end
		end
	end
	
	--Power Rear Wheels
	if _Tune.Config == "RWD" or _Tune.Config == "AWD" then
		for i,v in pairs(car.Wheels:GetChildren()) do
			if v.Name=="RL" or v.Name=="RR" or v.Name=="R" then
				table.insert(Drive,v)
			end
		end
	end
	
	--Determine Wheel Size
	local wDia = 0
	for i,v in pairs(Drive) do
		if v.Size.x>wDia then wDia = v.Size.x end
	end
	
	--Pre-Toggled PBrake
	for i,v in pairs(car.Wheels:GetChildren()) do
		if math.abs(v["#AV"].maxTorque.Magnitude-PBrakeForce)<1 then
			_PBrake=true
		end
	end
	
	

--[[Steering]]

	function Steering()
		--Mouse Steer
		if _MSteer then
			local msWidth = math.max(1,mouse.ViewSizeX*_Tune.Peripherals.MSteerWidth/200)
			local mdZone = _Tune.Peripherals.MSteerDZone/100
			local mST = ((mouse.X-mouse.ViewSizeX/2)/msWidth)
			if math.abs(mST)<=mdZone then
				_GSteerT = 0
			else
				_GSteerT = (math.max(math.min((math.abs(mST)-mdZone),(1-mdZone)),0)/(1-mdZone))^_Tune.MSteerExp * (mST / math.abs(mST))
			end
		end
		
		--Interpolate Steering
		if _GSteerC < _GSteerT then
			if _GSteerC<0 then
				_GSteerC = math.min(_GSteerT,_GSteerC+_Tune.ReturnSpeed)
			else
				_GSteerC = math.min(_GSteerT,_GSteerC+_Tune.SteerSpeed)
			end
		else
			if _GSteerC>0 then
				_GSteerC = math.max(_GSteerT,_GSteerC-_Tune.ReturnSpeed)
			else
				_GSteerC = math.max(_GSteerT,_GSteerC-_Tune.SteerSpeed)
			end
		end
		
		--Steer Decay Multiplier
		local sDecay = (1-math.min(car.DriveSeat.Velocity.Magnitude/_Tune.SteerDecay,1-(_Tune.MinSteer/100)))
		
		--Apply Steering
		for i,v in pairs(car.Wheels:GetChildren()) do
			if v.Name=="F" then
				v.Arm.Steer.CFrame=car.Wheels.F.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerInner*sDecay),0)
			elseif v.Name=="FL" then
				if _GSteerC>= 0 then
					v.Arm.Steer.CFrame=car.Wheels.FL.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerOuter*sDecay),0)
				else
					v.Arm.Steer.CFrame=car.Wheels.FL.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerInner*sDecay),0)
				end
			elseif v.Name=="FR" then
				if _GSteerC>= 0 then
					v.Arm.Steer.CFrame=car.Wheels.FR.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerInner*sDecay),0)
				else
					v.Arm.Steer.CFrame=car.Wheels.FR.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerOuter*sDecay),0)
				end
			end
		end
	end



--[[Engine]]

	local fFD = _Tune.FinalDrive*_Tune.FDMult

	--Horsepower Curve
	local fgc_h=_Tune.Horsepower/100
	local fgc_n=_Tune.PeakRPM/1000
	local fgc_a=_Tune.PeakSharpness
	local fgc_c=_Tune.CurveMult
	function FGC(x)
		x=x/1000
		return (((-(x-fgc_n)^2)*math.min(fgc_h/(fgc_n^2),fgc_c^(fgc_n/fgc_h)))+fgc_h)*(x-((x^fgc_a)/((fgc_a*fgc_n)^(fgc_a-1))))
	end
	local PeakFGC = FGC(_Tune.PeakRPM)
	
	--Plot Current Horsepower
	local cGrav = workspace.Gravity/32.2
	function GetCurve(x)
		local hp=math.max((FGC(x)*_Tune.Horsepower)/PeakFGC,0)
		local iComp =(car.DriveSeat.CFrame.lookVector.y)*_Tune.InclineComp*cGrav
		if _CGear==-1 then iComp=-iComp end
		return hp,hp*(_Tune.EqPoint/x)*_Tune.Ratios[_CGear+2]*fFD*math.max(1,(1+iComp))*hpScaling
	end
	
	--Powertrain
	function Engine()
		--Neutral Gear
		if _CGear==0 then _ClutchOn = false end
	
		--Car Is Off
		local revMin = _Tune.IdleRPM
		if not _IsOn then 
			revMin = 0 
			_CGear = 0
			_ClutchOn = false
			_GThrot = _Tune.IdleThrottle/100
		end
		
		--Determine RPM
		local maxSpin=0
		for i,v in pairs(Drive) do
			if v.RotVelocity.Magnitude>maxSpin then maxSpin = v.RotVelocity.Magnitude end
		end
		if _ClutchOn then
			local aRPM = math.max(math.min(maxSpin*_Tune.Ratios[_CGear+2]*fFD*30/math.pi,_Tune.Redline+100),revMin)
			local clutchP = math.min(math.abs(aRPM-_RPM)/_Tune.ClutchTol,.9)
			_RPM = _RPM*clutchP  +  aRPM*(1-clutchP)
			_HP,_OutTorque = GetCurve(_RPM)
		else
			if _GThrot-(_Tune.IdleThrottle/100)>0 then
				_RPM = math.min(_RPM+_Tune.RevAccel*_GThrot,_Tune.Redline+100)
			else
				_RPM = math.max(_RPM-_Tune.RevDecay,revMin)
			end
			_OutTorque = 0
		end
		
		--Rev Limiter
		local spLimit = 0
		if _RPM>_Tune.Redline then 
			if _CGear<#_Tune.Ratios-2 then
				_RPM = _RPM-_Tune.RevBounce
				spLimit = 0
			else
				_RPM = _RPM-_Tune.RevBounce*.5
			end
		else
			spLimit = (_Tune.Redline+100)*math.pi/(30*_Tune.Ratios[_CGear+2]*fFD)
		end
		
		--Automatic Transmission
		if _TMode == "Auto" and _IsOn then
			_ClutchOn = true
			if _CGear == 0 then _CGear = 1 end
			if _CGear >= 1 then
				if _CGear==1 and _GBrake > 0  and car.DriveSeat.Velocity.Magnitude < 20 then
					_CGear = -1
				else
					if _Tune.AutoShiftMode == "RPM" then
						if _RPM>(_Tune.PeakRPM+_Tune.AutoUpThresh) then
							_CGear=math.min(_CGear+1,#_Tune.Ratios-2) 
						elseif math.max(math.min(maxSpin*_Tune.Ratios[_CGear+1]*fFD*30/math.pi,_Tune.Redline+100),_Tune.IdleRPM)<(_Tune.PeakRPM-_Tune.AutoDownThresh) then
							_CGear=math.max(_CGear-1,1)
						end
					else
						if car.DriveSeat.Velocity.Magnitude > math.ceil(wDia*math.pi*(_Tune.PeakRPM+_Tune.AutoUpThresh)/60/_Tune.Ratios[_CGear+2]/fFD) then
							_CGear=math.min(_CGear+1,#_Tune.Ratios-2)
						elseif car.DriveSeat.Velocity.Magnitude < math.ceil(wDia*math.pi*(_Tune.PeakRPM-_Tune.AutoDownThresh)/60/_Tune.Ratios[_CGear+1]/fFD) then
							_CGear=math.max(_CGear-1,1)
						end
					end
				end
			else
				if _GThrot-(_Tune.IdleThrottle/100) > 0 and car.DriveSeat.Velocity.Magnitude < 20 then
					_CGear = 1
				end
			end
		end 
		
		--Average Rotational Speed Calculation
		local fwspeed=0
		local fwcount=0
		local rwspeed=0
		local rwcount=0
		
		for i,v in pairs(car.Wheels:GetChildren()) do
			if v.Name=="FL" or v.Name=="FR" or v.Name == "F" then
				fwspeed=fwspeed+v.RotVelocity.Magnitude
				fwcount=fwcount+1
			elseif v.Name=="RL" or v.Name=="RR" or v.Name == "R" then
				rwspeed=rwspeed+v.RotVelocity.Magnitude
				rwcount=rwcount+1
			end
		end
		fwspeed=fwspeed/fwcount
		rwspeed=rwspeed/rwcount	
		local cwspeed=(fwspeed+rwspeed)/2
		
		--Update Wheels
		for i,v in pairs(car.Wheels:GetChildren()) do
			--Reference Wheel Orientation
			local Ref=(CFrame.new(v.Position-((v.Arm.CFrame*CFrame.Angles(math.pi/2,-math.pi/2,0)).lookVector),v.Position)*CFrame.Angles(0,math.pi,0)).lookVector
			local aRef=1
			local diffMult=1
			if v.Name=="FL" or v.Name=="RL" then aRef=-1 end
			
			--AWD Torque Scaling
			if _Tune.Config == "AWD" then _OutTorque = _OutTorque*(2^.5)/2 end
			
			--Differential/Torque-Vectoring
			if v.Name=="FL" or v.Name=="FR" then
				diffMult=math.max(0,math.min(1,1+((((v.RotVelocity.Magnitude-fwspeed)/fwspeed)/(math.max(_Tune.FDiffSlipThres,1)/100))*((_Tune.FDiffLockThres-50)/50))))
				if _Tune.Config == "AWD" then
					diffMult=math.max(0,math.min(1,diffMult*(1+((((fwspeed-cwspeed)/cwspeed)/(math.max(_Tune.CDiffSlipThres,1)/100))*((_Tune.CDiffLockThres-50)/50)))))
				end
			elseif v.Name=="RL" or v.Name=="RR" then
				diffMult=math.max(0,math.min(1,1+((((v.RotVelocity.Magnitude-rwspeed)/rwspeed)/(math.max(_Tune.RDiffSlipThres,1)/100))*((_Tune.RDiffLockThres-50)/50))))
				if _Tune.Config == "AWD" then
					diffMult=math.max(0,math.min(1,diffMult*(1+((((rwspeed-cwspeed)/cwspeed)/(math.max(_Tune.CDiffSlipThres,1)/100))*((_Tune.CDiffLockThres-50)/50)))))
				end
			end
			
			_TCSActive = false
			_ABSActive = false
			--Output
			if _PBrake and ((_Tune.Config ~= "FWD" and (((v.Name=="FL" or v.Name=="FR") and car.DriveSeat.Velocity.Magnitude<20) or ((v.Name=="RR" or v.Name=="RL") and car.DriveSeat.Velocity.Magnitude>=20))) or (_Tune.Config == "FWD" and (v.Name=="RR" or v.Name=="RL"))) then
				--PBrake
				v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*PBrakeForce
				v["#AV"].angularvelocity=Vector3.new()
			else
				--Apply Power
				if ((_TMode == "Manual" or _TMode == "Semi") and _GBrake==0) or (_TMode == "Auto" and ((_CGear>-1 and _GBrake==0 ) or (_CGear==-1 and _GThrot-(_Tune.IdleThrottle/100)==0 )))then
					local driven = false
					for _,a in pairs(Drive) do if a==v then driven = true end end
					if driven then
						local on=1
						if not script.Parent.IsOn.Value then on=0 end
						local throt = _GThrot
						if _TMode == "Auto" and _CGear==-1 then throt = _GBrake end
						
						--Apply TCS
						local tqTCS = 1
						if _TCS then
							tqTCS = 1-(math.min(math.max(0,math.abs(v.RotVelocity.Magnitude*(v.Size.x/2) - v.Velocity.Magnitude)-_Tune.TCSThreshold)/_Tune.TCSGradient,1)*(1-(_Tune.TCSLimit/100)))
						end
						if tqTCS < 1 then
							_TCSActive = true
						end
						
						--Update Forces
						local dir = 1
						if _CGear==-1 then dir = -1 end
						v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*_OutTorque*(1+(v.RotVelocity.Magnitude/60)^1.15)*throt*tqTCS*diffMult*on
						v["#AV"].angularvelocity=Ref*aRef*spLimit*dir
					else
						v["#AV"].maxTorque=Vector3.new()
						v["#AV"].angularvelocity=Vector3.new()
					end
					
				--Brakes
				else
					local brake = _GBrake
					if _TMode == "Auto" and _CGear==-1 then brake = _GThrot end
					
					--Apply ABS
					local tqABS = 1
					if _ABS and math.abs(v.RotVelocity.Magnitude*(v.Size.x/2) - v.Velocity.Magnitude)-_Tune.ABSThreshold>0 then
						tqABS = 0
					end
					if tqABS < 1 then
						_ABSActive = true
					end
					
					--Update Forces
					if v.Name=="FL" or v.Name=="FR" or v.Name=="F" then
						v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*FBrakeForce*brake*tqABS
					else
						v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*RBrakeForce*brake*tqABS
					end
					v["#AV"].angularvelocity=Vector3.new()
				end
			end
		end
	end



--[[Flip]]

	function Flip()
		--Detect Orientation
		if (car.DriveSeat.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector.y > .1 or FlipDB then
			FlipWait=tick()
			
		--Apply Flip
		else
			if tick()-FlipWait>=3 then
				FlipDB=true
				local gyro = car.DriveSeat.Flip
				gyro.maxTorque = Vector3.new(10000,0,10000)
				gyro.P=3000
				gyro.D=500
				wait(1)
				gyro.maxTorque = Vector3.new(0,0,0)
				gyro.P=0
				gyro.D=0
				FlipDB=false
			end
		end
	end



--[[Run]]

	--Print Version
	local ver=require(car["A-Chassis Tune"].README)
	print("//INSPARE: AC6 Loaded - Build "..ver)
	
	--Runtime Loop
	while wait() do
		--Steering
		Steering()
		
		--Powertrain
		Engine()
		
		--Flip
		if _Tune.AutoFlip then Flip() end
		
		--Update External Values
		_IsOn = script.Parent.IsOn.Value
		_InControls = script.Parent.ControlsOpen.Value
		script.Parent.Values.Gear.Value = _CGear
		script.Parent.Values.RPM.Value = _RPM
		script.Parent.Values.Horsepower.Value = _HP
		script.Parent.Values.Torque.Value = _HP * 5250 / _RPM
		script.Parent.Values.TransmissionMode.Value = _TMode
		script.Parent.Values.Throttle.Value = _GThrot
		script.Parent.Values.Brake.Value = _GBrake
		script.Parent.Values.SteerC.Value = _GSteerC*(1-math.min(car.DriveSeat.Velocity.Magnitude/_Tune.SteerDecay,1-(_Tune.MinSteer/100)))
		script.Parent.Values.SteerT.Value = _GSteerT
		script.Parent.Values.PBrake.Value = _PBrake
		script.Parent.Values.TCS.Value = _TCS
		script.Parent.Values.TCSActive.Value = _TCSActive
		script.Parent.Values.ABS.Value = _ABS
		script.Parent.Values.ABSActive.Value = _ABSActive
		script.Parent.Values.MouseSteerOn.Value = _MSteer
		script.Parent.Values.Velocity.Value = car.DriveSeat.Velocity
		
	end

--[[END]]
end,
function(script,require)
--[[                                           <<DO NOT DELETE THIS MODULE>>
   ___      _______                _     
  / _ |____/ ___/ /  ___ ____ ___ (_)__ 
 / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
/_/ |_|   \___/_//_/\_,_/___/___/_/___/	Build 6.43S
				SecondLogic @ Inspare

>>Manual

Basically...everything you can and would ever want to touch is in the tuning module. EVERYTHING

Torque Curve Tune Visualizer:
https://www.desmos.com/calculator/2uo3hqwdhf


Basic Tips:
--Installation
	>Everything is built-in (assembly, welding, suspension, gyros), so all you have to worry about is placing the wheels and the seat.
	>Body parts go in the "Body" section.
	>Wheel parts such as 3D rims and brake disks go in the "Parts" section of the wheel.
	>Suspension-Anchored parts such as suspension wishbones and linkages go in the "SuspensionFixed" section.
	>Axle-Anchored parts such as calipers go in the "WheelFixed" section.
	>You can add or remove wheels. To add a wheel, simply copy one of the wheels and make sure it's named one of the following: "F","FL","FR","R","RL","RR".
	>Wheels need to be aligned with the axes of the seat. Don't rotate the seat relative to the wheels as it may cause welding problems.
	>All wheel offsets are applied in the tuning module. Do NOT manually add offset to the wheels. Steering axis is centered on the wheel part by default.
	>Seat offset can be adjusted in the "MiscWeld" module under "Initialize".
	>Use the "Misc" section for scripted/moving parts and apply welding using the "MiscWeld" module under "Initialize".

--Tuning
	>Reduce weight(density) if setup is lacking torque. Increase density if setup has too much torque.
	>Add downforce manually if setup is lacking grip or use a downforce plugin.
	>Dialing in ratios used in real cars is an easy way to have a realisticly tuned transmission.
	>Modifying the "Drive" script may affect the integrity of the system.
	>Custom scripts should be put in the "Plugins" folder. Using plugins made by other users is encouraged.
	>When writing custom plugins, you can reference the values within the "Values" folder inside the A-Chassis Interface.
	>It is a good practice to make plugins compatible with any setup and providing a usage manual if a plugin is released.
	>You can remove/change the default plugins that come with the kit. The drive system will still work perfectly with or without them.
	
--Updates
	>To update, simply just replace the entire "A-Chassis Tune" module of an existing car with a newer version of the module.
	>You may want to copy the tune values and plugins from the old module, but dont simply overwrite the tune module as new values may be added.
	

>>Changelog
	[5/23/17 : Build 6.43S] - STUFF
		[Added Tune Values]
		-Added WBVisible to set weight brick visibility
		
		[Independent Camera Handling]
		-Separated camera handling from Drive script
		-Mouse camera is now handled by a plugin
		-Custom camera plugin support is now easier
		
		[Stock Plugins Update]
		-Added Dynamic Friction as a stock plugin
		-Dynamic friction can be tuned within the Simulated script
		-Updated default sound plugin
		-Added mouse-steer camera plugin
		
		[Code Fixes]
		-Fixed missing operation within torque curve
		-Slight optimizations during runtime

	[5/20/17 : Build 6.42S] - ABS and PGS Standardization
	
		[Added ABS]
		-Modulates brakes when locking
		-Added threshold value for slip allowance
		-Added control toggles for ABS
		-Added ABS indicator and control mapping to stock UI
		
		[Split Density Tuning for PGS and Legacy]
		-Added standardized weight scaling values to tune
		-Default weight tuning set to 1 cubic stud : 50 lbs for PGS
		-Default weight tuning set to 1 cubic stud : 10 lbs for Legacy
		-Split front and rear density to PGS and Legacy
		-Split brake force tuning to PGS and Legacy
		
		[Added Tune Values]
		-TCSEnabled: Sets whether or not the car will have TCS
		-ABSEnabled: Sets whether or not the car will have ABS
		-LoadDelay: Sets a delay time before initializing car
		
		[Bug Fix: Axle Size Initialization]
		-Car applies proper axle size
		-Added AxleDensity value which sets axle density
		-Fixed miscelaneous wheel part welding
		
		[Added Changable Stock Gauge Units]
		-Added units system for stock gauges
		-Added default units: MPH [1 stud : 10 in], KP/H [1 stud : 10 in], SPS
		-Custom units can be added or removed
		-Click on speed to change between units
		-Moved Controls button to middle for better visibility
		
		[Code Documentation]
		-Extensive documentation and commenting within scripts for better readability
		-Improved warning message for oversized mass condition

	[5/4/17 : Build 6.41S] - Standardized Weight
	
		[Added automatic weight system]
		-Added tune values for car weight, center of gravity, and wheel density
		-Weight standard: 100 lbs = 1 cubic stud mass
		-Applies weight at initialization
		
		[Scaled Down Power Delivery]
		-Horsepower output now at 1/10 because of lighter weight standard
		-Added FDMult value in transmission for gear ratio scaling without having to change Final Drive (useful for low HP tunes)
		
		[Optimized value for Anchor Offset]
		-Changed "SusOffset" to "Anchor Offset"
		-New anchor offset is now based off of wishbone length and wishbone angle.
		-Anchor offset now labelled for forward, lateral, and vertical offsets.
		
		[Split some tune values to F/R]
		-Suspension values for front and rear are now independently tunable.
		-Front and rear brakes can be tuned independently.	
		
		[Tune Module Housekeeping]
		-Rearranged and documented several of the values within the tune module.
		-Removed GyroP and GyroMaxTorque for simplicity. Dampening values are still present.
		-Changed some decimal values to percent values 

	[1/2/17 : Build 6.40S] - Suspension
		"S" Build number identifies suspension build
	
		[Added suspension system for PGS Physics Solver]
		-Suspension uses ROBLOX constraints and is automatically generated with the chassis
		-Added tune values for suspension
		-Temporarily removed caster tuning
		
		[Steering Fix]
		-Added tune value 'ReturnSpeed' which determines how fast wheels return to default orientation
		
		[New Torque Curve Equation]
		-New equation gives more control over the shape of the torque curve
		-Engine values have been replaced with the new equation's variables
		-Added link to desmos graph for the torque curve visualization

	[10/31/16 : Build 6.33] - Semi-Automatic
		
		[Added semi-automatic transmission mode]
		-'TransModes' now accepts "Semi" value for semi-automatic.
		-Updated AC6_Stock_Gauges to include semi-automatic mode.
		
		[Fixed disengaging p-brake]
		-P-Brake now remains engaged if player gets into then vehicle.
		
		[Fixed FE Support for AC6_Stock_Sound]
		-Sounds should now work properly with Filtering Enabled.

	[8/5/16 : Build 6.32] - Differential System
		
		[Implemented differential system]
		-Differential controls torque distibution between wheels that are spinning at different rates
		-Added tune values 'FDiffSlipThres', 'FDiffLockThres', 'RDiffSlipThres', 'RDiffLockThres', 'CDiffSlipThres', and 'CDiffLockThres'.
		-'DiffSlipThres' determine the threshold of the speed difference between the wheels. Full lock applies at max threshold.
		-A lower slip threshold value will make the diff more aggressive.
		-'DiffLockThres' determines the bias of the differential.
		-A lock threshold value more than 50 puts more torque into the slipping wheel (moving towards an open diff).
		-A lock threshold value less than 50 puts more torque into the grounded wheel (moving towards a locked diff).
		
		[Fixed multiple wheel support]
		-The chassis can now use more than just the default 4 set of wheels. Just copy an existing wheel and place accordingly.
		-Differential works with auxiliary wheels.

	[7/13/16 : Build 6.31] - Peripheral Settings
		
		[Added peripheral adjustment values]
		-Moved controller and mouse deadzone values to the "Controls" section of the tune.
		-Split controller deadzone into left and right input.
		-Moved mouse control width to "Conrols" secton. This value now operates based off of % of screed width.
		
		[Updated stock Controls Module]
		-Added sliders for controller and mouse deadzone values.
		-Added slider for mouse control width.

	[6/15/16 : Build 6.3] - Motercisly
	
		[Better motorcycle system support]
		-Added wheel configurations "F" and "R" for single wheel settup.
		-"F" and "R" wheels will have axle parts on both sides for better balance.
		-These wheel configurations will ignore outor rotation value and will rotated based off of the inner rotation value only.
		-Camber and Toe cannot be applied to these wheel configurations. Caster will still be applied as normal.
		
		[Bug fixes]
		-Caster now applies after wheel part rotations so wheel parts dont rotate with caster.
		-Fixed Clutch re-engaging automatically when shifting out of neutral.	
		
	[6/4/16 : Build 6.21] - AC6 Official Public Kit Release
	
		[Plugin FilteringEnabled compatability made easier]
		-System now detects if there is a RemoteEvent or RemoteFunction inside a plugin. These will be parented directly under the car.
		-The RemoteEvent/RemoteFunction needs to be a direct child of the plugin for it to be detected.
		-Scripts inside the RemoteEvent/RemoteFunction should be disabled. They will be enabled after initialization.
		-Be careful as this system is suceptible to name collisions. Name your RemoteEvents/RemoteFunctions uniquely.
		-Stock AC6 Sound plugin is now FE compatible.
	
		[Controls Panel now a plugin instead of integrated]
		-Separated controls panel from Drive script. The controls panel is now a plugin.
		-The "Controls" folder appears inside the interface on Drive startup. Use this folder to reference button mapping values for custom controls plugins.
		-"ControlsOpen" value added. This is a safety toggle when changing control values. This value can be manipulated by plugins.
		
		[New tune values]
		-Added 'AutoFlip' tune value. This determines if the car automatically flips itself over when upside down.
		-Added 'StAxisOffset' tune value. This offsets the center of the steering axis. Positive value = offset outward.
		-Added 'SteerD', 'SteerMaxTorque', and 'SteerP' values which set the steering axle gyro properties.
		
		[MiscWeld streamlining]
		-Added "Misc" section to the main sections. This should contain scripted/moving parts.
		-Parts in this section are NOT WELDED AUTOMATICALLY. Use the "MiscWeld" module to weld these parts. The "Misc" section is pre-referenced as 'misc'.
		
		[Bug fixes]
		-Fixed flip gyro not resetting when gyro is active and driver leaves car.
		-Fixed issue with switching transmission modes.
--]]

return "6.43S"
end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]


---Controls UI
script.Parent.Parent:WaitForChild("Controls")
script.Parent.Parent:WaitForChild("ControlsOpen")
script.Parent:WaitForChild("Window")
script.Parent:WaitForChild("Toggle")

local car = script.Parent.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local UserInputService = game:GetService("UserInputService")
local cPanel = script.Parent
local Controls = script.Parent.Parent.Controls

local ver = require(car["A-Chassis Tune"].README)
cPanel.Window["//INSPARE"].Text = "A-Chassis "..ver.." // INSPARE"

local controlsOpen = false
local cInputB = nil
local cInputT = nil
local cInput = false

local UIS1 = nil
local UIS2 = nil

for i,v in pairs(_Tune.Peripherals) do
	script.Parent.Parent.Controls:WaitForChild(i)
	local slider = cPanel.Window.Content[i]
	slider.Text = v.."%"
	slider.S.CanvasPosition=Vector2.new(v*(slider.S.CanvasSize.X.Offset-slider.S.Size.X.Offset)/100,0)
	slider.S.Changed:connect(function(property)
		if property=="CanvasPosition" then
			Controls[i].Value = math.floor(100*slider.S.CanvasPosition.x/(slider.S.CanvasSize.X.Offset-slider.S.Size.X.Offset))
			slider.Text = Controls[i].Value.."%"
		end
	end)
end

for i,v in pairs(_Tune.Controls) do
	script.Parent.Parent.Controls:WaitForChild(i)
	local button = cPanel.Window.Content[i]
	button.Text = v.Name
	button.MouseButton1Click:connect(function()
		if UIS1 ~= nil then UIS1:disconnect() end
		if UIS2 ~= nil then UIS2:disconnect() end
		UIS1 = UserInputService.InputBegan:connect(function(input) 
			if cInput then
				cInputB = input.KeyCode
				cInputT = input.UserInputType
			end
		end)
		UIS2 = UserInputService.InputChanged:connect(function(input)
			if cInput and (input.KeyCode==Enum.KeyCode.Thumbstick1 or input.KeyCode==Enum.KeyCode.Thumbstick2) then
				cInputB = input.KeyCode
				cInputT = input.UserInputType
			end
		end)
		script.Parent.Parent.ControlsOpen.Value = true
		cPanel.Window.Overlay.Visible = true
		cInput = true
		repeat wait() until cInputB~=nil
		if UIS1 ~= nil then UIS1:disconnect() end
		if UIS2 ~= nil then UIS2:disconnect() end
		if cInputB == Enum.KeyCode.Return or cInputB == Enum.KeyCode.KeypadEnter then
			--do nothing
		elseif string.find(i,"Contlr")~=nil then
			if cInputT.Name:find("Gamepad") then
				Controls[i].Value = cInputB.Name
				button.Text = cInputB.Name
			else
				cPanel.Window.Error.Visible = true
			end
		elseif i=="MouseThrottle" or i=="MouseBrake" then
			if cInputT == Enum.UserInputType.MouseButton1 or cInputT == Enum.UserInputType.MouseButton2 then
				Controls[i].Value = cInputT.Name
				button.Text = cInputT.Name
			elseif cInputT ==  Enum.UserInputType.Keyboard then
				Controls[i].Value = cInputB.Name
				button.Text = cInputB.Name	
			else
				cPanel.Window.Error.Visible = true
			end	
		else
			if cInputT == Enum.UserInputType.Keyboard then
				Controls[i].Value = cInputB.Name
				button.Text = cInputB.Name
			else
				cPanel.Window.Error.Visible = true
			end
		end
		cInputB = nil
		cInputT = nil
		cInput = false
		wait(.2)
		cPanel.Window.Overlay.Visible = false
		script.Parent.Parent.ControlsOpen.Value = false
	end)
end

cPanel.Window.Error.Changed:connect(function(property)
	if property == "Visible" then
		wait(3)
		cPanel.Window.Error.Visible = false
	end
end)

cPanel.Toggle.MouseButton1Click:connect(function()
	controlsOpen = not controlsOpen
	if controlsOpen then
		cPanel.Toggle.BackgroundColor3 = Color3.new(1,85/255,.5)
		cPanel.Window:TweenPosition(UDim2.new(0.5, -250,0.5, -250),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.7,true)
	else
		if UIS1 ~= nil then UIS1:disconnect() end
		if UIS2 ~= nil then UIS2:disconnect() end
		cPanel.Toggle.BackgroundColor3 = Color3.new(1,170/255,0)
		cPanel.Window:TweenPosition(UDim2.new(0.5, -250,0, -500),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.7,true)
	end
end)

cPanel.Window.Tabs.Keyboard.MouseButton1Click:connect(function()
	cPanel.Window.Content:TweenPosition(UDim2.new(0, 0, 0, 60),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Keyboard:TweenPosition(UDim2.new(0, 5, 0, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Mouse:TweenPosition(UDim2.new(0, 120, 0, -5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Controller:TweenPosition(UDim2.new(0, 235, 0, -5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
end)

cPanel.Window.Tabs.Mouse.MouseButton1Click:connect(function()
	cPanel.Window.Content:TweenPosition(UDim2.new(-1, 0, 0, 60),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Keyboard:TweenPosition(UDim2.new(0, 5, 0, -5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Mouse:TweenPosition(UDim2.new(0, 120, 0, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Controller:TweenPosition(UDim2.new(0, 235, 0, -5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
end)

cPanel.Window.Tabs.Controller.MouseButton1Click:connect(function()
	cPanel.Window.Content:TweenPosition(UDim2.new(-2, 0, 0, 60),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Keyboard:TweenPosition(UDim2.new(0, 5, 0, -5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Mouse:TweenPosition(UDim2.new(0, 120, 0, -5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
	cPanel.Window.Tabs.Controller:TweenPosition(UDim2.new(0, 235, 0, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,true)
end)

wait(.5)
cPanel.Toggle:TweenPosition(UDim2.new(0.5, -50, 1, -25),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,.4,false)	
for i=1,6 do
	cPanel.Toggle.BackgroundColor3 = Color3.new(100/255,100/255,100/255)
	wait(.2)
	if controlsOpen then
		cPanel.Toggle.BackgroundColor3 = Color3.new(1,85/255,.5)
	else
		cPanel.Toggle.BackgroundColor3 = Color3.new(1,170/255,0)
	end
	wait(.2)
end
end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local handler = car:WaitForChild("AC6_FE_Sounds")
local _Tune = require(car["A-Chassis Tune"])
local on = 0
local throt=0
local redline=0

script:WaitForChild("Rev")


for i,v in pairs(car.DriveSeat:GetChildren()) do
	for _,a in pairs(script:GetChildren()) do
		if v.Name==a.Name then v:Stop() wait() v:Destroy() end
	end
end

handler:FireServer("newSound","Rev",car.DriveSeat,script.Rev.SoundId,0,script.Rev.Volume,true)
handler:FireServer("playSound","Rev")
car.DriveSeat:WaitForChild("Rev")

while wait() do
	local _RPM = script.Parent.Values.RPM.Value
	
	if script.Parent.Values.Throttle.Value <= _Tune.IdleThrottle/100 then
		throt = math.max(.3,throt-.2)	
	else
		throt = math.min(1,throt+.1)	
	end	
	if script.Parent.Values.RPM.Value > _Tune.Redline-_Tune.RevBounce/4 and script.Parent.Values.Throttle.Value > _Tune.IdleThrottle/100 then
		redline=.5
	else
		redline=1
	end
	if not script.Parent.IsOn.Value then on=math.max(on-.015,0) else on=1 end
	local Pitch = math.max((((script.Rev.SetPitch.Value + script.Rev.SetRev.Value*_RPM/_Tune.Redline))*on^2),script.Rev.SetPitch.Value)
	if FE then
		handler:FireServer("updateSound","Rev",script.Rev.SoundId,Pitch,script.Rev.Volume)
	else
		car.DriveSeat.Rev.Pitch = Pitch
	end
end

end,
function(script,require)
local car = script.Parent.Parent
local Sounds = {}
local F = {}

F.newSound = function(name,par,id,pitch,volume,loop)
	for i,v in pairs(Sounds) do
		if i==name then
			v:Stop()
			v:Destroy()
		end
	end
	local sn = Instance.new("Sound",par)
	sn.Name = name
	sn.SoundId = id
	sn.Pitch = pitch
	sn.Volume = volume
	sn.Looped = loop
	Sounds[name]=sn
end

F.updateSound = function(sound,id,pit,vol)
	local sn = Sounds[sound]
	if id~=sn.SoundId then sn.SoundId = id end
	if pit~=sn.Pitch then sn.Pitch = pit end
	if vol~=sn.Volume then sn.Volume = vol end
end

F.playSound = function(sound)
	Sounds[sound]:Play()
end

F.pauseSound = function(sound)
	Sounds[sound]:Pause()
end

F.stopSound = function(sound)
	Sounds[sound]:Stop()
end

F.removeSound = function(sound)
	Sounds[sound]:Stop()
	Sounds[sound]:Destroy()
	Sounds[sound]=nil
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		F.removeSound("Rev")
	end
end)
end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]


local autoscaling	= false					--Estimates top speed

local UNITS	= {								--Click on speed to change units
											--First unit is default	
	{
		units			= "MPH"				,
		scaling			= (10/12) * (60/88)	, -- 1 stud : 10 inches | ft/s to MPH
		maxSpeed		= 140				,
		spInc			= 10				, -- Increment between labelled notches
	},
	
	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	, -- 1 stud : 10 inches | ft/s to KP/H
		maxSpeed		= 220				,
		spInc			= 20				, -- Increment between labelled notches
	},
	
	{
		units			= "SPS"				,
		scaling			= 1					, -- Roblox standard
		maxSpeed		= 240				,
		spInc			= 20				, -- Increment between labelled notches
	}
}

-----------------------------------------------------------------------------------------------

script.Parent:WaitForChild("Speedo")
script.Parent:WaitForChild("Tach")
script.Parent:WaitForChild("ln")
script.Parent:WaitForChild("Gear")
script.Parent:WaitForChild("Speed")

local player=game.Players.LocalPlayer
local mouse=player:GetMouse()

local car = script.Parent.Parent.Car.Value
car.DriveSeat.HeadsUpDisplay = false

local _Tune = require(car["A-Chassis Tune"])

local _pRPM = _Tune.PeakRPM
local _lRPM = _Tune.Redline

local currentUnits = 1
local revEnd = math.ceil(_lRPM/1000)

--Automatic Gauge Scaling
if autoscaling then
	local Drive={}
	if _Tune.Config == "FWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("FL")~= nil then
			table.insert(Drive,car.Wheels.FL)
		end
		if car.Wheels:FindFirstChild("FR")~= nil then
			table.insert(Drive,car.Wheels.FR)
		end
		if car.Wheels:FindFirstChild("F")~= nil then
			table.insert(Drive,car.Wheels.F)
		end
	end
	if _Tune.Config == "RWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("RL")~= nil then
			table.insert(Drive,car.Wheels.RL)
		end
		if car.Wheels:FindFirstChild("RR")~= nil then
			table.insert(Drive,car.Wheels.RR)
		end
		if car.Wheels:FindFirstChild("R")~= nil then
			table.insert(Drive,car.Wheels.R)
		end
	end

	local wDia = 0
	for i,v in pairs(Drive) do
		if v.Size.x>wDia then wDia = v.Size.x end
	end
	Drive = nil
	for i,v in pairs(UNITS) do
		v.maxSpeed = math.ceil(v.scaling*wDia*math.pi*_lRPM/60/_Tune.Ratios[#_Tune.Ratios]/_Tune.FinalDrive)
		v.spInc = math.max(math.ceil(v.maxSpeed/200)*20,20)
	end
end

for i=0,revEnd*2 do
	local ln = script.Parent.ln:clone()
	ln.Parent = script.Parent.Tach
	ln.Rotation = 45 + i * 225 / (revEnd*2)
	ln.Num.Text = i/2
	ln.Num.Rotation = -ln.Rotation
	if i*500>=math.floor(_pRPM/500)*500 then
		ln.Frame.BackgroundColor3 = Color3.new(1,0,0)
		if i<revEnd*2 then
			ln2 = ln:clone()
			ln2.Parent = script.Parent.Tach
			ln2.Rotation = 45 + (i+.5) * 225 / (revEnd*2)
			ln2.Num:Destroy()
			ln2.Visible=true
		end
	end
	if i%2==0 then
		ln.Frame.Size = UDim2.new(0,3,0,10)
		ln.Frame.Position = UDim2.new(0,-1,0,100)
		ln.Num.Visible = true
	else
		ln.Num:Destroy()
	end
	ln.Visible=true
end

local lns = Instance.new("Frame",script.Parent.Speedo)
lns.Name = "lns"
lns.BackgroundTransparency = 1
lns.BorderSizePixel = 0
lns.Size = UDim2.new(0,0,0,0)
for i=1,90 do
	local ln = script.Parent.ln:clone()
	ln.Parent = lns
	ln.Rotation = 45 + 225*(i/90)
	if i%2==0 then
		ln.Frame.Size = UDim2.new(0,2,0,10)
		ln.Frame.Position = UDim2.new(0,-1,0,100)
	else
		ln.Frame.Size = UDim2.new(0,3,0,5)
	end
	ln.Num:Destroy()
	ln.Visible=true
end

for i,v in pairs(UNITS) do
	local lnn = Instance.new("Frame",script.Parent.Speedo)
	lnn.BackgroundTransparency = 1
	lnn.BorderSizePixel = 0
	lnn.Size = UDim2.new(0,0,0,0)
	lnn.Name = v.units
	if i~= 1 then lnn.Visible=false end
	
	for i=0,v.maxSpeed,v.spInc do
		local ln = script.Parent.ln:clone()
		ln.Parent = lnn
		ln.Rotation = 45 + 225*(i/v.maxSpeed)
		ln.Num.Text = i
		ln.Num.TextSize = 14
		ln.Num.Rotation = -ln.Rotation
		ln.Frame:Destroy()
		ln.Num.Visible=true
		ln.Visible=true
	end
end

if 	script.Parent.Parent.IsOn.Value then
	script.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
end

script.Parent.Parent.IsOn.Changed:connect(function()
	if script.Parent.Parent.IsOn.Value then
		script.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
	end
end)

script.Parent.Parent.Values.RPM.Changed:connect(function()
	script.Parent.Tach.Needle.Rotation = 45 + 225 * math.min(1,script.Parent.Parent.Values.RPM.Value / (revEnd*1000))
end)

script.Parent.Parent.Values.Gear.Changed:connect(function()
	local gearText = script.Parent.Parent.Values.Gear.Value
	if gearText == 0 then gearText = "N"
	elseif gearText == -1 then gearText = "R"
	end
	script.Parent.Gear.Text = gearText
end)

script.Parent.Parent.Values.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Values.TCS.Value then
			script.Parent.TCS.TextColor3 = Color3.new(1,170/255,0)
			script.Parent.TCS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if script.Parent.Parent.Values.TCSActive.Value then
				wait()
				script.Parent.TCS.Visible = not script.Parent.TCS.Visible
			else
				wait()
				script.Parent.TCS.Visible = false
			end
		else
			script.Parent.TCS.Visible = true
			script.Parent.TCS.TextColor3 = Color3.new(1,0,0)
			script.Parent.TCS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		script.Parent.TCS.Visible = false
	end
end)

script.Parent.Parent.Values.TCSActive.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Values.TCSActive.Value and script.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = not script.Parent.TCS.Visible
		elseif not script.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = true
		else
			wait()
			script.Parent.TCS.Visible = false
		end
	else
		script.Parent.TCS.Visible = false
	end
end)

script.Parent.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Values.TCSActive.Value and script.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = not script.Parent.TCS.Visible
		elseif not script.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = true
		end
	else
		if script.Parent.TCS.Visible then
			script.Parent.TCS.Visible = false
		end
	end
end)

script.Parent.Parent.Values.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Values.ABS.Value then
			script.Parent.ABS.TextColor3 = Color3.new(1,170/255,0)
			script.Parent.ABS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if script.Parent.Parent.Values.ABSActive.Value then
				wait()
				script.Parent.ABS.Visible = not script.Parent.ABS.Visible
			else
				wait()
				script.Parent.ABS.Visible = false
			end
		else
			script.Parent.ABS.Visible = true
			script.Parent.ABS.TextColor3 = Color3.new(1,0,0)
			script.Parent.ABS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		script.Parent.ABS.Visible = false
	end
end)

script.Parent.Parent.Values.ABSActive.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Values.ABSActive.Value and script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = not script.Parent.ABS.Visible
		elseif not script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = true
		else
			wait()
			script.Parent.ABS.Visible = false
		end
	else
		script.Parent.ABS.Visible = false
	end
end)

script.Parent.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Values.ABSActive.Value and script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = not script.Parent.ABS.Visible
		elseif not script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = true
		end
	else
		if script.Parent.ABS.Visible then
			script.Parent.ABS.Visible = false
		end
	end
end)

script.Parent.Parent.Values.PBrake.Changed:connect(function()
	script.Parent.PBrake.Visible = script.Parent.Parent.Values.PBrake.Value
end)

script.Parent.Parent.Values.TransmissionMode.Changed:connect(function()
	if script.Parent.Parent.Values.TransmissionMode.Value == "Auto" then
		script.Parent.TMode.Text = "A/T"
		script.Parent.TMode.BackgroundColor3 = Color3.new(1,170/255,0)
	elseif script.Parent.Parent.Values.TransmissionMode.Value == "Semi" then
		script.Parent.TMode.Text = "S/T"
		script.Parent.TMode.BackgroundColor3 = Color3.new(0, 170/255, 127/255) 
	else
		script.Parent.TMode.Text = "M/T"
		script.Parent.TMode.BackgroundColor3 = Color3.new(1,85/255,.5)
	end
end)

script.Parent.Parent.Values.Velocity.Changed:connect(function(property)
	script.Parent.Speedo.Needle.Rotation = 45 + 225 * math.min(1,UNITS[currentUnits].scaling*script.Parent.Parent.Values.Velocity.Value.Magnitude/UNITS[currentUnits].maxSpeed)
	script.Parent.Speed.Text = math.floor(UNITS[currentUnits].scaling*script.Parent.Parent.Values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units
end)

script.Parent.Speed.MouseButton1Click:connect(function()
	if currentUnits==#UNITS then
		currentUnits = 1
	else
		currentUnits = currentUnits+1
	end
	for i,v in pairs(script.Parent.Speedo:GetChildren()) do
		v.Visible=v.Name==UNITS[currentUnits].units or v.Name=="Needle" or v.Name=="lns"
	end
	script.Parent.Speed.Text = math.floor(UNITS[currentUnits].scaling*script.Parent.Parent.Values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units
end)

mouse.KeyDown:connect(function(key)
	if key=="v" then
		script.Parent.Visible=not script.Parent.Visible
	end
end)


end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]

local car = script.Parent.Car.Value
local cam = workspace.CurrentCamera
local RS = game:GetService("RunService")

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		RS:UnbindFromRenderStep("MCam")
		cam.CameraType = Enum.CameraType.Custom
	end
end)

script.Parent.Values.MouseSteerOn.Changed:connect(function(property)
	if script.Parent.Values.MouseSteerOn.Value then
		RS:BindToRenderStep("MCam",Enum.RenderPriority.Camera.Value,function()	
			cam.CameraType = Enum.CameraType.Scriptable
			local pspeed = math.min(1,car.DriveSeat.Velocity.Magnitude/500)
			local cc = car.DriveSeat.Position+Vector3.new(0,8+(pspeed*2),0)-(car.DriveSeat.CFrame.lookVector*17)+(car.DriveSeat.Velocity.Unit*-7*pspeed)
			cam.CoordinateFrame = CFrame.new(cc,car.DriveSeat.Position)
		end)
	else
		RS:UnbindFromRenderStep("MCam")
		cam.CameraType = Enum.CameraType.Custom
	end
end)
end,
function(script,require)
wait(1)
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local on = 0

local body = car.Body

local event=car:WaitForChild("SmeersLightsHandler")

local dtapdleft=false

local uis=game:GetService("UserInputService")

uis.InputBegan:connect(function(input, gp)
	if not gp then
		if input.KeyCode==Enum.KeyCode.L or input.KeyCode==Enum.KeyCode.ButtonL3 then
			event:FireServer({["ToggleLight"]=true})
		elseif input.KeyCode==Enum.KeyCode.J then
			event:FireServer({["ToggleFog"]=true})
		elseif input.KeyCode==Enum.KeyCode.Z or input.KeyCode==Enum.KeyCode.ButtonL1 then
			event:FireServer({["ToggleLeftBlink"]=true})
		elseif input.KeyCode==Enum.KeyCode.C or input.KeyCode==Enum.KeyCode.ButtonR1 then
			event:FireServer({["ToggleRightBlink"]=true})
		elseif input.KeyCode==Enum.KeyCode.K then
			event:FireServer({["ToggleHazard"]=true})
		elseif input.KeyCode==Enum.KeyCode.DPadLeft then
			if dtapdleft==true then
				event:FireServer({["ToggleHazard"]=true})
			else
				dtapdleft=true
				wait(0.3)
				dtapdleft=false
			end
		end
	end
end)

car.DriveSeat.Changed:connect(function(valueChanged)
	if valueChanged=="Throttle" then
		if car.DriveSeat.Throttle == -1 then
			event:FireServer({["EnableBrakes"]=true})
		else
			event:FireServer({["DisableBrakes"]=true})
		end
	end
end)
end,
function(script,require)
-- Testing AC FE support

local event = script.Parent
local car=script.Parent.Parent


event.OnServerEvent:connect(function(player,data)
	if data['ToggleLight'] then
		if car.Body.Light.on.Value==true then
			car.Body.Light.on.Value=false
		else
			car.Body.Light.on.Value=true
		end
	elseif data['ToggleFog'] then
		if car.Body.Fog.on.Value==true then
			car.Body.Fog.on.Value=false
		else
			car.Body.Light.on.Value=true
		end
	elseif data['EnableBrakes'] then
		car.Body.Brakes.on.Value=true
	elseif data['DisableBrakes'] then
		car.Body.Brakes.on.Value=false
	elseif data['ToggleLeftBlink'] then
		if car.Body.Left.on.Value==true then
			car.Body.Left.on.Value=false
		else
			car.Body.Left.on.Value=true
		end
	elseif data['ToggleRightBlink'] then
		if car.Body.Right.on.Value==true then
			car.Body.Right.on.Value=false
		else
			car.Body.Right.on.Value=true
		end
	elseif data['ToggleHazard'] then
		if car.Body.Hazards.on.Value==true then
			car.Body.Hazards.on.Value=false
		else
			car.Body.Hazards.on.Value=true
		end
	end
end)
end,
function(script,require)
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
car.Wheels.RL.SQ:Play()
car.Wheels.RR.SQ:Play()
local handler = car:WaitForChild("Smoke_FE")

while wait(.2) do
	local r1 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RL.Size.x/2))
	local r1hit = 0
	if workspace:FindPartOnRay(r1,car)~=nil then r1hit=1 end

	local r2 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RR.Size.x/2))
	local r2hit = 0
	if workspace:FindPartOnRay(r2,car)~=nil then r2hit=1 end
	
	local rl = math.min((math.max(math.abs((car.Wheels.RL.RotVelocity.Magnitude*car.Wheels.RL.Size.x/2) - (car.Wheels.RL.Velocity.Magnitude))-30,0)),50)*r1hit
	local rr = math.min((math.max(math.abs((car.Wheels.RR.RotVelocity.Magnitude*car.Wheels.RR.Size.x/2) - (car.Wheels.RR.Velocity.Magnitude))-30,0)),50)*r2hit
	
	if FE then
		handler:FireServer("UpdateSmoke",rl,rr)
	else
		car.Wheels.RL.Smoke.Rate = rl
		car.Wheels.RR.Smoke.Rate = rr
		car.Wheels.RL.SQ.Volume = rl/50
		car.Wheels.RR.SQ.Volume = rr/50
	end
end

end,
function(script,require)
local car = script.Parent.Parent
local F = {}

F.UpdateSmoke = function(rl,rr)
	car.Wheels.RL.Smoke.Rate = rl
	car.Wheels.RR.Smoke.Rate = rr
	car.Wheels.RL.SQ.Volume = rl/50
	car.Wheels.RR.SQ.Volume = rr/50
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Wheels.RL.SQ:Stop()
		car.Wheels.RR.SQ:Stop()
		car.Wheels.RL.Smoke.Rate=0
		car.Wheels.RR.Smoke.Rate=0
	end
end)

for i,v in pairs(car.Wheels:GetChildren()) do
	if v.Name=="RL" or v.Name=="RR" or v.Name=="R" then
		local sq = script.Parent.SQ:Clone()
		sq.Parent=v
		local sm = script.Parent.Smoke:Clone()
		sm.Parent=v
	end
end
end,
function(script,require)
local player=game.Players.LocalPlayer
local mouse=player:GetMouse()
local car=script.Parent.Car.Value
local run=game:GetService("RunService")
local Binded={}
local GMode=0

---Controller
local Controller=false
local UserInputService = game:GetService("UserInputService")
local LStickX = 0
local RStickX = 0
local RStickY = 0
local RTriggerValue = 0
local LTriggerValue = 0

local ButtonX = 0
local ButtonY = 0
local ButtonL1 = 0
local ButtonR1 = 0
local ButtonR3 = 0
local DPadUp = 0
function DealWithInput(input,IsRobloxFunction)
	if Controller then
		if input.KeyCode ==Enum.KeyCode.ButtonX then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonX=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonX=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonY then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonY=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonY=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonL1 then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonL1=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonL1=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonR1 then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonR1=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonR1=0
			end
		elseif input.KeyCode ==Enum.KeyCode.DPadLeft then
			if input.UserInputState == Enum.UserInputState.Begin then
				DPadUp=1
			elseif input.UserInputState == Enum.UserInputState.End then
				DPadUp=0
			end
		elseif input.KeyCode ==Enum.KeyCode.ButtonR3 then
			if input.UserInputState == Enum.UserInputState.Begin then
				ButtonR3=1
			elseif input.UserInputState == Enum.UserInputState.End then
				ButtonR3=0
			end
		end
		if input.UserInputType.Name:find("Gamepad") then --it's one of 4 gamepads
			if input.KeyCode == Enum.KeyCode.Thumbstick1 then
				LStickX = input.Position.X
			elseif input.KeyCode == Enum.KeyCode.Thumbstick2 then
				RStickX = input.Position.X
				RStickY = input.Position.Y
			elseif input.KeyCode == Enum.KeyCode.ButtonR2 then--right shoulder
				RTriggerValue = input.Position.Z
			elseif input.KeyCode == Enum.KeyCode.ButtonL2 then--left shoulder
				LTriggerValue = input.Position.Z
			end
		end
	end
end
UserInputService.InputBegan:connect(DealWithInput)
UserInputService.InputChanged:connect(DealWithInput)--keyboards don't activate with Changed, only Begin and Ended. idk if digital controller buttons do too
UserInputService.InputEnded:connect(DealWithInput)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		for i,v in pairs(Binded) do
			run:UnbindFromRenderStep(v)
		end 
		workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
		workspace.CurrentCamera.FieldOfView=70
		player.CameraMaxZoomDistance=200
	end
end)

function Camera()
	local cam=workspace.CurrentCamera
	local intcam=false
	local CRot=0
	local CBack=0
	local CUp=0
	local mode=0
	local look=0
	local camChange = 0
	local function CamUpdate()
		if not pcall (function()
			if camChange==0 and DPadUp==1 then
				intcam = not intcam
			end
			camChange=DPadUp
			if mode==1 then
				if math.abs(RStickX)>.1 then
					local sPos=1
					if RStickX<0 then sPos=-1 end
					if intcam then
						CRot=sPos*math.abs(((math.abs(RStickX)-.1)/(.9)))*-80
					else
						CRot=sPos*math.abs(((math.abs(RStickX)-.1)/(.9)))*-90
					end
				else
					CRot=0
				end
				if math.abs(RStickY)>.1 then
					local sPos=1
					if RStickY<0 then sPos=-1 end
					if intcam then
						CUp=sPos*math.abs(((math.abs(RStickY)-.1)/(.9)))*30
					else
						CUp=math.min(sPos*math.abs(((math.abs(RStickY)-.1)/(.9)))*-75,30)
					end
				else
					CUp=0
				end
			else
				if CRot>look then
					CRot=math.max(look,CRot-20)
				elseif CRot<look then
					CRot=math.min(look,CRot+20)
				end
				CUp=0
			end
			if intcam then
				CBack=0
			else
				CBack=-180*ButtonR3
			end
			if intcam then
				cam.CameraSubject=player.Character.Humanoid
				cam.CameraType=Enum.CameraType.Scriptable
				cam.FieldOfView=80 + car.DriveSeat.Velocity.Magnitude/12
				player.CameraMaxZoomDistance=5
				local cf=car.Body.Cam.CFrame
				if ButtonR3==1 then
					cf=car.Body.RCam.CFrame
				end
				cam.CoordinateFrame=cf*CFrame.Angles(0,math.rad(CRot+CBack),0)*CFrame.Angles(math.rad(CUp),0,0)
			else
				cam.CameraSubject=car.DriveSeat
				cam.FieldOfView=70
				if mode==0 then
					cam.CameraType=Enum.CameraType.Custom
					player.CameraMaxZoomDistance=400
					run:UnbindFromRenderStep("CamUpdate")
				else
					cam.CameraType = "Scriptable"
					local pspeed = math.min(1,car.DriveSeat.Velocity.Magnitude/500)
					local cc = car.DriveSeat.Position+Vector3.new(0,8+(pspeed*2),0)-((car.DriveSeat.CFrame*CFrame.Angles(math.rad(CUp),math.rad(CRot+CBack),0)).lookVector*17)+(car.DriveSeat.Velocity.Unit*-7*pspeed)
					cam.CoordinateFrame = CFrame.new(cc,car.DriveSeat.Position)
				end
			end
		end) then
			cam.FieldOfView=70
			cam.CameraSubject=player.Character.Humanoid
			cam.CameraType=Enum.CameraType.Custom
			player.CameraMaxZoomDistance=400
			run:UnbindFromRenderStep("CamUpdate")
		end
	end
	local function ModeChange()
		if GMode~=mode then
			mode=GMode
			run:BindToRenderStep("CamUpdate",Enum.RenderPriority.Camera.Value,CamUpdate)
		end
	end
	mouse.KeyDown:connect(function(key)
		if key=="u" then
			look=90
		elseif key=="i" then
			if intcam then
				look=180
			else
				look=195
			end
		elseif key=="o" then
			look=-90
		elseif key=="v" then
			run:UnbindFromRenderStep("CamUpdate")
			intcam=not intcam
			run:BindToRenderStep("CamUpdate",Enum.RenderPriority.Camera.Value,CamUpdate)
		end
	end)
	mouse.KeyUp:connect(function(key)
		if key=="u" and look==90 then
			look=0
		elseif key=="i" and (look==180 or look==195) then
			look=0
		elseif key=="o" and look==-90 then
			look=0
		end
	end)
	run:BindToRenderStep("CMChange",Enum.RenderPriority.Camera.Value,ModeChange)
	table.insert(Binded,"CamUpdate")
	table.insert(Binded,"CMChange")
end
Camera()

mouse.KeyDown:connect(function(key)
	if key=="b" then
		if GMode>=1 then
			GMode=0
		else
			GMode=GMode+1
		end
		if GMode==1 then
			Controller=true
		else
			Controller=false
		end
	end
end)
end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]


local autoscaling	= false					--Estimates top speed

local UNITS	= {								--Click on speed to change units
											--First unit is default	
	{
		units			= "MPH"				,
		scaling			= (10/12) * (60/88)	, -- 1 stud : 10 inches | ft/s to MPH
		maxSpeed		= 230				,
		spInc			= 20				, -- Increment between labelled notches
	},
	
	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	, -- 1 stud : 10 inches | ft/s to KP/H
		maxSpeed		= 370				,
		spInc			= 40				, -- Increment between labelled notches
	},
	
	{
		units			= "SPS"				,
		scaling			= 1					, -- Roblox standard
		maxSpeed		= 400				,
		spInc			= 40				, -- Increment between labelled notches
	}
}

-----------------------------------------------------------------------------------------------

script.Parent:WaitForChild("Speedo")
script.Parent:WaitForChild("Tach")
script.Parent:WaitForChild("ln")
script.Parent:WaitForChild("Gear")
script.Parent:WaitForChild("Speed")

local player=game.Players.LocalPlayer
local mouse=player:GetMouse()

local car = script.Parent.Parent.Parent.Car.Value
car.DriveSeat.HeadsUpDisplay = false

local _Tune = require(car["A-Chassis Tune"])

local _pRPM = _Tune.PeakRPM
local _lRPM = _Tune.Redline

local currentUnits = 1
local revEnd = math.ceil(_lRPM/1000)

--Automatic Gauge Scaling
if autoscaling then
	local Drive={}
	if _Tune.Config == "FWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("FL")~= nil then
			table.insert(Drive,car.Wheels.FL)
		end
		if car.Wheels:FindFirstChild("FR")~= nil then
			table.insert(Drive,car.Wheels.FR)
		end
		if car.Wheels:FindFirstChild("F")~= nil then
			table.insert(Drive,car.Wheels.F)
		end
	end
	if _Tune.Config == "RWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("RL")~= nil then
			table.insert(Drive,car.Wheels.RL)
		end
		if car.Wheels:FindFirstChild("RR")~= nil then
			table.insert(Drive,car.Wheels.RR)
		end
		if car.Wheels:FindFirstChild("R")~= nil then
			table.insert(Drive,car.Wheels.R)
		end
	end

	local wDia = 0
	for i,v in pairs(Drive) do
		if v.Size.x>wDia then wDia = v.Size.x end
	end
	Drive = nil
	for i,v in pairs(UNITS) do
		v.maxSpeed = math.ceil(v.scaling*wDia*math.pi*_lRPM/60/_Tune.Ratios[#_Tune.Ratios]/_Tune.FinalDrive)
		v.spInc = math.max(math.ceil(v.maxSpeed/200)*20,20)
	end
end

for i=0,revEnd*2 do
	local ln = script.Parent.ln:clone()
	ln.Parent = script.Parent.Tach
	ln.Rotation = 45 + i * 225 / (revEnd*2)
	ln.Num.Text = i/2
	ln.Num.Rotation = -ln.Rotation
	if i*500>=math.floor(_pRPM/500)*500 then
		ln.Frame.BackgroundColor3 = Color3.new(1,0,0)
		if i<revEnd*2 then
			ln2 = ln:clone()
			ln2.Parent = script.Parent.Tach
			ln2.Rotation = 45 + (i+.5) * 225 / (revEnd*2)
			ln2.Num:Destroy()
			ln2.Visible=true
		end
	end
	if i%2==0 then
		ln.Frame.Size = UDim2.new(0,3,0,10)
		ln.Frame.Position = UDim2.new(0,-1,0,100)
		ln.Num.Visible = true
	else
		ln.Num:Destroy()
	end
	ln.Visible=true
end

local lns = Instance.new("Frame",script.Parent.Speedo)
lns.Name = "lns"
lns.BackgroundTransparency = 1
lns.BorderSizePixel = 0
lns.Size = UDim2.new(0,0,0,0)
for i=1,90 do
	local ln = script.Parent.ln:clone()
	ln.Parent = lns
	ln.Rotation = 45 + 225*(i/90)
	if i%2==0 then
		ln.Frame.Size = UDim2.new(0,2,0,10)
		ln.Frame.Position = UDim2.new(0,-1,0,100)
	else
		ln.Frame.Size = UDim2.new(0,3,0,5)
	end
	ln.Num:Destroy()
	ln.Visible=true
end

for i,v in pairs(UNITS) do
	local lnn = Instance.new("Frame",script.Parent.Speedo)
	lnn.BackgroundTransparency = 1
	lnn.BorderSizePixel = 0
	lnn.Size = UDim2.new(0,0,0,0)
	lnn.Name = v.units
	if i~= 1 then lnn.Visible=false end
	
	for i=0,v.maxSpeed,v.spInc do
		local ln = script.Parent.ln:clone()
		ln.Parent = lnn
		ln.Rotation = 45 + 225*(i/v.maxSpeed)
		ln.Num.Text = i
		ln.Num.TextSize = 14
		ln.Num.Rotation = -ln.Rotation
		ln.Frame:Destroy()
		ln.Num.Visible=true
		ln.Visible=true
	end
end

if 	script.Parent.Parent.Parent.IsOn.Value then
	script.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
end

script.Parent.Parent.Parent.IsOn.Changed:connect(function()
	if script.Parent.Parent.IsOn.Value then
		script.Parent:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
	end
end)

script.Parent.Parent.Adornee=car.Body.Gauges
script.Parent.Parent.CanvasSize=Vector2.new(1000,1000)


script.Parent.Parent.Parent.Values.RPM.Changed:connect(function()
	script.Parent.Tach.Needle.Rotation = 45 + 225 * math.min(1,script.Parent.Parent.Parent.Values.RPM.Value / (revEnd*1000))
end)

script.Parent.Parent.Parent.Values.Gear.Changed:connect(function()
	local gearText = script.Parent.Parent.Parent.Values.Gear.Value
	if gearText == 0 then gearText = "N"
	elseif gearText == -1 then gearText = "R"
	end
	script.Parent.Gear.Text = gearText
end)

script.Parent.Parent.Parent.Values.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Parent.Values.TCS.Value then
			script.Parent.TCS.TextColor3 = Color3.new(1,170/255,0)
			script.Parent.TCS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if script.Parent.Parent.Values.TCSActive.Value then
				wait()
				script.Parent.TCS.Visible = not script.Parent.TCS.Visible
			else
				wait()
				script.Parent.TCS.Visible = false
			end
		else
			script.Parent.TCS.Visible = true
			script.Parent.TCS.TextColor3 = Color3.new(1,0,0)
			script.Parent.TCS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		script.Parent.TCS.Visible = false
	end
end)

script.Parent.Parent.Parent.Values.TCSActive.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Parent.Values.TCSActive.Value and script.Parent.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = not script.Parent.TCS.Visible
		elseif not script.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = true
		else
			wait()
			script.Parent.TCS.Visible = false
		end
	else
		script.Parent.TCS.Visible = false
	end
end)

script.Parent.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Parent.Values.TCSActive.Value and script.Parent.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = not script.Parent.TCS.Visible
		elseif not script.Parent.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = true
		end
	else
		if script.Parent.TCS.Visible then
			script.Parent.TCS.Visible = false
		end
	end
end)

script.Parent.Parent.Parent.Values.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Parent.Values.ABS.Value then
			script.Parent.ABS.TextColor3 = Color3.new(1,170/255,0)
			script.Parent.ABS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if script.Parent.Parent.Parent.Values.ABSActive.Value then
				wait()
				script.Parent.ABS.Visible = not script.Parent.ABS.Visible
			else
				wait()
				script.Parent.ABS.Visible = false
			end
		else
			script.Parent.ABS.Visible = true
			script.Parent.ABS.TextColor3 = Color3.new(1,0,0)
			script.Parent.ABS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		script.Parent.ABS.Visible = false
	end
end)

script.Parent.Parent.Parent.Values.ABSActive.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Parent.Values.ABSActive.Value and script.Parent.Parent.Values.Parent.ABS.Value then
			wait()
			script.Parent.ABS.Visible = not script.Parent.ABS.Visible
		elseif not script.Parent.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = true
		else
			wait()
			script.Parent.ABS.Visible = false
		end
	else
		script.Parent.ABS.Visible = false
	end
end)

script.Parent.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Parent.Values.ABSActive.Value and script.Parent.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = not script.Parent.ABS.Visible
		elseif not script.Parent.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = true
		end
	else
		if script.Parent.ABS.Visible then
			script.Parent.ABS.Visible = false
		end
	end
end)


function PBrake()
	script.Parent.PBrake.Visible = script.Parent.Parent.Parent.Values.PBrake.Value
end
script.Parent.Parent.Parent.Values.PBrake.Changed:connect(PBrake)

function Gear()
	if script.Parent.Parent.Parent.Values.TransmissionMode.Value == "Auto" then
		script.Parent.TMode.Text = "A/T"
		script.Parent.TMode.BackgroundColor3 = Color3.new(1,170/255,0)
	elseif script.Parent.Parent.Parent.Values.TransmissionMode.Value == "Semi" then
		script.Parent.TMode.Text = "S/T"
		script.Parent.TMode.BackgroundColor3 = Color3.new(0, 170/255, 127/255) 
	else
		script.Parent.TMode.Text = "M/T"
		script.Parent.TMode.BackgroundColor3 = Color3.new(1,85/255,.5)
	end
end
script.Parent.Parent.Parent.Values.TransmissionMode.Changed:connect(Gear)

script.Parent.Parent.Parent.Values.Velocity.Changed:connect(function(property)
	script.Parent.Speedo.Needle.Rotation =45 + 225 * math.min(1,UNITS[currentUnits].scaling*script.Parent.Parent.Parent.Values.Velocity.Value.Magnitude/UNITS[currentUnits].maxSpeed)
	script.Parent.Speed.Text = math.floor(UNITS[currentUnits].scaling*script.Parent.Parent.Parent.Values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units
end)



script.Parent.Speed.MouseButton1Click:connect(function()
	if currentUnits==#UNITS then
		currentUnits = 1
	else
		currentUnits = currentUnits+1
	end
	for i,v in pairs(script.Parent.Speedo:GetChildren()) do
		v.Visible=v.Name==UNITS[currentUnits].units or v.Name=="Needle" or v.Name=="lns"
	end
	script.Parent.Speed.Text = math.floor(UNITS[currentUnits].scaling*script.Parent.Parent.Values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units
end)

wait(.1)
Gear()
PBrake()

end,
function(script,require)
--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]

--[[START]]

	_BuildVersion = require(script.Parent.README)

--[[Weld functions]]

	local JS = game:GetService("JointsService")
	local PGS_ON = workspace:PGSIsEnabled()
	
	function MakeWeld(x,y,type,s) 
		if type==nil then type="Weld" end
		local W=Instance.new(type,JS) 
		W.Part0=x W.Part1=y 
		W.C0=x.CFrame:inverse()*x.CFrame 
		W.C1=y.CFrame:inverse()*x.CFrame 
		if type=="Motor" and s~=nil then 
			W.MaxVelocity=s 
		end 
		return W	
	end
	
	function ModelWeld(a,b) 
		if a:IsA("BasePart") then 
			MakeWeld(b,a,"Weld") 
		elseif a:IsA("Model") then 
			for i,v in pairs(a:GetChildren()) do 
				ModelWeld(v,b) 
			end 
		end 
	end
	
	function UnAnchor(a) 
		if a:IsA("BasePart") then a.Anchored=false  end for i,v in pairs(a:GetChildren()) do UnAnchor(v) end 
	end


	
--[[Initialize]]

	script.Parent:WaitForChild("A-Chassis Interface")
	script.Parent:WaitForChild("Plugins")
	script.Parent:WaitForChild("README")
	
	local car=script.Parent.Parent
	local _Tune=require(script.Parent)
	
	wait(_Tune.LoadDelay)
	
	--Weight Scaling
	local weightScaling = _Tune.WeightScaling
	if not workspace:PGSIsEnabled() then
		weightScaling = _Tune.LegacyScaling
	end

	local Drive=car.Wheels:GetChildren()
	
	--Remove Existing Mass
	function DReduce(p)
		for i,v in pairs(p:GetChildren())do
			if v:IsA("BasePart") then
				if v.CustomPhysicalProperties == nil then v.CustomPhysicalProperties = PhysicalProperties.new(v.Material) end
				v.CustomPhysicalProperties = PhysicalProperties.new(
					0,
					v.CustomPhysicalProperties.Friction,
					v.CustomPhysicalProperties.Elasticity,
					v.CustomPhysicalProperties.FrictionWeight,
					v.CustomPhysicalProperties.ElasticityWeight
				)
			end
			DReduce(v)
		end
	end
	DReduce(car)



--[[Wheel Configuration]]	
	
	--Store Reference Orientation Function
	function getParts(model,t,a)
		for i,v in pairs(model:GetChildren()) do
			if v:IsA("BasePart") then table.insert(t,{v,a.CFrame:toObjectSpace(v.CFrame)})
			elseif v:IsA("Model") then getParts(v,t,a)
			end
		end
	end
	
	--PGS/Legacy
	local fDensity = _Tune.FWheelDensity
	local rDensity = _Tune.RWheelDensity
	if not PGS_ON then
		fDensity = _Tune.FWLgcyDensity
		rDensity = _Tune.RWLgcyDensity
	end
	
	for _,v in pairs(Drive) do
		--Apply Wheel Density
		if v.Name=="FL" or v.Name=="FR" or v.Name=="F" then
			if v:IsA("BasePart") then
				if v.CustomPhysicalProperties == nil then v.CustomPhysicalProperties = PhysicalProperties.new(v.Material) end
				v.CustomPhysicalProperties = PhysicalProperties.new(
					fDensity,
					v.CustomPhysicalProperties.Friction,
					v.CustomPhysicalProperties.Elasticity,
					v.CustomPhysicalProperties.FrictionWeight,
					v.CustomPhysicalProperties.ElasticityWeight
				)
			end
		else
			if v:IsA("BasePart") then
				if v.CustomPhysicalProperties == nil then v.CustomPhysicalProperties = PhysicalProperties.new(v.Material) end
				v.CustomPhysicalProperties = PhysicalProperties.new(
					rDensity,
					v.CustomPhysicalProperties.Friction,
					v.CustomPhysicalProperties.Elasticity,
					v.CustomPhysicalProperties.FrictionWeight,
					v.CustomPhysicalProperties.ElasticityWeight
				)
			end		
		end
		
		--Resurface Wheels
		for _,a in pairs({"Top","Bottom","Left","Right","Front","Back"}) do
			v[a.."Surface"]=Enum.SurfaceType.SmoothNoOutlines
		end
		
		--Store Axle-Anchored/Suspension-Anchored Part Orientation
		local WParts = {}
		
		local tPos = v.Position-car.DriveSeat.Position
		if v.Name=="FL" or v.Name=="RL" then
			v.CFrame = car.DriveSeat.CFrame*CFrame.Angles(math.rad(90),0,math.rad(90))
		else
			v.CFrame = car.DriveSeat.CFrame*CFrame.Angles(math.rad(90),0,math.rad(-90))
		end
		v.CFrame = v.CFrame+tPos
		
		if v:FindFirstChild("Parts")~=nil then
			getParts(v.Parts,WParts,v)
		end
		if v:FindFirstChild("Fixed")~=nil then
			getParts(v.Fixed,WParts,v)
		end
		
		--Align Wheels
		if v.Name=="FL" or v.Name=="FR" then
			v.CFrame = v.CFrame*CFrame.Angles(math.rad(_Tune.FCamber),0,0)
			if v.Name=="FL" then
				v.CFrame = v.CFrame*CFrame.Angles(0,0,math.rad(_Tune.FToe))
			else
				v.CFrame = v.CFrame*CFrame.Angles(0,0,math.rad(-_Tune.FToe))
			end
		elseif v.Name=="RL" or v.Name=="RR" then
			v.CFrame = v.CFrame*CFrame.Angles(math.rad(_Tune.RCamber),0,0)
			if v.Name=="RL" then
				v.CFrame = v.CFrame*CFrame.Angles(0,0,math.rad(_Tune.RToe))
			else
				v.CFrame = v.CFrame*CFrame.Angles(0,0,math.rad(-_Tune.RToe))
			end
		end
		
		--Re-orient Axle-Anchored/Suspension-Anchored Parts
		for _,a in pairs(WParts) do
			a[1].CFrame=v.CFrame:toWorldSpace(a[2])
		end



--[[Chassis Assembly]]
		--Create Steering Axle
		local arm=Instance.new("Part",v)
		arm.Name="Arm"
		arm.Anchored=true
		arm.CanCollide=false
		arm.FormFactor=Enum.FormFactor.Custom
		arm.Size=Vector3.new(_Tune.AxleSize,_Tune.AxleSize,_Tune.AxleSize)
		arm.CFrame=(v.CFrame*CFrame.new(0,_Tune.StAxisOffset,0))*CFrame.Angles(-math.pi/2,-math.pi/2,0)
		arm.CustomPhysicalProperties = PhysicalProperties.new(_Tune.AxleDensity,0,0,0,0)
		arm.TopSurface=Enum.SurfaceType.Smooth
		arm.BottomSurface=Enum.SurfaceType.Smooth
		arm.Transparency=1
		
		if PGS_ON then
			
	--PGS Assembly---------------------------------------------------------------------------------------------------------------------------
	
			--Suspension Offsets
			local fAnchorOffset = Vector3.new(_Tune.FAnchorOffset[1],_Tune.FAnchorOffset[2],_Tune.FAnchorOffset[3])
			local rAnchorOffset = Vector3.new(_Tune.RAnchorOffset[1],_Tune.RAnchorOffset[2],_Tune.RAnchorOffset[3])
			
			--Create Wheel Suspsension Anchor
			local anchor2=arm:Clone()
			anchor2.Parent=v
			anchor2.Name="Base"
			if v.Name == "FL" or v.Name == "FR" or v.Name=="F" then
				anchor2.CFrame=anchor2.CFrame*CFrame.new(fAnchorOffset)
			else
				anchor2.CFrame=anchor2.CFrame*CFrame.new(rAnchorOffset)
			end
			
			--Create Body Suspsension Anchor
			local anchor1=anchor2:Clone()
			anchor1.Parent=v
			anchor1.Name="Anchor"
			if v.Name == "FL" or v.Name == "FR" or v.Name=="F" then
				anchor1.CFrame=anchor1.CFrame*CFrame.new(-_Tune.FSusLength*math.cos(math.rad(_Tune.FSusAngle)),_Tune.FSusLength*math.sin(math.rad(_Tune.FSusAngle)),0)
			else
				anchor1.CFrame=anchor1.CFrame*CFrame.new(-_Tune.RSusLength*math.cos(math.rad(_Tune.RSusAngle)),_Tune.RSusLength*math.sin(math.rad(_Tune.RSusAngle)),0)
			end
			
			--Create Attachments
			local s0=Instance.new("Attachment",anchor1)
			local s1=Instance.new("Attachment",anchor2)
			local p0=Instance.new("Attachment",anchor1)
			local r0=Instance.new("Attachment",car.DriveSeat)
			local h0=Instance.new("Attachment",car.DriveSeat)
			local a0=Instance.new("Attachment",anchor2)
			local a1=Instance.new("Attachment",arm)
			local a2=Instance.new("Attachment",arm)
			local a3=Instance.new("Attachment",v)
			s0.Name="S0"
			s1.Name="S1"
			p0.Name="P0"
			r0.Name="R0"
			h0.Name="H0"
			a0.Name="A0"
			a1.Name="A1"
			a2.Name="A2"
			a3.Name="A3"
			
			--Calculate Wishbone Anchor Point
			local rAnc0=(arm.CFrame*CFrame.new(fAnchorOffset+Vector3.new(-math.cos(math.rad(_Tune.FWsBoneAngle))*_Tune.FWsBoneLen,math.sin(math.rad(_Tune.FWsBoneAngle))*_Tune.FWsBoneLen,0))).p
			if v.Name == "RL" or v.Name == "RR" or v.Name=="R" then
				rAnc0=(arm.CFrame*CFrame.new(rAnchorOffset+Vector3.new(-math.cos(math.rad(_Tune.RWsBoneAngle))*_Tune.RWsBoneLen,math.sin(math.rad(_Tune.RWsBoneAngle))*_Tune.RWsBoneLen,0))).p
			end
			
			--Apply Attachment Alignment
			p0.Position=anchor1.CFrame:toObjectSpace(CFrame.new(anchor2.Position)).p
			r0.Position=car.DriveSeat.CFrame:toObjectSpace(CFrame.new(rAnc0)).p
			h0.Position=car.DriveSeat.CFrame:toObjectSpace(CFrame.new(anchor1.Position)).p
			a0.Position=anchor2.CFrame:toObjectSpace(CFrame.new(arm.Position)).p
			if v.Name == "FL" or v.Name == "FR" or v.Name=="F" then
				p0.Rotation=Vector3.new(0,0,-_Tune.FSusAngle)
				s1.Rotation=Vector3.new(0,0,-_Tune.FSusAngle)
			else
				p0.Rotation=Vector3.new(0,0,-_Tune.RSusAngle)
				s1.Rotation=Vector3.new(0,0,-_Tune.RSusAngle)
			end
			if v.Name=="FL" then
				s0.Rotation=Vector3.new(0,90+_Tune.FToe,0)
			elseif v.Name=="FR" then
				s0.Rotation=Vector3.new(0,90-_Tune.FToe,0)
			elseif v.Name=="RL" then
				s0.Rotation=Vector3.new(0,90+_Tune.RToe,0)
			elseif v.Name=="RR" then
				s0.Rotation=Vector3.new(0,90-_Tune.RToe,0)
			end
			h0.Rotation=Vector3.new(0,-90,0)
			a0.Rotation=Vector3.new(90,90,0)
			a1.Rotation=Vector3.new(90,90,0)
			a2.Rotation=Vector3.new(0,0,0)
			a3.Rotation=Vector3.new(0,0,90)
			if v.Name=="FR" or v.Name=="RR" then
				h0.Rotation=Vector3.new(0,90,0)
				a2.Rotation=Vector3.new(-180,00,0)
			end
			
			if v.Name == "RL" or v.Name == "RR" or v.Name=="R" then
				--Lock Rear Steering Axle
				MakeWeld(anchor2,arm)
			else
				--Create Steering Hinge
				local h2=Instance.new("HingeConstraint",v)
				h2.Attachment0=a0
				h2.Attachment1=a1
			end	
			
			--Create Wheel Spindle
			local h3=Instance.new("HingeConstraint",v)
			h3.Attachment0=a2
			h3.Attachment1=a3
			
			--Apply Suspension
			if _Tune.SusEnabled then
			--Suspension Enabled
				local h1=Instance.new("HingeConstraint",v)
				h1.Attachment0=h0
				h1.Attachment1=s0
				
				local sus=Instance.new("SpringConstraint",v)
				sus.Attachment0=s0
				sus.Attachment1=s1
				sus.Visible=_Tune.SusVisible
				sus.Radius=_Tune.SusRadius
				sus.Thickness=_Tune.SusThickness
				sus.Color=BrickColor.new(_Tune.SusColor)
				sus.Coils=_Tune.SusCoilCount
				sus.LimitsEnabled=true
				if v.Name == "FL" or v.Name == "FR" or v.Name=="F" then
					sus.MinLength=_Tune.FSusLength-math.abs(_Tune.FSusMaxComp)
					sus.MaxLength=_Tune.FSusLength+math.abs(_Tune.FSusMaxExt)
					sus.FreeLength=_Tune.FSusLength+math.abs(_Tune.FSusMaxExt)
					sus.Damping=_Tune.FSusDamping
					sus.Stiffness=_Tune.FSusStiffness
				else
					sus.MinLength=_Tune.RSusLength-math.abs(_Tune.RSusMaxComp)
					sus.MaxLength=_Tune.RSusLength+math.abs(_Tune.RSusMaxExt)
					sus.FreeLength=_Tune.RSusLength+math.abs(_Tune.RSusMaxExt)
					sus.Damping=_Tune.RSusDamping
					sus.Stiffness=_Tune.RSusStiffness
				end
				
				local rod=Instance.new("RodConstraint",v)
				rod.Attachment0=r0
				rod.Attachment1=s1
				rod.Length=rod.CurrentDistance
				rod.Visible=_Tune.WsBVisible
				rod.Color=BrickColor.new(_Tune.WsColor)
				rod.Thickness=_Tune.WsThickness
				
				local prm=Instance.new("PrismaticConstraint",v)
				prm.Attachment0=p0
				prm.Attachment1=s1
			else
			--Suspension Disabled
				anchor1:Destroy()
				MakeWeld(car.DriveSeat,anchor2)
			end
			
			--Weld Miscelaneous Parts
			if v:FindFirstChild("SuspensionFixed")~=nil then
				ModelWeld(v.SuspensionFixed,anchor2)
			end	
			if v:FindFirstChild("WheelFixed")~=nil then
				ModelWeld(v.WheelFixed,arm)
			end
			if v:FindFirstChild("Fixed")~=nil then
				ModelWeld(v.Fixed,arm)
			end
		else	
			
	--Legacy Assembly---------------------------------------------------------------------------------------------------------------------------	
			
			--Create Wheel Spindle
			local base=arm:Clone()
			base.Parent=v
			base.Name="Base"
			base.CFrame=base.CFrame*CFrame.new(0,_Tune.AxleSize,0)
			base.BottomSurface=Enum.SurfaceType.Hinge
			
			--Create Steering Anchor
			local axle=arm:Clone()
			axle.Parent=v
			axle.Name="Axle"
			axle.CFrame=CFrame.new(v.Position-((v.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector*((v.Size.x/2)+(axle.Size.x/2))),v.Position)*CFrame.Angles(0,math.pi,0)
			axle.BackSurface=Enum.SurfaceType.Hinge
			
			if v.Name=="F" or v.Name=="R" then
				local axle2=arm:Clone()
				axle2.Parent=v
				axle2.Name="Axle"
				axle2.CFrame=CFrame.new(v.Position+((v.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector*((v.Size.x/2)+(axle2.Size.x/2))),v.Position)*CFrame.Angles(0,math.pi,0)
				axle2.BackSurface=Enum.SurfaceType.Hinge
				MakeWeld(arm,axle2)
			end
			
			--Lock Rear Steering Axle
			if v.Name == "RL" or v.Name == "RR" or v.Name=="R" then
				MakeWeld(base,axle)
			end
			
			--Weld Assembly
			MakeWeld(car.DriveSeat,base)
			if v.Parent.Name == "RL" or v.Parent.Name == "RR" or v.Name=="R" then
				MakeWeld(car.DriveSeat,arm)
			end
			
			MakeWeld(arm,axle)
			
			arm:MakeJoints()
			axle:MakeJoints()
		
			--Weld Miscelaneous Parts
			if v:FindFirstChild("SuspensionFixed")~=nil then
				ModelWeld(v.SuspensionFixed,car.DriveSeat)
			end
			if v:FindFirstChild("WheelFixed")~=nil then
				ModelWeld(v.WheelFixed,axle)
			end
			if v:FindFirstChild("Fixed")~=nil then
				ModelWeld(v.Fixed,arm)
			end
		end
	---------------------------------------------------------------------------------------------------------------------------
		
		--Weld Wheel Parts
		if v:FindFirstChild("Parts")~=nil then
			ModelWeld(v.Parts,v)
		end
		
		--Add Steering Gyro
		if v:FindFirstChild("Steer") then
			v:FindFirstChild("Steer"):Destroy()
		end
		
		if v.Name=="FL" or v.Name=="FR" or v.Name=="F" then
			local steer=Instance.new("BodyGyro",arm)
			steer.Name="Steer"
			steer.P=_Tune.SteerP
			steer.D=_Tune.SteerD
			steer.MaxTorque=Vector3.new(0,_Tune.SteerMaxTorque,0)
			steer.cframe=v.CFrame*CFrame.Angles(0,-math.pi/2,0)
		end
		
		--Add Stabilization Gyro
		local gyro=Instance.new("BodyGyro",v)
		gyro.Name="Stabilizer"
		gyro.MaxTorque=Vector3.new(1,0,1)
		gyro.P=0
		if v.Name=="FL" or v.Name=="FR"  or v.Name=="F" then
			gyro.D=_Tune.FGyroDamp
		else
			gyro.D=_Tune.RGyroDamp
		end
		
		--Add Rotational BodyMover
		local AV=Instance.new("BodyAngularVelocity",v)
		AV.Name="#AV"
		AV.angularvelocity=Vector3.new(0,0,0)
		AV.maxTorque=Vector3.new(_Tune.PBrakeForce,0,_Tune.PBrakeForce)
		AV.P=1e9
	end



--[[Vehicle Weight]]	
	--Determine Current Mass
	local mass=0
	
	function getMass(p)
		for i,v in pairs(p:GetChildren())do
			if v:IsA("BasePart") then
				mass=mass+v:GetMass()
			end
			getMass(v)
		end	
	end
	getMass(car)
	
	--Apply Vehicle Weight
	if mass<_Tune.Weight*weightScaling then
		--Calculate Weight Distribution
		local centerF = Vector3.new()
		local centerR = Vector3.new()
		local countF = 0
		local countR = 0
		
		for i,v in pairs(Drive) do
			if v.Name=="FL" or v.Name=="FR" or v.Name=="F" then
				centerF = centerF+v.CFrame.p
				countF = countF+1
			else
				centerR = centerR+v.CFrame.p
				countR = countR+1
			end
		end
		centerF = centerF/countF
		centerR = centerR/countR
		local center = centerR:Lerp(centerF, _Tune.WeightDist/100)  
		
		--Create Weight Brick
		local weightB = Instance.new("Part",car.Body)
		weightB.Name = "#Weight"
		weightB.Anchored = true
		weightB.CanCollide = false
		weightB.BrickColor = BrickColor.new("Really black")
		weightB.TopSurface = Enum.SurfaceType.Smooth
		weightB.BottomSurface = Enum.SurfaceType.Smooth
		if _Tune.WBVisible then
			weightB.Transparency = .75			
		else
			weightB.Transparency = 1			
		end
		weightB.Size = Vector3.new(_Tune.WeightBSize[1],_Tune.WeightBSize[2],_Tune.WeightBSize[3])
		weightB.CustomPhysicalProperties = PhysicalProperties.new(((_Tune.Weight*weightScaling)-mass)/(weightB.Size.x*weightB.Size.y*weightB.Size.z),0,0,0,0)
		weightB.CFrame=(car.DriveSeat.CFrame-car.DriveSeat.Position+center)*CFrame.new(0,_Tune.CGHeight,0)
	else
		--Existing Weight Is Too Massive
		warn( "\n\t [AC".._BuildVersion.."]: Mass too high for specified weight."
			.."\n\t    Target Mass:\t"..(math.ceil(_Tune.Weight*weightScaling*100)/100)
			.."\n\t    Current Mass:\t"..(math.ceil(mass*100)/100)
			.."\n\t Reduce part size or axle density to achieve desired weight.")
	end
	
	local flipG = Instance.new("BodyGyro",car.DriveSeat)
	flipG.Name = "Flip"
	flipG.D = 0
	flipG.MaxTorque = Vector3.new(0,0,0)
	flipG.P = 0


	
--[[Finalize Chassis]]	
	--Misc Weld
	wait()
	for i,v in pairs(script:GetChildren()) do
		if v:IsA("ModuleScript") then
			require(v)
		end
	end
	
	--Weld Body
	wait()
	ModelWeld(car.Body,car.DriveSeat)
	
	--Unanchor
	wait()	
	UnAnchor(car)

--[[Manage Plugins]]
	
	script.Parent["A-Chassis Interface"].Car.Value=car
	for i,v in pairs(script.Parent.Plugins:GetChildren()) do
		for _,a in pairs(v:GetChildren()) do
			if a:IsA("RemoteEvent") or a:IsA("RemoteFunction") then 
				a.Parent=car
				for _,b in pairs(a:GetChildren()) do
					if b:IsA("Script") then b.Disabled=false end
				end	
			end
		end
		v.Parent = script.Parent["A-Chassis Interface"]
	end
	script.Parent.Plugins:Destroy()



--[[Remove Character Weight]]
	--Get Seats
	local Seats = {}
	function getSeats(p)
		for i,v in pairs(p:GetChildren()) do
			if v:IsA("VehicleSeat") or v:IsA("Seat") then
				local seat = {}
				seat.Seat = v
				seat.Parts = {}
				table.insert(Seats,seat)
			end
			getSeats(v)
		end	
	end
	getSeats(car)
	
	--Store Physical Properties/Remove Mass Function
	function getPProperties(mod,t)
		for i,v in pairs(mod:GetChildren()) do
			if v:IsA("BasePart") then
				if v.CustomPhysicalProperties == nil then v.CustomPhysicalProperties = PhysicalProperties.new(v.Material) end
				table.insert(t,{v,v.CustomPhysicalProperties})
				v.CustomPhysicalProperties = PhysicalProperties.new(
					0,
					v.CustomPhysicalProperties.Friction,
					v.CustomPhysicalProperties.Elasticity,
					v.CustomPhysicalProperties.FrictionWeight,
					v.CustomPhysicalProperties.ElasticityWeight
				)
			end
			getPProperties(v,t)
		end			
	end
	
	--Apply Seat Handler
	for i,v in pairs(Seats) do
		--Sit Handler
		v.Seat.ChildAdded:connect(function(child)
			if child.Name=="SeatWeld" and child:IsA("Weld") and child.Part1~=nil and child.Part1.Parent ~= workspace and not child.Part1.Parent:IsDescendantOf(car) then
				v.Parts = {}
				getPProperties(child.Part1.Parent,v.Parts)
			end
		end)
		
		--Leave Handler
		v.Seat.ChildRemoved:connect(function(child)
			if child.Name=="SeatWeld" and child:IsA("Weld") then
				for i,v in pairs(v.Parts) do
					if v[1]~=nil and v[2]~=nil and v[1]:IsDescendantOf(workspace) then
						v[1].CustomPhysicalProperties = v[2]
					end
				end
				v.Parts = {}
			end
		end)
	end



--[[Driver Handling]]
	--Driver Sit	
	car.DriveSeat.ChildAdded:connect(function(child)
		if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			--Distribute Client Interface
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			car.DriveSeat:SetNetworkOwner(p)
			local g=script.Parent["A-Chassis Interface"]:Clone()
			g.Parent=p.PlayerGui
		end
	end)
	
	--Driver Leave
	car.DriveSeat.ChildRemoved:connect(function(child)
		if child.Name=="SeatWeld" and child:IsA("Weld") then
			--Remove Flip Force
			if car.DriveSeat:FindFirstChild("Flip")~=nil then
				car.DriveSeat.Flip.MaxTorque = Vector3.new()
			end
			
			--Remove Wheel Force
			for i,v in pairs(car.Wheels:GetChildren()) do
				if v:FindFirstChild("#AV")~=nil then
					if v["#AV"].AngularVelocity.Magnitude>0 then
						v["#AV"].AngularVelocity = Vector3.new()
						v["#AV"].MaxTorque = Vector3.new()
					end
				end
			end
		end
	end)
	
--[END]]
end,
function(script,require)
local MiscWeld = {}

function MakeWeld(x,y,type,s) 
	if type==nil then type="Weld" end
	local W=Instance.new(type)
	W.Part0=x W.Part1=y 
	W.C0=x.CFrame:inverse()*x.CFrame 
	W.C1=y.CFrame:inverse()*x.CFrame 
	W.Parent=x 
	if type=="Motor" and s~=nil then 
		W.MaxVelocity=s 
	end 
	return W	
end
function ModelWeld(a,b) 
	if a:IsA("BasePart") then 
		MakeWeld(b,a,"Weld") 
	elseif a:IsA("Model") then 
		for i,v in pairs(a:GetChildren()) do 
			ModelWeld(v,b) 
		end 
	end 
end

car = script.Parent.Parent.Parent
misc = car:WaitForChild("Misc")

---------------------------
--[[
	--Main anchor point is the DriveSeat <car.DriveSeat>	
	
	Usage:
		MakeWeld(Part1,Part2,WeldType*,MotorVelocity**) *default is "Weld"  **Applies to Motor welds only
		ModelWeld(Model,MainPart)
	Example:
		MakeWeld(car.DriveSeat,misc.PassengerSeat)
		MakeWeld(car.DriveSeat,misc.SteeringWheel,"Motor",.2)
		ModelWeld(car.DriveSeat,misc.Door)
]]
--Weld stuff here

car.DriveSeat.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		child.C0=CFrame.new(0,-.5,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0)
	end
end)

---------------------------
return MiscWeld
end,
function(script,require)
script.Parent["Insurgent | Founder"].Parent=workspace
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


local Objects = Decode('AFS+BCEFTW9kZWwhBE5hbWUhCUluc3VyZ2VudCEKV29ybGRQaXZvdAREBEUERgQhE0luc3VyZ2VudCB8IEZvdW5kZXIhC1ByaW1hcnlQYXJ0BHIARwRIBCEEQm9keQRyAEkESgQhC1ZlaGljbGVTZWF0IQRTZWF0IQhBbmNob3JlZCIhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQ1Cb3R0b21TdXJmYWNlIQpCcmlja0NvbG9yBxoAIQZDRnJhbWUEIQBLBEwEIQpDYW5Db2xsaWRlAiEFQ29sb3'
..'IGGyo1IQxGcm9udFN1cmZhY2UhC0xlZnRTdXJmYWNlIQhNYXRlcmlhbAMAAAAAAABxQCELT3JpZW50YXRpb24KCtcjvHH9M0MK1yO8IQhQb3NpdGlvbgpmqjJC5nWQQFFYrcMhDFJpZ2h0U3VyZmFjZSEIUm90YXRpb24Kcf0zwwrXIzxx/TNDIQRTaXplCgAAgD8AAIA/AACAPyEKVG9wU3VyZmFjZSEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQ5IZWFkc1VwRGlzcGxheSEITWF4U3BlZWQD'
..'AAAAAAAAAAAhBlRvcnF1ZSEJVHVyblNwZWVkBDAASwRMBApghDNC1zKQQBCGr8MEMgBLBEwECiB2QkLFL5BAKIavwyEGQnJha2VzBE0ETgRPBCECRzEhBFBhcnQEOwBQBFEEIRhDdXN0b21QaHlzaWNhbFByb3BlcnRpZXMQCtcjPAAAAAAAAAAAAAAAAAAAAAAKCtcjPAAANEMAAAAACsBIL0JUWYpAP020wwpx/TNDAAAAAAAANMMKKFwPP83MzD7NzEw+IQpQb2ludExpZ2h0IQZMaWdodH'
..'MG/wAAIQdFbmFibGVkIQdTaGFkb3dzIQVSYW5nZQMAAAAAAAAUQCEJQmxvY2tNZXNoIQVTY2FsZQo0JVc/NCVXPzQlVz8hClN1cmZhY2VHdWkhB0JyYWtpbmchBEZhY2UDAAAAAAAAAEAhCkltYWdlTGFiZWwhBkFjdGl2ZSEQQmFja2dyb3VuZENvbG9yMwbBwMMhFkJhY2tncm91bmRUcmFuc3BhcmVuY3khDEJvcmRlckNvbG9yMwwAAIDAAAAAAIC/AAAhClNlbGVjdGFibGUMAAAQQQAA'
..'AABAQAAAIQVJbWFnZSEWcmJ4YXNzZXRpZDovLzE0MTExNjQ3NgRYAFIEUwQKIIFGQqY+ikB8TLTDCnH9M0MAAAAAAAA0QwqD6xE/zczMPs3MTD4hCUJvb2xWYWx1ZSECb24hBlNjcmlwdCEFX21haW4hBUxpZ2h0IQlIZWFkbGlnaHQEYwBUBFUECrgehT8fRTPDexSOvwpkakVCYtCZQNqUqMMKw/UyQ0jhOr+43jJDCnGpJT+W55o+zcxMPiEJU3BvdExpZ2h0IQpCcmlnaHRuZXNzAwAAAA'
..'AAAD5AIQxCaWxsYm9hcmRHdWkMAABAQAAAAABAQAAADAAAgD8AAAAAgD8AACEVcmJ4YXNzZXRpZDovLzM2OTQ5ODEwCgAAgD8AAIA/NCVXPwRvAFQEVQQKZGAwQmLQmUDalKjDIQlUYWlsbGlnaHQEcgBWBFcECmB7RkIl1q5A2M+wwwrNzEw+zcxMPs3MTD4G/wAEIQVBbmdsZQMAAAAAAIBmQAMAAAAAAAAiQAwzMzM/AAAzMzM/AAAhClNpemVPZmZzZXQLAAAAvwAAAAAGv7exDAAAAAAA'
..'AAAAAL8AAAwAAABAAAAAAABAAAAhKGh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9Njc4MjI4MjkEgABWBFcECkB7L0Il1q5A2M+wwwRYBFkEWgQhCE1lc2hQYXJ0B+sDBIYARQRGBAYREREKwOA6Qk3kSUCsPLTDCnMVGUHI8ZQ/9Ia8PyEGTWVzaElkIRdyYnhhc3NldGlkOi8vMjE4NjM3Nzk3OCEITWVzaFNpemUKgOAHQfAzhD8gVqc/BI0ARQRGBArG4DpCovoBQWw1rMMKpq'
..'ndQE840z/hobE/IRdyYnhhc3NldGlkOi8vMjE4NjMwMTExMgpbv8RAgHq7P4yqnT8EkgBFBEYECsbgOkKu1PhA+eWswwqX9vZA/QtRQIzHbkEhF3JieGFzc2V0aWQ6Ly8yMTg2MjkzMjA5Ckg020C2jDlAuPBTQSEKTWFudWFsV2VsZCEhTWVzaFBhcnQtdG8tTWVzaFBhcnQgU3Ryb25nIEpvaW50IQJDMARbBFwEXQQhAkMxBF4EXARdBCEFUGFydDAhBVBhcnQxIQZDaHJvbWUEXwRZBFoE'
..'BKIARQRGBAMAAAAAAACRQAqk4DpCG8tXQPhPqMMhC1JlZmxlY3RhbmNlCsg2C0F03IA/xch3PyEXcmJ4YXNzZXRpZDovLzIxODYyNDg2MDIK3CH3QADBZD/U7ls/BKgARQRGBArA4DpCiblSQEQutMMKMw4YQb7paD99sbI/IRdyYnhhc3NldGlkOi8vMjE4NjM3NDc4NwrX9gZBuLtOP6Cbnj8ErQBFBEYECsbgOkIxiiZAizquwwrQJyVBzcxMPWXT/0AhF3JieGFzc2V0aWQ6Ly8yMTg2Mz'
..'E3MjA3CoCXEkEAHwU8EBLjQCEOVW5pb25PcGVyYXRpb24hBFdhbGwHZgAEtgBFBEYEBl6szArg3zpCW0IEQTdVsMMKAKvlQI7rIUAAmJ8+IQxVc2VQYXJ0Q29sb3IKSuGqQIDrIUBSuJ4+CqDWOkJeQgRBU1WwwwrFHr1A+f//P1K4nj4KgPo6QukEAEFSVbDDIQlXZWRnZVBhcnQKDwCAPhCuBz+xmZk+CiClL0IGHRRBR1GwwwoAAAAAAAC0QgrXI7wKDwCAPsbM7D/L9Sg/CiDXLUJGiQFB'
..'R1Gwwwqg6EdCRokBQUZRsMMKAAAAAAAAtMIK1yM8CsAaRkIHHRRBSVGwwwTHAEUERgQKxOA6QhovUkC0BKjDCplgkUCaGxs/IZAcPiEXcmJ4YXNzZXRpZDovLzIxODYzNDk3ODgKZgmBQGisCT8Q9wo+BMwARQRGBArG4DpCP6oTQRLkrMMK+FOwQII1nD4SO5w+IRdyYnhhc3NldGlkOi8vMjE4NjM5MTE5MQosgpxAoKaKPpCrij4E0QBFBEYECvyyPUIQUVdA2AmowwMAAAAAAADgPwo9xl'
..'NAEz6OP1KiTj8hF3JieGFzc2V0aWQ6Ly8yMTg2Mzg5MTg5Cnv4O0Aognw/eGg3PwTXAEUERgQKwOA6QpMLJEE5brDDCi3HKUAtBZY+569PPiEXcmJ4YXNzZXRpZDovLzIxODYzOTM3NjEK2rEWQGAohT7AVzg+BGAEXARdBCEFR2xhc3MHAgQE4QBhBGIEBqqq/woK1yO8AAAAAAAAiEEKXp9IQuhP90CgNK/DAwAAAKCZmbk/Cs3MTD0Rrsc/dxQ+QAMAAABAMzPDPwTmAEUERgQKoAxCQlLV'
..'00CNP7TDCoIiwD5DRnZAzZTrPSEXcmJ4YXNzZXRpZDovLzIxODYzNDI4NTgK4ImqPsSXWkAAGtE9BOsARQRGBAoE6zpCmtVoQMkiqMMKNYLOP2lXED83zTQ/IRdyYnhhc3NldGlkOi8vMjE4NjM4NzMwNgr4S7c/BB4AP7B6ID8H7wME8wBFBEYEBqNLSwMAAAAAAAByQAqg3zpCzZyKQDlFtMMKJSH2QGnM2j6Bj3c9IRdyYnhhc3NldGlkOi8vMjE4NjMzOTQ5NArUdtpAiDTCPgC8Wz0E+A'
..'BFBEYECsbgOkJvYQJBSj6swwrJXNJAYiOzP5tJrz8hF3JieGFzc2V0aWQ6Ly8yMTg2MzA0MDM2Cqi3ukC4AJ8/vpWbPwc3AQT/AEUERgQGn6GsCsTgOkKDnadAR8CowwrUle1A+IYFPs3MTD0hF3JieGFzc2V0aWQ6Ly8yMTg2MjgxNzQyCl7h0kCACe09AC0SPARjBFwEXQQHlQAEBwFFBEYEBg8PLwrA4DpCRaPgQJFXssMKg2jPQMZQq0B8I91AIRdyYnhhc3NldGlkOi8vMjE4NjMwNzQz'
..'OApjGLhANQ+YQERIxEAEDAFFBEYECsbgOkK+bQJBtTGswwr/CdlAS+3HP4gYpz8hF3JieGFzc2V0aWQ6Ly8yMTg2Mjk4ODY3CsCkwEBwdLE/YlCUPwQRAUUERgQKxuA6QlzOBkE2Q6zDCkX+20ASYQI/ffw4PyEXcmJ4YXNzZXRpZDovLzIxODYzMTA1MzIKBETDQOBy5z6MMSQ/BBYBRQRGBArA4DpCzZyKQDlFtMMKEXTMQGnM2j6Bj3c9IRdyYnhhc3NldGlkOi8vMjE4NjMzODI0Mgr4eL'
..'VAiDTCPgC8Wz0EZARcBF0EBBwBRQRGBAoGsCtC5Qa4QN4arsMKekiEP5LwxEB7BhFBIRdyYnhhc3NldGlkOi8vMjE4NjMyMzk0Nwog1Go/rM2uQGi5AEEEIQFFBEYECsDgOkIbvV5AlzW0wwqd9mhAi9RfP7dVAEAhF3JieGFzc2V0aWQ6Ly8yMTg2MzgwNjAzCibHTkDgq0Y/0NHjPwQmAUUERgQKhhFKQuYGuEAsGK7DCmhHhD+S8MRALLMRQSEXcmJ4YXNzZXRpZDovLzIxODYzNTc5NjYK'
..'ONJqP6zNrkCwUgFBBCsBRQRGBArG4DpCjxQzQPpIrsMKF/G9QOoKvz9jcM9BIRdyYnhhc3NldGlkOi8vMjE4NjM0Nzc5MQqPl6hAtJGpP18fuEEEMAFFBEYECuDmOkImsONA/jeywwpG2vJAytyHPtzGfUAhF3JieGFzc2V0aWQ6Ly8yMTg2MzY3Mzk4Cj+O10DALnE+fEBhQARlBFwEXQQhDEJhY2sgQmVuY2hlcwQ3AUUERgQKwOA6QvYVukB0V7LDAwAAAKCZmck/CoNoz0CzhXk+RgfdQC'
..'EXcmJ4YXNzZXRpZDovLzIxODYzNDQ1MzgKYxi4QMB5XT46L8RACgO3okBpzNo+gY93PSEXcmJ4YXNzZXRpZDovLzIxODYzMzcxMDIK7myQQIg0wj4AvFs9BEABRQRGBArA4DpC4DsCQW4xssMKFVLoQEGIhT9SPLpAIRdyYnhhc3NldGlkOi8vMjE4NjMzMzI5OQocNc5AyAttP25NpUAERQFFBEYECsbgOkJxkp5APOKpwwoOrAlBMSqTQOed9kAhF3JieGFzc2V0aWQ6Ly8yMTg2MjM0Mzk4'
..'CiZl9ECOn4JAjuXaQAdcAQRMAUUERgQG7erqCsDgOkJyykNAfZW0wwpeTKE/zMEgP83MTD0hF3JieGFzc2V0aWQ6Ly8yMTg2MzgxODgyCgwrjz8MsA4/AADCOQfpAwRTAUUERgQG+Pj4CsTgOkKbjp9A4Miowwr/xO9AZ74zP0mGJD4hF3JieGFzc2V0aWQ6Ly8yMTg2MjYxNTUwCq/R1EBQih8/IAgSPgRYAUUERgQKpuA6QipB+EApFK7DCufh80B2ebY/aTLuQCEXcmJ4YXNzZXRpZDovLz'
..'IxODYzMzAwMzcKPnjYQMz2oT9YbNNAIQVQYWludARmBFkEWgQhBURvb3JzBGABRQRGBArA4DpCqWXFQKUHsMMKkeYIQUERr0A0lodBIRdyYnhhc3NldGlkOi8vMjE4NjMxMzA5NwqQBvNAumObQHKxcEEEZQFFBEYECsbgOkKwPMJAsV2uwwrQJyVBSWwIQb5su0EhF3JieGFzc2V0aWQ6Ly8yMTg2MjExNzUyCoCXEkF8LfJAolumQQRqAUUERgQKwOA6QkqLwUA/GLTDCgeeB0HYVMBA6qkk'
..'PyEXcmJ4YXNzZXRpZDovLzIxODYzMTQ3NDMKWL/wQIy2qkDAJxI/BG8BRQRGBArE4DpC1qycQFuVqMMKB54HQTj19z/lXro/IRdyYnhhc3NldGlkOi8vMjE4NjIxOTY5NgpYv/BASBbcPx5spT8EdAFFBEYECsTgOkIZWJtAVkWowwpCop9ALdikP1u8oD4hF3JieGFzc2V0aWQ6Ly8yMTg2MjI3Mzk4CtWwjUDQUJI/OKuOPgR5AUUERgQKxuA6QjySDkBhF67DClYXrECSgrk/94O/QSEXcm'
..'J4YXNzZXRpZDovLzIxODYzNjk2NDgKdL+YQI+opD8m/alBBH4BRQRGBApk0zpCiXmaQAxSqMMK05OkQGkZuD/8CM8+IRdyYnhhc3NldGlkOi8vMjE4NjIyMTI1MAomFJJA/mejP5jDtz4EgwFFBEYECsbgOkJReJBA7FuuwwpxYiRBc0A8QA0rq0EhF3JieGFzc2V0aWQ6Ly8yMTg2MjQyMDc2ClHoEUGLFydAue2XQQSJAUUEZwQKFK6/wAAANEMAAAAACqCuPkLouh5Bm9KzwwqPAi7DAAAA'
..'AAAANEMKeH7zP83MTD1HJuc+IRdyYnhhc3NldGlkOi8vMjE4NjI1MDk0OQr8H9g/AICWOQArzT4hDlpJbmRleEJlaGF2aW9yIRBDbGlwc0Rlc2NlbmRhbnRzIQ5MaWdodEluZmx1ZW5jZSEKU2l6aW5nTW9kZQb///8MAAAAAGQAAAAAAGQAIS5yYnhhc3NldDovL3RleHR1cmVzL3VpL0d1aUltYWdlUGxhY2Vob2xkZXIucG5nBJcBRQRGBAMAAAAAAICUQArG4DpC5qDFQGL8rcMKUzHoQB'
..'OerkBZVAxBIRdyYnhhc3NldGlkOi8vMjE4NjMyNzIzMAoJGM5Afv2aQMsc+UAEnQFFBEYEBiQkJAqm3TpC1Z7DQMUMrsMDAAAAAAAA0D8KbKToQEXR2kAj9SBBIRdyYnhhc3NldGlkOi8vNjY3NTEzMjE0OQoyfs5A2DjCQJ7dDkEEowFFBEYECsTgOkLHFqZAF3OowwpziKBA0s76Pyqtgz8hF3JieGFzc2V0aWQ6Ly8yMTg2MjU0OTg4CiZ9jkDgnd4/aMBpPwSoAUUERgQKxuA6QnoJUkBJ'
..'JK7DCnFiJEGfzjxAT7u5QSEXcmJ4YXNzZXRpZDovLzIxODYyNTcyMTUKUegRQbyVJ0Dr2qRBBK0BRQRGBArE4DpCi/9OQGZXqMMKqyMNQQJxsz/a/8k/IRdyYnhhc3NldGlkOi8vMjE4NjI0NzAxMQrWjPpAnkWfP1xLsz8EsgFFBEYECsDgOkL7vUlADgm0wwozDhhBDqazP7pNIUAhF3JieGFzc2V0aWQ6Ly8yMTg2MzcyNDczCtf2BkG0dJ8/QCwPQAf2AwS5AUUERgQGlGMACobZOkIsbb'
..'lAgXCtwwqqytZAtp6pQO/QQUAhF3JieGFzc2V0aWQ6Ly8yMTg2MzYwNjgyChamvkDvjZZA6gcsQAS+AUUERgQKwOA6QupVw0BZ6rDDCjXuAkH1tzg/l35RQSEXcmJ4YXNzZXRpZDovLzIxODYzNjQzMDAKbW3oQLj0Iz9u8jlBISJNZXNoUGFydC10by1UYWlsbGlnaHQgU3Ryb25nIEpvaW50BGgEaQRdBARqBGsEbAQEbQRrBGwEBMgBRQRuBAoAAChCAAA0QwAAAAAKJuw6QiLfAUGkRqzD'
..'CgAACkMAAAAAAAA0wwqrFM5AYWbmP83MTD0DAAAAoJmZ2T8EzgFvBHAECgrXIzwAADRDAACIQQpeAy1C6k/3QNgzr8MKcf0zQwAAAAAAACPDBNEBbwRwBApmAy1CfFH3QDYSrcME0wFhBGIECmafSEKBUfdAoA2twwrNzEw9Ea7HP7QeRUAE1gFvBHAECgCTO0JxdPNAkWqywwoAp+JAAFpdQGBt6EAKXwMtQhJP90AdZLHDCmADLUKgTPdAUA6zwwp0n0hC0E73QMtXscMKdJ9IQkxM90BQDr'
..'PDCnQ9SkAAAIA/hj2KPgrxTjtCtkMAQSYqtMME3wFFBEYECmDgOkIZB4pAnrCxwwo/M5tAzcxMPZqZGUEhDFBsYXRlIE51bWJlcgTkAXEEcgQKAAAAAB8FtEIAAAAACuZ0KkI8v55AaAatwwoAAAAAAAC0QgAAAAAKVPShP3owKj9mmVs+IQdFZGl0IG1lIQpDYW52YXNTaXplCwAASUMAAExCIQlUZXh0TGFiZWwhB0VkaXQgTWUG//8ABgAAAAwAAAAAyAAAAAAAMgAhBEZvbnQDAAAAAAAA'
..'CEAhBFRleHQhB0ZPVU5ERVIhClRleHRDb2xvcjMhCFRleHRTaXplAwAAAAAAAE5AIRBUZXh0U3Ryb2tlQ29sb3IzBv+3ACEHVUlTY2FsZQT7AXMEdAQK7FGgwArXIzwAAAAACkjvOkJMBURAqoi0wyEGRklQVi0xIQpUZXh0U2NhbGVkAwAAAAAAAFlAIQtUZXh0V3JhcHBlZAQCAnUEdgQKAAAAAOH6s8IAAAAACoZ4S0Jcv55AgAatwwoAAAAAAAC0wgAAAAAhCk5FTy1MaWdodHMEdwR4BH'
..'kEBAgCegR7BAoAAAAAAAAAAAAAtMEKXqUvQtY18D/Eaq7DCgAAgD4AAIA+AAAYQQMAAAAA16PgPyEMU3VyZmFjZUxpZ2h0AwAAAAAAABBABA8CfAR9BAoAAAAAAAAAAAAAtEEKXuVFQto18D/Eaq7DBBICfgR/BAoAAAAAAAC0QgAAtMEK3BA7QnJ10T976ajDCgAAtMEAALRCAAAAAAoAAIA+AACAPjMzg0AEFwKABIEECgAAAAAAALRCAAC0QQrgEDtCpk7RP3tps8MKAAC0QQAAtEIAAAAA'
..'BBsCggSDBAoAAAAAAAAAAAAANMEKYKUtQmSfD0E+cbDDCgAAgD4AAIA+AABwQQMAAAAAAAAgQAQgAoQEhQQKAAAAAAAAAAAAADRBClD7R0JoVw9B2GqwwwoAAIA+AACAPpqZcUEEJAKGBIcECgrXIzyFa7HCCtcjvApghDNCIJWYQHq5ssMKKVwPP4VrscLNzAw/BCgCiASJBAoK1yO8AIC1QgrXozwKIHZCQiCSmECRubLDCs0MM8MAgLJC7BEzQyENU3RlZXJpbmdXaGVlbASKBIsEjAQhCE'
..'JyYWNrZXRzBC8CjQSOBAopXH9AAAAAAAAAAAAKhtdCQnPg1UBL0KzDCsgskj+a8WY/3jgTPyEXcmJ4YXNzZXRpZDovLzE2MjQ2ODg1NDIKM0jzQdIuwEGkBnVBIQZIYW5kbGUENQKNBI4ECobXQkJAQNpAq9KswwpABLo/N3KrP53bIj8hF3JieGFzc2V0aWQ6Ly8xNjI0Njg1Nzc5CrTLGkLSqw5CQoaHQSEEQmFzZQQ7Ao0EjgQK5s1CQseu1UD+r6zDCtFizj7hHcQ+UvhjPiEXcmJ4YXNz'
..'ZXRpZDovLzE2MjQ2OTE5NTcK5tIjQXwzI0Fctb1AIQlUZXh0dXJlSUQhF3JieGFzc2V0aWQ6Ly8xNjI0NjA5NTMwIQ9TdGVlcmluZyBDb2x1bW4ERAKPBJAECgAAAAAAALTCAADIwQrG0EJC86DHQLc4rMMKAADIQQAAtMIAAAAACprKBEAzaD4+OGi+PiEFU2hhcGUhCkhlYWRsaWdodHMEkQRZBFoEIQJPTgRNApIEkwQKXA+Iwh+FA8EKV7JCCoYkP0KPZ+lAb2uswwrDdYjC4XpEwHsUo0'
..'IKC9cjPmGPQj5hj0I+IQlzY3JpcHRpbmchDUNsaWNrRGV0ZWN0b3IhA09GRgRUApIEkwQKRjI/QnMG4kBId6zDBFcClASVBAoAALDCAAAAAAAAokIKhio/Qu9m5EBWa6zDCgAHuD4AXY8+gLwbPwrPzEw+5lG4PrgeBT8KovM+Qgm/5EAbSKzDCjMzsz4rXI8+uB4FPwq6Hj9CI1LkQAhirMMEXgJFBEYECsTgOkKyyZ5AZ8Gowwr+LN5Ay6sKP83MTD0hF3JieGFzc2V0aWQ6Ly8yMTg2Mjg2'
..'NDM5CvAzxUAgK/Y+AEC9OSEETGFtcAMAAADAzEwTQAb/9J4DAAAAAACAQEAElgRZBFoEBGgCkgSTBAom+j1CgWfpQE14rMMEagKSBJMECuYHPkJyBuJAJoSswwRsApQElQQKIAA+QuFm5EA0eKzDCjzJPUL7vuRA+VSswwpU9D1CFVLkQOZurMMEcAJFBEYECqbfOkJ4PhRBEdGswwo+mK5AUcs0Ps3MTD0hF3JieGFzc2V0aWQ6Ly8yMTg2MzkyNTY3ClL4mkAAeSA+AFaSPAMAAAAAAABIQA'
..'R3AkUElwQKAAC4wQAANEMAAAAACmZXQ0LYI9tAXGKswwoAAB3DAAAAAAAANEMKZmbGPwvXYz/NzEw9IQNDYW0EfQKYBJkEChSux78AADRDj8J1vQpGBUNCYEv/QApZrcMKpHAywwAAAACk8DNDIQZHYXVnZXMEggKaBJsECkjhykAK1yM8KVyPPQpG40JCH+P2QPZcrMMKExkEQK2q5j98zxc+IQlFTSBMaWdodHMEnASdBJ4EIQFBBIgCnwSgBAoGvzRCmq0YQcX8rMMKTgr0PomxIj4/MARA'
..'AwAAAMDMzNw/AwAAAAAAABhABgAA/wMAAAAAAAA0QCEBQwSQAp8EoAQKBr80QnolFkHF/KzDIQRXZWxkBKEEXARdBASiBFwEXQQElQKfBKAECgYUQUJ6JRZBxfyswyEBQgSYAp8EoAQKBhRBQpqtGEHF/KzDBKMEaQRdBASkBGkEXQQhAUoEngKlBKYECuxR2D8zM5hChWumwgpG2z1CXkLuQPhZrMMKFK7fQAAAmEIAALTCCv9R1T7i3bw+0mOcPiEIRGlzYWJsZWQhBldoZWVscwSnBKgEqQ'
..'QhAlJMBKgCqgSrBBAAAABAAAAAQAAAAAAAAIA/AACAPwoAALRCAAC0QgAAAAAKgAxLQvBWA0CDALLDCuH6s0IK1yM8AAC0wgp1k3BAdZNwQHWTcEAhBVBhcnRzBKwEWQRaBASuAkUERgQK4AxLQlBeA0CDALLDCu3y2T91c4FAXIqBQCEXcmJ4YXNzZXRpZDovLzIxODY0MjAzNzMErQRcBF0EBK4EXARdBAfHAAS2AkUERgQGY19iCqCuTEJQXgNAgwCywwrMALA+jMHlP9jM5T8hF3JieGFz'
..'c2V0aWQ6Ly8yMTg2NDI0MzU1B0ABBsrL0Qp0Xb4/ZhQaQPwcGkAhF3JieGFzc2V0aWQ6Ly8yMTg2NDIzMDUyIQVGaXhlZASvBLAEWgQhDEN5bGluZGVyTWVzaCEGT2Zmc2V0CgAAAAAzMzM/AAAAAAoAAIA/mpmZPgAAgD8hAkZSBMYCsQSyBAoAALRCAAC0wgAAAAAKB2sqQiB6AUD7T6rDCuH6s0IK1yM8AAC0QgSzBLAEWgQEywKNBEYECgrXI7wAAAAAAAAAAArnaipCIHQBQAdQqsMEtA'
..'RcBF0EBLUEaQS2BATPAo0ERgQK/8goQiB0AUAHUKrDCgAAAAAAAAA/AAAAACECRkwE1AKqBLcEEDMzMz/NzIw/AAAAAAAAgD8AAIA/CoZwS0IZ7gFA/lOqwwosmnBALJpwQCyacEAEuARZBFoEBNgCRQRGBAqGcEtCG+YBQPtTqsMEuQRcBF0EBNsCRQRGBApGGE1CG+YBQPtTqsMhAlJSBN4CugS7BArgAStC+lYDQB36scMEvASwBFoEBOECjQRGBApgAStCmlMDQCP6scME4wKNBEYECkBe'
..'KUKaUwNAI/qxwyEJRHJpdmVTZWF0BxUABOoCvQS+BAbEKBwQKVwPPgAAAAAAAAA/AACAPwAAgD8KAAAAAHH9M8MK1yM9CuYOQ0IZaaRArJ+twwoAADRDCtcjvMP1M8MK1MzMP83MTD0AAIA/IQVTb3VuZCEFQnJha2UhB1NvdW5kSWQhDnJieGFzc2V0aWQ6Ly8wIQZWb2x1bWUhB0NvbnRyb2whCVNjcmVlbkd1aSEBRyELT2JqZWN0VmFsdWUhA3NyYyEEc3JjMiEEc3JjMyELTG9jYWxTY3'
..'JpcHQhB0xpZ2h0czMhB0hhemFyZHMhBExlZnQhBVJpZ2h0IQdTY3JlZWNoIQ1QbGF5YmFja1NwZWVkAwAAAMDMzOw/IRZyYnhhc3NldGlkOi8vMzAzNzM1NDM1AwAAAAAAAPg/IQRIb3JuIQZMb29wZWQhF3JieGFzc2V0aWQ6Ly8xMDU0NDg4NDgxIRRFcXVhbGl6ZXJTb3VuZEVmZmVjdCEISGlnaEdhaW4hB0xvd0dhaW4hB01pZEdhaW4hB0hpTGlnaHQhB1N0YXJ0dXAhFnJieGFzc2V0'
..'aWQ6Ly8yOTUyMjc0MzUhCUd1aSBHaXZlciEGVGhlRml4IQxNb2R1bGVTY3JpcHQhDkEtQ2hhc3NpcyBUdW5lIRNBLUNoYXNzaXMgSW50ZXJmYWNlIQNDYXIhBkZvbGRlciEGVmFsdWVzIQtOdW1iZXJWYWx1ZSEDUlBNIQpIb3JzZXBvd2VyIQtTdHJpbmdWYWx1ZSEQVHJhbnNtaXNzaW9uTW9kZSEER2VhciEIVGhyb3R0bGUhBlN0ZWVyQyEGU3RlZXJUIQNUQ1MhBlBCcmFrZSEJVENTQW'
..'N0aXZlIQxWZWN0b3IzVmFsdWUhCFZlbG9jaXR5IQNBQlMhCUFCU0FjdGl2ZSEMTW91c2VTdGVlck9uIQRJc09uIQxDb250cm9sc09wZW4hBURyaXZlIQZSRUFETUUhB1BsdWdpbnMhBUZyYW1lIRNBQzZfQ29udHJvbHNfTW9kdWxlIQ9Cb3JkZXJTaXplUGl4ZWwhBlpJbmRleCEMQ29udHJvbHNfQUM2IQZXaW5kb3cMAAAAPwb/AAAAAAz+DAAAAAD0AQAAAACQASEHT3ZlcmxheSEHVmlz'
..'aWJsZSEqW1ByZXNzIGEga2V5IHRvIGFzc2lnbiBvciBFbnRlciB0byBjYW5jZWxdAwAAAAAAADxABi8vLyEWVGV4dFN0cm9rZVRyYW5zcGFyZW5jeSEFRXJyb3IMAAAAPwAAAAAAABQAIQ1JbnZhbGlkIElucHV0AwAAAAAAADJABmRkZAMAAABgZmbuPyEJLy9JTlNQQVJFDAAAgD/s/wAAAAAUACEYQS1DaGFzc2lzIDYgYnkgLy9JTlNQQVJFAwAAAAAAACxAIQ5UZXh0WEFsaWdubWVudC'
..'EGSGVhZGVyDAAAAAAKAAAAAAAUACEIQ29udHJvbHMDAAAAAAAAQEAhBFRhYnMMAAAAAAUAAAAAACgADAAAAADqAQAAAAAUACEKVGV4dEJ1dHRvbiEKQ29udHJvbGxlcgwAAAAA6wAAAAAA+/8MAAAAAGQAAAAAABQAIQ5UZXh0WUFsaWdubWVudCEFTW91c2UMAAAAAHgAAAAAAPv/IQhLZXlib2FyZAwAAAAABQAAAAAAAAAhBExpbmUMAACAPwAAAAAAAAIAIQdDb250ZW50DAAAAAAAAAAA'
..'AAA8AAwAAIA/AAAAAIA/xP8hDUNvbnRyb2xSRFpvbmUMAAAAQMgAAAAAAPAAIQQxMDAlIQ5TY3JvbGxpbmdGcmFtZSEBUwwAAAAACgAAAAAAAgAMAAAAAAQBAAAAAAMAIQtCb3R0b21JbWFnZSEvcmJ4YXNzZXQ6Ly90ZXh0dXJlcy91aS9TY3JvbGwvc2Nyb2xsLW1pZGRsZS5wbmcMAAAAAFAUAAAAAAAAIRJTY3JvbGxCYXJUaGlja25lc3MhCFRvcEltYWdlIQ1Db250cm9sTERab25lDA'
..'AAAEDIAAAAAADcACELTVN0ZWVyV2lkdGgMAACAP8gAAAAAALQAIQtNU3RlZXJEWm9uZQwAAIA/yAAAAAAAoAAhAVQMAAAAQJYAAAAAAPAAIQ5SaWdodCBEZWFkem9uZQwAAABAlgAAAAAA3AAhDUxlZnQgRGVhZHpvbmUMAACAP5YAAAAAALQAIQ1Db250cm9sIFdpZHRoDAAAgD+WAAAAAACgACEIRGVhZHpvbmUhD0NvbnRsclRvZ2dsZVRDUwwAAABAqgAAAAAArQAMAAAAACwBAAAAAA8A'
..'IRFDb250bHJUb2dnbGVUTW9kZQwAAABAqgAAAAAAmQAhDENvbnRsclBCcmFrZQwAAABAqgAAAAAAhQAhDENvbnRsckNsdXRjaAwAAABAqgAAAAAAcQAhD0NvbnRsclNoaWZ0RG93bgwAAABAqgAAAAAAXQAhDUNvbnRsclNoaWZ0VXAMAAAAQKoAAAAAAEkAIQtDb250bHJTdGVlcgwAAABAqgAAAAAANQAhC0NvbnRsckJyYWtlDAAAAECqAAAAAAAhACEOQ29udGxyVGhyb3R0bGUMAAAAQK'
..'oAAAAAAA0ADAAAAECWAAAAAACgACERVHJhbnNtaXNzaW9uIE1vZGUMAAAAQJYAAAAAALQAIQpUb2dnbGUgVENTDAAAAECWAAAAAACMACEJSGFuZGJyYWtlDAAAAECWAAAAAAB4ACEGQ2x1dGNoDAAAAECWAAAAAABkACEKU2hpZnQgRG93bgwAAABAlgAAAAAAUAAhCFNoaWZ0IFVwDAAAAECWAAAAAAA8ACEFU3RlZXIMAAAAQJYAAAAAACgADAAAAECWAAAAAAAUACELTW91c2VQQnJha2UM'
..'AACAP6oAAAAAAIUAIQtNb3VzZUNsdXRjaAwAAIA/qgAAAAAAcQAhDk1vdXNlU2hpZnREb3duDAAAgD+qAAAAAABdACEMTW91c2VTaGlmdFVwDAAAgD+qAAAAAABJACEKTW91c2VTdGVlcgYoKCgMAACAP6oAAAAAADUAIQlNb3VzZU1vdmUGsLCwIQpNb3VzZUJyYWtlDAAAgD+qAAAAAAAhACENTW91c2VUaHJvdHRsZQwAAIA/qgAAAAAADQAMAACAP5YAAAAAAIwADAAAgD+WAAAAAAB4AA'
..'wAAIA/lgAAAAAAZAAMAACAP5YAAAAAAFAADAAAgD+WAAAAAAA8AAwAAIA/lgAAAAAAKAAMAACAP5YAAAAAABQAIQlUb2dnbGVBQlMMAAAAAKoAAAAAACUBIQlUb2dnbGVUQ1MMAAAAAKoAAAAAABEBIQ9Ub2dnbGVUcmFuc01vZGUMAAAAAKoAAAAAAP0ADAAAAACqAAAAAADpAAwAAAAAqgAAAAAA1QAhCVNoaWZ0RG93bgwAAAAAqgAAAAAAwQAhB1NoaWZ0VXAMAAAAAKoAAAAAAK0AIQtT'
..'dGVlclJpZ2h0MgwAAAAAqgAAAAAAmQAhClN0ZWVyTGVmdDIMAAAAAKoAAAAAAIUAIQZCcmFrZTIMAAAAAKoAAAAAAHEAIQlUaHJvdHRsZTIMAAAAAKoAAAAAAF0AIQpTdGVlclJpZ2h0DAAAAACqAAAAAABJACEJU3RlZXJMZWZ0DAAAAACqAAAAAAA1AAwAAAAAqgAAAAAAIQAMAAAAAKoAAAAAAA0ADAAAAACWAAAAAAAsASEKVG9nZ2xlIEFCUwwAAAAAlgAAAAAAGAEMAAAAAJYAAAAAAA'
..'QBDAAAAACWAAAAAADwAAwAAAAAlgAAAAAA3AAMAAAAAJYAAAAAAMgADAAAAACWAAAAAAC0AAwAAAAAlgAAAAAAoAAhFltTZWNvbmRhcnldIFN0ZWVyUmlnaHQMAAAAAJYAAAAAAIwAIRhbU2Vjb25kYXJ5XSAgIFN0ZWVyIExlZnQMAAAAAJYAAAAAAHgAIRlbU2Vjb25kYXJ5XSAgICAgICAgQnJha2VzDAAAAACWAAAAAABkACEYW1NlY29uZGFyeV0gICAgIFRocm90dGxlDAAAAACWAAAA'
..'AABQACELU3RlZXIgUmlnaHQMAAAAAJYAAAAAADwAIQpTdGVlciBMZWZ0DAAAAACWAAAAAAAoAAwAAAAAlgAAAAAAFAAhEFRvZ2dsZU1vdXNlRHJpdmUMAAAAAKoAAAAAADkBDAAAAACWAAAAAABAASEUU3dpdGNoIE1vdXNlIENvbnRyb2wMAAAAQJYAAAAAAMgAIQ9Db250bHJUb2dnbGVBQlMMAAAAQKoAAAAAAMEAIQZUb2dnbGUG/6oABpaWlgwAAAA/zv8AAIA/CgAMAAAAAGQAAAAAAB'
..'IAAwAAAAAAADBABmpqaiEPQUM2X1N0b2NrX1NvdW5kIQtSZW1vdGVFdmVudCENQUM2X0ZFX1NvdW5kcyEHSGFuZGxlciEDUmV2IRZyYnhhc3NldGlkOi8vMjM3ODQ5MTE1IQZTZXRSZXYhBVZhbHVlIQhTZXRQaXRjaAOamZmZmZnpPyEQQUM2X1N0b2NrX0dhdWdlcyEKR2F1Z2VzX0FDNiEEVGFjaAwAAAA/av8AAIA/nP8hBk5lZWRsZQMAAAAAAIBGQAwAAAAA/v8AAAAA9v8MAAAAAAQA'
..'AAAAAG4AIQZTcGVlZG8MAAAAP5YAAACAP5z/IQJsbgwAAAAA/v8AAAAAaQAMAAAAAAMAAAAAAAUAIQNOdW0MAAAAAAAAAAAAAFgAAwAAAAAAgEbAIQEwBtXV1SEQVGV4dFRyYW5zcGFyZW5jeQwAAAA/iP8AAIA/uv8hAU4MAAAAP4IAAACAP5z/DAAAAD/IAAAAgD+I/yEBUAb/VX8DAAAAAAAAOEAMAAAAP4IAAACAP4j/IQVUTW9kZQwAAAA/W/8AAIA/2P8MAAAAACgAAAAAABQAIQNBL1'
..'QhBVNwZWVkDAAAAD+WAAAAgD+w/yEFMCBTUFMMAAAAP4IAAACAP3T/IRFBQzZfTVN0ZWVyX0NhbWVyYSERU21lZXJzTGlnaHRzQWRkb24hE1NtZWVyc0xpZ2h0c0hhbmRsZXIhC1Ntb2tlIFtGRStdIQhTbW9rZV9GRSECU1EhElJvbGxPZmZNYXhEaXN0YW5jZQMAAAAAAMByQCEWcmJ4YXNzZXRpZDovLzQzNTc1MjM4MSESVHJlbW9sb1NvdW5kRWZmZWN0IQVEZXB0aAMAAACgmZnpPyEJ'
..'RnJlcXVlbmN5IQ9QYXJ0aWNsZUVtaXR0ZXIhBVNtb2tlIQxBY2NlbGVyYXRpb24KAAAAAAAAgD8AAAAAIRFFbWlzc2lvbkRpcmVjdGlvbiEITGlmZXRpbWURAABAQAAAYEAhBFJhdGUhCFJvdFNwZWVkEQAAoEEAAMhCKQMAAAAAAABAQAAAAACc6xg+OY77QFBVFT8AAIA/5DgWQcBxHD8RAAAAwAAAAAAhC1NwcmVhZEFuZ2xlCwAAoEEAAKBBIQdUZXh0dXJlIShodHRwOi8vd3d3LnJvYm'
..'xveC5jb20vYXNzZXQvP2lkPTM0MDk4NTUyKQIAAAAAAABAPwAAAAAAAIA/AACAPwAAAAAhDkZpcnN0UGVyc29uQ2FtIQhGUEdhdWdlcwsAAAAAAAAAAAbV1dUG/1V/IQNQU0kMAAAAPwAAAACAP4j/IQYtMiBQU0kG1dXVIQpJbml0aWFsaXplIQhNaXNjV2VsZCEETWlzYwrj7TpCe2KmQAFJrsMKAACAvy82xrKz3lS1CvKZxbIAAIA/K+e7uAoAAIA/5ScssoKOzDMKXCssMgAAgD9z4wq3'
..'CgAAgD/iJyyygo7MMwpbKywyAACAP3HjCrcK//9/v6fZYbkLcnK5ClrnYbkAAIA/AGdnOQoggUZCEkCKQH1MtMMKAACAv4r5JbPdTFu1Cn6wJbMAAIA/XomquAoAAIC/leMDNOeblbYK41EENAAAgD9evry4CgAAgL/XBPayqd50tQoeUfWyAACAP8zlu7gK9O1/v5FDn7zTYlc8Cm4sobzi6H8/aCiSvAoAAIA/oSmssoeOTDQKkjCsMgAAgD9144q3CtzgOkJ8zL1A/0iuwwoAAIC/CG3ZtE'
..'SwPTYKoRXZtAAAgD/E6Gs5Cpc1EMCYNRA/mDWQPwoAAIC/AAAAAAAAAAAKAAAAAAAAAAAAAIA/Cpc1EMCYNRC/mDWQPwrc4DpCyyVOQOZMrsMKlzUQwHQ1EL+YNZA/CmLQdD/LsZU+jWPVtwrLsZW+YtB0P8E9tLgKlzUQwGI1EL+YNZA/Cpc1EMDgNRC/mDWQPwqXNRDAUDUQv5g1kD8K3OA6QjU4vUDNL67DCoUj47ObmX4/j+TVPQo17oJA9be4vpd+0UAKAACAPwAAAAAAAAAACmAMn79Q'
..'BI8+gh7YwAoBAIC/IzgOs+dMO7UKWrshNUwumbgAAIC/CjjD38BABI8+ih7YwAqi2Ak1nDs+P55PK78KZNB0v8WxlT6cHOK3CsSxlT5j0HQ/0ESzuAoZRsC4ADJKuAAAgL8KJ/yUswAAgD//MUq4CgAAgD83HKAyXEa/uAoz0AW3GwZ/P1ytsr0KI0bAOPwxSjgAAIA/Cs/PjbUAAIA/4jFKuAr9rDtCjtWuQOmCrsMKxRR7P0zFRz7I2DI4CkzFR77EFHs/5nxwOQphg2w/E+/Dvh87BTgKE+'
..'/DPmCDbD8QAJ24CmGDbD8T78M+iaX/twoT78O+YINsP8UenrgK91LZNFz2w77dgWy/CoxI1TPdgWw/XfbDvgr3X780z+fDPuKEbL8Kh+9ntOKEbD/O58M+Cr8Uez++xUe+MdOKNwq+xUc+vxR7P8X6prgKvxR7P7vFRz7or363CrvFR77AFHs/7oynuAolpbg8taOGuVnvfz8K/6NiuQAAgD+DOok5ChRyVbxH/Jg5cPp/vwoD0F25AACAP4VxmjkK581CQhmt1UD+r6zDCgAAgD94FQ4z5kw7'
..'NQqTRa+zu2B/PzSyjj0KAACAPy82xjKz3lQ1CssSqLPEYH8/062OPQrugom0cVrYvmsFaD8KP/JWtGoFaD9xWtg+CuLgOkLt3MFAmqKqwwoUfxY+KZG/PtBnar8Kadl8v73qsTvmECC+CjMoID5P/gw9JbJ8vwp42Xy/cpyyO0sPIL4Kvt86Qi9QAUHEmKzDCpW4sbRWqGs/3gPIPgr4/3+/okOEupqdlbgKRHiEuqrnfz+HF988CvT/fz/JGKA6lxq+uArLzZ26uG5+PylH4j0Knuk6Qo+MBk'
..'E7q6zDCq7gMLfqwWo6+v9/vwo7GqK1+v9/P+rBajoKIQyqNAAySrgAAIC/CqkpnbMAAIA/ATJKuAoAAAAAibGiPQAAAAAKAAAAAABXob0AAAAACgAAAACJsaK9AAAAAAoAAAAAAFehPQAAAAAK9BPIMzgYfr9VaPm9Cvq6dz67//E994t2vwpY7TpCshkCQGcorsMKycu7uGPZRjr8/3+/CgAAgD9gZeE4B6C7uApxBaW4vS5CuQAAgL8KAACAP2+G4jgvEKW4CtsMS0LigwNApQCywwoAAADA'
..'AAAAPwAAgD8KAAAAwAAAAL8AAIA/ClTPM8F6I3HABB4kwwoAAIA/CG3ZNESwPbYKTR6nOE8iQTkAAIA/CgAAgL9nhuK4/CinOAonaypCV6sAQChQqsMKAACAwwAAIEEAAIBDCmC9REKMFwLAQKbSwgoAAAAAAAAAAAAAgL8KAACAP5Bt4DgWEKW4CqZwS0IcHgFAHlSqwwrAtyPCjIkCwGyW0kIKTh6nOL0uQjkAAIA/CgAAgL9nhuK4DCmnOApeAStCAngDQET6scMK/v9/v73dKTo9oyE5Co'
..'DdKTr9/38/0o+9twUCAQAAAAIAAgADAAQABQABAAEAAgACAAYABAAIAAEAAgACAAIACQAEAAoACwADABYAAgAMAA0ADgAPABAAEQAQABIAEwAUABUAFgAXABgAGQAaABAAGwAQABwAHQAeAB8AIAAhACIAEAAjACQAJQAmACcAEAAoACkAKgAXACsALAAtACwALgAsAAsAAwAWAAIADAANAA4ADwAQABEAEAASABMAFAAvABYAFwAYABkAGgAQABsAEAAcAB0AHgAfACAAMAAiABAAIwAkACUA'
..'JgAnABAAKAApACoAFwArACwALQAsAC4ALAALAAMAFgACAAwADQAOAA8AEAARABAAEgATABQAMQAWABcAGAAZABoAEAAbABAAHAAdAB4AHwAgADIAIgAQACMAJAAlACYAJwAQACgAKQAqABcAKwAsAC0ALAAuACwAAQADAAIAAgAzAAQANAABAAcAAgACADUABAA0ADYACAAPAAIAMwANAA4AEQAsABIAEwAUADcAFgAXABgAGQA4ADkAHAAdAB4AOgAgADsAIwA8ACUAPQAnACwAKAApAD4ACQ'
..'AFAAIAPwAYAEAAQQAXAEIADgBDAEQARQAJAAEARgBHAEgACQADAAIASQBBABcASgBLAEwADAAIAE0ADgBOAE8AUAApAFEAGQAgAFIAUwAOACUAVABVAFYANgAIAA8AAgAzAA0ADgARACwAEgATABQAVwAWABcAGAAZADgAOQAcAB0AHgA6ACAAWAAjAFkAJQBaACcALAAoACkAPgAOAAUAAgA/ABgAQABBABcAQgAOAEMARABFAA4AAQBGAEcASAAOAAMAAgBJAEEAFwBKAEsATAARAAgATQAO'
..'AE4ATwBQACkAUQAZACAAUgBTAA4AJQBUAFUAVgBbAAcAAQACAFwAXQAHAAEAAgBeAAEAAwACAAIAXwAEAAoAAQAVAAIAAgA1AAQACgA2ABYAEwACAGAADQAOAA8AEAARABAAEgATABQAYQAWABcAGAAZADgAOQAaABAAGwAQABwAHQAeAGIAIABjACIAEAAjAGQAJQBlACcAEAAoACkAZgAXAAUAAgA/AGcAEABBABcAQgAOAEMAaABpABcABAACAEkAQQAXAE0ADgAlAGoATAAZAAYATQAOAE'
..'4ATwBQACkAUQAZACUAawBVAGwARQAXAAEARgBtADYAFgATAAIAYAANAA4ADwAQABEAEAASABMAFABuABYAFwAYABkAOAA5ABoAEAAbABAAHAAdAB4AYgAgAG8AIgAQACMAZAAlAGUAJwAQACgAKQBmABwABQACAD8AZwAQAEEAFwBCAA4AQwBoAGkAHAAEAAIASQBBABcATQAOACUAagBMAB4ABgBNAA4ATgBPAFAAKQBRABkAJQBrAFUAbABFABwAAQBGAG0ANgAWABEAAgBwAA0ADgAPABAA'
..'EQAQABIAEwAUAHEAFgAXABgAGQA4ADkAGgAQABsAEAAcAB0AIAByACIAEAAlAHMAJwAQACgAKQBmACEABgACAD8AGAB0AEEAFwBCAA4AdQB2AEMAdwBpACEABAACAEkAQQAXACUAeAB5AHoATAAjAAUATgB7AFAAKQAgAHwAJQB9AFUAfgBFACEAAQBGAEcANgAWABEAAgBwAA0ADgAPABAAEQAQABIAEwAUAH8AFgAXABgAGQA4ADkAGgAQABsAEAAcAB0AIACAACIAEAAlAHMAJwAQACgAKQ'
..'BmACYABgACAD8AGAB0AEEAFwBCAA4AdQB2AEMAdwBpACYABAACAEkAQQAXACUAeAB5AHoATAAoAAUATgB7AFAAKQAgAHwAJQB9AFUAfgBFACYAAQBGAEcAWwAVAAEAAgBcAF0AFQABAAIAXgABAAMAAgACAAkABACBAIIALQAMAA0ADgASAIMAFACEABYAFwAYAIUAHAAdAB4AOgAgAIYAIwBZACUAhwCIAIkAigCLAIIALQALAA0ADgASABMAFACMABgAGQAcAB0AHgA6ACAAjQAjAFkAJQCO'
..'AIgAjwCKAJAAggAtAAsADQAOABIAgwAUAJEAGACFABwAHQAeADoAIACSACMAWQAlAJMAiACUAIoAlQCWADAAAwACAJcAmACZAJoAmwABAC0AAgACAJ4ABACfAIIAMgAMAA0ADgASAIMAFACgABgAhQAcAKEAHgA6ACAAogCjACkAIwBZACUApACIAKUAigCmAIIAMgAMAA0ADgASAIMAFACnABgAhQAcAKEAHgA6ACAAqACjACkAIwBZACUAqQCIAKoAigCrAIIAMgAMAA0ADgASAIMAFACsAB'
..'gAhQAcAKEAHgA6ACAArQCjACkAIwBZACUArgCIAK8AigCwAJYANQADAAIAlwCYAJkAmgCbALEAQAYANgC5ALoAOgAANgC7ALwAOgAAvQC+AL8AwAAAvQDBAMIAwAAAvQDBAMMAxAAAvQC+AMUAxAAtAAwAAgCyAA0ADgASALMAFAC0ABYAFwAYALUAHAAdAB4AOgAgALYAIwBZACUAtwC4AA4AggAtAAwADQAOABIAgwAUAMYAFgAXABgAhQAcAB0AHgA6ACAAxwAjAFkAJQDIAIgAyQCKAMoA'
..'lgA4AAMAAgCXAJgAmQCaAJsAggAtAAwADQAOABIAswAUAMsAFgAXABgAtQAcAB0AHgA6ACAAzAAjAFkAJQDNAIgAzgCKAM8AlgA6AAMAAgCXAJgAmQCaAJsAggAtAA0ADQAOABIAgwAUANAAFgAXABgAhQAcAKEAHgA6ACAA0QCjANIAIwBZACUA0wCIANQAigDVAJYAPAADAAIAlwCYAJkAmgCbAIIALQAMAA0ADgASALMAFADWABYAFwAYALUAHAAdAB4AOgAgANcAIwBZACUA2ACIANkAig'
..'DaAJYAPgADAAIAlwCYAJkAmgDbADYALQAPAAIA3AANAA4AEQAsABIA3QAUAN4AFgAXABgA3wAcAB0AHgDgACAA4QCjAOIAIwDgACUA4wAnACwAKADkAIIALQAMAA0ADgASAIMAFADlABYAFwAYAIUAHAAdAB4AOgAgAOYAIwBZACUA5wCIAOgAigDpAIIALQAMAA0ADgASAIMAFADqABYAFwAYAIUAHAChAB4AOgAgAOsAIwBZACUA7ACIAO0AigDuAIIALQAMAA0ADgASAO8AFADwABYAFwAY'
..'APEAHADyAB4AOgAgAPMAIwBZACUA9ACIAPUAigD2AJYAQwADAAIAlwCYAJkAmgDbAIIALQAMAA0ADgASABMAFAD3ABYAFwAYABkAHAAdAB4AOgAgAPgAIwBZACUA+QCIAPoAigD7AIIALQAMAA0ADgASAPwAFAD9ABYAFwAYAP4AHADyAB4AOgAgAP8AIwBZACUAAAGIAAEBigACAZYARgADAAIAlwCYAJkAmgADAYIALQAMAA0ADgASAAQBFAAFARYAFwAYAAYBHAAdAB4AOgAgAAcBIwBZAC'
..'UACAGIAAkBigAKAYIALQAMAA0ADgASAIMAFAALARYAFwAYAIUAHAAdAB4AOgAgAAwBIwBZACUADQGIAA4BigAPAZYASQADAAIAlwCYAJkAmgCbAIIALQAMAA0ADgASAIMAFAAQARYAFwAYAIUAHAChAB4AOgAgABEBIwBZACUAEgGIABMBigAUAYIALQAMAA0ADgASAPwAFAAVARYAFwAYAP4AHADyAB4AOgAgABYBIwBZACUAFwGIABgBigAZAZYATAADAAIAlwCYAJkAmgAaAYIALQAMAA0A'
..'DgASAIMAFAAbARYAFwAYAIUAHAAdAB4AOgAgABwBIwBZACUAHQGIAB4BigAfAZYATgADAAIAlwCYAJkAmgADAYIALQAMAA0ADgASABMAFAAgARYAFwAYABkAHAAdAB4AOgAgACEBIwBZACUAIgGIACMBigAkAZYAUAADAAIAlwCYAJkAmgCbAIIALQAMAA0ADgASAIMAFAAlARYAFwAYAIUAHAAdAB4AOgAgACYBIwBZACUAJwGIACgBigApAZYAUgADAAIAlwCYAJkAmgCbAIIALQAMAA0ADg'
..'ASAIMAFAAqARYAFwAYAIUAHAAdAB4AOgAgACsBIwBZACUALAGIAC0BigAuAZYAVAADAAIAlwCYAJkAmgCbAIIALQAMAA0ADgASALMAFAAvARYAFwAYALUAHAAdAB4AOgAgADABIwBZACUAMQGIADIBigAzAZYAVgADAAIAlwCYAJkAmgA0AYIALQAOAAIANQENAA4AEgCzABQANgEWABcAGAC1ABwAHQAeADoAIAA3AaMAOAEjAFkAJQA5AYgAOgGKADsBggAtAAwADQAOABIA7wAUABUBFgAX'
..'ABgA8QAcAPIAHgA6ACAAFgEjAFkAJQA8AYgAPQGKAD4BlgBZAAMAAgCXAJgAmQCaAJsAggAtAAwADQAOABIAgwAUAD8BFgAXABgAhQAcAB0AHgA6ACAAQAEjAFkAJQBBAYgAQgGKAEMBggAtAAwADQAOABIAgwAUAEQBFgAXABgAhQAcAB0AHgA6ACAARQEjAFkAJQBGAYgARwGKAEgBggAtAAwADQAOABIASQEUAEoBFgAXABgASwEcAB0AHgA6ACAATAEjAFkAJQBNAYgATgGKAE8BggAtAA'
..'wADQAOABIAUAEUAFEBFgAXABgAUgEcAPIAHgA6ACAAUwEjAFkAJQBUAYgAVQGKAFYBggAtAAwADQAOABIAgwAUAFcBFgAXABgAhQAcAB0AHgA6ACAAWAEjAFkAJQBZAYgAWgGKAFsBlgBfAAMAAgCXAJgAmQCaAJsAAQAtAAIAAgBcAQQAXQGCAGEADQACAF4BDQAOABIA3QAUAF8BFgAXABgA3wAcAB0AHgA6ACAAYAEjAFkAJQBhAYgAYgGKAGMBggBhAAsADQAOABIAswAUAGQBGAC1ABwA'
..'HQAeADoAIABlASMAWQAlAGYBiABnAYoAaAGCAGEADAANAA4AEgCzABQAaQEWABcAGAC1ABwAHQAeADoAIABqASMAWQAlAGsBiABsAYoAbQGCAGEACwANAA4AEgCzABQAbgEYALUAHAAdAB4AOgAgAG8BIwBZACUAcAGIAHEBigByAYIAYQALAA0ADgASALMAFABzARgAtQAcAB0AHgA6ACAAdAEjAFkAJQB1AYgAdgGKAHcBggBhAAwADQAOABIAswAUAHgBFgAXABgAtQAcAB0AHgA6ACAAeQ'
..'EjAFkAJQB6AYgAewGKAHwBlgBnAAMAAgCXAJgAmQCaAJsAggBhAAsADQAOABIAswAUAH0BGAC1ABwAHQAeADoAIAB+ASMAWQAlAH8BiACAAYoAgQGCAGEADAANAA4AEgATABQAggEWABcAGAAZABwAHQAeADoAIACDASMAWQAlAIQBiACFAYoAhgGCAGEADAANAA4AEgCzABQAhwEWABcAGAC1ABwAHQAeAIgBIACJASMAigElAIsBiACMAYoAjQFIAGEABACOASkAjwEOAJABKQCRASkATABs'
..'AAMATgCSASUAkwFVAJQBggAtAAwADQAOABIASQEUAJUBFgAXABgASwEcAJYBHgA6ACAAlwEjAFkAJQCYAYgAmQGKAJoBlgBuAAMAAgCXAJgAmQCaAJsAggAtAAwADQAOABIAEwAUAJsBFgAXABgAnAEeADoAIACdAaMAngEjAFkAJQCfAYgAoAGKAKEBggAtAAwADQAOABIAgwAUAKIBFgAXABgAhQAcAB0AHgA6ACAAowEjAFkAJQCkAYgApQGKAKYBggAtAAwADQAOABIAgwAUAKcBFgAXAB'
..'gAhQAcAB0AHgA6ACAAqAEjAFkAJQCpAYgAqgGKAKsBggAtAAwADQAOABIAgwAUAKwBFgAXABgAhQAcAB0AHgA6ACAArQEjAFkAJQCuAYgArwGKALABggAtAAwADQAOABIAgwAUALEBFgAXABgAhQAcAKEAHgA6ACAAsgEjAFkAJQCzAYgAtAGKALUBlgB0AAMAAgCXAJgAmQCaAJsAggAtAAwADQAOABIAtgEUALcBFgAXABgAuAEcAB0AHgA6ACAAuQEjAFkAJQC6AYgAuwGKALwBggAtAA0A'
..'DQAOABIAgwAUAL0BFgAXABgAhQAcAKEAHgA6ACAAvgGjACkAIwBZACUAvwGIAMABigDBAZYAdwADAAIAwgGYAMMBmgDEAZYAdwADAAIAwgGYAMMBmgDFATYALQAPAAIA3AANAA4AEQAsABIA3QAUAMYBFgAXABgA3wAcAB0AHgDHASAAyAGjAOIAIwDJASUAygEnACwAKADLATYALQAPAAIA3AANAA4AEQAsABIA3QAUAMwBFgAXABgA3wAcAB0AHgDNASAAzgGjAOIAIwDPASUA4wAnACwAKA'
..'DkADYALQAPAAIA3AANAA4AEQAsABIA3QAUANABFgAXABgA3wAcAB0AHgDNASAA0QGjAOIAIwDPASUA4wAnACwAKADkADYALQAPAAIA3AANAA4AEQAsABIA3QAUANIBFgAXABgA3wAcAB0AHgDgACAA0wGjAOIAIwDgACUA1AEnACwAKADkALEAQAUANgDjANgBzQEANgDjANkBzQEANgDjANoB4AAANgDjANsB4AAANgDcAd0BOgAtAAoADQAOABIAswAUANUBFgAXABgAtQAcAB0AHgDNASAA'
..'1gEjAM8BJQDXATYALQALAA0ADgARACwAEgATABQA3gEYABkAHgA6ACAA3wEjAFkAJQDgAScALAAoACkANgAtAAwAAgDhAQ0ADgASABMAFADiARYAFwAYABkAHAAdAB4A4wEgAOQBIwDlASUA5gEoACkASACAAAIAAgDnAegB6QHqAYEACgACAOsBTgDsAVAAKQBRAO0BJQDuAe8B8AHxAfIB8wHtAfQB9QH2AfcB+AGCAAAANgAtAAwAAgDhAQ0ADgASABMAFAD5ARYAFwAYABkAHAAdAB4A+g'
..'EgAPsBIwD6ASUA5gEoACkASACEAAIAAgDnAegB6QHqAYUADAACAOsBTgDsAVAAKQBRAO0BJQDuAe8B8AHxAfwB8wHtAf0BDgD0Af4B9gH3Af8BDgA2AC0ADAACAOEBDQAOABIAEwAUAAACFgAXABgAGQAcAB0AHgABAiAAAgIjAAMCJQDmASgAKQBIAIcAAgACAOcB6AHpAeoBiAAKAAIA6wFOAOwBUAApAFEA7QElAO4B7wHwAfEB8gHzAe0B9AH1AfYB9wH4AYkAAAABAC0AAgACAAQCBAAF'
..'AjYAiwAMAA0ADgARACwAEgCzABQABgIYALUAHADyAB4ABwIgAAgCIwAHAiUACQInACwAKAAKAgsCjAADABgAtQBCAA4ASgAMAjYAiwAMAA0ADgARACwAEgCzABQADQIYALUAHADyAB4ADgIgAA8CIwAOAiUACQInACwAKAAKAgsCjgADABgAtQBCAA4ASgAMAjYAiwAMAA0ADgARACwAEgCzABQAEAIYALUAHADyAB4AEQIgABICIwATAiUAFAInACwAKAAKAgsCkAADABgAtQBCAA4ASgAMAj'
..'YAiwAMAA0ADgARACwAEgCzABQAFQIYALUAHADyAB4AFgIgABcCIwAYAiUAFAInACwAKAAKAgsCkgADABgAtQBCAA4ASgAMAjYAiwAMAA0ADgARACwAEgCzABQAGQIYALUAHADyAB4AGgIgABsCIwAaAiUAHAInACwAKAAKAgsClAAFAGcASwAYALUAQgAOAEoADAJDAB0CNgCLAAwADQAOABEALAASALMAFAAeAhgAtQAcAPIAHgAfAiAAIAIjAB8CJQAhAicALAAoAAoCCwKWAAUAZwBLABgA'
..'tQBCAA4ASgAMAkMAHQILAAMAFgACAAwADQAOAA8AEAARABAAEgATABQAIgIWABcAGAAZABoAEAAbABAAHAAdAB4AIwIgACQCIgAQACMAJQIlACYAJwAQACgAKQAqABcAKwAsAC0ALAAuACwACwADABYAAgAMAA0ADgAPABAAEQAQABIAEwAUACYCFgAXABgAGQAaABAAGwAQABwAHQAeACcCIAAoAiIAEAAjACkCJQAmACcAEAAoACkAKgAXACsALAAtACwALgAsAAEAAwACAAIAKgIEACsCgg'
..'CaAA0AAgAsAg0ADgASABMAFAAtAhYAFwAYABkAHgAuAiAALwKjADgBIwAuAiUAMAKIADECigAyAoIAmgAMAAIAMwINAA4AEgATABQANAIWABcAGAAZAB4ALgIgADUCIwAuAiUANgKIADcCigA4AoIAmgANAAIAOQINAA4AEgATABQAOgIWABcAGAAZAB4ALgIgADsCIwAuAiUAPAKIAD0CigA+Aj8CQAI2AJoADAACAEECDQAOABEALAASABMAFABCAhgAGQAeAEMCIABEAiMARQIlAEYCJwAs'
..'AEcCSwABAAMAAgACAEgCBABJAjYAnwAMAAIASgINAA4AEQAsABIAUAEUAEsCGABSARwA8gAeAEwCIABNAiMATgIlAE8CJwAsAF0AoAABAAIAUAJRAqAAAAA2AJ8ADAACAFICDQAOABEALAASAFABFABTAhgAUgEcAPIAHgBMAiAAVAIjAE4CJQBPAicALABRAqMAAABdAKMAAQACAFACsQBAAoA2AFkCWgJWAgA2AFsCXAJMAp8ACQACADYADQAOABQAVQIYAFIBHADyAB4AVgIgAFcCIwBWAi'
..'UAWAKCAJ8ADQACAF8ADQAOABIAUAEUAF0CFgAXABgAUgEcAPIAHgA6ACAAXgIjAFkAJQBfAogAYAKKAGECCwKnAAcAAgBiAmcAYwIYAGQCQQAXAEIADgB1AHYAQwBlAgEAAwACAAIASAIEAGYCNgCpAAwAAgBKAg0ADgARACwAEgBQARQAZwIYAFIBHADyAB4ATAIgAGgCIwBOAiUATwInACwAXQCqAAEAAgBQAlECqgAAADYAqQAMAAIAUgINAA4AEQAsABIAUAEUAGkCGABSARwA8gAeAEwC'
..'IABqAiMATgIlAE8CJwAsAFECrQAAAF0ArQABAAIAUAKxAEACgDYAWQJtAlYCADYAWwJuAkwCqQAJAAIANgANAA4AFABrAhgAUgEcAPIAHgBWAiAAbAIjAFYCJQBYAoIAqQANAAIAXwANAA4AEgBQARQAbwIWABcAGABSARwA8gAeADoAIABwAiMAWQAlAHECiAByAooAcwILArEABgACAGICZwBjAkEAFwBCAA4AdQB2AEMAdAI2AAMADAANAA4AEQAsABIAEwAUAHUCFgAXABgAGQAcAPIAHg'
..'B2AiAAdwIjAHgCJQB5AicALAA2AAMADQACAHoCDQAOABIAEwAUAHsCFgAXABgAGQA4ADkAHADyAB4AfAIgAH0CIwB+AiUAcwAoACkANgADABMAAgB/Ag0ADgAPABAAEQAQABIAEwAUAIACFgAXABgAGQA4ADkAGgAQABsAEAAcAB0AHgCBAiAAggIiABAAIwCBAiUAgwInABAAKAApAAEAAwACAAIAhAIEAIUCNgC2AA8AAgCGAg0ADgARAEsAEgATABQAhwIWABcAGAAZABoASwAcAB0AHgDl'
..'ASAAiAIjAOUBJQCJAicALAAoAIoCPgC3AAQAZwCLAhgAjAJBABcAQwCNAjYAtgAOAAIAjgINAA4AEQBLABIAEwAUAI8CFgAXABgAGQAaAEsAHAAdAB4A5QEgAJACIwDlASUAiQInACwAkQK5AAIAmACSApoAkwI2ALYADgACAI4CDQAOABEASwASABMAFACUAhYAFwAYABkAGgBLABwAHQAeAOUBIACVAiMA5QElAIkCJwAsADYAtgAPAAIAlgINAA4AEQBLABIAEwAUAJcCFgAXABgAGQAaAE'
..'sAHAAdAB4A5QEgAJgCIwDlASUAiQInACwAKACKAj4AvAAEAGcAiwIYAIwCQQAXAEMAjQKRArwAAgCYAJkCmgCaAjYAtgAPAAIAmwINAA4AEQBLABIAEwAUAJwCFgAXABgAGQAaAEsAHAAdAB4AnQIgAJ4CowApACMAnwIlAKACJwAsAF0AvwABAAIAhgJdAL8AAQACAJYCXQC/AAIAAgCOAqECDgBRAr8AAAABAAIAAgACAKICBACjAjYAxAATAAIApAINAA4ADwAQABEAEAASAIMAFAClAhgA'
..'hQA4AKYCGgAQABsAEAAcAB0AHgCnAiAAqAIiABAAIwCpAiUAqgInABAAKAApAEcCLAABAMUAAgACAKsCBACsAgEAxgABAAQArAKCAMcADAANAA4AEgCDABQArQIWABcAGACFABwAHQAeADoAIACuAiMAWQAlAK8CiACwAooArwKWAMgAAwACAJcAmACxApoAsgKWAMgAAwACAJcAmACxApoAsgKWAMgAAwACAJcAmACxApoAsgKWAMgAAwACAJcAmACxApoAsgKCAMcADAANAA4AEgCzAhQAtA'
..'IWABcAGAC1AhwAHQAeADoAIAC2AiMAWQAlALcCiAC4AooAtwKWAM0AAwACAJcAmACxApoAsgKWAM0AAwACAJcAmACxApoAsgKWAM0AAwACAJcAmACxApoAsgKWAM0AAwACAJcAmACxApoAsgKCAMcADAANAA4AEgC5AhQArQIWABcAGAC6AhwAHQAeADoAIACuAiMAWQAlALsCiAC8AooAuwKWANIAAwACAJcAmACxApoAsgKWANIAAwACAJcAmACxApoAsgKWANIAAwACAJcAmACxApoAsgKW'
..'ANIAAwACAJcAmACxApoAsgKWANIAAwACAJcAmACxApoAsgIBAMUAAgACAL0CBAC+Ar8CxQACAMACwQJGAMICNgDEABMAAgDDAg0ADgAPABAAEQAQABIAgwAUAMQCGACFADgApgIaABAAGwAQABwAHQAeAMUCIADGAiIAEAAjAMcCJQCqAicAEAAoACkARwIsAAEA2gACAAIAqwIEAMgCAQDbAAEABADIAoIA3AAMAA0ADgASAIMAFADJAhYAFwAYAIUAHAAdAB4AygIgAMsCIwDKAiUArwKIAL'
..'ACigCvApYA3QADAAIAlwCYALECmgCyApYA3QADAAIAlwCYALECmgCyApYA3QADAAIAlwCYALECmgCyApYA3QADAAIAlwCYALECmgCyApEC3QACAJgAzAKaAM0CggDcAAwADQAOABIAswIUAM4CFgAXABgAtQIcAB0AHgDKAiAAzwIjAMoCJQC3AogAuAKKALcClgDjAAMAAgCXAJgAsQKaALIClgDjAAMAAgCXAJgAsQKaALIClgDjAAMAAgCXAJgAsQKaALIClgDjAAMAAgCXAJgAsQKaALIC'
..'ggDcAAwADQAOABIAuQIUAMkCFgAXABgAugIcAB0AHgDKAiAAywIjAMoCJQC7AogAvAKKALsClgDoAAMAAgCXAJgAsQKaALIClgDoAAMAAgCXAJgAsQKaALIClgDoAAMAAgCXAJgAsQKaALIClgDoAAMAAgCXAJgAsQKaALIClgDoAAMAAgCXAJgAsQKaALICAQDaAAIAAgC9AgQAvgK/AtoAAgDAAtACRgDCAjYAxAATAAIA0QINAA4ADwAQABEAEAASAIMAFADSAhgAhQA4ANMCGgAQABsAEA'
..'AcAB0AHgCnAiAA1AIiABAAIwCpAiUA1QInABAAKAApAEcCLAABAPAAAgACAL0CBAC+AgEA8AACAAIAqwIEANYCAQDyAAEABADWAoIA8wAMAA0ADgASAIMAFADXAhYAFwAYAIUAHAAdAB4AOgAgANgCIwBZACUArwKIALACigCvApYA9AADAAIAlwCYALECmgCyApYA9AADAAIAlwCYALECmgCyApYA9AADAAIAlwCYALECmgCyApYA9AADAAIAlwCYALECmgCyApEC9AACAJgAzAKaANkCggDz'
..'AAwADQAOABIAswIUANoCFgAXABgAtQIcAB0AHgA6ACAA2wIjAFkAJQC3AogAuAKKALcClgD6AAMAAgCXAJgAsQKaALIClgD6AAMAAgCXAJgAsQKaALIClgD6AAMAAgCXAJgAsQKaALIClgD6AAMAAgCXAJgAsQKaALICggDzAAwADQAOABIAuQIUANcCFgAXABgAugIcAB0AHgA6ACAA2AIjAFkAJQC7AogAvAKKALsClgD/AAMAAgCXAJgAsQKaALIClgD/AAMAAgCXAJgAsQKaALIClgD/AA'
..'MAAgCXAJgAsQKaALIClgD/AAMAAgCXAJgAsQKaALIClgD/AAMAAgCXAJgAsQKaALICvwLwAAIAwALQAkYAwgI2AMQAEwACANwCDQAOAA8AEAARABAAEgCDABQA3QIYAIUAOACmAhoAEAAbABAAHAAdAB4AxQIgAN4CIgAQACMAxwIlAKoCJwAQACgAKQBHAiwAAQAGAQIAAgCrAgQA3wIBAAcBAQAEAN8CggAIAQwADQAOABIAgwAUAOACFgAXABgAhQAcAB0AHgDKAiAA4QIjAMoCJQCvAogA'
..'sAKKAK8ClgAJAQMAAgCXAJgAsQKaALIClgAJAQMAAgCXAJgAsQKaALIClgAJAQMAAgCXAJgAsQKaALIClgAJAQMAAgCXAJgAsQKaALICggAIAQwADQAOABIAswIUAOICFgAXABgAtQIcAB0AHgDKAiAA4wIjAMoCJQC3AogAuAKKALcClgAOAQMAAgCXAJgAsQKaALIClgAOAQMAAgCXAJgAsQKaALIClgAOAQMAAgCXAJgAsQKaALIClgAOAQMAAgCXAJgAsQKaALICggAIAQwADQAOABIAuQ'
..'IUAOACFgAXABgAugIcAB0AHgDKAiAA4QIjAMoCJQC7AogAvAKKALsClgATAQMAAgCXAJgAsQKaALIClgATAQMAAgCXAJgAsQKaALIClgATAQMAAgCXAJgAsQKaALIClgATAQMAAgCXAJgAsQKaALIClgATAQMAAgCXAJgAsQKaALICAQAGAQIAAgC9AgQAvgK/AgYBAgDAAsECRgDCAgsAAgAXAAIA5AINAA4ADwAQABEAEAASAOUCFADmAhYAFwAYAOcCOADoAhoAiwIbABAAHAAdAB4A6QIg'
..'AOoCIgAQACMA6wIlAOwCJwCLAigAKQAqABcAKwAsAC0ALAAuACwA7QIbAQMAAgDuAu8C8ALxAikAXQAcAQEAAgDyAvMCHQEBAAIA9AL1Ah4BAQACAPYC9QIeAQEAAgD3AvUCHgEBAAIA+AL5Ah4BAgACAPoCoQIOAO0CGwECAAIA+wLxAikAXQAjAQEAAgDyAvMCJAEBAAIA9AL1AiUBAQACAPYC9QIlAQEAAgD3AvUCJQEBAAIA+AL5AiUBAgACAPoCoQIOAO0CGwECAAIAYADxAikAXQAqAQ'
..'EAAgDyAvMCKwEBAAIA9AL1AiwBAQACAPYC9QIsAQEAAgD3AvUCLAEBAAIA+AL5AiwBAgACAPoCoQIOAO0CGwECAAIA/ALxAikAXQAxAQEAAgDyAvMCMgEBAAIA9AL1AjMBAQACAPYC9QIzAQEAAgD3AvUCMwEBAAIA+AL5AjMBAgACAPoCoQIOAO0CGwECAAIA/QLxAikAXQA4AQEAAgDyAvMCOQEBAAIA9AL1AjoBAQACAPYC9QI6AQEAAgD3AvUCOgEBAAIA+AL5AjoBAgACAPoCoQIOAO0C'
..'GwEEAAIA/gL/AgAD7wIBA/ECAgNdAD8BAQACAPIC8wJAAQEAAgD0AvkCQQECAAIAAwOhAg4A9QJBAQEAAgD2Au0CGwEFAAIAAwMEAw4A/wIAA+8CBQPxAgIDXQBEAQEAAgDyAvMCRQEBAAIA9AL5AkYBAgACAAMDoQIOAPUCRgEBAAIA9gIGA0QBAwAHAxAACAMsAAkDLABdABsBAADtAhsBAgACAAoD8QIpAF0ASwEBAAIA8gLzAkwBAQACAPQC9QJNAQEAAgD2AvUCTQEBAAIA9wL1Ak0BAQ'
..'ACAPgC+QJNAQIAAgD6AqECDgDtAhsBBAACAAsD/wIAA+8CDAPxAikABgNSAQMABwNEAAgDLAAJAywAXQAbAQIAAgANA6ECDgBdAFQBAQACAA4DDwMCAAEAAgAQA/MCVgEBAAIAEQP1AlcBAQACABIDEwNXAQEAAgAUAxUDWQEBAAIAFgMVA1kBAQACABcDFQNZAQEAAgAtABgDWQEBAAIAGQMVA1kBAQACABoDFQNZAQEAAgAbAxUDWQEBAAIAHAMVA1kBAQACAB0DFQNZAQEAAgDuAlsAWQEB'
..'AAIAHgNbAFkBAQACAB8DWwBZAQEAAgAgAyEDWQEBAAIAIgNbAFkBAQACACMDWwBZAQEAAgAkA1sAWQEBAAIAJQNbAFcBAQACACYDWwBXAQEAAgAnA/kCVwEBAAIAKAMPA1YBAQACACkDEwNWAQEAAgAqAysDbgEGAAIALANOAJIBUAApAC0DLAAlAGsALgPwAfkCbwEBAAIALwMrA28BCAACADADTgDtAVAA0gAtAywAjwEOACAAMQMlADIDLgPwAeoBcQENAAIAMwNOAJIBUADSAC0DLAAlAG'
..'sANAMXAC4DDALvAYsC8QE1A/MBkgH0ATYD9gE3AzgDLADqAXEBDQACADkDTgCSAVAAKQAtAywAIAA6AzQDFwAuA/AB7wGLAvEBOwPzAUAA9AE8A/YBPQM4Az4D6gFxAQ0AAgA/A04AkgFQACkALQMsACAAQAMuA/AB7wFEAPEBQQPzAZIB9AFCA/YBPQM4Az4DQwMpAOoBcQENAAIARANOAJIBUAApAC0DLAAgAEUDLgPwAe8BRADxAUYD8wGSAfQBRwP2AT0DOAM+A0MDLAArA3EBCAACAEgD'
..'TgCSAVAAKQAtAywAjwEOACAASQMlAEoDLgPwAUsDdgEMAAIATANOAJIBLQMsACAATQMlAE4DLgPwAe8B8AHxAUwD8wE9A/QBQgM4Az4DTwNLAEsDdgEMAAIAUANOAJIBLQMsACAAUQMlAE4DLgPwAe8B8AHxAVAD8wE9A/QBQgM4Az4DTwNLAEsDdgEMAAIAUgNOAJIBLQMsACAAUwMlAE4DLgPwAe8B8AHxAVID8wE9A/QBQgM4Az4DTwNLACsDdgEFAAIAVANOAJIBLQMsACUAVQMuA/ABKw'
..'NxAQcAAgBWA04AkgFQACkALQMsACAAVwMlAFgDLgPwAeoBewENAAIAWQNOAJIBUAApAC0DLAAgAFoDLgPwAe8BiwLxAVsD8wGSAfQBPAP2AT0DOAM+A0MDKQBcA3wBCgACAF0DTgDtAVAA0gAtAywAIABeAyUAXwNgA2ED6AFiA2MDHQJkA2ED6gF7AQ0AAgBlA04AkgFQACkALQMsACAAZgMuA/AB7wGLAvEBWwPzAZIB9AE8A/YBPQM4Az4DQwMpAFwDfgEKAAIAXQNOAO0BUADSAC0DLAAg'
..'AF4DJQBfA2ADYQPoAWIDYwMdAmQDYQPqAXsBDQACAGcDTgCSAVAAKQAtAywAIABoAy4D8AHvAYsC8QFbA/MBkgH0ATwD9gE9AzgDPgNDAykAXAOAAQoAAgBdA04A7QFQANIALQMsACAAXgMlAF8DYANhA+gBYgNjAx0CZANhA+oBewENAAIAaQNOAJIBUAApAC0DLAAgAGoDLgPwAe8BiwLxAVsD8wGSAfQBPAP2AT0DOAM+A0MDKQBcA4IBCgACAF0DTgDtAVAA0gAtAywAIABeAyUAXwNgA2'
..'ED6AFiA2MDHQJkA2ED6gF7AQ0AAgBrA04AkgFQACkALQMsACAAbAMuA/AB7wGLAvEBbQPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAG4DLgPwAe8BiwLxAW8D8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIABwAy4D8AHvAYsC8QFxA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAAcgMuA/AB'
..'7wGLAvEBcwPzAZIB9AE8A/YBPQM4Az4DQwMpAEsDewEKAAIAdANOAO0BUADSAC0DLAAgAHUDJQB2Ay4D8AHvAfAB8wGSAfQBQgNLA3sBCgACAHcDTgDtAVAA0gAtAywAIAB4AyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgB5A04A7QFQANIALQMsACAAegMlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEKAAIAewNOAO0BUADSAC0DLAAgAHwDJQB2Ay4D8AHvAfAB8wGSAfQBQgNLA3sBCg'
..'ACAH0DTgDtAVAA0gAtAywAIAB+AyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgB/A04A7QFQANIALQMsACAAgAMlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEKAAIAgQNOAO0BUADSAC0DLAAgAIIDJQB2Ay4D8AHvAfAB8wGSAfQBQgNLA3sBCgACAIMDTgDtAVAA0gAtAywAIACEAyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgCFA04A7QFQANIALQMsACAAhgMlAHYDLgPwAe8B8AHz'
..'AZIB9AFCA+oBewENAAIAawNOAJIBUAApAC0DLAAgAIcDLgPwAe8BiwLxAYgD8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIACJAy4D8AHvAYsC8QGKA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAAiwMuA/AB7wGLAvEBjAPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAI0DLgPwAe8BiwLxAY'
..'4D8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIACPAy4D8AHvAYsC8QGQA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAAkQMuA/AB7wGLAvEBkgPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAJMDLgPwAe8BiwLxAZQD8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywA'
..'IACVAy4D8AHvAYsC8QEzAPMBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAAlgMuA/AB7wGLAvEBGwPzAZIB9AE8A/YBPQM4Az4DQwMpAEsDewEMAAIAlwNNABcATgDtAVAA0gAtAywAIACYA1MAFwAlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEMAAIAmQNNABcATgDtAVAA0gAtAywAIACaA1MAFwAlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEMAAIAmwNNABcATg'
..'DtAVAA0gAtAywAIACcA1MAFwAlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEMAAIAnQNNABcATgDtAVAA0gAtAywAIACeA1MAFwAlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewENAAIAnwNNABcATgCgA1AA0gAtAywAIAChA1MAFwAlAHYDLgPwAe8B8AHxAaID8wGjA/QBQgNLA3sBCgACAKQDTgDtAVAA0gAtAywAIAClAyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgCmA04A7QFQANIALQMs'
..'ACAApwMlAHYDLgPwAe8B8AHzAZIB9AFCA+oBewENAAIAawNOAJIBUAApAC0DLAAgAKgDLgPwAe8BiwLxAYwD8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIACpAy4D8AHvAYsC8QGOA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAAqgMuA/AB7wGLAvEBkAPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC'
..'0DLAAgAKsDLgPwAe8BiwLxAZID8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIACsAy4D8AHvAYsC8QGUA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAArQMuA/AB7wGLAvEBMwDzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAK4DLgPwAe8BiwLxARsD8wGSAfQBPAP2AT0DOAM+A0MDKQBLA3sB'
..'CgACAK8DTgDtAVAA0gAtAywAIACwAyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgCxA04A7QFQANIALQMsACAAsgMlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEKAAIAswNOAO0BUADSAC0DLAAgALQDJQB2Ay4D8AHvAfAB8wGSAfQBQgNLA3sBCgACAB8DTgDtAVAA0gAtAywAIAC1AyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgCOA04A7QFQANIALQMsACAAtgMlAHYDLgPwAe8B8A'
..'HzAZIB9AFCA0sDewEKAAIAtwNOAO0BUADSAC0DLAAgALgDJQB2Ay4D8AHvAfAB8wGSAfQBQgNLA3sBCgACALkDTgDtAVAA0gAtAywAIAC6AyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgC7A04A7QFQANIALQMsACAAvAMlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEKAAIAvQNOAO0BUADSAC0DLAAgAL4DJQB2Ay4D8AHvAfAB8wGSAfQBQgNLA3sBCgACAL8DTgDtAVAA0gAtAywAIADA'
..'AyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgDBA04A7QFQANIALQMsACAAwgMlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEKAAIAwwNOAO0BUADSAC0DLAAgAMQDJQB2Ay4D8AHvAfAB8wGSAfQBQgNLA3sBCgACAMUDTgDtAVAA0gAtAywAIADGAyUAdgMuA/AB7wHwAfMBkgH0AUIDSwN7AQoAAgDuAk4A7QFQANIALQMsACAAxwMlAHYDLgPwAe8B8AHzAZIB9AFCA0sDewEKAAIAGwNOAO'
..'0BUADSAC0DLAAgAMgDJQB2Ay4D8AHvAfAB8wGSAfQBQgPqAXsBDQACAGsDTgCSAVAAKQAtAywAIADJAy4D8AHvAYsC8QHKA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAAywMuA/AB7wGLAvEBigPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAMwDLgPwAe8BiwLxAYgD8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsD'
..'TgCSAVAAKQAtAywAIADNAy4D8AHvAYsC8QGMA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAAzgMuA/AB7wGLAvEBjgPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAM8DLgPwAe8BiwLxAZAD8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIADQAy4D8AHvAYsC8QGSA/MBkgH0ATwD9gE9AzgDPg'
..'NDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAA0QMuA/AB7wGLAvEB0gPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgANMDLgPwAe8BiwLxAdQD8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIADVAy4D8AHvAYsC8QHWA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAA1wMuA/AB7wGLAvEB2APz'
..'AZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgANkDLgPwAe8BiwLxAdoD8wGSAfQBPAP2AT0DOAM+A0MDKQDqAXsBDQACAGsDTgCSAVAAKQAtAywAIADbAy4D8AHvAYsC8QHcA/MBkgH0ATwD9gE9AzgDPgNDAykA6gF7AQ0AAgBrA04AkgFQACkALQMsACAA3QMuA/AB7wGLAvEBMwDzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAN'
..'4DLgPwAe8BiwLxARsD8wGSAfQBPAP2AT0DOAM+A0MDKQBLA3sBCgACAN8DTgDtAVAA0gAtAywAIADgAyUAdgMuA/AB7wHwAfMBkgH0AUID6gF7AQ0AAgBrA04AkgFQACkALQMsACAA4QMuA/AB7wGLAvEB4gPzAZIB9AE8A/YBPQM4Az4DQwMpAOoBewENAAIAawNOAJIBUAApAC0DLAAgAOMDLgPwAe8BiwLxAcoD8wGSAfQBPAP2AT0DOAM+A0MDKQBLA3sBCgACAOQDTgDtAVAA0gAtAywA'
..'IADlAyUAdgMuA/AB7wHwAfMBkgH0AUIDSwNvAQ4AAgDmA04A5wNQANIAUQDoAy0DLAAgAOkDJQDqAy4DRADvASkA8QFGA/MBkgH0AesD9gHsA08DSwD5Am4BAQACAO0D7gPLAQEAAgDvA10AzAECAAIA8AOhAg4A7QLLAQUAAgDxAwQDDgD/AiwA7wLyA/ECAAMVA84BAgACAPMD9AMpABUDzgECAAIA9QP0A/YDKwNuAQUAAgD3A04AkgFQACkALQMsACUAawD5AtEBAQACAPgDKwPRAQQAAg'
..'D5A04AkgEtAywAIAD6AysD0wEEAAIA+wNOAJIBLQMsACMA/AMrA9QBBgBOAEAAUADiAC0DLAAgAP0DJQD+Ay4DSwArA9EBBAACAP8DTgCSAS0DLAAgAAAEKwPWAQQAAgD7A04AkgEtAywAIwD8AysD1wEGAE4AQABQAOIALQMsACAA/QMlAP4DLgNLACsD0QEFAAIAAQROAJIBLQMsACMA/AM0AxcAKwPZAQUATgCSAVAA4gAtAywAIAACBCUAAwTqAdkBDgACAAQETgCSAVAAKQAtAywAIAAF'
..'BCMABgQ0AxcA7wFLAPEBBwTzAZIB9AE8A/YBCAQ4AwADCQTiAOoB0QEMAAIAGgNOAJIBUAApAC0DLAAgAAoE7wFLAPEBCwTzAZIB9AF0AvYBCAQ4AwADCQTiAOoB0QEOAAIAIwNOAJIBUAApAC0DLAAgAAwENAMXAO8BSwDxASMD8wHnA/QBPAP2AecDOAMAAwkE4gBDAykA6gHRAQ4AAgAfA04AkgFQACkALQMsACAADQQ0AxcA7wFLAPEBDgTzAQ8E9AEQBPYBDwQ4AwADCQTiAEMDKQDqAd'
..'EBDgACAB4DTgCSAVAAKQAtAywAIAARBDQDFwDvAUsA8QEeA/MB5wP0ATwD9gHnAzgDAAMJBOIAQwMpAOoB0QENAAIAEgROAOcDUADSAC0DLAAgABMEJQAUBO8BSwDxARUE8wGSAfQBPAP2AecDOAMAAwkE4gBLA9EBDwACABYETgCSAVAAKQAtAywAIAAXBCUATgMuA0sA7wFLAPEBGATzAZIB9AEQBPYBCAQ4AwADCQTiAEMDKQDqAdEBDgACACMDTgCSAVAAKQAtAywAIAAZBDQDFwDvAUsA'
..'8QEjA/MB5wP0ATwD9gHnAzgDAAMJBOIAQwMpAPkCbgEBAAIAGgT5Am4BAQACABsE7gPkAQEAAgAcBF0A5QECAAIA8AOhAg4A+QJuAQEAAgAdBO4D5wEBAAIAHgRdAOgBAgACAPADoQIOAO0C6AEFAAIAHwQEAw4AIAQhBO8CIgTxAiwAIwTqAQIAJAQlBCYEEAAnBOgBDAACACgEKQQqBCsEDAIsBC0EkAEpAC4ELAAvBDAEJQAxBBYEMgQzBDQENQQ2BCgANwT5Am4BAQACADgESABuAQIAAg'
..'A5BOgBOgQrA+4BBgACAPcDTgCSAVAAKQBRABkALQMsACUAawArA+8BBQACAPkDTgCSAVEAGQAtAywAIAD6AysD8AEFAAIA+wNOAJIBUQAZAC0DLAAjAPwDKwPxAQcATgBAAFAA4gBRABkALQMsACAA/QMlAP4DLgNLACsD7wEFAAIA/wNOAJIBUQAZAC0DLAAgAAAEKwPzAQUAAgD7A04AkgFRABkALQMsACMA/AMrA/QBBwBOAEAAUADiAFEAGQAtAywAIAD9AyUA/gMuA0sAKwPvAQYAAgAB'
..'BE4AkgFRABkALQMsACMA/AM0AxcAKwP2AQYATgCSAVAA4gBRABkALQMsACAAAgQlAAME6gH2AQ8AAgAEBE4AkgFQACkAUQAZAC0DLAAgAAUEIwAGBDQDFwDvAUsA8QEHBPMBkgH0ATwD9gE7BDgDAAMJBOIA6gHvAQ0AAgAaA04AkgFQACkAUQAZAC0DLAAgAAoE7wFLAPEBCwTzAZIB9AF0AvYBOwQ4AwADCQTiAOoB7wEPAAIAIwNOAJIBUAApAFEAGQAtAywAIAAMBDQDFwDvAUsA8QEjA/'
..'MB5wP0ATwD9gHnAzgDAAMJBOIAQwMpAOoB7wEPAAIAHwNOAJIBUAApAFEAGQAtAywAIAANBDQDFwDvAUsA8QEOBPMBPAT0ARAE9gE8BDgDAAMJBOIAQwMpAOoB7wEPAAIAHgNOAJIBUAApAFEAGQAtAywAIAARBDQDFwDvAUsA8QEeA/MB5wP0ATwD9gHnAzgDAAMJBOIAQwMpAOoB7wEOAAIAEgROAOcDUADSAFEAGQAtAywAIAATBCUAFATvAUsA8QEVBPMBkgH0ATwD9gHnAzgDAAMJBOIA'
..'SwPvARAAAgAWBE4AkgFQACkAUQAZAC0DLAAgABcEJQBOAy4DSwDvAUsA8QEYBPMBkgH0ARAE9gE7BDgDAAMJBOIAQwMpAOoB7wEPAAIAIwNOAJIBUAApAFEAGQAtAywAIAAZBDQDFwDvAUsA8QEjA/MB5wP0ATwD9gHnAzgDAAMJBOIAQwMpAOoB7wEMAAIAPQROAJIBUAApAC0DLAAgAD4E7wEMAvEBPwTzAZIB9AE8A/YBQAQ4AwADCQTiAPkC7wEBAAIA+ANdAFYBAQACAEEEDwMCAgEAAg'
..'BCBAEAAgACAAIAQwQEAL4CXQABAAAAcQACAAcAIQADAAcAIQAHAAcADgAIAAcADgAVAAcAIQAWAAcAIQAxAJwAMAAxAJ0ASQA2AJwANQA2AJ0AZAA5AJwAOAA5AJ0AVAA7AJwAOgA7AJ0APAA9AJwAPAA9AJ0AQgA/AJwAPgA/AJ0AsQBEAJwAQwBEAJ0ATABHAJwARgBHAJ0AXgBKAJwASQBKAJ0ApwBNAJwATABNAJ0AWQBPAJwATgBPAJ0ANQBRAJwAUABRAJ0ALgBTAJwAUgBTAJ0AOABV'
..'AJwAVABVAJ0AWABXAJwAVgBXAJ0AdwBaAJwAWQBaAJ0AWwBgAJwAXwBgAJ0AbgBoAJwAZwBoAJ0AVgBvAJwAbgBvAJ0ATgB1AJwAdAB1AJ0AZwB4AJwAdwB4AJ0AJgB5AJwAdwB5AJ0AIQCaAAcAnQC6AJwAuQC6AJ0AtwC+AJwAvAC+AJ0AuwDJAJwAyADKAJwAyADLAJwAyADMAJwAyADOAJwAzQDPAJwAzQDQAJwAzQDRAJwAzQDTAJwA0gDUAJwA0gDVAJwA0gDWAJwA0gDXAJwA0gDXAJ'
..'0AyADeAJwA3QDfAJwA3QDgAJwA3QDhAJwA3QDiAJ0A3QDkAJwA4wDlAJwA4wDmAJwA4wDnAJwA4wDpAJwA6ADqAJwA6ADrAJwA6ADsAJwA6ADtAJwA6ADtAJ0A3QD1AJwA9AD2AJwA9AD3AJwA9AD4AJwA9AD5AJ0A9AD7AJwA+gD8AJwA+gD9AJwA+gD+AJwA+gAAAZwA/wABAZwA/wACAZwA/wADAZwA/wAEAZwA/wAEAZ0A9AAKAZwACQELAZwACQEMAZwACQENAZwACQEPAZwADgEQAZwA'
..'DgERAZwADgESAZwADgEUAZwAEwEVAZwAEwEWAZwAEwEXAZwAEwEYAZwAEwEYAZ0ACQE=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
