-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 35580 characters

local ScriptFunctions = {
function(script,require)
repeat wait() until game.Players.LocalPlayer.Character
local rs = game:GetService('RunService').RenderStepped
local cam = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local char = player.Character
_G.tweeningFov = false

local Utilities = {}

--[[Utilities.tweenFoV = function(FOV,step)
	coroutine.resume(coroutine.create(function()
   		local fv0 = cam.FieldOfView
    	for i = 0,90,step do
        	local r = ((math.sin(math.rad(i))+1)/2)
        	cam.FieldOfView = (Vector3.new(fv0,0,0):Lerp(Vector3.new(FOV,0,0),r).X)
        	rs:wait()
    	end
	end))
end]]--

Utilities.tweenFoV = function(goal, frames)
	if not _G.tweeningFov then
		coroutine.resume(coroutine.create(function()
			SFn = SFn and SFn + 1 or 0 
			local SFn_S = SFn
			for i = 1, frames do
				if SFn ~= SFn_S then break end
					cam.FieldOfView = cam.FieldOfView + (goal - cam.FieldOfView) * (i / frames)
					game:GetService("RunService").RenderStepped:wait()
					--_G.tweeningFov = true
				end
			--_G.tweeningFov = false
		end))
	end
end

Utilities.tweenRoll = function(Roll,step)
	coroutine.resume(coroutine.create(function()
   		local r0 = cam:GetRoll()
    	for i = -90,90,step do
        	local r = ((math.sin(math.rad(i))+1)/2)
        	cam:SetRoll(Vector3.new(r0,0,0):Lerp(Vector3.new(Roll,0,0),r).X)
        	rs:wait()
    	end
	end))
end

Utilities.Fade = function(target, goal, frames, IsGui)
	coroutine.resume(coroutine.create(function()
		for i = 1, frames do
			if IsGui == true then
				target.TextTransparency = target.TextTransparency + (goal - target.TextTransparency) * (i / frames)
				rs:wait()
			elseif IsGui == false then
				target.Size = target.Size + (goal - target.Size) * (i / frames)
				rs:wait()
			end
		end
	end))
end

Utilities.FixCam = function()
	cam.CameraSubject = player.Character.Humanoid
	cam.CameraType = "Custom"
	player.Character.Humanoid.WalkSpeed = 16
end

Utilities.SpawnCam = function(Target)
	cam.CameraType = "Attach"
	cam.CameraSubject = Target
	wait(.05)
	cam.CoordinateFrame = Target.CFrame
	cam.CameraType = "Scriptable"
	player.Character.Humanoid.WalkSpeed = 0
end

Utilities.tweenCam = function(CO, t)
 coroutine.resume(coroutine.create(function()
  COn = COn and COn + 1 or 0 local COn_S = COn
  for i = 1, t do
   if COn ~= COn_S then break end
   char.Humanoid.CameraOffset = char.Humanoid.CameraOffset + (CO - char.Humanoid.CameraOffset) * (i / t)
   rs:wait()
  end
 end))
end

Utilities.TweenJoint = function(Joint, newC0, newC1, Alpha, Duration)
	spawn(function()
		local newCode = math.random(-1e9, 1e9) --This creates a random code between -1000000000 and 1000000000
		local tweenIndicator = nil
		if (not Joint:findFirstChild("tweenCode")) then --If the joint isn't being tweened, then
			tweenIndicator = Instance.new("IntValue")
			tweenIndicator.Name = "tweenCode"
			tweenIndicator.Value = newCode
			tweenIndicator.Parent = Joint
		else
			tweenIndicator = Joint.tweenCode
			tweenIndicator.Value = newCode --If the joint is already being tweened, this will change the code, and the tween loop will stop
		end
		if Duration <= 0 then --If the duration is less than or equal to 0 then there's no need for a tweening loop
			if newC0 then Joint.C0 = newC0 end
			if newC1 then Joint.C1 = newC1 end
		else
			local Increment = 1.5 / Duration --Calculate the increment here so it doesn't need to be calculated in the loop
			local startC0 = Joint.C0
			local startC1 = Joint.C1
			local X = 0
			while true do
				rs:wait() --This makes the for loop step every 1/60th of a second
				local newX = X + Increment
				X = (newX > 90 and 90 or newX) --Makes sure the X never goes above 90
				if tweenIndicator.Value ~= newCode then break end --This makes sure that another tween wasn't called on the same joint
				if newC0 then Joint.C0 = startC0:lerp(newC0, Alpha(X)) end
				if newC1 then Joint.C1 = startC1:lerp(newC1, Alpha(X)) end
				if X == 90 then break end --If the tweening is done...
			end
		end
		if tweenIndicator.Value == newCode then --If this tween functions was the last one called on a joint then it will remove the code
			tweenIndicator:Destroy()
		end
	end)	
end

Utilities.Weld = function(p1, p2, c0)
	local w = Instance.new("Motor6D", p1)
	w.Part0 = p1
	w.Part1 = p2
	w.Name = p1.Name
	w.C0 = c0 or p1.CFrame:inverse() * p2.CFrame
	return w
end

return Utilities
end,
function(script,require)
local Spring = {}

function Spring.new(Initial)
	local t0 = tick()
	local p0 = Initial or 0
	local v0 = Initial and Vector3.new() or 0
	local t	= Initial or 0
	local d	= 1
	local s	= 1

	local function positionVelocity(Tick)
		local x	= Tick - t0
		local c0 = p0 - t
		if s == 0 then
			return p0, 0
		elseif d < 1 then
			local c	= math.sqrt(1 - d ^ 2)
			local c1 = (v0 / s + d * c0) / c
			local co = math.cos(c * s * x)
			local si = math.sin(c * s * x)
			local e	= math.exp(d * s * x)
			return t + (c0 * co + c1 * si) / e,
				s * ((c * c1 - d * c0) * co - (c * c0 + d * c1) * si) / e
		else
			local c1 = v0 / s + c0
			local e	= math.exp(s * x)
			return t + (c0 + c1 * s * x) / e,
				s * (c1 - c0 - c1 * s * x) / e
		end
	end

	return setmetatable(
		{
			accelerate = function(_, acceleration)
				local T = tick()
				local p, v = positionVelocity(T)
				p0 = p
				v0 = v + acceleration
				t0 = T
			end;
		},
		{
			__index = function(_, index)
				if index == "value" or index == "position" or index == "p" then
					local p, v = positionVelocity(tick())
					return p
				elseif index == "velocity" or index == "v" then
					local p, v = positionVelocity(tick())
					return v
				elseif index == "acceleration" or index == "a" then
					local x	= tick() - t0
					local c0 = p0 - t
					if s == 0 then
						return 0
					elseif d < 1 then
						local c = math.sqrt(1 - d ^ 2)
						local c1 = (v0 / s + d * c0) / c
						local cs = (c0 * d ^ 2 - 2 * c * d * c1 - c0 * c ^ 2) * math.cos(c * s * x)
						local sn = (c1 * d ^ 2 + 2 * c * d * c0 - c1 * c ^ 2) * math.sin(c * s * x)
						return s ^ 2 *(cs + sn) / math.exp(d * s * x)
					else
						local c1 = v0 / s + c0
						return s ^ 2 * (c0 - 2 * c1 + c1 * s * x) / math.exp(s * x)
					end
				elseif index == "target" or index == "t" then
					return t
				elseif index == "damper" or index == "d" then
					return d
				elseif index == "speed" or index == "s" then
					return s
				elseif index == "magnitude" or index == "m" then
					local p, v = positionVelocity(tick())
					return p.magnitude
				else
					error(index.." is not a valid member of spring", 0)
				end
			end;
			
			__newindex = function(_, index, value)
				local T = tick()
				if index == "value" or index == "position" or index == "p" then
					local p, v = positionVelocity(T)
					p0, v0 = value, v
				elseif index == "velocity" or index == "v" then
					local p, v = positionVelocity(T)
					p0, v0 = p, value
				elseif index == "acceleration" or index == "a" then
					local p, v = positionVelocity(T)
					p0, v0 = p, v + value
				elseif index == "target" or index == "t" then
					p0, v0 = positionVelocity(T)
					t = value
				elseif index == "damper" or index == "d" then
					p0, v0 = positionVelocity(T)
					d = value < 0 and 0 or value < 1 and value or 1
				elseif index == "speed" or index == "s" then
					p0, v0 = positionVelocity(T)
					s = value < 0 and 0 or value
				else
					error(index.." is not a valid member of spring", 0)
				end
				t0 = T
			end;
		}
	)
end

return Spring
end,
function(script,require)
return function(s,t, frames)
	s = {s:components()}
	t = {t:components()}
	for i = 1, 12 do
		s[i] = s[i] + (t[i] - s[i]) * frames
	end
	return CFrame.new(unpack(s))
end
end,
function(script,require)
--[[

	Plugins for this gun kit are basically functions that will run at specific times, i.e. When a key is pressed, when the gun is
	fired, when the gun is aimed, etc.
	
	HOW TO USE IT:
	
		KEYDOWN PLUGIN:
		
			Let's say you wanted to toggle a laser whenever you press the "v" key:
			
			You would create a table like the example below
			The first element would be "Key = INSERT_KEY_HERE"
			The second element would be "Description = INSERT_DESCRIPTION_HERE"
			The third element would be "Plugin = INSERT_FUNCTION_HERE"
			
			So whenever you press the "v" key, the plugin function will run
			
			Pretty useful if you want to add extra code to the script without actually having to modify the script
		
			NOTE: Only the keydown plugin requires this table. Every other plugin just needs a function
			
		EVERY OTHER PLUGIN:
		
			Let's say you wanted to make a shell eject whenever the gun was fired:
			
			You would add function called "Plugin = INSERT_FUNCTION_HERE"
			
			That's it; If you want other stuff to happen when the gun is fired, you would either put it all into 1 function, or
			you would add more Plugins to the "Firing" table. Like so:
			
			Firing = {
				Plugin = function()
					--Code
				end;
				Plugin = function()
					--Code
				end;
				Plugin = function()
					--Code
				end;
			};
	
	That's really it, you just need to know some basic scripting to use it. If you have more questions, pm me.
	
	NOTE: The plugins run seperate from the code in the Gun_Main. For example, if you have a plugin that ejects a shell 1 second
	after the gun is fired, the gun's firing speed won't be affected in any way.
	
--]]

local Gun = script.Parent.Parent.Parent
local player = game.Players.LocalPlayer

local Plugins = {
	
	KeyDown = {
		{ --This is a plugin for a toggleable laser
			Key = "g"; --This is the key you press to activate the plugin
			Description = "Toggle Laser"; --This is what the description of the key will be in the controls
			Plugin = function() --This is the actual plugin function
				local Laser = Gun:WaitForChild("LaserLight") --These few lines wait for the necessary bricks/models
				local Handle = Gun:WaitForChild("Grip")
				local ignoreCode = Gun.Program_Client:WaitForChild("ignoreCode")
				local ignoreModel = game.Workspace:WaitForChild("BulletModel: " .. player.Name)
				local ignoreList = {}
				
				local PlyrName = game.Players:GetPlayerFromCharacter(Gun.Parent).Name
				local playerFolder = ignoreModel
				
				local RS = game:GetService("RunService")
				
				local function createLaserDot() --This function creates the red laser dot
					local laserDot = Instance.new("Part")
					laserDot.Transparency = 1
					laserDot.Name = "laserDot"
					laserDot.Anchored = true
					laserDot.CanCollide = false
					laserDot.FormFactor = Enum.FormFactor.Custom
					laserDot.Size = Vector3.new(0.25, 0.25, 1)
					
					local laserGui = Instance.new("SurfaceGui")
					laserGui.CanvasSize = Vector2.new(100, 100)
					laserGui.Parent = laserDot
					
					local laserImage = Instance.new("ImageLabel")
					laserImage.BackgroundTransparency = 1
					laserImage.Size = UDim2.new(1, 0, 1, 0)
					laserImage.Image = "http://www.roblox.com/asset/?id=131394739"
					laserImage.Parent = laserGui
					
					--[[local laserLight = Instance.new("SurfaceLight")
					laserLight.Angle = 180
					laserLight.Brightness = math.huge
					laserLight.Color = Color3.new(1, 0, 0)
					laserLight.Face = Enum.NormalId.Back
					laserLight.Range = 5
					laserLight.Shadows = true
					laserLight.Parent = laserDot]]
					
					return laserDot
				end
				
				local function getHitSurfaceCFrame(Pos, Obj) --This function returns the proper cframe based on the face that the position is on
					local surfaceCF = {
						{"Back", Obj.CFrame * CFrame.new(0, 0, Obj.Size.z)};
						{"Bottom", Obj.CFrame * CFrame.new(0, -Obj.Size.y, 0)};
						{"Front", Obj.CFrame * CFrame.new(0, 0, -Obj.Size.z)};
						{"Left", Obj.CFrame * CFrame.new(-Obj.Size.x, 0, 0)};
						{"Right", Obj.CFrame * CFrame.new(Obj.Size.x, 0, 0)};
						{"Top", Obj.CFrame * CFrame.new(0, Obj.Size.y, 0)}
					}
					local closestDist = math.huge
					local closestSurface = nil
					for _,v in pairs(surfaceCF) do
						local surfaceDist = (Pos - v[2].p).magnitude
						if surfaceDist < closestDist then
							closestDist = surfaceDist
							closestSurface = v
						end
					end
					
					local surfaceDir = CFrame.new(Obj.CFrame.p, closestSurface[2].p)
					local surfaceDist = surfaceDir.lookVector * ((Obj.CFrame.p - closestSurface[2].p).magnitude / 2 - 0.25)
					local surfaceOffset = Pos - closestSurface[2].p + surfaceDist
					local surfaceCFrame = surfaceDir + surfaceDist + surfaceOffset
					
					return surfaceCFrame
				end
				
				local laserDot = createLaserDot() --The code is cleaner when the laser creating code is in a function
				
				Laser.Transparency = (Laser.Transparency == 1 and 0 or 1) --Toggles the laser on or off
				
				while math.floor(Laser.Transparency) == 0 do --This loop will keep running as long as the laser is visible
					if (not game.Players:GetPlayerFromCharacter(Gun.Parent)) then break end --This checks if the gun is a child of the character
					
					local newRay = Ray.new(Laser.Position, Handle.CFrame.lookVector * 999)
					local H, P = game.Workspace:FindPartOnRayWithIgnoreList(newRay, ignoreList)
					
					if H and (H and H.Transparency >= 1 or H.CanCollide == false) then
						table.insert(ignoreList, H)
					end
					
					local Distance = (P - Laser.Position).magnitude
					Laser.Mesh.Offset = Vector3.new(0, Distance / 2, 0)
					Laser.Mesh.Scale = Vector3.new(0.075, Distance / 0.2, 0.075)
					
					if H then
						laserDot.CFrame = getHitSurfaceCFrame(P, H) --If the laser hits a part then position the dot on the part
						laserDot.Parent = playerFolder
					else
						laserDot.Parent = nil --If the laser doesn't hit a part then temporarily remove the laser dor
					end
					
					RS.RenderStepped:wait()
				end
				
				laserDot:Destroy() --These lines reset the laser if the laser is transparent or the gun was deselected
				Laser.Transparency = 1
				Laser.Mesh.Offset = Vector3.new()
				Laser.Mesh.Scale = Vector3.new(0.075, 0, 0.075)
			end;
		};
		
	};
	
}

return Plugins
end,
function(script,require)
local Tool = script.Parent.Parent.Parent

local Settings = {

--// Positioning
	RightArmPos = CFrame.new(-0.902175903, 0.295501232, -1.32277012, 1, 0, 0, 0, 1.19248806e-08, 1, 0, -1, 1.19248806e-08);
	LeftArmPos = CFrame.new(1.06851184, 0.973718464, -2.29667926, 0.787567914, -0.220087856, 0.575584888, -0.615963876, -0.308488727, 0.724860668, 0.0180283934, -0.925416589, -0.378522098);
	GunPos = CFrame.new(0.284460306, -0.318524063, 1.06423128, 1, 0, 0, 0, -2.98023224e-08, -0.99999994, 0, 0.99999994, -2.98023224e-08);
	
--// Holstering
	HolsteringEnabled = false;
	HolsterPos = CFrame.new(0.140751064, 0, -0.616261482, -4.10752676e-08, -0.342020065, 0.939692616, -1.49501727e-08, 0.939692557, 0.342020094, -0.99999994, 0, -4.37113847e-08);

--// Patrol Mode
	PatrolPosR = CFrame.new();
	PatrolPosL = CFrame.new();

--// Explosive Settings
	BlastPressue = 500000;
	BlastRadius = 10;
	DestroyJointRadius = 10;
	ExplosionType = Enum.ExplosionType.NoCraters; -- Might wanna leave it like this

	}

return Settings

end,
function(script,require)
local Tool = script.Parent.Parent.Parent
local Utilize = require(script.Parent.Parent:WaitForChild("Modules"):WaitForChild("Utilities"))
local TweenJoint = Utilize.TweenJoint
local ts = game:GetService('TweenService')
local sConfig = require(script.Parent:WaitForChild('ServerConfig'))

local Settings = {

--// Positioning
	SprintPos = CFrame.new(0, 0, 0, 0.844756603, -0.251352191, 0.472449303, 0.103136979, 0.942750931, 0.317149073, -0.525118113, -0.219186768, 0.822318792);			

--// Ammo Settings			
	Ammo = 30;
	StoredAmmo = 30;
	MagCount = math.huge; --  If you want infinate ammo, set to math.huge EX. MagCount = math.huge;
	ExplosiveAmmo = 10;
	
--// Damage Settings	
	BaseDamage = 42; -- Torso Damage
	LimbDamage = 35; -- Arms and Legs
	ArmorDamage = 35; -- How much damage is dealt against armor (Name the armor "Armor")
	HeadDamage = 61; -- If you set this to 100, there's a chance the player won't die because of the heal script	
	
--// Recoil Settings	
	gunrecoil = -0.5; -- How much the gun recoils backwards when not aiming
	camrecoil = 0.43; -- How much the camera flicks when not aiming
	AimGunRecoil = -0.4; -- How much the gun recoils backwards when aiming
	AimCamRecoil = 0.31; -- How much the camera flicks when aiming
	
	CamShake = 10; -- THIS IS NEW!!!! CONTROLS CAMERA SHAKE WHEN FIRING
	AimCamShake = 8; -- THIS IS ALSO NEW!!!!
	
	Kickback = 3.4; -- Upward gun rotation when not aiming
	AimKickback = 2.2; -- Upward gun rotation when aiming
	
--// Handling Settings		
	Firerate = 60 / 625; -- 60 = 1 Minute, 625 = Rounds per that 60 seconds. DO NOT TOUCH THE 60!
	
	FireMode = 2; -- 1 = Semi, 2 = Auto, 3 = Burst, 4 = Bolt Action, 5 = Shot, 6 = Explosive
	
--// Firemode Settings
	CanSelectFire = true;
	BurstEnabled = false;
	SemiEnabled = false;
	AutoEnabled = true;
	BoltAction = false;
	ExplosiveEnabled = true;
	
--// Firemode Shot Customization
	BurstNum = 3; -- How many bullets per burst
	ShotNum = 5; -- How many bullets per shot
	
--// Aim|Zoom|Sensitivity Customization
	ZoomSpeed = 0.20; -- The lower the number the slower and smoother the tween
	AimZoom = 15; -- Default zoom
	AimSpeed = 0.24;
	UnaimSpeed = 0.20;
	CycleAimZoom = 30; -- Cycled zoom
	MouseSensitivity = 0.25; -- Number between 0.1 and 1
	SensitivityIncrement = 0.05; -- No touchy
	
--// Bullet Physics
	BulletPhysics = Vector3.new(0,55,0); -- Drop fixation: Lower number = more drop
	BulletSpeed = 2500; -- Bullet Speed
	BulletSpread = 0; -- How much spread the bullet has
	
	ExploPhysics = Vector3.new(0,20,0); -- Drop for explosive rounds
	ExploSpeed = 600; -- Speed for explosive rounds
	
	BulletDecay = 10000; -- How far the bullet travels before slowing down and being deleted (BUGGY)
	
--// Probabilities
	JamChance = 0; -- This is percent scaled. For 100% Chance of jamming, put 100, for 0%, 0; and everything inbetween
	TracerChance = 100; -- This is the percen scaled. For 100% Chance of showing tracer, put 100, for 0%, 0; and everything inbetween
	
--// Tracer Vars
	TracerTransparency = 0;	
	TracerLightEmission = 1;
	TracerTextureLength = 0.1;
	TracerLifetime = 0.0005;
	TracerFaceCamera = true;
	TracerColor = BrickColor.new('White');

--// Dev Vars
	CameraGo = true; -- No touchy
	FirstPersonOnly = false; -- SET THIS TO FALSE TO ENABLE THIRD PERSON, TRUE FOR FIRST PERSON ONLY
	TPSMouseIcon = 1415957732; -- Image used as the third person reticle
	
--// Extras
	WalkAnimEnabled = true; -- Set to false to disable walking animation, true to enable
	SwayEnabled = true;	 -- Set to false to disable sway, true to enable
	TacticalModeEnabled = true; -- SET THIS TO TRUE TO TURN ON TACTICAL MODEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

-- Customization
	AntiTK = false; -- Set to false to allow TK and damaging of NPC, true for no TK. (To damage NPC, this needs to be false)
	
	MouseSense = 0.5;

	CanAim = true; -- Allows player to aim
	CanBolt = true; -- When shooting, if this is enabled, the bolt will move (SCAR-L, ACR, AK Series)
	
	LaserAttached = true;
	LightAttached = true;
	TracerEnabled = true;
	
	SprintSpeed = 20;
	
	CanCallout = false;
	SuppressCalloutChance = 0;

--// KeyBindings
	FireSelectKey = Enum.KeyCode.T;
	CycleSightKey = Enum.KeyCode.T;
	LaserKey = Enum.KeyCode.G;
	LightKey = Enum.KeyCode.B;
	InteractKey = Enum.KeyCode.E;
	AlternateAimKey = Enum.KeyCode.Z;
	InspectionKey = Enum.KeyCode.H;
	AttachmentKey = Enum.KeyCode.LeftControl;
	
--// Unused (Don't delete)
	RestMode = false;
	AttachmentsEnabled = true;
	UIScope = false;
	CanSlideLock = false;
		
--// Animations
	
	-- Idle Anim
	IdleAnim = function(char, speed, objs)
		TweenJoint(objs[2],  nil , CFrame.new(-0.902175903, 0.295501232, -1.32277012, 1, 0, 0, 0, 1.19248806e-08, 1, 0, -1, 1.19248806e-08), function(X) return math.sin(math.rad(X)) end, 0.25)
		TweenJoint(objs[3],  nil , CFrame.new(1.06851184, 0.973718464, -2.29667926, 0.787567914, -0.220087856, 0.575584888, -0.615963876, -0.308488727, 0.724860668, 0.0180283934, -0.925416589, -0.378522098), function(X) return math.sin(math.rad(X)) end, 0.25)
		wait(0.18)	
	end;
	
	-- FireMode Anim
	FireModeAnim = function(char, speed, objs)
		TweenJoint(objs[1],  nil , CFrame.new(0.340285569, 0, -0.0787199363, 0.962304771, 0.271973342, 0, -0.261981696, 0.926952124, -0.268561482, -0.0730415657, 0.258437991, 0.963262498), function(X) return math.sin(math.rad(X)) end, 0.25)
		wait(0.1)
		TweenJoint(objs[2],  nil , CFrame.new(0.67163527, -0.310947895, -1.34432662, 0.766044378, -2.80971371e-008, 0.642787576, -0.620885074, -0.258818865, 0.739942133, 0.166365519, -0.965925872, -0.198266774), function(X) return math.sin(math.rad(X)) end, 0.25)
		wait(0.25)
		objs[4]:WaitForChild("Click"):Play()		
	end;
	
	-- Reload Anim
	ReloadAnim = function(char, speed, objs)
			ts:Create(objs[2],TweenInfo.new(0.5),{C1 = CFrame.new(-1.83314121, 0.112866193, -0.954399943, 0.758022368, -0.558526218, -0.336824089, 0.157115281, -0.344846308, 0.925416529, -0.633021891, -0.75440675, -0.173648208)}):Play()
			ts:Create(objs[3],TweenInfo.new(0.5),{C1 = CFrame.new(-0.570892751, 0.765644431, -2.10391617, 0.545084536, -0.836516321, 0.0558858961, -0.482962906, -0.258818835, 0.836516321, -0.685295284, -0.482962966, -0.545084476)}):Play()
			wait(0.2)		
			
			local MagC = objs[4]:clone()
			MagC:FindFirstChild("Mag"):Destroy()
			MagC.Parent = Tool
			MagC.Name = "MagC"
			local MagCW = Instance.new("Motor6D")
			MagCW.Part0 = MagC
			MagCW.Part1 = workspace.CurrentCamera:WaitForChild("Arms"):WaitForChild("Left Arm")
			MagCW.Parent = MagC
			MagCW.C1 = MagC.CFrame:toObjectSpace(objs[4].CFrame)
			objs[4].Transparency = 1
			
			objs[6]:WaitForChild("MagOut"):Play()		
			
			ts:Create(objs[3],TweenInfo.new(0.4),{C1 = CFrame.new(-0.970892727, 0.365644425, -3.30391622, 0.545084536, -0.836516321, 0.0558858961, -0.482962906, -0.258818835, 0.836516321, -0.685295284, -0.482962966, -0.545084476)}):Play()
			ts:Create(objs[2],TweenInfo.new(0.13),{C1 = CFrame.new(-1.83314121, 0.112866193, -1.15439999, 0.758022368, -0.558526218, -0.336824089, 0.157115281, -0.344846308, 0.925416529, -0.633021891, -0.75440675, -0.173648208)}):Play()
			wait(0.1)
			ts:Create(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-1.83314121, 0.112866193, -0.954399943, 0.758022368, -0.558526218, -0.336824089, 0.157115281, -0.344846308, 0.925416529, -0.633021891, -0.75440675, -0.173648208)}):Play()
			ts:Create(objs[3],TweenInfo.new(0.5),{C1 = CFrame.new(-2.63354445, 0.365644455, -0.92290014, -0.0482801795, -0.826441228, 0.560948968, 0.376857162, 0.505025029, 0.776484549, -0.925012231, 0.248886406, 0.287067622)}):Play()
			wait(0.75)
			ts:Create(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-1.98033559, 0.365644455, -1.12859631, -0.281058222, -0.892398655, -0.353031129, -0.101086289, -0.338284373, 0.935598731, -0.954351902, 0.298644274, 0.00486823916)}):Play()
			wait(0.10)
			ts:Create(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.970892727, 0.365644425, -3.30391622, 0.545084536, -0.836516321, 0.0558858961, -0.482962906, -0.258818835, 0.836516321, -0.685295284, -0.482962966, -0.545084476)}):Play()
			wait(0.10)
			objs[6]:WaitForChild('MagIn'):Play()
			ts:Create(objs[3],TweenInfo.new(0.2),{C1 = CFrame.new(-0.570892751, 0.765644431, -2.10391617, 0.545084536, -0.836516321, 0.0558858961, -0.482962906, -0.258818835, 0.836516321, -0.685295284, -0.482962966, -0.545084476)}):Play()
			wait(0.10)
			ts:Create(objs[2],TweenInfo.new(0.13),{C1 = CFrame.new(-1.83314121, 0.112866186, -0.954399943, 0.758022368, -0.558526218, -0.336824089, 0.0448053852, -0.470608532, 0.881203771, -0.650687635, -0.683063805, -0.331706822)}):Play()
			ts:Create(objs[3],TweenInfo.new(0.13),{C1 = CFrame.new(-0.543338716, 0.753075361, -2.10391617, 0.491499543, -0.870869577, -0.00377259403, -0.594625771, -0.338752329, 0.729154944, -0.63627702, -0.356136084, -0.684338093)}):Play()
			wait(0.1)
			MagC:Destroy()
			objs[4].Transparency = 0
		end;

	-- Bolt Anim
		BoltBackAnim = function(char, speed, objs)
			TweenJoint(objs[3],  nil , CFrame.new(-0.833141267, -0.530990303, -1.55439997, 0.642787576, 3.34848629e-08, -0.766044378, 0.766044378, -2.80971371e-08, 0.642787576, 0, -1, -4.37113883e-08), function(X) return math.sin(math.rad(X)) end, 0.45)
			TweenJoint(objs[2],  nil , CFrame.new(2.1115706, -0.937148452, -1.32660568, 0.803367436, 0.238225982, 0.545755446, -0.118667498, -0.834062338, 0.538755715, 0.583539844, -0.497582287, -0.641788721), function(X) return math.sin(math.rad(X)) end, 0.2)
			wait(0.5)
			objs[5]:WaitForChild("BoltBack"):Play()
			TweenJoint(objs[2],  nil , CFrame.new(1.00409043, -1.18411899, -1.32660568, 0.803367436, 0.238225982, 0.545755446, -0.118667498, -0.834062338, 0.538755715, 0.583539844, -0.497582287, -0.641788721), function(X) return math.sin(math.rad(X)) end, 0.25)
			TweenJoint(objs[1],  nil , CFrame.new(0, 0, 0.817838132, 1, 0, 0, 0, 1, 0, 0, 0, 1), function(X) return math.sin(math.rad(X)) end, 0.25)
			TweenJoint(objs[3],  nil , CFrame.new(-0.833141267, -0.854931653, -1.55439997, 0.642787576, 3.34848629e-08, -0.766044378, 0.766044378, -2.80971371e-08, 0.642787576, 0, -1, -4.37113883e-08), function(X) return math.sin(math.rad(X)) end, 0.25)
			wait(0.1)
		end;
		
		BoltForwardAnim = function(char, speed, objs)
			objs[5]:WaitForChild("BoltForward"):Play()
			TweenJoint(objs[1],  nil , CFrame.new(), function(X) return math.sin(math.rad(X)) end, 0.1)
			TweenJoint(objs[2],  nil , CFrame.new(0.299306631, -1.18411899, -1.32660568, 0.803367436, 0.238225982, 0.545755446, -0.118667498, -0.834062338, 0.538755715, 0.583539844, -0.497582287, -0.641788721), function(X) return math.sin(math.rad(X)) end, 0.1)
			TweenJoint(objs[3],  nil , CFrame.new(-0.833141267, -0.291854143, -1.55439997, 0.642787576, 3.34848629e-08, -0.766044378, 0.766044378, -2.80971371e-08, 0.642787576, 0, -1, -4.37113883e-08), function(X) return math.sin(math.rad(X)) end, 0.2)
			wait(0.1)
		end;
		
		-- Bolting Back
		BoltingBackAnim = function(char, speed, objs)
			TweenJoint(objs[1],  nil , CFrame.new(0, 0, 0.273770154, 1, 0, 0, 0, 1, 0, 0, 0, 1), function(X) return math.sin(math.rad(X)) end, 0.001)
		end;
		
		BoltingForwardAnim = function(char, speed, objs)
			TweenJoint(objs[1],  nil , CFrame.new(), function(X) return math.sin(math.rad(X)) end, 0.001)
		end;
		
		InspectAnim = function(char, speed, objs)
			ts:Create(objs[1],TweenInfo.new(1),{C1 = CFrame.new(0.805950999, 0.654529691, -1.92835355, 0.999723792, 0.0109803826, 0.0207702816, -0.0223077796, 0.721017241, 0.692557871, -0.00737112388, -0.692829967, 0.721063137)}):Play()
			ts:Create(objs[2],TweenInfo.new(1),{C1 = CFrame.new(-1.49363565, -0.699174881, -1.32277012, 0.66716975, -8.8829113e-09, -0.74490571, 0.651565909, -0.484672248, 0.5835706, -0.361035138, -0.874695837, -0.323358655)}):Play()
			wait(1)
			ts:Create(objs[2],TweenInfo.new(1),{C1 = CFrame.new(1.37424219, -0.699174881, -1.03685927, -0.204235911, 0.62879771, 0.750267386, 0.65156585, -0.484672219, 0.58357054, 0.730581641, 0.60803473, -0.310715646)}):Play()
			wait(1)
			ts:Create(objs[2],TweenInfo.new(1),{C1 = CFrame.new(-0.902175903, 0.295501232, -1.32277012, 0.935064793, -0.354476899, 4.22709467e-09, -0.110443868, -0.291336805, 0.950223684, -0.336832345, -0.888520718, -0.311568588)}):Play()
			ts:Create(objs[1],TweenInfo.new(1),{C1 = CFrame.new(0.447846293, 0.654529572, -1.81345785, 0.761665463, -0.514432132, 0.393986136, -0.560285628, -0.217437655, 0.799250066, -0.325492471, -0.82950604, -0.453843832)}):Play()
			wait(1)
			local MagC = Tool:WaitForChild("Mag"):clone()
			MagC:FindFirstChild("Mag"):Destroy()
			MagC.Parent = Tool
			MagC.Name = "MagC"
			local MagCW = Instance.new("Motor6D")
			MagCW.Part0 = MagC
			MagCW.Part1 = workspace.CurrentCamera:WaitForChild("Arms"):WaitForChild("Left Arm")
			MagCW.Parent = MagC
			MagCW.C1 = MagC.CFrame:toObjectSpace(Tool:WaitForChild('Mag').CFrame)
			Tool.Mag.Transparency = 1
			Tool:WaitForChild('Grip'):WaitForChild("MagOut"):Play()
			
			ts:Create(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-0.902175903, 0.295501232, -1.55972552, 0.935064793, -0.354476899, 4.22709467e-09, -0.110443868, -0.291336805, 0.950223684, -0.336832345, -0.888520718, -0.311568588)}):Play()
			ts:Create(objs[1],TweenInfo.new(0.3),{C1 = CFrame.new(0.447846293, 0.654529572, -2.9755671, 0.761665463, -0.514432132, 0.393986136, -0.568886042, -0.239798605, 0.786679745, -0.31021595, -0.823320091, -0.475299776)}):Play()
			wait(0.13)
			ts:Create(objs[2],TweenInfo.new(0.20),{C1 = CFrame.new(-0.902175903, 0.295501232, -1.28149843, 0.935064793, -0.354476899, 4.22709467e-09, -0.110443868, -0.291336805, 0.950223684, -0.336832345, -0.888520718, -0.311568588)}):Play()
			wait(0.20)			
			ts:Create(objs[1],TweenInfo.new(0.5),{C1 = CFrame.new(0.447846293, -0.650498748, -1.82401526, 0.761665463, -0.514432132, 0.393986136, -0.646156013, -0.55753684, 0.521185875, -0.0484529883, -0.651545882, -0.75706023)}):Play()
			wait(0.8)
			ts:Create(objs[1],TweenInfo.new(0.6),{C1 = CFrame.new(0.447846293, 0.654529572, -2.9755671, 0.761665463, -0.514432132, 0.393986136, -0.568886042, -0.239798605, 0.786679745, -0.31021595, -0.823320091, -0.475299776)}):Play()
			wait(0.5)
			Tool:WaitForChild('Grip'):WaitForChild("MagIn"):Play()
			ts:Create(objs[1],TweenInfo.new(0.3),{C1 = CFrame.new(0.447846293, 0.654529572, -1.81345785, 0.761665463, -0.514432132, 0.393986136, -0.560285628, -0.217437655, 0.799250066, -0.325492471, -0.82950604, -0.453843832)}):Play()			
			wait(0.3)
			MagC:Destroy()
			Tool.Mag.Transparency = 0
			wait(0.1)
		end;
		
		nadeReload = function(char, speed, objs)
			ts:Create(objs[1], TweenInfo.new(0.6), {C1 = CFrame.new(-0.902175903, -1.15645337, -1.32277012, 0.984807789, -0.163175702, -0.0593911409, 0, -0.342020363, 0.939692557, -0.17364797, -0.925416529, -0.336824328)}):Play()
			ts:Create(objs[2], TweenInfo.new(0.6), {C1 = CFrame.new(0.805950999, 0.654529691, -1.92835355, 0.787567914, -0.220087856, 0.575584888, -0.323594928, 0.647189975, 0.690240026, -0.524426222, -0.72986728, 0.438486755)}):Play()
			wait(0.6)
			ts:Create(objs[2], TweenInfo.new(0.6), {C1 = CFrame.new(0.805950999, 0.559619546, -1.73060048, 0.802135408, -0.348581612, 0.484839559, -0.597102284, -0.477574915, 0.644508123, 0.00688350201, -0.806481719, -0.59121877)}):Play()
			wait(0.6)		
		end;
		
		AttachAnim = function(char, speed, objs)
			TweenJoint(objs[1],  nil , CFrame.new(-2.05413628, -0.386312962, -0.955676377, 0.5, 0, -0.866025329, 0.852868497, -0.17364797, 0.492403895, -0.150383547, -0.984807789, -0.086823985), function(X) return math.sin(math.rad(X)) end, 0.25)
			TweenJoint(objs[2],  nil , CFrame.new(0.931334019, 1.66565645, -1.2231313, 0.787567914, -0.220087856, 0.575584888, -0.0180282295, 0.925416708, 0.378521889, -0.615963817, -0.308488399, 0.724860728), function(X) return math.sin(math.rad(X)) end, 0.25)
			wait(0.18)	
		end;
		
		-- Patrol Anim
		PatrolAnim = function(char, speed, objs)
			TweenJoint(objs[1],  nil , sConfig.PatrolPosR, function(X) return math.sin(math.rad(X)) end, 0.25)
			TweenJoint(objs[2],  nil , sConfig.PatrolPosL, function(X) return math.sin(math.rad(X)) end, 0.25)
			wait(0.18)
		end;
	
	}

return Settings

end,
function(script,require)
-- params : ...

local sp = script.Parent
update = function()
  
  sp.Scope.Position = UDim2.new(0.5, -10 - sp.AbsoluteSize.y / 2, 0, -26)
  sp.Scope.Size = UDim2.new(0, 20 + sp.AbsoluteSize.y, 0, 20 + sp.AbsoluteSize.y)
  sp.ScopeId.Position = UDim2.new(0.5, -10 - sp.AbsoluteSize.y / 2, 0, -26)
  sp.ScopeId.Size = UDim2.new(0, 20 + sp.AbsoluteSize.y, 0, 20 + sp.AbsoluteSize.y)
  sp.F1.Size = UDim2.new(0, 20 + (sp.AbsoluteSize.x - sp.AbsoluteSize.y) / 2, 1, 20)
  sp.F2.Size = UDim2.new(0, 20 + (sp.AbsoluteSize.x - sp.AbsoluteSize.y) / 2, 1, 20)
  sp.F2.Position = UDim2.new(1, -10 - (sp.AbsoluteSize.x - sp.AbsoluteSize.y) / 2, 0, -10)
end

wait()
sp.Changed:connect(update)
update()

end,
function(script,require)
--// Variables
local L_1_ = script.Parent
local L_2_ = L_1_.Parent.Parent
local L_3_ = L_2_.Character
local L_4_ = game.ReplicatedStorage:FindFirstChild('[WB] Leaderstat Network') or nil

--// Declarables
local L_5_ = L_1_:WaitForChild('Resource')
local L_6_ = L_5_:WaitForChild('FX')
local L_7_ = L_5_:WaitForChild('Events')
local L_8_ = L_5_:WaitForChild('HUD')
local L_9_ = L_5_:WaitForChild('Modules')
local L_10_ = L_5_:WaitForChild('Vars')
local L_11_ = L_5_:WaitForChild('SettingsModule')
local L_12_ = require(L_11_:WaitForChild('ServerConfig'))
local L_13_ = L_5_:WaitForChild('Nodes')
local L_14_

local L_15_
local L_16_

local L_17_
local L_18_
local L_19_

local L_20_
local L_21_
local L_22_
local L_23_
local L_24_
local L_25_

local L_26_
local L_27_

--// Gun Parts
local L_28_ = L_1_.Bolt
local L_29_ = L_1_.Mag
local L_30_ = L_1_.FirePart
local L_31_ = L_5_:WaitForChild('FX')
local L_32_

--// Events
local L_33_ = L_7_:WaitForChild('Equipped')
local L_34_ = L_7_:WaitForChild('ShootEvent')
local L_35_ = L_7_:WaitForChild('DamageEvent')
local L_36_ = L_7_:WaitForChild('CreateOwner')
local L_37_ = L_7_:WaitForChild('Stance')
local L_38_ = L_7_:WaitForChild('HitEvent')
local L_39_ = L_7_:WaitForChild('KillEvent')
local L_40_ = L_7_:WaitForChild('AimEvent')
local L_41_ = L_7_:WaitForChild('ExploEvent')
local L_42_ = L_7_:WaitForChild('AttachEvent')
local L_43_ = L_7_:WaitForChild('ServerFXEvent')
local L_44_ = L_7_:WaitForChild('ChangeIDEvent')

--// Functions
function Weld(L_53_arg1, L_54_arg2, L_55_arg3)
	local L_56_ = Instance.new("Motor6D", L_53_arg1)
	L_56_.Part0 = L_53_arg1
	L_56_.Part1 = L_54_arg2
	L_56_.Name = L_53_arg1.Name
	L_56_.C0 = L_55_arg3 or L_53_arg1.CFrame:inverse() * L_54_arg2.CFrame
	return L_56_
end

--// Tables
local L_45_ = {
	
	"1565831468";
	"1565832329";
	
}

local L_46_ = {
	
	"1565831129";
	"1565830611";
	
}

local L_47_ = {
	
	"1565825075";
	"1565824613";
	
}

local L_48_ = {
	
	"1565821941";
	"1565821634";
	
}

local L_49_ = {
	
	"1565756818";
	"1565756607";
	
}

local L_50_ = {
	
	"1565717027";
	"1565716705";
	
}

local L_51_ = {
	
	1565703226;
	1565675605;
	
}

--// Connections
L_1_.Equipped:connect(function()
	local L_57_ = L_3_:FindFirstChild('Torso')
	local L_58_ = L_3_:FindFirstChild('Head')
	local L_59_ = L_3_:FindFirstChild('HumanoidRootPart')
	
	L_17_ = Instance.new("Motor6D", L_57_)
	L_17_.Parent = L_57_
	L_17_.Name = "Clone"
	L_17_.Part0 = L_59_
	L_17_.Part1 = L_58_
	L_17_.C0 = L_57_:WaitForChild("Neck").C0	
	L_17_.C1 = L_57_:WaitForChild("Neck").C1
	
-- Make the AnimBase
	L_18_ = Instance.new("Part", L_3_)
	L_18_.FormFactor = "Custom"
	L_18_.CanCollide = false
	L_18_.Transparency = 1
	L_18_.Anchored = false
	L_18_.Name = "AnimBase"
	
	L_19_ = Instance.new("Motor6D")
	L_19_.Part0 = L_18_
	L_19_.Part1 = L_58_
	L_19_.Parent = L_18_
	L_19_.Name = "AnimBaseW"
	--AnimBaseW.C1 = gunSettings.StartPose	
	
	L_15_ = Instance.new("Motor6D")
	L_15_.Part0 = L_3_['Right Arm']
	L_15_.Part1 = L_1_:FindFirstChild('Grip')
	L_15_.Parent = L_3_['Right Arm']
	L_15_.C1 = L_12_.GunPos
	L_15_.Name = "Grip"
	
	for L_60_forvar1, L_61_forvar2 in pairs(L_1_:GetChildren()) do
		if L_61_forvar2:IsA("Part") or L_61_forvar2:IsA("MeshPart") or L_61_forvar2:IsA("UnionOperation") then
			L_61_forvar2.Anchored = true
			
			if L_61_forvar2.Name ~= "Grip" and L_61_forvar2.Name ~= "Bolt" and L_61_forvar2.Name ~= 'Lid' then
				Weld(L_61_forvar2, L_1_:WaitForChild("Grip"))
			end
			
			if L_61_forvar2.Name == "Bolt" then
				if L_1_:FindFirstChild('BoltHinge') then
					Weld(L_61_forvar2, L_1_:WaitForChild("BoltHinge"))
				else
					Weld(L_61_forvar2, L_1_:WaitForChild("Grip"))
				end
			end;
			
			if L_61_forvar2.Name == "Lid" then
				if L_1_:FindFirstChild('LidHinge') then
					Weld(L_61_forvar2, L_1_:WaitForChild("LidHinge"))
				else
					Weld(L_61_forvar2, L_1_:WaitForChild("Grip"))
				end
			end
		end
	end
	
	for L_62_forvar1, L_63_forvar2 in pairs(L_13_:GetChildren()) do
		if L_63_forvar2:IsA('Part') then
			Weld(L_63_forvar2, L_1_:WaitForChild("Grip"))
		end
	end
	
	for L_64_forvar1, L_65_forvar2 in pairs(L_13_:GetChildren()) do
		if L_65_forvar2:IsA('Part') then
			L_65_forvar2.Anchored = false
		end
	end
	
	for L_66_forvar1, L_67_forvar2 in pairs(L_1_:GetChildren()) do
		if L_67_forvar2:IsA("Part") or L_67_forvar2:IsA("MeshPart") or L_67_forvar2:IsA("UnionOperation") then
			L_67_forvar2.Anchored = false
		end
	end
	
	L_20_ = L_3_['Right Arm']
	L_21_ = L_3_['Left Arm']
	L_24_ = L_3_.Torso:WaitForChild("Right Shoulder")
	L_25_ = L_3_.Torso:WaitForChild("Left Shoulder")
	
	L_22_ = Instance.new("Motor6D")
	L_22_.Name = "RAW"
	L_22_.Part0 = L_18_
	L_22_.Part1 = L_20_
	L_22_.Parent = L_18_
	L_22_.C1 = L_12_.RightArmPos
	L_3_.Torso:WaitForChild("Right Shoulder").Part1 = nil
		
	L_23_ = Instance.new("Motor6D")
	L_23_.Name = "LAW"
	L_23_.Part0 = L_18_
	L_23_.Part1 = L_21_
	L_23_.Parent = L_18_
	L_23_.C1 = L_12_.LeftArmPos
	L_3_.Torso:WaitForChild("Left Shoulder").Part1 = nil
	
	L_14_ = L_8_:WaitForChild('MainGui'):clone()
	L_14_.Parent = L_2_.PlayerGui
	
	L_27_ = L_58_:FindFirstChild('AHH') or L_6_:WaitForChild('AHH'):clone()
	L_27_.Parent = L_3_.Head
	
	if L_32_ then
		L_32_:Destroy()
	end
	
	L_33_:FireClient(L_2_, true, L_15_, L_18_, L_19_, L_22_, L_23_, L_17_)
end)

L_1_.Unequipped:connect(function()
	L_15_:Destroy()
	local L_68_ = L_3_:FindFirstChild('Torso')
	local L_69_ = L_3_:FindFirstChild('Head')
	L_32_ = Instance.new('Model', L_3_)
	L_32_.Name = "HolsterModel"
	
	for L_70_forvar1, L_71_forvar2 in pairs(L_1_:GetChildren()) do
		for L_72_forvar1, L_73_forvar2 in pairs(L_71_forvar2:GetChildren()) do
			if L_73_forvar2.ClassName == "Motor6D" then
				L_73_forvar2:Destroy()
			end
		end
	end
	
	for L_74_forvar1, L_75_forvar2 in pairs(L_1_:GetChildren()) do
		if L_75_forvar2:IsA("Part") or L_75_forvar2:IsA("MeshPart") or L_75_forvar2:IsA("UnionOperation") then
			L_75_forvar2.Anchored = true
		end
	end
	
	if L_3_.Humanoid and L_3_.Humanoid.Health > 0 then
		L_3_.HumanoidRootPart.RootJoint.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
		L_68_['Right Hip'].C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
		L_68_['Left Hip'].C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		L_17_.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
		
		L_3_.HumanoidRootPart.RootJoint.C1 = CFrame.new(0, 0, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
		L_68_['Right Hip'].C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
		L_68_['Left Hip'].C1 = CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
		L_17_.C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	end
	
	L_68_:WaitForChild("Neck").Part1 = L_69_
	L_68_:WaitForChild("Neck").C1 = L_68_:WaitForChild("Neck").C1
	L_68_:WaitForChild("Neck").C0 = L_68_:WaitForChild("Neck").C0
	
	L_18_:Destroy()
	L_17_:Destroy()
	L_24_.Part1 = L_20_
	L_25_.Part1 = L_21_
	
	if L_69_:FindFirstChild('AHH') then
		L_69_.AHH:Destroy()
	end
	
	L_33_:FireClient(L_2_, false)
	
	if L_12_.HolsteringEnabled then
		for L_77_forvar1, L_78_forvar2 in pairs(L_1_:GetChildren()) do
			if L_78_forvar2:IsA("Part") or L_78_forvar2:IsA("MeshPart") or L_78_forvar2:IsA("UnionOperation") then
				L_78_forvar2.Anchored = true
				local L_79_ = L_78_forvar2:clone()
				L_79_.Parent = L_32_
			end
		end;
		
		for L_80_forvar1, L_81_forvar2 in pairs(L_32_:GetChildren()) do
			Weld(L_81_forvar2, L_32_:WaitForChild("Grip"))
		end
		
		local L_76_ = Weld(L_32_:WaitForChild("Grip"), L_3_:WaitForChild('Torso'))
		L_76_.Name = "TWeld"
		L_76_.C1 = L_12_.HolsterPos
		
		for L_82_forvar1, L_83_forvar2 in pairs(L_32_:GetChildren()) do
			L_83_forvar2.Anchored = false
		end
	end
end)

L_3_.Humanoid.Died:connect(function()	
	L_33_:FireClient(L_2_, false)
end)

--// Events
L_34_.OnServerEvent:connect(function(L_84_arg1)	
	for L_85_forvar1, L_86_forvar2 in pairs(L_30_:GetChildren()) do
		if L_86_forvar2.Name:sub(1, 7) == "FlashFX" then
			L_86_forvar2.Enabled = true
		end
	end;

	delay(1 / 30, function()
		for L_87_forvar1, L_88_forvar2 in pairs(L_30_:GetChildren()) do
			if L_88_forvar2.Name:sub(1, 7) == "FlashFX" then
				L_88_forvar2.Enabled = false
			end
		end
	end);
end)

local L_52_
L_35_.OnServerEvent:connect(function(L_89_arg1, L_90_arg2, L_91_arg3)
	L_90_arg2:TakeDamage(L_91_arg3)
	if L_90_arg2.Health <= 0 and L_90_arg2 ~= L_52_ then
		if L_4_ and L_4_:FindFirstChild(L_2_.Name) then
			local L_92_ = L_4_[L_2_.Name]
			L_92_.Value = not L_92_.Value
		end
		L_39_:FireClient(L_89_arg1)
		L_52_ = L_90_arg2
	end
end)

L_36_.OnServerEvent:connect(function(L_93_arg1, L_94_arg2)
	local L_95_ = Instance.new("ObjectValue")
	L_95_.Name = "creator"
	L_95_.Value = L_93_arg1
	L_95_.Parent = L_94_arg2
	game.Debris:AddItem(L_95_, 3)
end)

L_37_.OnServerEvent:connect(function(L_96_arg1, L_97_arg2, L_98_arg3)
	local L_99_ = L_96_arg1.Character
	local L_100_ = L_99_:FindFirstChild('Torso')
	local L_101_ = L_99_:FindFirstChild('HumanoidRootPart'):FindFirstChild('RootJoint')
	local L_102_ = L_100_:FindFirstChild('Right Hip')
	local L_103_ = L_100_:FindFirstChild('Left Hip')
	local L_104_ = L_100_:FindFirstChild('Clone')
	
	if L_97_arg2 == "Prone" and L_99_ and L_104_ then
		L_101_.C0 = CFrame.new(0, -2.4201169, -0.0385534465, -0.99999994, -5.86197757e-012, -4.54747351e-013, 5.52669195e-012, 0.998915195, 0.0465667509, 0, 0.0465667509, -0.998915195)
		L_102_.C0 = CFrame.new(1.00000191, -1, -5.96046448e-008, 1.31237243e-011, -0.344507754, 0.938783348, 0, 0.938783467, 0.344507784, -1, 0, -1.86264515e-009)
		L_103_.C0 = CFrame.new(-0.999996185, -1, -1.1920929e-007, -2.58566502e-011, 0.314521015, -0.949250221, 0, 0.94925046, 0.314521164, 1, 3.7252903e-009, 1.86264515e-009)			
		L_104_.C0 = CFrame.new(0, -2.04640698, -0.799179077, -1, 0, -8.57672189e-15, 8.57672189e-15, 0, 1, 0, 1, 0)	
	elseif L_97_arg2 == "Crouch" and L_99_ and L_104_ then
		L_101_.C0 = CFrame.new(0, -1.04933882, 0, -1, 0, -1.88871293e-012, 1.88871293e-012, -3.55271368e-015, 1, 0, 1, -3.55271368e-015)
		L_102_.C0 = CFrame.new(1, 0.0456044674, -0.494239986, 6.82121026e-013, -1.22639676e-011, 1, -0.058873821, 0.998265445, -1.09836602e-011, -0.998265445, -0.058873821, 0)
		L_103_.C0 = CFrame.new(-1.00000381, -0.157019258, -0.471293032, -8.7538865e-012, -8.7538865e-012, -1, 0.721672177, 0.692235112, 1.64406284e-011, 0.692235112, -0.721672177, 0)
		L_104_.C0 = CFrame.new(0, -0.0399827957, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
	elseif L_97_arg2 == "Stand" and L_99_ and L_104_ then	
		L_101_.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
		L_102_.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
		L_103_.C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		L_104_.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
	elseif L_97_arg2 == "LeanRight" then
		L_101_.C1 = CFrame.new(0, 0.200000003, 0, -0.939692616, 0, -0.342020124, -0.342020124, 0, 0.939692616, 0, 1, 0)
		L_102_.C1 = CFrame.new(0.300000012, 0.600000024, 0, 0, 0.342020124, 0.939692616, 0, 0.939692616, -0.342020124, -1, 0, 0)
		L_104_.C1 = CFrame.new(-0.400000006, -0.300000012, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
	elseif L_97_arg2 == "LeanLeft" then
		L_101_.C1 = CFrame.new(0, 0.200000003, 0, -0.939692616, 0, 0.342020124, 0.342020124, 0, 0.939692616, 0, 1, 0)
		L_103_.C1 = CFrame.new(-0.300000012, 0.600000024, 0, 0, -0.342020124, -0.939692616, 0, 0.939692616, -0.342020124, 1, 0, 0)
		L_104_.C1 = CFrame.new(0.400000006, -0.300000012, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
	elseif L_97_arg2 == "Unlean" then
		L_101_.C1 = CFrame.new(0, 0, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
		L_102_.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
		L_103_.C1 = CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
		if L_100_:FindFirstChild('Clone') then
			L_104_.C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
		end
	elseif L_97_arg2 == "Patrol" then
		L_19_.C1 = L_98_arg3
	elseif L_97_arg2 == "Unpatrol" then
		L_19_.C1 = CFrame.new()
	end
end)

L_38_.OnServerInvoke = function(L_105_arg1, L_106_arg2, L_107_arg3, L_108_arg4, L_109_arg5, L_110_arg6, L_111_arg7)
	local L_112_ = Instance.new("Part", workspace)
	L_112_.FormFactor = "Custom"
	L_112_.TopSurface = 0
	L_112_.BottomSurface = 0
	L_112_.Transparency = 1
	L_112_.Anchored = true
	L_112_.CanCollide = false
	L_112_.Size = Vector3.new(0.5, 0, 0.5)
	L_112_.CFrame = CFrame.new(L_106_arg2) * CFrame.fromAxisAngle(L_107_arg3.magnitude == 0 and Vector3.new(1) or L_107_arg3.unit, L_108_arg4)
	L_112_.BrickColor = BrickColor.new("Really black")
	L_112_.Material = "SmoothPlastic"

	local L_113_ = Instance.new("Decal", L_112_)
	L_113_.Texture = "rbxassetid://64291977"
	L_113_.Face = "Top"
	game.Debris:AddItem(L_113_, 3)
	
	local L_114_ = Instance.new("PointLight", L_112_)
	L_114_.Color = Color3.new(0, 0, 0)
	L_114_.Range = 0
	L_114_.Shadows = true
	
	--[[local Meta = Instance.new("Sound")
	Meta.Name = "Crack"	
	
	if h.Material == Enum.Material.Grass or h.Material == Enum.Material.Ice or h.Material == Enum.Material.Fabric or h.Material == Enum.Material.Pebble then
		Meta = Crack:FindFirstChild('Crack') or Instance.new('Sound',Crack)
		Meta.Name = 'Crack'
		Meta.SoundId = "rbxassetid://" .. DirtSounds[math.random(0,#DirtSounds)]
	end
	
	if h.Material == Enum.Material.Sand then
		Meta = Crack:FindFirstChild('Crack') or Instance.new('Sound',Crack)
		Meta.Name = 'Crack'
		Meta.SoundId = "rbxassetid://" .. SandSounds[math.random(0,#SandSounds)]
	end
	
	if h.Material == Enum.Material.Glass or h.Material == Enum.Material.Neon then
		Meta = Crack:FindFirstChild('Crack') or Instance.new('Sound',Crack)
		Meta.Name = 'Crack'
		Meta.SoundId = "rbxassetid://" .. GlassSounds[math.random(0,#GlassSounds)]
	end
	
	if h.Material == Enum.Material.Wood or h.Material == Enum.Material.WoodPlanks then
		Meta = Crack:FindFirstChild('Crack') or Instance.new('Sound',Crack)
		Meta.Name = 'Crack'
		Meta.SoundId = "rbxassetid://" .. WoodSounds[math.random(0,#WoodSounds)]
	end
	
	if h.Material == Enum.Material.Metal or h.Material == Enum.Material.CorrodedMetal or h.Material == Enum.Material.DiamondPlate then
		Meta = Crack:FindFirstChild('Crack') or Instance.new('Sound',Crack)
		Meta.Name = 'Crack'
		Meta.SoundId = "rbxassetid://" .. MetalSounds[math.random(0,#MetalSounds)]
	end
	
	if h.Material == Enum.Material.Water then
		Meta = Crack:FindFirstChild('Crack') or Instance.new('Sound',Crack)
		Meta.Name = 'Crack'
		Meta.SoundId = "rbxassetid://" .. WaterSounds[math.random(0,#WaterSounds)]
	end
	
	if h.Material == Enum.Material.Concrete or h.Material == Enum.Material.Plastic or h.Material == Enum.Material.SmoothPlastic or h.Material == Enum.Material.Slate or h.Material == Enum.Material.Foil or h.Material == Enum.Material.Brick or h.Material == Enum.Material.Granite or h.Material == Enum.Material.Marble or h.Material == Enum.Material.Cobblestone then
		Meta = Crack:FindFirstChild('Crack') or Instance.new('Sound',Crack)
		Meta.Name = 'Crack'
		Meta.SoundId = "rbxassetid://" .. ConcreteSounds[math.random(0,#ConcreteSounds)]
	end	
	
	Meta.Volume = math.random(0.8,1)
	Meta.EmitterSize = 10
	Meta.MaxDistance = 30
	Meta.Pitch = math.random(0,0.6)
	Meta.Parent = Crack
	Meta:play()]]--
	
	game.Debris:AddItem(L_112_, 3)
	
	local L_115_
	local L_116_
		
	if L_110_arg6 == "Part" then
		L_115_ = L_31_:WaitForChild("Spark"):clone()
		L_115_.Parent = L_112_
		L_115_.EmissionDirection = "Top"
		
		L_116_ = L_31_:WaitForChild("Smoke"):clone()
		L_116_.Parent = L_112_
		L_116_.EmissionDirection = "Top"
		
		L_115_.Enabled = true
		L_116_.Enabled = true
		
		game.Debris:AddItem(L_115_, 1)
		game.Debris:AddItem(L_116_, 1)
		
		delay(0.1, function()
			L_115_.Enabled = false
			L_116_.Enabled = false
		end)
	elseif L_110_arg6 == "Human" then		
		L_115_ = L_31_:WaitForChild("Blood"):clone()
		L_115_.Parent = L_112_
		L_115_.EmissionDirection = "Top"
		L_115_.Enabled = true
		
		game.Debris:AddItem(L_115_, 1)
		
		delay(0.1, function()
			L_115_.Enabled = false
		end)
	end
end;

L_40_.OnServerEvent:connect(function(L_117_arg1, L_118_arg2)
	L_40_:FireAllClients(L_117_arg1, L_118_arg2)
end)

L_41_.OnServerEvent:connect(function(L_119_arg1, L_120_arg2)
	local L_121_ = Instance.new('Part', workspace)
	L_121_.Size = Vector3.new(0.1, 0.1, 0.1)
	L_121_.Transparency = 1
	L_121_.CanCollide = false
	L_121_.Anchored = true
	L_121_.Position = L_120_arg2
	local L_122_ = Instance.new('Explosion', workspace)
	L_122_.Position = L_120_arg2
	L_122_.BlastPressure = L_12_.BlastPressue
	L_122_.BlastRadius = L_12_.BlastRadius
	L_122_.DestroyJointRadiusPercent = L_12_.DestroyJointRadius
	L_122_.ExplosionType = L_12_.ExplosionType
	local L_123_ = L_31_:WaitForChild('ExplosionSound'):clone()
	L_123_.Parent = L_121_
	L_123_:Play()
	game:GetService('Debris'):AddItem(L_121_, L_123_.TimeLength)
end)

L_43_.OnServerEvent:connect(function(L_124_arg1, L_125_arg2)
	for L_126_forvar1, L_127_forvar2 in pairs(game.Players:GetChildren()) do
		if L_127_forvar2:IsA('Player') and L_127_forvar2.PlayerGui:FindFirstChild('MainGui') and L_127_forvar2.PlayerGui.MainGui:FindFirstChild('Shading') then
			for L_128_forvar1, L_129_forvar2 in pairs(L_127_forvar2.Character:GetChildren()) do
				if L_129_forvar2:IsA('Tool') and L_129_forvar2:FindFirstChild('Resource') and L_129_forvar2.Resource:FindFirstChild('Events') and L_129_forvar2.Resource.Events:FindFirstChild('ServerFXEvent') then
					L_129_forvar2.Resource.Events.ServerFXEvent:FireClient(L_127_forvar2, L_125_arg2, L_2_)
				end	
			end
		end
	end
end)

L_44_.OnServerEvent:connect(function(L_130_arg1, L_131_arg2, L_132_arg3)
	L_131_arg2.SoundId = 'rbxassetid://' .. L_132_arg3
	L_131_arg2:Play()
end)
end,
function(script,require)

repeat
	wait()
until game.Players.LocalPlayer.Character
wait(0.5)

--// Variables
local L_1_ = script.Parent
local L_2_ = game.Players.LocalPlayer
local L_3_ = L_2_.Character
local L_4_ = L_2_:GetMouse()
local L_5_ = workspace.CurrentCamera

local L_6_ = L_3_:WaitForChild('Torso')
local L_7_ = L_3_:WaitForChild('Head')
local L_8_ = L_3_:WaitForChild('HumanoidRootPart')
local L_9_ = L_8_:WaitForChild('RootJoint')
local L_10_ = L_6_:WaitForChild('Right Hip')
local L_11_ = L_6_:WaitForChild('Left Hip')

--// Services
local L_12_ = game:GetService('UserInputService')
local L_13_ = game:GetService('RunService')
local L_14_ = game:GetService('TweenService')

--// Declarables
local L_15_ = false

local L_16_ = false
local L_17_ = true

local L_18_ = L_1_:WaitForChild('Resource')
local L_19_ = L_18_:WaitForChild('FX')
local L_20_ = L_18_:WaitForChild('Events')
local L_21_ = L_18_:WaitForChild('HUD')
local L_22_ = L_18_:WaitForChild('Modules')
local L_23_ = L_18_:WaitForChild('SettingsModule')
local L_24_ = require(L_23_:WaitForChild("ClientConfig"))
local L_25_ = L_18_:WaitForChild('Vars')

local L_26_
local L_27_
local L_28_
local L_29_
local L_30_
local L_31_
local L_32_
local L_33_
local L_34_
local L_35_
local L_36_
local L_37_
local L_38_
local L_39_
local L_40_
local L_41_

local L_42_

local L_43_
local L_44_
local L_45_
local L_46_
local L_47_
local L_48_
local L_49_

local L_50_ = L_24_.AimZoom

local L_51_ = L_24_.MouseSensitivity
local L_52_ = L_12_.MouseDeltaSensitivity

local L_53_ = game.ReplicatedStorage:FindFirstChild('SoundIso_Network') or nil
local L_54_
if L_53_ then
	L_54_ = L_53_:WaitForChild('EventConnection')
end

local L_55_ = CFrame.Angles(0, 0, 0)

--// Weapon Parts
local L_56_ = L_1_:WaitForChild('AimPart')
local L_57_
local L_58_ = L_1_:WaitForChild('Grip')
local L_59_ = L_1_:WaitForChild('FirePart')
local L_60_
local L_61_ = L_1_:WaitForChild('Mag')
local L_62_ = L_1_:WaitForChild('Bolt')

--// Probability
local L_63_

--// States
local L_64_ = false
local L_65_ = false
local L_66_ = false
local L_67_ = false
local L_68_ = false
local L_69_ = true
local L_70_ = false
local L_71_ = false
local L_72_ = false
local L_73_ = false
local L_74_ = false
local L_75_ = false
local L_76_ = false
local L_77_ = false
local L_78_ = false
local L_79_ = false

local L_80_ = false
local L_81_ = false
local L_82_ = false

local L_83_ = false
local L_84_ = true
local L_85_ = true

local L_86_ = false

local L_87_
local L_88_

local L_89_
local L_90_
local L_91_

local L_92_ = L_24_.FireMode

local L_93_ = 0
local L_94_ = false
local L_95_ = true
local L_96_ = false

local L_97_ = 70

--// Tables
local L_98_ = {
	
	"285421759";
	"151130102";
	"151130171";
	"285421804";
	"287769483";
	"287769415";
	"285421687";
	"287769261";
	"287772525";
	"287772445";
	"287772351";
	"285421819";
	"287772163";
	
}

local L_99_ = {
	
	"2282590559";
	"2282583154";
	"2282584222";
	"2282584708";
	"2282585118";
	"2282586860";
	"2282587182";
	"2282587628";
	"2282588117";
	"2282588433";
	"2282576973";
	"2282577954";
	"2282578595";
	"2282579272";
	"2282579760";
	"2282580279";
	"2282580551";
	"2282580935";
	"2282582377";
	"2282582717";
	"2282449653";
		
}

local L_100_ = {
	
	"2297264589";
	"2297264920";
	"2297265171";
	"2297265394";
	"2297266410";
	"2297266774";
	"2297267106";
	"2297267463";
	"2297267748";
	"2297268261";
	"2297268486";
	"2297268707";
	"2297268894";
	"2297269092";
	"2297269542";
	"2297269946";
	"2297270243";
	"2297270591";
	"2297270984";
	"2297271381";
	"2297271626";
	"2297272112";
	"2297272424";
	
}

local L_101_ = workspace:FindFirstChild("BulletModel: " .. L_2_.Name) or Instance.new("Folder", workspace)
L_101_.Name = "BulletModel: " .. L_2_.Name

local L_102_

local L_103_ = L_24_.Ammo
local L_104_ = L_24_.StoredAmmo * L_24_.MagCount

local L_105_ = L_24_.ExplosiveAmmo

IgnoreList = {
	L_3_,
	L_101_,
	L_5_
}

--// Services
local L_106_ = game:GetService('RunService').RenderStepped
local L_107_ = game:GetService('UserInputService')

--// Events
local L_108_ = L_20_:WaitForChild('Equipped')
local L_109_ = L_20_:WaitForChild('ShootEvent')
local L_110_ = L_20_:WaitForChild('DamageEvent')
local L_111_ = L_20_:WaitForChild('CreateOwner')
local L_112_ = L_20_:WaitForChild('Stance')
local L_113_ = L_20_:WaitForChild('HitEvent')
local L_114_ = L_20_:WaitForChild('KillEvent')
local L_115_ = L_20_:WaitForChild('AimEvent')
local L_116_ = L_20_:WaitForChild('ExploEvent')
local L_117_ = L_20_:WaitForChild('AttachEvent')
local L_118_ = L_20_:WaitForChild('ServerFXEvent')
local L_119_ = L_20_:WaitForChild('ChangeIDEvent')

--// Modules
local L_120_ = require(L_22_:WaitForChild("Utilities"))
local L_121_ = require(L_22_:WaitForChild("Spring"))
local L_122_ = require(L_22_:WaitForChild("Plugins"))
local L_123_ = require(L_22_:WaitForChild("easing"))

local L_124_ = L_120_.Fade
local L_125_ = L_120_.SpawnCam
local L_126_ = L_120_.FixCam
local L_127_ = L_120_.tweenFoV
local L_128_ = L_120_.tweenCam
local L_129_ = L_120_.tweenRoll
local L_130_ = L_120_.TweenJoint

local L_131_ = L_120_.Weld

--// Math
local L_132_ = function(L_169_arg1, L_170_arg2, L_171_arg3)
	if L_169_arg1 > L_171_arg3 then
		return L_171_arg3
	elseif L_169_arg1 < L_170_arg2 then
		return L_170_arg2
	end
	return L_169_arg1
end

local L_133_ = L_121_.new(Vector3.new())
L_133_.s = 30
L_133_.d = 0.55
	
local L_134_ = CFrame.Angles(0, 0, 0)

--// Functions
function MakeFakeArms()
	Arms = Instance.new("Model")
	Arms.Name = "Arms"
	Arms.Parent = L_5_

	local L_172_ = Instance.new("Humanoid")
	L_172_.MaxHealth = 0
	L_172_.Health = 0
	L_172_.Name = ""
	L_172_.Parent = Arms
		
	if L_3_:FindFirstChild("Shirt") then
		local L_177_ = L_3_:FindFirstChild("Shirt"):clone()
		L_177_.Parent = Arms
	end
	
	local L_173_ = L_3_:FindFirstChild("Right Arm"):clone()
	for L_178_forvar1, L_179_forvar2 in pairs(L_173_:GetChildren()) do
		if L_179_forvar2:IsA('Motor6D') then
			L_179_forvar2:Destroy()
		end
	end
	L_173_.Name = "Right Arm"
	L_173_.FormFactor = "Custom"
	L_173_.Size = Vector3.new(0.8, 2.5, 0.8)
	L_173_.Transparency = 0.0
	
	local L_174_ = Instance.new("Motor6D")
	L_174_.Part0 = L_173_
	L_174_.Part1 = L_3_:FindFirstChild("Right Arm")
	L_174_.C0 = CFrame.new()
	L_174_.C1 = CFrame.new()
	L_174_.Parent = L_173_	
	L_173_.Parent = Arms
		
	local L_175_ = L_3_:FindFirstChild("Left Arm"):clone()
	L_175_.Name = "Left Arm"
	L_175_.FormFactor = "Custom"
	L_175_.Size = Vector3.new(0.8, 2.5, 0.8)
	L_175_.Transparency = 0.0	
	
	local L_176_ = Instance.new("Motor6D")
	L_176_.Part0 = L_175_
	L_176_.Part1 = L_3_:FindFirstChild("Left Arm")
	L_176_.C0 = CFrame.new()
	L_176_.C1 = CFrame.new()
	L_176_.Parent = L_175_	
	L_175_.Parent = Arms
end

function RemoveArmModel()
	if Arms then
		Arms:Destroy()
		Arms = nil
	end
end

local L_135_

function CreateShell()
	L_135_ = time()
	local L_180_ = L_1_.Shell:clone()
	if L_180_:FindFirstChild('Shell') then
		L_180_.Shell:Destroy()
	end
	L_180_.CFrame =  L_1_.Chamber.CFrame
	L_180_.Velocity = L_1_.Chamber.CFrame.lookVector * 30 + Vector3.new(0, 4, 0)
	--shell.RotVelocity = Vector3.new(-10,40,30)
	L_180_.Parent = L_101_
	L_180_.CanCollide = false
	game:GetService("Debris"):addItem(L_180_, 1)
	delay(0.5, function()
		if L_19_:FindFirstChild('ShellCasing') then
			local L_181_ = L_19_.ShellCasing:clone()
			L_181_.Parent = L_2_.PlayerGui
			L_181_:Play()
			game:GetService('Debris'):AddItem(L_181_, L_181_.TimeLength)
		end
	end)
end

-- 100 == 1  0 == 0  1/0.5

function JamCalculation()
	local L_182_
	if (math.random(1, 100) <= L_24_.JamChance) then	
		L_182_ = true
		L_75_ = true
	else
		L_182_ = false
	end
	return L_182_
end

function TracerCalculation()
	local L_183_
	if (math.random(1, 100) <= L_24_.TracerChance) then	
		L_183_ = true
	else
		L_183_ = false
	end
	return L_183_
end

function ScreamCalculation()
	local L_184_
	if (math.random(1, 100) <= L_24_.SuppressCalloutChance) then	
		L_184_ = true
	else
		L_184_ = false
	end
	return L_184_
end

function SearchResupply(L_185_arg1)
	local L_186_ = false
	local L_187_ = nil
	
	if L_185_arg1:FindFirstChild('ResupplyVal') or L_185_arg1.Parent:FindFirstChild('ResupplyVal') then
		L_186_ = true
		if L_185_arg1:FindFirstChild('ResupplyVal') then
			L_187_ = L_185_arg1.ResupplyVal
		elseif L_185_arg1.Parent:FindFirstChild('ResupplyVal') then
			L_187_ = L_185_arg1.Parent.ResupplyVal
		end
	end
	return L_186_, L_187_
end

function CheckReverb()
	local L_188_, L_189_ = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_6_.CFrame.p, (L_6_.CFrame.upVector).unit * 30), IgnoreList);
		
	if L_188_ then
		local L_190_ = L_59_:WaitForChild('Fire'):FindFirstChild('ReverbSoundEffect') or Instance.new("ReverbSoundEffect", L_59_:WaitForChild('Fire'))
	elseif not L_188_ then
		if L_59_:WaitForChild('Fire'):FindFirstChild('ReverbSoundEffect') then
			L_59_.Fire.ReverbSoundEffect:Destroy()
		end
	end
end

function UpdateAmmo()
	L_29_.Text = L_103_
	L_30_.Text = L_29_.Text
	
	L_31_.Text = '| ' .. math.ceil(L_104_ / L_24_.StoredAmmo)
	L_32_.Text = L_31_.Text
	
	if L_93_ == 0 then
		L_40_.Image = 'rbxassetid://' .. 1868007495
	elseif L_93_ == 1 then
		L_40_.Image = 'rbxassetid://' .. 1868007947
	elseif L_93_ == 2 then
		L_40_.Image = 'rbxassetid://' .. 1868008584
	end
	
	if L_92_ == 1 then
		L_35_.BackgroundTransparency = 0
		L_36_.BackgroundTransparency = 0.7
		L_37_.BackgroundTransparency = 0.7
		L_38_.BackgroundTransparency = 0.7
		L_39_.BackgroundTransparency = 0.7
	elseif L_92_ == 2 then
		L_35_.BackgroundTransparency = 0
		L_36_.BackgroundTransparency = 0
		L_37_.BackgroundTransparency = 0
		L_38_.BackgroundTransparency = 0
		L_39_.BackgroundTransparency = 0
	elseif L_92_ == 3 then
		L_35_.BackgroundTransparency = 0
		L_36_.BackgroundTransparency = 0
		L_37_.BackgroundTransparency = 0
		L_38_.BackgroundTransparency = 0.7
		L_39_.BackgroundTransparency = 0.7
	elseif L_92_ == 4 then
		L_35_.BackgroundTransparency = 0
		L_36_.BackgroundTransparency = 0
		L_37_.BackgroundTransparency = 0
		L_38_.BackgroundTransparency = 0
		L_39_.BackgroundTransparency = 0.7
	elseif L_92_ == 5 then
		L_35_.BackgroundTransparency = 0
		L_36_.BackgroundTransparency = 0.7
		L_37_.BackgroundTransparency = 0
		L_38_.BackgroundTransparency = 0.7
		L_39_.BackgroundTransparency = 0.7
	elseif L_92_ == 6 then
		L_35_.BackgroundTransparency = 0
		L_36_.BackgroundTransparency = 0.7
		L_37_.BackgroundTransparency = 0
		L_38_.BackgroundTransparency = 0
		L_39_.BackgroundTransparency = 0.7
	end
	
end

--// Connections
L_108_.OnClientEvent:connect(function(L_191_arg1, L_192_arg2, L_193_arg3, L_194_arg4, L_195_arg5, L_196_arg6, L_197_arg7)
	if L_191_arg1 and not L_15_ then
		MakeFakeArms()
		
		L_42_ = L_2_.PlayerGui.MainGui
		L_26_ = L_42_:WaitForChild('Others')
		L_27_ = L_26_:WaitForChild('Kill')
		L_28_ = L_42_:WaitForChild('GameGui'):WaitForChild('AmmoFrame')
		L_29_ = L_28_:WaitForChild('Ammo')
		L_30_ = L_28_:WaitForChild('AmmoBackground')
		L_31_ = L_28_:WaitForChild('MagCount')
		L_32_ = L_28_:WaitForChild('MagCountBackground')
		L_33_ = L_28_:WaitForChild('DistDisp')
		L_34_ = L_28_:WaitForChild('Title')
		L_35_ = L_28_:WaitForChild('Mode1')
		L_36_ = L_28_:WaitForChild('Mode2')
		L_37_ = L_28_:WaitForChild('Mode3')
		L_38_ = L_28_:WaitForChild('Mode4')
		L_39_ = L_28_:WaitForChild('Mode5')
		L_40_ = L_28_:WaitForChild('Stances')
		L_41_ = L_42_:WaitForChild('Shading')
		L_41_.Visible = false
		
		L_34_.Text = L_1_.Name
		UpdateAmmo()
		
		L_43_ = L_192_arg2
		L_44_ = L_193_arg3
		L_45_ = L_194_arg4
		L_46_ = L_195_arg5
		L_47_ = L_196_arg6
		L_48_ = L_197_arg7	
		L_49_ = L_62_.Bolt
		
		L_87_ = L_48_.C1
		L_88_ = L_48_.C0
		
		if L_1_:FindFirstChild('AimPart2') then
			L_57_ = L_1_:WaitForChild('AimPart2')
		end
		
		if L_1_:FindFirstChild('FirePart2') then
			L_60_ = L_1_.FirePart2
		end
		
		if L_24_.FirstPersonOnly then
			L_2_.CameraMode = Enum.CameraMode.LockFirstPerson
		end
		--uis.MouseIconEnabled = false
		L_5_.FieldOfView = 70
		L_15_ = true
	elseif L_15_ then
		if L_3_ and L_3_.Humanoid and L_3_.Humanoid.Health > 0 and L_9_ then
			Stand()
			Unlean()
		end	
		
		L_93_ = 0
		L_80_ = false
		L_81_ = false
		L_82_ = false
		L_64_ = false
		L_67_ = false
		L_66_ = false
		Shooting = false
		
		L_97_ = 70
		
		RemoveArmModel()
		
		L_42_:Destroy()	
		
		for L_198_forvar1, L_199_forvar2 in pairs(IgnoreList) do
			if L_199_forvar2 ~= L_3_ and L_199_forvar2 ~= L_5_ and L_199_forvar2 ~= L_101_ then
				table.remove(IgnoreList, L_198_forvar1)
			end
		end
		
		if L_3_:FindFirstChild('Right Arm') and L_3_:FindFirstChild('Left Arm') then
			L_3_['Right Arm'].LocalTransparencyModifier = 0
			L_3_['Left Arm'].LocalTransparencyModifier = 0
		end	

		L_78_ = false
		L_69_ = true
		
		L_2_.CameraMode = Enum.CameraMode.Classic
		L_107_.MouseIconEnabled = true		
		L_5_.FieldOfView = 70
		L_15_ = false
		L_107_.MouseDeltaSensitivity = L_52_
		L_4_.Icon = ""
		L_15_ = false
		L_4_.TargetFilter = nil
	end
end)

--// Firemode Functions
function CreateBullet(L_200_arg1)
	local L_201_ = L_59_.Position
	local L_202_ = (L_4_.Hit.p - L_201_).unit
	local L_203_ = CFrame.Angles(math.rad(math.random(-L_200_arg1, L_200_arg1)), math.rad(math.random(-L_200_arg1, L_200_arg1)), math.rad(math.random(-L_200_arg1, L_200_arg1)))
	L_202_ = L_203_ * L_202_	
	local L_204_ = CFrame.new(L_201_, L_201_ + L_202_)	
		
	local L_205_ = Instance.new("Part", L_101_)
	game.Debris:AddItem(L_205_, 10)
	L_205_.Shape = Enum.PartType.Ball
	L_205_.Size = Vector3.new(1, 1, 12)
	L_205_.Name = "Bullet"
	L_205_.TopSurface = "Smooth"
	L_205_.BottomSurface = "Smooth"
	L_205_.BrickColor = BrickColor.new("Bright green")
	L_205_.Material = "Neon"
	L_205_.CanCollide = false
		--Bullet.CFrame = FirePart.CFrame + (Grip.CFrame.p - Grip.CFrame.p)
	L_205_.CFrame = L_204_
		
	local L_206_ = Instance.new("Sound")
	L_206_.SoundId = "rbxassetid://341519743"
	L_206_.Looped = true
	L_206_:Play()
	L_206_.Parent = L_205_
	L_206_.Volume = 0.4
	L_206_.MaxDistance = 30
	
	L_205_.Transparency = 1
	local L_207_ = L_205_:GetMass()
	local L_208_ = Instance.new('BodyForce', L_205_)
		
	if not L_83_ then
		L_208_.Force = L_24_.BulletPhysics
		L_205_.Velocity = L_202_ * L_24_.BulletSpeed
	else
		L_208_.Force = L_24_.ExploPhysics
		L_205_.Velocity = L_202_ * L_24_.ExploSpeed
	end
		
	local L_209_ = Instance.new('Attachment', L_205_)
	L_209_.Position = Vector3.new(0.1, 0, 0)
	local L_210_ = Instance.new('Attachment', L_205_)
	L_210_.Position = Vector3.new(-0.1, 0, 0)
			
	local L_211_ = TracerCalculation()
		
	if L_24_.TracerEnabled == true and L_211_ then
		local L_212_ = Instance.new('Trail', L_205_)
		L_212_.Attachment0 = L_209_
		L_212_.Attachment1 = L_210_
		L_212_.Transparency = NumberSequence.new(L_24_.TracerTransparency)
		L_212_.LightEmission = L_24_.TracerLightEmission
		L_212_.TextureLength = L_24_.TracerTextureLength
		L_212_.Lifetime = L_24_.TracerLifetime
		L_212_.FaceCamera = L_24_.TracerFaceCamera
		L_212_.Color = ColorSequence.new(L_24_.TracerColor.Color)
	end
		
	if L_1_:FindFirstChild('Shell') and not L_83_ then	
		CreateShell()	
	end	
		
	delay(0.2, function()
		L_205_.Transparency = 0
	end)
	
	return L_205_
end

function CheckForHumanoid(L_213_arg1)
	local L_214_ = false
	local L_215_ = nil
	if L_213_arg1 then
		if (L_213_arg1.Parent:FindFirstChild("Humanoid") or L_213_arg1.Parent.Parent:FindFirstChild("Humanoid")) then
			L_214_ = true
			if L_213_arg1.Parent:FindFirstChild('Humanoid') then
				L_215_ = L_213_arg1.Parent.Humanoid
			elseif L_213_arg1.Parent.Parent:FindFirstChild('Humanoid') then
				L_215_ = L_213_arg1.Parent.Parent.Humanoid
			end
		else
			L_214_ = false
		end	
	end
	return L_214_, L_215_
end

function CastRay(L_216_arg1)
	local L_217_, L_218_, L_219_
	local L_220_ = L_56_.Position;
	local L_221_ = L_216_arg1.Position;
	local L_222_ = 0

	local L_223_ = L_83_	
	
	while true do
		L_106_:wait()
		L_221_ = L_216_arg1.Position;
		L_222_ = L_222_ + (L_221_ - L_220_).magnitude
		L_217_, L_218_, L_219_ = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_220_, (L_221_ - L_220_)), IgnoreList);
		local L_224_ = Vector3.new(0, 1, 0):Cross(L_219_)
		local L_225_ = math.asin(L_224_.magnitude) -- division by 1 is redundant
		if L_222_ > L_24_.BulletDecay then
			L_216_arg1:Destroy()
			break
		end
		if L_217_ and (L_217_ and L_217_.Transparency >= 1 or L_217_.CanCollide == false) and L_217_.Name ~= 'Right Arm' and L_217_.Name ~= 'Left Arm' and L_217_.Name ~= 'Right Leg' and L_217_.Name ~= 'Left Leg' and L_217_.Name ~= 'Armor' then
			table.insert(IgnoreList, L_217_)
		end
	
		if L_217_ then
			L_224_ = Vector3.new(0, 1, 0):Cross(L_219_)
			L_225_ = math.asin(L_224_.magnitude) -- division by 1 is redundant
		
			L_118_:FireServer(L_218_)
		
			local L_226_ = CheckForHumanoid(L_217_)
			if L_226_ == false then
				L_216_arg1:Destroy()
				local L_227_ = L_113_:InvokeServer(L_218_, L_224_, L_225_, L_219_, "Part", L_217_)
			elseif L_226_ == true then
				L_216_arg1:Destroy()
				local L_228_ = L_113_:InvokeServer(L_218_, L_224_, L_225_, L_219_, "Human", L_217_)
			end
		end
	
		if L_217_ and L_223_ then
			L_116_:FireServer(L_218_)
		end
	
		if L_217_ then
			local L_229_, L_230_ = CheckForHumanoid(L_217_)
			if L_229_ then
				L_111_:FireServer(L_230_)
				if L_24_.AntiTK then
					if game.Players:FindFirstChild(L_230_.Parent.Name) and game.Players:FindFirstChild(L_230_.Parent.Name).TeamColor ~= L_2_.TeamColor or L_230_.Parent:FindFirstChild('Vars') and game.Players:FindFirstChild(L_230_.Parent:WaitForChild('Vars'):WaitForChild('BotID').Value) and L_2_.TeamColor ~= L_230_.Parent:WaitForChild('Vars'):WaitForChild('teamColor').Value then
						if L_217_.Name == 'Head' then
							L_110_:FireServer(L_230_, L_24_.HeadDamage)
							local L_231_ = L_19_:WaitForChild('BodyHit'):clone()
							L_231_.Parent = L_2_.PlayerGui
							L_231_:Play()
							game:GetService("Debris"):addItem(L_231_, L_231_.TimeLength)
						end
						if L_217_.Name ~= 'Head' and not (L_217_.Parent:IsA('Accessory') or L_217_.Parent:IsA('Hat')) then
							if L_217_.Name ~= 'Torso' and L_217_.Name ~= 'HumanoidRootPart' and L_217_.Name ~= 'Armor' then
								L_110_:FireServer(L_230_, L_24_.LimbDamage)
							elseif L_217_.Name == 'Torso' or L_217_.Name == 'HumanoidRootPart' and L_217_.Name ~= 'Armor'  then
								L_110_:FireServer(L_230_, L_24_.BaseDamage)
							elseif L_217_.Name == 'Armor' then
								L_110_:FireServer(L_230_, L_24_.ArmorDamage)
							end
							local L_232_ = L_19_:WaitForChild('BodyHit'):clone()
							L_232_.Parent = L_2_.PlayerGui
							L_232_:Play()
							game:GetService("Debris"):addItem(L_232_, L_232_.TimeLength)
						end
						if (L_217_.Parent:IsA('Accessory') or L_217_.Parent:IsA('Hat')) then
							L_110_:FireServer(L_230_, L_24_.HeadDamage)
							local L_233_ = L_19_:WaitForChild('BodyHit'):clone()
							L_233_.Parent = L_2_.PlayerGui
							L_233_:Play()
							game:GetService("Debris"):addItem(L_233_, L_233_.TimeLength)
						end
					end
				else
					if L_217_.Name == 'Head' then
						L_110_:FireServer(L_230_, L_24_.HeadDamage)
						local L_234_ = L_19_:WaitForChild('BodyHit'):clone()
						L_234_.Parent = L_2_.PlayerGui
						L_234_:Play()
						game:GetService("Debris"):addItem(L_234_, L_234_.TimeLength)
					end
					if L_217_.Name ~= 'Head' and not (L_217_.Parent:IsA('Accessory') or L_217_.Parent:IsA('Hat')) then
						if L_217_.Name ~= 'Torso' and L_217_.Name ~= 'HumanoidRootPart' and L_217_.Name ~= 'Armor' then
							L_110_:FireServer(L_230_, L_24_.LimbDamage)
						elseif L_217_.Name == 'Torso' or L_217_.Name == 'HumanoidRootPart' and L_217_.Name ~= 'Armor' then
							L_110_:FireServer(L_230_, L_24_.BaseDamage)
						elseif L_217_.Name == 'Armor' then
							L_110_:FireServer(L_230_, L_24_.ArmorDamage)
						end
						local L_235_ = L_19_:WaitForChild('BodyHit'):clone()
						L_235_.Parent = L_2_.PlayerGui
						L_235_:Play()
						game:GetService("Debris"):addItem(L_235_, L_235_.TimeLength)
					end
					if (L_217_.Parent:IsA('Accessory') or L_217_.Parent:IsA('Hat')) then
						L_110_:FireServer(L_230_, L_24_.HeadDamage)
						local L_236_ = L_19_:WaitForChild('BodyHit'):clone()
						L_236_.Parent = L_2_.PlayerGui
						L_236_:Play()
						game:GetService("Debris"):addItem(L_236_, L_236_.TimeLength)
					end
				end	
			end
		end
	
		if L_217_ and L_217_.Parent:FindFirstChild("Humanoid") then
			return L_217_, L_218_;
		end
		L_220_ = L_221_;
	end
end

function fireSemi()
	if L_15_ then
		L_69_ = false
		Recoiling = true
		Shooting = true
		
		--CheckReverb()
		if L_54_ then
			L_54_:FireServer(L_59_:WaitForChild('Fire').SoundId, L_59_)
		else
			L_59_:WaitForChild('Fire'):Play()	
		end
		L_109_:FireServer()
		L_102_ = CreateBullet(L_24_.BulletSpread)
		L_103_ = L_103_ - 1
		UpdateAmmo()
		RecoilFront = true
		local L_237_, L_238_ = spawn(function()
			CastRay(L_102_)
		end)
		
		if L_24_.CanBolt == true then
			BoltingBackAnim()
			delay(L_24_.Firerate / 2, function()
				if L_24_.CanSlideLock == false then
					BoltingForwardAnim()
				elseif L_24_.CanSlideLock == true then
					if L_103_ > 0 then
						BoltingForwardAnim()
					end
				end
			end)
		end
		
		delay(L_24_.Firerate / 2, function()
			Recoiling = false
			RecoilFront = false
		end)		
		
		wait(L_24_.Firerate)
		
		local L_239_ = JamCalculation()
		if L_239_ then
			L_69_ = false
		else
			L_69_ = true
		end
		Shooting = false
	end
end

function fireExplo()
	if L_15_ then
		L_69_ = false
		Recoiling = true
		Shooting = true
		if L_54_ then
			L_54_:FireServer(L_60_:WaitForChild('Fire').SoundId, L_60_)
		else
			L_60_:WaitForChild('Fire'):Play()	
		end
		L_109_:FireServer()
		L_102_ = CreateBullet(L_24_.BulletSpread)
		L_105_ = L_105_ - 1
		UpdateAmmo()
		RecoilFront = true
		local L_240_, L_241_ = spawn(function()
			CastRay(L_102_)
		end)
		
		delay(L_24_.Firerate / 2, function()
			Recoiling = false
			RecoilFront = false
		end)		
			
		L_69_ = false
		Shooting = false
	end
end

function fireShot()
	if L_15_ then
		L_69_ = false
		Recoiling = true
		Shooting = true
		RecoilFront = true
		--CheckReverb()
		if L_54_ then
			L_54_:FireServer(L_59_:WaitForChild('Fire').SoundId, L_59_)
		else
			L_59_:WaitForChild('Fire'):Play()	
		end
		L_109_:FireServer()
		for L_243_forvar1 = 1, L_24_.ShotNum do
			spawn(function()
				L_102_ = CreateBullet(L_24_.BulletSpread)
			end)
			local L_244_, L_245_ = spawn(function()
				CastRay(L_102_)
			end)
		end
						
		for L_246_forvar1, L_247_forvar2 in pairs(L_59_:GetChildren()) do
			if L_247_forvar2.Name:sub(1, 7) == "FlashFX" then
				L_247_forvar2.Enabled = true
			end
		end
	
		delay(1 / 30, function()
			for L_248_forvar1, L_249_forvar2 in pairs(L_59_:GetChildren()) do
				if L_249_forvar2.Name:sub(1, 7) == "FlashFX" then
					L_249_forvar2.Enabled = false
				end
			end
		end)
		
		if L_24_.CanBolt == true then
			BoltingBackAnim()
			delay(L_24_.Firerate / 2, function()
				if L_24_.CanSlideLock == false then
					BoltingForwardAnim()
				elseif L_24_.CanSlideLock == true then
					if L_103_ > 0 then
						BoltingForwardAnim()
					end
				end
			end)
		end
		
		delay(L_24_.Firerate / 2, function()
			Recoiling = false
			RecoilFront = false
		end)
		L_103_ = L_103_ - 1
		UpdateAmmo()
		wait(L_24_.Firerate)
		
		L_76_ = true
		BoltBackAnim()
		BoltForwardAnim()
		IdleAnim()
		L_76_ = false
		
		local L_242_ = JamCalculation()
		if L_242_ then
			L_69_ = false
		else
			L_69_ = true
		end
		
		Shooting = false
	end
end

function fireBoltAction()
	if L_15_ then
		L_69_ = false
		Recoiling = true
		Shooting = true
		--CheckReverb()
		if L_54_ then
			L_54_:FireServer(L_59_:WaitForChild('Fire').SoundId, L_59_)
		else
			L_59_:WaitForChild('Fire'):Play()	
		end
		L_109_:FireServer()
		L_102_ = CreateBullet(L_24_.BulletSpread)
		L_103_ = L_103_ - 1
		UpdateAmmo()
		RecoilFront = true
		local L_250_, L_251_ = spawn(function()
			CastRay(L_102_)
		end)
						
		for L_253_forvar1, L_254_forvar2 in pairs(L_59_:GetChildren()) do
			if L_254_forvar2.Name:sub(1, 7) == "FlashFX" then
				L_254_forvar2.Enabled = true
			end
		end
	
		delay(1 / 30, function()
			for L_255_forvar1, L_256_forvar2 in pairs(L_59_:GetChildren()) do
				if L_256_forvar2.Name:sub(1, 7) == "FlashFX" then
					L_256_forvar2.Enabled = false
				end
			end
		end)
		
		if L_24_.CanBolt == true then
			BoltingBackAnim()
			delay(L_24_.Firerate / 2, function()
				if L_24_.CanSlideLock == false then
					BoltingForwardAnim()
				elseif L_24_.CanSlideLock == true then
					if L_103_ > 0 then
						BoltingForwardAnim()
					end
				end
			end)
		end
		
		delay(L_24_.Firerate / 2, function()
			Recoiling = false
			RecoilFront = false
		end)
		wait(L_24_.Firerate)
		
		L_76_ = true
		BoltBackAnim()
		BoltForwardAnim()
		IdleAnim()
		L_76_ = false
		
		local L_252_ = JamCalculation()
		if L_252_ then
			L_69_ = false
		else
			L_69_ = true
		end		
		
		Shooting = false
	end
end

function fireAuto()
	while not Shooting and L_103_ > 0 and L_68_ and L_69_ and L_15_ do
		L_69_ = false
		Recoiling = true
		--CheckReverb()
		if L_54_ then
			L_54_:FireServer(L_59_:WaitForChild('Fire').SoundId, L_59_)
		else
			L_59_:WaitForChild('Fire'):Play()	
		end
		L_109_:FireServer()
		L_103_ = L_103_ - 1
		UpdateAmmo()
		Shooting = true
		RecoilFront = true
		L_102_ = CreateBullet(L_24_.BulletSpread)
		local L_257_, L_258_ = spawn(function()
			CastRay(L_102_)
		end)
					
		for L_260_forvar1, L_261_forvar2 in pairs(L_59_:GetChildren()) do
			if L_261_forvar2.Name:sub(1, 7) == "FlashFX" then
				L_261_forvar2.Enabled = true
			end
		end
	
		delay(1 / 30, function()
			for L_262_forvar1, L_263_forvar2 in pairs(L_59_:GetChildren()) do
				if L_263_forvar2.Name:sub(1, 7) == "FlashFX" then
					L_263_forvar2.Enabled = false
				end
			end
		end)
		
		if L_24_.CanBolt == true then
			BoltingBackAnim()
			delay(L_24_.Firerate / 2, function()
				if L_24_.CanSlideLock == false then
					BoltingForwardAnim()
				elseif L_24_.CanSlideLock == true then
					if L_103_ > 0 then
						BoltingForwardAnim()
					end
				end
			end)
		end
		
		
		delay(L_24_.Firerate / 2, function()
			Recoiling = false
			RecoilFront = false
		end)
		wait(L_24_.Firerate)
		
		local L_259_ = JamCalculation()
		if L_259_ then
			L_69_ = false
		else
			L_69_ = true
		end
		
		Shooting = false
	end
end

function fireBurst()
	if not Shooting and L_103_ > 0 and L_68_ and L_15_ then
		for L_264_forvar1 = 1, L_24_.BurstNum do
			if L_103_ > 0 and L_68_ then
				L_69_ = false
				Recoiling = true
			--CheckReverb()
				if L_54_ then
					L_54_:FireServer(L_59_:WaitForChild('Fire').SoundId, L_59_)
				else
					L_59_:WaitForChild('Fire'):Play()	
				end
				L_109_:FireServer()
				L_102_ = CreateBullet(L_24_.BulletSpread)
				local L_265_, L_266_ = spawn(function()
					CastRay(L_102_)
				end)
					
				for L_268_forvar1, L_269_forvar2 in pairs(L_59_:GetChildren()) do
					if L_269_forvar2.Name:sub(1, 7) == "FlashFX" then
						L_269_forvar2.Enabled = true
					end
				end
		
				delay(1 / 30, function()
					for L_270_forvar1, L_271_forvar2 in pairs(L_59_:GetChildren()) do
						if L_271_forvar2.Name:sub(1, 7) == "FlashFX" then
							L_271_forvar2.Enabled = false
						end
					end
				end)
			
				if L_24_.CanBolt == true then
					BoltingBackAnim()
					delay(L_24_.Firerate / 2, function()
						if L_24_.CanSlideLock == false then
							BoltingForwardAnim()
						elseif L_24_.CanSlideLock == true then
							if L_103_ > 0 then
								BoltingForwardAnim()
							end
						end
					end)
				end
			
				L_103_ = L_103_ - 1
				UpdateAmmo()
				RecoilFront = true
				delay(L_24_.Firerate / 2, function()
					Recoiling = false
					RecoilFront = false
				end)
				wait(L_24_.Firerate)
			
				local L_267_ = JamCalculation()
				if L_267_ then
					L_69_ = false
				else
					L_69_ = true
				end
		
			end
			Shooting = true
		end
		Shooting = false
	end
end

function Shoot()
	if L_15_ and L_69_ then
		if L_92_ == 1 then
			fireSemi()
		elseif L_92_ == 2 then
			fireAuto()
		elseif L_92_ == 3 then
			fireBurst()	
		elseif L_92_ == 4 then
			fireBoltAction()
		elseif L_92_ == 5 then
			fireShot()
		elseif L_92_ == 6 then
			fireExplo()
		end
	end
end

--// Walk and Sway
local L_136_

local L_137_ = 0.6
local L_138_ = 0.05 -- speed
local L_139_ = -0.1 -- height

local L_140_ = 0
local L_141_ = 0
local L_142_ = 35 --This is the limit of the mouse input for the sway
local L_143_ = -9 --This is the magnitude of the sway when you're unaimed
local L_144_ = -9 --This is the magnitude of the sway when you're aimed

--local Sprinting =false
local L_145_ = L_121_.new(Vector3.new())
L_145_.s = 15
L_145_.d = 0.5

game:GetService("UserInputService").InputChanged:connect(function(L_272_arg1) --Get the mouse delta for the gun sway
	if L_272_arg1.UserInputType == Enum.UserInputType.MouseMovement then
		L_140_ = math.min(math.max(L_272_arg1.Delta.x, -L_142_), L_142_)
		L_141_ = math.min(math.max(L_272_arg1.Delta.y, -L_142_), L_142_)
	end
end)

L_4_.Idle:connect(function() --Reset the sway to 0 when the mouse is still
	L_140_ = 0
	L_141_ = 0
end)

local L_146_ = false
local L_147_ = CFrame.new()
local L_148_ = CFrame.new()

local L_149_ 
local L_150_
local L_151_
local L_152_

local L_153_
local L_154_
local L_155_

if not L_24_.TacticalModeEnabled then
	L_149_ = 0
	L_150_ = CFrame.new()
	L_151_ = 0.1
	L_152_ = 2
	
	L_153_ = 0
	L_154_ = .2
	L_155_ = 17
else
	L_149_ = 0
	L_150_ = CFrame.new()
	L_151_ = 0.05
	L_152_ = 2
	
	L_153_ = 0
	L_154_ = 0.09
	L_155_ = 11
end

local L_156_ = 0
local L_157_ = 5
local L_158_ = .3

local L_159_, L_160_ = 0, 0

local L_161_ = nil
local L_162_ = nil
local L_163_ = nil

L_3_.Humanoid.Running:connect(function(L_273_arg1)
	if L_273_arg1 > 1 then
		L_146_ = true
	else
		L_146_ = false
	end
end)

--// Renders
local L_164_

L_106_:connect(function()
	if L_15_ then
		L_159_, L_160_ = L_159_ or 0, L_160_ or 0
		if L_162_ == nil or L_161_ == nil then
			L_162_ = L_45_.C0
			L_161_ = L_45_.C1
		end
		
		local L_274_ = (math.sin(L_153_ * L_155_ / 2) * L_154_)
		local L_275_ = (math.sin(L_153_ * L_155_) * L_154_)
		local L_276_ = CFrame.new(L_274_, L_275_, 0.02)
		
		local L_277_ = (math.sin(L_153_ * L_155_ / 2) * L_154_)
		local L_278_ = (math.sin(L_153_ * L_155_) * L_154_)
		local L_279_ = CFrame.new(L_274_, L_275_, 0.02) * CFrame.Angles((math.cos(L_153_ * L_155_) * L_154_), (math.cos(L_153_ * L_155_ / 2) * L_154_), 0)
		
		local L_280_ = (math.sin(L_149_ * L_152_ / 2) * L_151_)
		local L_281_ = (math.cos(L_149_ * L_152_) * L_151_)
		local L_282_ = CFrame.new(L_280_, L_281_, 0.02)
		
		if L_146_ then
			L_153_ = L_153_ + .017
			if L_24_.WalkAnimEnabled == true then
				if L_24_.TacticalModeEnabled then
					L_147_ = L_279_
				else
					L_147_ = L_276_
				end
			else
				L_147_ = CFrame.new()
			end
		else
			L_153_ = 0
			L_147_ = CFrame.new()
		end
		
		L_145_.t = Vector3.new(L_140_, L_141_, 0)
		local L_283_ = L_145_.p
		local L_284_ = L_283_.X / L_142_ * (L_64_ and L_144_ or L_143_)
		local L_285_ = L_283_.Y / L_142_ * (L_64_ and L_144_ or L_143_)
		
		L_5_.CFrame = L_5_.CFrame:lerp(L_5_.CFrame * L_148_, 0.2)
		
		if L_64_ then
			L_136_ = CFrame.Angles(math.rad(-L_284_), math.rad(L_284_), math.rad(L_285_)) * CFrame.fromAxisAngle(Vector3.new(5, 0, -1), math.rad(L_284_))	
			L_149_ = 0
			L_150_ = CFrame.new()
		elseif not L_64_ then
			L_136_ = CFrame.Angles(math.rad(-L_285_), math.rad(-L_284_), math.rad(-L_284_)) * CFrame.fromAxisAngle(L_44_.Position, math.rad(-L_285_))
			L_149_ = L_149_ + 0.017			
			L_150_ = L_282_
		end
		
		if L_24_.SwayEnabled ==  true then
			L_45_.C0 = L_45_.C0:lerp(L_162_ * L_136_ * L_147_ * L_150_, 0.1)
		else
			L_45_.C0 = L_45_.C0:lerp(L_162_ * L_147_, 0.1)
		end		
		
		if L_67_ and not L_70_ and L_72_ and not L_64_ and not L_66_ and not Shooting then
			L_45_.C1 = L_45_.C1:lerp(L_45_.C0 * L_24_.SprintPos, 0.1)
		elseif not L_67_ and not L_70_ and not L_72_ and not L_64_ and not L_66_ and not Shooting and not L_79_ then
			L_45_.C1 = L_45_.C1:lerp(CFrame.new() * L_134_, 0.05)
		end
		
		
		if L_64_ and not L_67_ then
			if not L_65_ then
				L_90_ = L_24_.AimCamRecoil
				L_89_ = L_24_.AimGunRecoil
				L_91_ = L_24_.AimKickback
			elseif L_65_ then
				if L_93_ == 1 then
					L_90_ = L_24_.AimCamRecoil / 1.5
					L_89_ = L_24_.AimGunRecoil / 1.5
					L_91_ = L_24_.AimKickback / 1.5
				end
				
				if L_93_ == 2 then
					L_90_ = L_24_.AimCamRecoil / 2
					L_89_ = L_24_.AimGunRecoil / 2
					L_91_ = L_24_.AimKickback / 2
				end
			end
			
			if (L_3_.Head.Position - L_5_.CoordinateFrame.p).magnitude < 2 then
				L_45_.C1 = L_45_.C1:lerp(L_45_.C0 * L_56_.CFrame:toObjectSpace(L_44_.CFrame), L_24_.AimSpeed)
				
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Visible = true
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Text = L_51_
				L_107_.MouseDeltaSensitivity = L_51_
			end
		elseif not L_64_ and not L_67_ and L_15_ and not L_79_ then
			if (L_3_.Head.Position - L_5_.CoordinateFrame.p).magnitude < 2 then
				L_45_.C1 = L_45_.C1:lerp(CFrame.new() * L_134_, L_24_.UnaimSpeed)
				
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Visible = false
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Text = L_51_
				L_107_.MouseDeltaSensitivity = L_52_
			end	
			
			if not L_65_ then
				L_90_ = L_24_.camrecoil
				L_89_ = L_24_.gunrecoil
				L_91_ = L_24_.Kickback
			elseif L_65_ then
				if L_93_ == 1 then
					L_90_ = L_24_.camrecoil / 1.5
					L_89_ = L_24_.gunrecoil / 1.5
					L_91_ = L_24_.Kickback / 1.5
				end
				
				if L_93_ == 2 then
					L_90_ = L_24_.camrecoil / 2
					L_89_ = L_24_.gunrecoil / 2
					L_91_ = L_24_.Kickback / 2
				end
			end	
		end
		
		if Recoiling then
			if not L_64_ then
				L_148_ = CFrame.fromEulerAnglesXYZ(math.rad(L_90_ * math.random(0, L_24_.CamShake)), math.rad(L_90_ * math.random(-L_24_.CamShake, L_24_.CamShake)), math.rad(L_90_ * math.random(-L_24_.CamShake, L_24_.CamShake)))--CFrame.Angles(camrecoil,0,0)	
			else
				L_148_ = CFrame.fromEulerAnglesXYZ(math.rad(L_90_ * math.random(0, L_24_.AimCamShake)), math.rad(L_90_ * math.random(-L_24_.AimCamShake, L_24_.AimCamShake)), math.rad(L_90_ * math.random(-L_24_.AimCamShake, L_24_.AimCamShake)))
			end
			--cam.CoordinateFrame = cam.CoordinateFrame *  CFrame.fromEulerAnglesXYZ(math.rad(camrecoil*math.random(0,3)), math.rad(camrecoil*math.random(-1,1)), math.rad(camrecoil*math.random(-1,1)))
			L_45_.C0 = L_45_.C0:lerp(L_45_.C0 * CFrame.new(0, 0, L_89_) * CFrame.Angles(-math.rad(L_91_), 0, 0), 0.3)
		elseif not Recoiling then	
			L_148_ = CFrame.Angles(0, 0, 0)
			L_45_.C0 = L_45_.C0:lerp(CFrame.new(), 0.2)
		end
		
		if L_65_ then
			L_3_:WaitForChild('Humanoid').Jump = false
		end
		
		if L_15_ then 
			L_5_.FieldOfView = L_5_.FieldOfView * (1 - L_24_.ZoomSpeed) + (L_97_ * L_24_.ZoomSpeed)
			if (L_3_.Head.Position - L_5_.CoordinateFrame.p).magnitude >= 2 then
				L_90_ = L_24_.AimCamRecoil
				L_89_ = L_24_.AimGunRecoil
				L_91_ = L_24_.AimKickback
				
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Visible = true
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Text = L_51_
				L_107_.MouseDeltaSensitivity = L_51_
			elseif (L_3_.Head.Position - L_5_.CoordinateFrame.p).magnitude < 2 and not L_64_ and not L_65_ then
				L_90_ = L_24_.camrecoil
				L_89_ = L_24_.gunrecoil
				L_91_ = L_24_.Kickback
				
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Visible = false
				L_42_:WaitForChild('Sense'):WaitForChild('Sensitivity').Text = L_51_
				L_107_.MouseDeltaSensitivity = L_52_
			end
		end
		
		if L_15_ and L_24_.CameraGo then --and (char.Head.Position - cam.CoordinateFrame.p).magnitude < 2 then
			L_4_.TargetFilter = game.Workspace
			local L_286_ =  L_3_:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 1.5, 0) * CFrame.new(L_3_:WaitForChild("Humanoid").CameraOffset)
			L_48_.C0 = L_8_.CFrame:toObjectSpace(L_286_)
			L_48_.C1 = CFrame.Angles(-math.asin((L_4_.Hit.p - L_4_.Origin.p).unit.y), 0, 0)
			L_107_.MouseIconEnabled = false	
		end
		
		if L_15_ and (L_3_.Head.Position - L_5_.CoordinateFrame.p).magnitude >= 2 then
			if L_4_.Icon ~= "http://www.roblox.com/asset?id=" .. L_24_.TPSMouseIcon then
				L_4_.Icon = "http://www.roblox.com/asset?id=" .. L_24_.TPSMouseIcon
			end
			L_107_.MouseIconEnabled = true
			
			if L_3_:FindFirstChild('Right Arm') and L_3_:FindFirstChild('Left Arm') then
				L_3_['Right Arm'].LocalTransparencyModifier = 1
				L_3_['Left Arm'].LocalTransparencyModifier = 1
			end
		end;
	end
end)

--// Stances
function Prone()
	UpdateAmmo()
	L_112_:FireServer("Prone")	
	
	L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
		CameraOffset = Vector3.new(0, -3, 0)
	}):Play()
	L_3_:WaitForChild("Humanoid").WalkSpeed = 4
	
	if not L_24_.TacticalModeEnabled then
		L_155_ = 4
		L_154_ = 0.025
	else
		L_154_ = 0.01
		L_155_ = 4
	end
	
	L_65_ = true
	
	Proned2 = Vector3.new(0, 0.5, 0.5)
	L_130_(L_9_,  CFrame.new(0, -2.4201169, -0.0385534465, -0.99999994, -5.86197757e-012, -4.54747351e-013, 5.52669195e-012, 0.998915195, 0.0465667509, 0, 0.0465667509, -0.998915195), nil, function(L_287_arg1)
		return math.sin(math.rad(L_287_arg1))
	end, 0.25)
	L_130_(L_10_,  CFrame.new(1.00000191, -1, -5.96046448e-008, 1.31237243e-011, -0.344507754, 0.938783348, 0, 0.938783467, 0.344507784, -1, 0, -1.86264515e-009) , nil, function(L_288_arg1)
		return math.sin(math.rad(L_288_arg1))
	end, 0.25)
	L_130_(L_11_,  CFrame.new(-0.999996185, -1, -1.1920929e-007, -2.58566502e-011, 0.314521015, -0.949250221, 0, 0.94925046, 0.314521164, 1, 3.7252903e-009, 1.86264515e-009) , nil, function(L_289_arg1)
		return math.sin(math.rad(L_289_arg1))
	end, 0.25)
end

function Stand()
	UpdateAmmo()
	L_112_:FireServer("Stand")
	
	L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
		CameraOffset = Vector3.new(0, 0, 0)
	}):Play()
	
	L_65_ = false		
	
	if not L_64_ then
		L_3_:WaitForChild("Humanoid").WalkSpeed = 16
		if L_24_.TacticalModeEnabled then
			L_154_ = 0.09
			L_155_ = 11
		else
			L_154_ = .2
			L_155_ = 17
		end
	elseif L_64_ then
		if L_24_.TacticalModeEnabled then
			L_154_ = 0.015
			L_155_ = 7
			L_3_:WaitForChild("Humanoid").WalkSpeed = 7
		else
			L_3_:WaitForChild("Humanoid").WalkSpeed = 16
			L_155_ = 10
			L_154_ = 0.02
		end
	end
	
	Proned2 = Vector3.new(0, 0, 0)
	L_130_(L_9_, CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), nil, function(L_290_arg1)
		return math.sin(math.rad(L_290_arg1))
	end, 0.25)
	L_130_(L_10_,  CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), nil, function(L_291_arg1)
		return math.sin(math.rad(L_291_arg1))
	end, 0.25)
	L_130_(L_11_,  CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), nil, function(L_292_arg1)
		return math.sin(math.rad(L_292_arg1))
	end, 0.25)
end

function Crouch()
	UpdateAmmo()
	L_112_:FireServer("Crouch")
	
	L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
		CameraOffset = Vector3.new(0, -1, 0)
	}):Play()
	L_3_:WaitForChild("Humanoid").WalkSpeed = 9
	
	if not L_24_.TacticalModeEnabled then
		L_155_ = 9
		L_154_ = 0.035
	else
		L_154_ = 0.015
		L_155_ = 9
	end
	
	L_65_ = true
	
	Proned2 = Vector3.new(0, 0, 0)
	L_130_(L_9_, CFrame.new(0, -1.04933882, 0, -1, 0, -1.88871293e-012, 1.88871293e-012, -3.55271368e-015, 1, 0, 1, -3.55271368e-015), nil, function(L_293_arg1)
		return math.sin(math.rad(L_293_arg1))
	end, 0.25)
	L_130_(L_10_,  CFrame.new(1, 0.0456044674, -0.494239986, 6.82121026e-013, -1.22639676e-011, 1, -0.058873821, 0.998265445, -1.09836602e-011, -0.998265445, -0.058873821, 0), nil, function(L_294_arg1)
		return math.sin(math.rad(L_294_arg1))
	end, 0.25)
	L_130_(L_11_,  CFrame.new(-1.00000381, -0.157019258, -0.471293032, -8.7538865e-012, -8.7538865e-012, -1, 0.721672177, 0.692235112, 1.64406284e-011, 0.692235112, -0.721672177, 0), nil, function(L_295_arg1)
		return math.sin(math.rad(L_295_arg1))
	end, 0.25)
	L_130_(L_6_:WaitForChild("Neck"), nil, CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), function(L_296_arg1)
		return math.sin(math.rad(L_296_arg1))
	end, 0.25)
end

function LeanRight()
	if L_93_ ~= 2 then
		L_112_:FireServer("LeanRight")
		L_130_(L_9_, nil, CFrame.new(0, 0.200000003, 0, -0.939692616, 0, -0.342020124, -0.342020124, 0, 0.939692616, 0, 1, 0), function(L_297_arg1)
			return math.sin(math.rad(L_297_arg1))
		end, 0.25)
		L_130_(L_10_, nil, CFrame.new(0.300000012, 0.600000024, 0, 0, 0.342020124, 0.939692616, 0, 0.939692616, -0.342020124, -1, 0, 0), function(L_298_arg1)
			return math.sin(math.rad(L_298_arg1))
		end, 0.25)
		L_130_(L_11_,  nil, nil, function(L_299_arg1)
			return math.sin(math.rad(L_299_arg1))
		end, 0.25)	
		L_130_(L_6_:WaitForChild("Clone"), nil, CFrame.new(-0.400000006, -0.300000012, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), function(L_300_arg1)
			return math.sin(math.rad(L_300_arg1))
		end, 0.25)
		if not L_65_ then
			L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
				CameraOffset = Vector3.new(1, -0.5, 0)
			}):Play()	
		elseif L_65_ then
			if L_93_ == 1 then
				L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
					CameraOffset = Vector3.new(1, -1.5, 0)
				}):Play()	
			end
		end;
	end	
end

function LeanLeft()
	if L_93_ ~= 2 then
		L_112_:FireServer("LeanLeft")
		L_130_(L_9_, nil, CFrame.new(0, 0.200000003, 0, -0.939692616, 0, 0.342020124, 0.342020124, 0, 0.939692616, 0, 1, 0), function(L_301_arg1)
			return math.sin(math.rad(L_301_arg1))
		end, 0.25)
		L_130_(L_10_, nil, nil, function(L_302_arg1)
			return math.sin(math.rad(L_302_arg1))
		end, 0.25)
		L_130_(L_11_,  nil, CFrame.new(-0.300000012, 0.600000024, 0, 0, -0.342020124, -0.939692616, 0, 0.939692616, -0.342020124, 1, 0, 0), function(L_303_arg1)
			return math.sin(math.rad(L_303_arg1))
		end, 0.25)
		L_130_(L_6_:WaitForChild("Clone"), nil, CFrame.new(0.400000006, -0.300000012, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), function(L_304_arg1)
			return math.sin(math.rad(L_304_arg1))
		end, 0.25)
		if not L_65_ then
			L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
				CameraOffset = Vector3.new(-1, -0.5, 0)
			}):Play()	
		elseif L_65_ then
			if L_93_ == 1 then
				L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
					CameraOffset = Vector3.new(-1, -1.5, 0)
				}):Play()	
			end
		end;
	end	
end

function Unlean()
	if L_93_ ~= 2 then
		L_112_:FireServer("Unlean")
		L_130_(L_9_, nil, CFrame.new(0, 0, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0), function(L_305_arg1)
			return math.sin(math.rad(L_305_arg1))
		end, 0.25)
		L_130_(L_10_, nil, CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0), function(L_306_arg1)
			return math.sin(math.rad(L_306_arg1))
		end, 0.25)
		L_130_(L_11_,  nil, CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0), function(L_307_arg1)
			return math.sin(math.rad(L_307_arg1))
		end, 0.25)	
		if L_6_:FindFirstChild('Clone') then
			L_130_(L_6_:WaitForChild("Clone"), nil, CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0), function(L_308_arg1)
				return math.sin(math.rad(L_308_arg1))
			end, 0.25)
		end		
		if not L_65_ then
			L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
				CameraOffset = Vector3.new(0, 0, 0)
			}):Play()	
		elseif L_65_ then			
			if L_93_ == 1 then
				L_14_:Create(L_3_:WaitForChild('Humanoid'), TweenInfo.new(0.3), {
					CameraOffset = Vector3.new(0, -1, 0)
				}):Play()	
			end
		end;
	end
end
	
local L_165_ = false

L_107_.InputBegan:connect(function(L_309_arg1, L_310_arg2)
	if not L_310_arg2 and L_15_ == true then
		if L_15_ then
			if L_309_arg1.KeyCode == Enum.KeyCode.C or L_309_arg1.KeyCode == Enum.KeyCode.ButtonB then 
				if L_93_ == 0 and not L_67_ and L_15_ then			
					L_93_ = 1
					Crouch()
				
					L_94_ = false
					L_96_ = true
					L_95_ = false
				elseif L_93_ == 1 and not L_67_ and L_15_ then
					L_93_ = 2
					Prone()
				
					L_96_ = false
					L_94_ = true
					L_95_ = false
					L_165_ = true
				end
			end
							
					
			if L_309_arg1.KeyCode == Enum.KeyCode.X or L_309_arg1.KeyCode == Enum.KeyCode.ButtonY then 
				if L_93_ == 2 and not L_67_ and L_15_ then
					L_165_ = false		
					L_93_ = 1
					Crouch()
					
					L_94_ = false
					L_96_ = true
					L_95_ = false
				elseif L_93_ == 1 and not L_67_ and L_15_ then		
					L_93_ = 0
					Stand()
				
					L_94_ = false
					L_96_ = false
					L_95_ = true
				end
			end
		end
	end
end)

--// Touch Connections
L_3_:WaitForChild('Humanoid').Touched:connect(function(L_311_arg1)
	local L_312_, L_313_ = SearchResupply(L_311_arg1)
	if L_312_ and L_17_ then
		L_17_ = false
		L_103_ = L_24_.Ammo
		L_104_ = L_24_.StoredAmmo * L_24_.MagCount
		L_105_ = L_24_.ExplosiveAmmo
		if L_58_:FindFirstChild('Resupply') then
			L_58_.Resupply:Play()
		end
		wait(15)
		L_17_ = true
	end;
end)

--// Input Connections
L_107_.InputBegan:connect(function(L_314_arg1, L_315_arg2)
	if not L_315_arg2 and L_15_ then
		if L_314_arg1.UserInputType == (Enum.UserInputType.MouseButton2 or L_314_arg1.KeyCode == Enum.KeyCode.ButtonL2) and not L_79_ and not L_78_ and not L_77_ and L_24_.CanAim and not L_74_ and L_15_ and not L_66_ and not L_67_ then
			if not L_64_ then
				if not L_65_ then
					if L_24_.TacticalModeEnabled then
						L_154_ = 0.015
						L_155_ = 7
						L_3_:WaitForChild("Humanoid").WalkSpeed = 7
					else
						L_155_ = 10
						L_154_ = 0.008
						L_3_:WaitForChild("Humanoid").WalkSpeed = 10
					end
					
				end
				
				if (L_3_.Head.Position - L_5_.CoordinateFrame.p).magnitude <= 2 then
					L_97_ = L_50_
				end
				L_133_.target = L_56_.CFrame:toObjectSpace(L_44_.CFrame).p
				L_115_:FireServer(true)				
				L_64_ = true
			end
		end;
		
		if L_314_arg1.KeyCode == Enum.KeyCode.A and L_15_ then
			L_134_ = CFrame.Angles(0, 0, 0.1)
		end;
		
		if L_314_arg1.KeyCode == Enum.KeyCode.D and L_15_ then
			L_134_ = CFrame.Angles(0, 0, -0.1)
		end;
		
		if L_314_arg1.KeyCode == Enum.KeyCode.E and L_15_ and not L_80_ and not L_81_ then
			L_80_ = true
			L_82_ = false
			L_81_ = true
			LeanRight()
		end
		
		if L_314_arg1.KeyCode == Enum.KeyCode.Q and L_15_ and not L_80_ and not L_82_ then
			L_80_ = true
			L_81_ = false
			L_82_ = true
			LeanLeft()
		end
		
		if L_314_arg1.KeyCode == L_24_.AlternateAimKey and not L_79_ and not L_78_ and not L_77_ and L_24_.CanAim and not L_74_ and L_15_ and not L_66_ and not L_67_ then
			if not L_64_ then
				if not L_65_ then
					L_3_.Humanoid.WalkSpeed = 10
					L_155_ = 10
					L_154_ = 0.008
				end
				L_97_ = L_50_
				L_133_.target = L_56_.CFrame:toObjectSpace(L_44_.CFrame).p
				L_115_:FireServer(true)
				L_64_ = true
			end
		end;
		
		if L_314_arg1.UserInputType == (Enum.UserInputType.MouseButton1 or L_314_arg1.KeyCode == Enum.KeyCode.ButtonR2) and not L_79_ and not L_77_ and L_69_ and L_15_ and not L_66_ and not L_67_ and not L_74_ then
			L_68_ = true
			if not Shooting and L_15_ and not L_83_ then
				if L_103_ > 0 then			
					Shoot()
				end
			elseif not Shooting and L_15_ and L_83_ then
				if L_105_ > 0 then
					Shoot()
				end
			end
		end;
		
		if L_314_arg1.KeyCode == (L_24_.LaserKey or L_314_arg1.KeyCode == Enum.KeyCode.DPadRight) and L_15_ and L_24_.LaserAttached then
			local L_316_ = L_1_:FindFirstChild("LaserLight")
			L_122_.KeyDown[1].Plugin()
		end;
		
		if L_314_arg1.KeyCode == (L_24_.LightKey or L_314_arg1.KeyCode == Enum.KeyCode.ButtonR3) and L_15_ and L_24_.LightAttached then
			local L_317_ = L_1_:FindFirstChild("FlashLight"):FindFirstChild('Light')
			local L_318_ = false
			L_317_.Enabled = not L_317_.Enabled
		end;
		
		if L_15_ and L_314_arg1.KeyCode == (L_24_.FireSelectKey or L_314_arg1.KeyCode == Enum.KeyCode.DPadUp) and not L_79_ and not L_70_ and not L_78_ then
			L_70_ = true
			if L_92_ == 1 then
				if Shooting then
					Shooting = false
				end
				if L_24_.AutoEnabled then
					L_92_ = 2
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.AutoEnabled and L_24_.BurstEnabled then
					L_92_ = 3
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.AutoEnabled and not L_24_.BurstEnabled and L_24_.BoltAction then
					L_92_ = 4
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.AutoEnabled and not L_24_.BurstEnabled and not L_24_.BoltAction and L_24_.ExplosiveEnabled then
					L_92_ = 6
					L_83_ = true
					L_84_ = L_69_
					L_69_ = L_85_
				elseif not L_24_.AutoEnabled and not L_24_.BurstEnabled and not L_24_.BoltAction and not L_24_.ExplosiveEnabled then
					L_92_ = 1
					L_83_ = false
					L_69_ = L_84_
				end
			elseif L_92_ == 2 then
				if Shooting then
					Shooting = false
				end
				if L_24_.BurstEnabled then
					L_92_ = 3
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.BurstEnabled and L_24_.BoltAction then
					L_92_ = 4
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.BurstEnabled and not L_24_.BoltAction and L_24_.ExplosiveEnabled then
					L_92_ = 6
					L_83_ = true
					L_84_ = L_69_
					L_69_ = L_85_
				elseif not L_24_.BurstEnabled and not L_24_.BoltAction and not L_24_.ExplosiveEnabled and L_24_.SemiEnabled then
					L_92_ = 1
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.BurstEnabled and not L_24_.BoltAction and not L_24_.SemiEnabled then
					L_92_ = 2
					L_83_ = false
					L_69_ = L_84_
				end
			elseif L_92_ == 3 then
				if Shooting then
					Shooting = false
				end
				if L_24_.BoltAction then
					L_92_ = 4
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.BoltAction and L_24_.ExplosiveEnabled then
					L_92_ = 6
					L_83_ = true
					L_84_ = L_69_
					L_69_ = L_85_
				elseif not L_24_.BoltAction and not L_24_.ExplosiveEnabled and L_24_.SemiEnabled then
					L_92_ = 1
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.BoltAction and not L_24_.SemiEnabled and L_24_.AutoEnabled then
					L_92_ = 2
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.BoltAction and not L_24_.SemiEnabled and not L_24_.AutoEnabled then
					L_92_ = 3
					L_83_ = false
					L_69_ = L_84_
				end
			elseif L_92_ == 4 then
				if Shooting then
					Shooting = false
				end
				if L_24_.ExplosiveEnabled then
					L_92_ = 6
					L_83_ = true
					L_84_ = L_69_
					L_69_ = L_85_
				elseif not L_24_.ExplosiveEnabled and L_24_.SemiEnabled then
					L_92_ = 1
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.SemiEnabled and L_24_.AutoEnabled then
					L_92_ = 2
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.SemiEnabled and not L_24_.AutoEnabled and L_24_.BurstEnabled then
					L_92_ = 3
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.SemiEnabled and not L_24_.AutoEnabled and not L_24_.BurstEnabled then
					L_92_ = 4
					L_83_ = false
					L_69_ = L_84_
				end
			elseif L_92_ == 6 then
				if Shooting then
					Shooting = false
				end
				L_85_ = L_69_
				if L_24_.SemiEnabled then
					L_92_ = 1
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.SemiEnabled and L_24_.AutoEnabled then
					L_92_ = 2
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.SemiEnabled and not L_24_.AutoEnabled and L_24_.BurstEnabled then
					L_92_ = 3
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.SemiEnabled and not L_24_.AutoEnabled and not L_24_.BurstEnabled and L_24_.BoltAction then
					L_92_ = 4
					L_83_ = false
					L_69_ = L_84_
				elseif not L_24_.SemiEnabled and not L_24_.AutoEnabled and not L_24_.BurstEnabled and not L_24_.BoltAction then
					L_92_ = 6
					L_83_ = true
					L_84_ = L_69_
					L_69_ = L_85_
				end
			end
			UpdateAmmo()
			FireModeAnim()
			IdleAnim()
			L_70_ = false
		end;
		
		if L_314_arg1.KeyCode == (Enum.KeyCode.F or L_314_arg1.KeyCode == Enum.KeyCode.DPadDown) and not L_79_ and not L_77_ and not L_78_ and not L_67_ and not L_70_ and not L_64_ and not L_66_ and not Shooting and not L_76_ then			
			if not L_73_ and not L_74_ then
				L_74_ = true
				Shooting = false
				L_69_ = false
				L_135_ = time()
				delay(0.6, function()
					if L_103_ ~= L_24_.Ammo and L_103_ > 0 then
						CreateShell()
					end
				end)	
				BoltBackAnim()
				L_73_ = true
			elseif L_73_ and L_74_ then
				BoltForwardAnim()
				Shooting = false
				L_69_ = true
				if L_103_ ~= L_24_.Ammo and L_103_ > 0 then
					L_103_ = L_103_ - 1
				elseif L_103_ >= L_24_.Ammo then
					L_69_ = true
				end						
				L_73_ = false
				L_74_ = false
				IdleAnim()
				L_75_ = false
			end
			UpdateAmmo()
		end;
		
		if L_314_arg1.KeyCode == (Enum.KeyCode.LeftShift or L_314_arg1.KeyCode == Enum.KeyCode.ButtonL3) and not L_78_ and not L_77_ and L_146_ then
			L_71_ = true
			if L_15_ and not L_70_ and not L_67_ and L_71_ and not L_65_ and not L_74_ then
				Shooting = false
				L_64_ = false
				L_67_ = true
						
				delay(0, function()
					if L_67_ and not L_66_ then
						L_64_ = false
						L_72_ = true
					end
				end)
				L_97_ = 80
				if L_24_.TacticalModeEnabled then
					L_154_ = 0.4
					L_155_ = 16
				else
					L_155_ = L_24_.SprintSpeed
					L_154_ = 0.4
				end
				L_3_.Humanoid.WalkSpeed = L_24_.SprintSpeed
			end
		end;
		
		if L_314_arg1.KeyCode == (Enum.KeyCode.R or L_314_arg1.KeyCode == Enum.KeyCode.ButtonX) and not L_79_ and not L_78_ and not L_77_ and L_15_ and not L_66_ and not L_64_ and not Shooting and not L_67_ and not L_74_ then		
			if not L_83_ then			
				if L_104_ > 0 and L_103_ < L_24_.Ammo then
					Shooting = false
					L_66_ = true
					
					for L_319_forvar1, L_320_forvar2 in pairs(game.Players:GetChildren()) do
						if L_320_forvar2 and L_320_forvar2:IsA('Player') and L_320_forvar2 ~= L_2_ and L_320_forvar2.TeamColor == L_2_.TeamColor then
							if (L_320_forvar2.Character.HumanoidRootPart.Position - L_3_.HumanoidRootPart.Position).magnitude  <= 150 then
								if L_7_:FindFirstChild('AHH') and not L_7_.AHH.IsPlaying then
									L_119_:FireServer(L_7_.AHH, L_100_[math.random(0, 23)])
								end
							end
						end
					end
					
					ReloadAnim()
					if L_103_ <= 0 then
						if not L_24_.CanSlideLock then
							BoltBackAnim()
							BoltForwardAnim()
						end
					end
					IdleAnim()
					L_69_ = true
					
					if L_103_ <= 0 then
						if (L_104_ - (L_24_.Ammo - L_103_)) < 0 then
							L_103_ = L_103_ + L_104_
							L_104_ = 0
						else
							L_104_ = L_104_ - (L_24_.Ammo - L_103_)
							L_103_ = L_24_.Ammo
						end
					elseif L_103_ > 0 then
						if (L_104_ - (L_24_.Ammo - L_103_)) < 0 then
							L_103_ = L_103_ + L_104_ + 1
							L_104_ = 0
						else
							L_104_ = L_104_ - (L_24_.Ammo - L_103_)
							L_103_ = L_24_.Ammo + 1
						end
					end
	
					L_66_ = false
					if not L_75_ then
						L_69_ = true
					end
				end;
			elseif L_83_ then
				if L_105_ > 0 then
					Shooting = false
					L_66_ = true
					nadeReload()
					IdleAnim()
					L_66_ = false
					L_69_ = true
				end
			end;
			UpdateAmmo()
		end;
		
		if L_314_arg1.KeyCode == Enum.KeyCode.RightBracket and L_64_ then
			if (L_51_ < 1) then
				L_51_ = L_51_ + L_24_.SensitivityIncrement
			end
		end
		
		if L_314_arg1.KeyCode == Enum.KeyCode.LeftBracket and L_64_ then
			if (L_51_ > 0.1) then
				L_51_ = L_51_ - L_24_.SensitivityIncrement
			end
		end
		
		if L_314_arg1.KeyCode == (Enum.KeyCode.T or L_314_arg1.KeyCode == Enum.KeyCode.DPadLeft) and L_1_:FindFirstChild("AimPart2") then
			if not L_86_ then
				L_56_ = L_1_:WaitForChild("AimPart2")
				L_50_ = L_24_.CycleAimZoom
				if L_64_ then
					L_97_ = L_24_.CycleAimZoom
				end
				L_86_ = true
			else
				L_56_ = L_1_:FindFirstChild("AimPart")
				L_50_ = L_24_.AimZoom
				if L_64_ then
					L_97_ = L_24_.AimZoom
				end
				L_86_ = false
			end;
		end;
		
		if L_314_arg1.KeyCode == L_24_.InspectionKey and not L_79_ and not L_78_ then
			if not L_77_ then
				L_77_ = true
				InspectAnim()
				IdleAnim()
				L_77_ = false
			end
		end;
		
		if L_314_arg1.KeyCode == L_24_.AttachmentKey and not L_79_ and not L_77_ then
			if L_15_ then
				if not L_78_ then
					L_67_ = false
					L_64_ = false
					L_69_ = false
					L_78_ = true
					
					AttachAnim()
				elseif L_78_ then
					L_67_ = false
					L_64_ = false
					L_69_ = true
					L_78_ = false
					
					IdleAnim()
				end
			end
		end;
			
		if L_314_arg1.KeyCode == Enum.KeyCode.P and not L_77_ and not L_78_ and not L_64_ and not L_67_ and not L_65_ and not L_66_ and not Recoiling and not L_67_ then
			if not L_79_ then
				L_79_ = true
				L_14_:Create(L_45_, TweenInfo.new(0.2), {
					C1 = L_24_.SprintPos
				}):Play()
				wait(0.2)
				L_112_:FireServer("Patrol", L_24_.SprintPos)
			else
				L_79_ = false
				L_14_:Create(L_45_, TweenInfo.new(0.2), {
					C1 = CFrame.new()
				}):Play()
				wait(0.2)
				L_112_:FireServer("Unpatrol")
			end
		end;
	end
end)

L_107_.InputEnded:connect(function(L_321_arg1, L_322_arg2)
	if not L_322_arg2 and L_15_ then
		if L_321_arg1.UserInputType == (Enum.UserInputType.MouseButton2 or L_321_arg1.KeyCode == Enum.KeyCode.ButtonL2) and not L_77_ and L_24_.CanAim and not L_78_ then
			if L_64_ then
				if not L_65_ then
					L_3_:WaitForChild("Humanoid").WalkSpeed = 16
					if L_24_.TacticalModeEnabled then
						L_154_ = 0.09
						L_155_ = 11
					else
						L_154_ = .2
						L_155_ = 17
					end
				end	
				L_97_ = 70
				L_133_.target = Vector3.new()
				L_115_:FireServer(false)
				L_64_ = false
			end
		end;
		
		if L_321_arg1.KeyCode == Enum.KeyCode.A and L_15_ then
			L_134_ = CFrame.Angles(0, 0, 0)
		end;
		
		if L_321_arg1.KeyCode == Enum.KeyCode.D and L_15_ then
			L_134_ = CFrame.Angles(0, 0, 0)
		end;
		
		if L_321_arg1.KeyCode == Enum.KeyCode.E and L_15_ and L_80_ then
			Unlean()		
			L_80_ = false
			L_82_ = false
			L_81_ = false
		end
		
		if L_321_arg1.KeyCode == Enum.KeyCode.Q and L_15_ and L_80_ then
			Unlean()		
			L_80_ = false
			L_82_ = false
			L_81_ = false
		end
		
		if L_321_arg1.KeyCode == L_24_.AlternateAimKey and not L_77_ and L_24_.CanAim then
			if L_64_ then
				if not L_65_ then
					L_3_.Humanoid.WalkSpeed = 16
					L_155_ = 17
					L_154_ = .25
				end	
				L_97_ = 70
				L_133_.target = Vector3.new()
				L_115_:FireServer(false)
				L_64_ = false
			end
		end;
		
		if L_321_arg1.UserInputType == (Enum.UserInputType.MouseButton1 or L_321_arg1.KeyCode == Enum.KeyCode.ButtonR2) and not L_77_ then
			L_68_ = false				
			if Shooting then
				Shooting = false
			end
		end;
		
		if L_321_arg1.KeyCode == Enum.KeyCode.E and L_15_ then
			local L_323_ = L_42_:WaitForChild('GameGui')
			if L_16_ then
				L_323_:WaitForChild('AmmoFrame').Visible = false
				L_16_ = false
			end
		end;
		
		if L_321_arg1.KeyCode == (Enum.KeyCode.LeftShift or L_321_arg1.KeyCode == Enum.KeyCode.ButtonL3) and not L_77_ and not L_70_ and not L_65_ then -- SPRINT
			L_71_ = false
			if L_67_ and not L_64_ and not Shooting and not L_71_ then
				L_67_ = false
				L_72_ = false
				L_97_ = 70
			
				L_3_.Humanoid.WalkSpeed = 16
				if L_24_.TacticalModeEnabled then
					L_154_ = 0.09
					L_155_ = 11
				else
					L_154_ = .2
					L_155_ = 17
				end			
			end
		end;
	end
end)

L_107_.InputChanged:connect(function(L_324_arg1, L_325_arg2)
	if not L_325_arg2 and L_15_ and L_24_.FirstPersonOnly and L_64_ then
		if L_324_arg1.UserInputType == Enum.UserInputType.MouseWheel then
			if L_324_arg1.Position.Z == 1 and (L_51_ < 1) then
				L_51_ = L_51_ + L_24_.SensitivityIncrement
			elseif L_324_arg1.Position.Z == -1 and (L_51_ > 0.1) then
				L_51_ = L_51_ - L_24_.SensitivityIncrement
			end
		end
	end
end)

L_107_.InputChanged:connect(function(L_326_arg1, L_327_arg2)
	if not L_327_arg2 and L_15_ then
		local L_328_, L_329_ = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_56_.CFrame.p, (L_56_.CFrame.lookVector).unit * 10000), IgnoreList);
		if L_328_ then
			local L_330_ = (L_329_ - L_6_.Position).magnitude
			L_33_.Text = math.ceil(L_330_) .. ' m'
		end
	end
end)

--// Event Connections
L_115_.OnClientEvent:connect(function(L_331_arg1, L_332_arg2)
	if L_331_arg1 ~= L_2_ then
		local L_333_ = L_331_arg1.Character
		local L_334_ = L_333_.AnimBase.AnimBaseW
		local L_335_ = L_334_.C1
		if L_332_arg2 then
			L_130_(L_334_,  nil , L_333_.Head.CFrame, function(L_336_arg1)
				return math.sin(math.rad(L_336_arg1))
			end, 0.25)
		elseif not L_332_arg2 then
			L_130_(L_334_,  nil , L_335_, function(L_337_arg1)
				return math.sin(math.rad(L_337_arg1))
			end, 0.25)
		end
	end
end)

L_118_.OnClientEvent:connect(function(L_338_arg1, L_339_arg2)
	if L_42_ and L_339_arg2 ~= L_2_ and L_24_.CanCallout then
		if (L_3_.HumanoidRootPart.Position - L_338_arg1).magnitude <= 10 then
			L_41_.Visible = true
			local L_340_ = ScreamCalculation()
			if L_340_ then
				if L_7_:FindFirstChild('AHH') and not L_7_.AHH.IsPlaying then
					L_119_:FireServer(L_7_.AHH, L_99_[math.random(0, 21)])
				end
			end
			L_14_:Create(L_41_, TweenInfo.new(0.1), {
				BackgroundTransparency = 0.4
			}):Play()
			delay(0.1, function()
				L_14_:Create(L_41_, TweenInfo.new(3), {
					BackgroundTransparency = 1
				}):Play()
			end)
		end
	end
end)

--// UI Tween Info
local L_166_ = TweenInfo.new(
	1,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local L_167_ = {
	TextTransparency = 1
}



--[[killEvent.OnClientEvent:connect(function()
	KillText.TextTransparency = 0
	delay(2, function()
		local testTween = tweenService:Create(KillText,killInfo,killGoals)
		testTween:Play()
	end)
end)]]--

--// Animations
local L_168_

function IdleAnim(L_341_arg1)
	L_24_.IdleAnim(L_3_, L_168_, {
		L_45_,
		L_46_,
		L_47_
	});
end;

function EquipAnim(L_342_arg1)
	L_24_.EquipAnim(L_3_, L_168_, {
		L_45_
	});
end;

function UnequipAnim(L_343_arg1)
	L_24_.UnequipAnim(L_3_, L_168_, {
		L_45_
	});
end;

function FireModeAnim(L_344_arg1)
	L_24_.FireModeAnim(L_3_, L_168_, {
		L_45_,
		L_47_,
		L_46_,
		L_58_
	});
end

function ReloadAnim(L_345_arg1)
	L_24_.ReloadAnim(L_3_, L_168_, {
		L_45_,
		L_46_,
		L_47_,
		L_61_,
		L_3_:WaitForChild('Left Arm'),
		L_58_,
		L_49_,
		L_3_:WaitForChild('Right Arm'),
		L_43_
	});
end;

function BoltingBackAnim(L_346_arg1)
	L_24_.BoltingBackAnim(L_3_, L_168_, {
		L_49_
	});
end

function BoltingForwardAnim(L_347_arg1)
	L_24_.BoltingForwardAnim(L_3_, L_168_, {
		L_49_
	});
end

function BoltingForwardAnim(L_348_arg1)
	L_24_.BoltingForwardAnim(L_3_, L_168_, {
		L_49_
	});
end

function BoltBackAnim(L_349_arg1)
	L_24_.BoltBackAnim(L_3_, L_168_, {
		L_49_,
		L_47_,
		L_46_,
		L_45_,
		L_62_
	});
end

function BoltForwardAnim(L_350_arg1)
	L_24_.BoltForwardAnim(L_3_, L_168_, {
		L_49_,
		L_47_,
		L_46_,
		L_45_,
		L_62_
	});
end

function InspectAnim(L_351_arg1)
	L_24_.InspectAnim(L_3_, L_168_, {
		L_47_,
		L_46_
	});
end

function nadeReload(L_352_arg1)
	L_24_.nadeReload(L_3_, L_168_, {
		L_46_,
		L_47_
	});
end

function AttachAnim(L_353_arg1)
	L_24_.AttachAnim(L_3_, L_168_, {
		L_46_,
		L_47_
	});
end

function PatrolAnim(L_354_arg1)
	L_24_.PatrolAnim(L_3_, L_168_, {
		L_46_,
		L_47_
	});
end
end,
function(script,require)
script.Parent.Model["SCAR-L"].Parent=owner
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


local Objects = Decode('AEChBSEFTW9kZWwhCldvcmxkUGl2b3QEkAWRBZIFIQRUb29sIQROYW1lIQZTQ0FSLUwhDENhbkJlRHJvcHBlZAIhDlJlcXVpcmVzSGFuZGxlIQdUb29sVGlwIRU1LjU2eDQ1bW0gTkFUTyAvIDQwbW0hBkZvbGRlciEIUmVzb3VyY2UhB01vZHVsZXMhDE1vZHVsZVNjcmlwdCEJVXRpbGl0aWVzIQZTcHJpbmchBmVhc'
..'2luZyEHUGx1Z2lucyEOU2V0dGluZ3NNb2R1bGUhDFNlcnZlckNvbmZpZyEMQ2xpZW50Q29uZmlnIQRWYXJzIQlCb29sVmFsdWUhCFJlc3VwcGx5IQ1VSVNjb3BlQWN0aXZlIQZFdmVudHMhC1JlbW90ZUV2ZW50IQhFcXVpcHBlZCEKU2hvb3RFdmVudCELQ3JlYXRlT3duZXIhC0RhbWFnZUV2ZW50IQZTdGFuY2UhCU'
..'tpbGxFdmVudCEIQWltRXZlbnQhCkV4cGxvRXZlbnQhC0F0dGFjaEV2ZW50IQ1TZXJ2ZXJGWEV2ZW50IQ1DaGFuZ2VJREV2ZW50IQ5SZW1vdGVGdW5jdGlvbiEISGl0RXZlbnQhBE1vZHMhBU5vZGVzIQJGWCEFU291bmQhA0FISCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAAwHJAIQZWb2x1bWUDAAAAAAAAAAAhB0J'
..'vZHlIaXQhB1NvdW5kSWQhFnJieGFzc2V0aWQ6Ly8xNjA0MzIzMzQDAAAAAAAA+D8hDkV4cGxvc2lvblNvdW5kIRdyYnhhc3NldGlkOi8vMzk2MzAxMzI1NgMAAAAAAAAAQCELU2hlbGxDYXNpbmchFnJieGFzc2V0aWQ6Ly8zMjUwMjUzODcDAAAAoJmZyT8hD1BhcnRpY2xlRW1pdHRlciEFQmxvb2QhBUNvbG9yKAIA'
..'AAAA/wAAAACAP/8AACEHRW5hYmxlZCEITGlmZXRpbWURAACAPwAAgD8hBFJhdGUDAAAAAAAALkAhCFJvdFNwZWVkEQAAoEAAAKBBIQhSb3RhdGlvbhEAAEhCAACgQiEEU2l6ZSkDAAAAAODW/D0AAAAAIVujPdbYQ0AAAAAAAACAPx3HMUAAAAAAIQVTcGVlZBEAAABAAAAAQCELU3ByZWFkQW5nbGULAAAgQQAAIEEhB'
..'1RleHR1cmUhACEMVHJhbnNwYXJlbmN5KQIAAAAAAACAPwAAAAAAAIA/AACAPwAAAAAhBVNtb2tlIQxBY2NlbGVyYXRpb24KAAAAAAAAIMEAAAAAKAIAAAAAnJycAACAPzo6OiENTGlnaHRFbWlzc2lvbgMAAACgmZm5PwMAAAAAAEBgQCkEAAAAAAIAUD8AAAAA5okoPfz/3z4AAAAAPPNTPwAAfEAAAAAAAACAPwIAUD'
..'8AAAAAEQAA8EEAAPBBCwAAyEEAAMhBIQVTcGFyawoAAAAAAABwwQAAAAAoAgAAAACqqv8AAIA/qqr/ETMzMz/NzEw/AwAAAAAAAPA/AwAAAAAAAE5AKQIAAAAAzcxMPgAAAAAAAIA/zcxMPgAAAAARAAAgQQAAIEELAACgQQAAoEEhA0hVRCEJU2NyZWVuR3VpIQdNYWluR3VpIQVGcmFtZSEHR2FtZUd1aSEQQmFja2d'
..'yb3VuZENvbG9yMwb///8hFkJhY2tncm91bmRUcmFuc3BhcmVuY3khCFBvc2l0aW9uDAAAAAAAAAAAAADc/wwAAIA/AAAAAIA/AAAhCUFtbW9GcmFtZQYwMDIDAAAAYGZm1j8hD0JvcmRlclNpemVQaXhlbAzeJIY/if72TJA/qP8MAAAAAAMBAAAAAD8AIQlUZXh0TGFiZWwhBVRpdGxlDAAAgD8AAAAAAAAZACEERm9u'
..'dCEEVGV4dCEETTRBMSEKVGV4dENvbG9yMyEIVGV4dFNpemUDAAAAAAAAM0AhFlRleHRTdHJva2VUcmFuc3BhcmVuY3khC1RleHRXcmFwcGVkIiESTWFnQ291bnRCYWNrZ3JvdW5kDAAAgD/R/7HkFz/r/wwAAAAAKAAAAAAAMwAhB1Zpc2libGUhBHwgMTUGIyMjAwAAAAAAADJAIQhNYWdDb3VudAwAAIA/zv8lhes+6'
..'v8MAAAAACgAAAAAAEwAIQZaSW5kZXghCERpc3REaXNwDAAAAAAGAFyPQj/s/wwAAAAASwAAAAAAIQAhAzAgbQMAAAAAAAAxQCEOVGV4dFhBbGlnbm1lbnQhDkFtbW9CYWNrZ3JvdW5kDAAAgD+u/5NFWT/o/wwAAAAAKAAAAAAAHAAhAjMwAwAAAAAAADlAIRBUZXh0U3Ryb2tlQ29sb3IzBioqKiEEQW1tbwwAAIA/q/'
..'+zLEs/5/8MAAAAACgAAAAAACkAIQpJbWFnZUxhYmVsIQdTdGFuY2VzIQxCb3JkZXJDb2xvcjMM/gF+PwIA9AzQvQAADAAAAABUAAAAAABRACEFSW1hZ2UhF3JieGFzc2V0aWQ6Ly8xODY4MDA3NDk1IQlTY2FsZVR5cGUDAAAAAAAAEEAhBU1vZGU1AwAAAGBmZuY/DAAAAAABAAAAAAAZAAwAAAAAMQAAAAAABQAhBU1'
..'vZGU0DAAAAAA0AAAAAAAZAAwAAAAAMAAAAAAABQAhBU1vZGUzDAAAAABmAAAAAAAZACEFTW9kZTIMAAAAAJgAAAAAABkAIQVNb2RlMQwAAAAAygAAAAAAGQAhCUNvbnRyb2xzMQwM/Cs/AAAURdG/AAAM7gYnPwAAbu4KPhkAIRIiVCIgLSBjaGFuZ2UgdG8gR0whCUNvbnRyb2xzMgwbXyE/AABu5qa/AAAM3KMxPwAA'
..'ryQ3PhkAIREiSCIgLSBpbnNwZWN0IGd1biEJQ29udHJvbHMzDPOuxT4AAAiWW78AAAyxcGk/AADX9p89GQAhCiJGIiAtIGJvbHQhCUNvbnRyb2xzNAxtUAY/AACz2Aa/AAAMvXQ1PwAAWQkFPhkAIQsiQyItIGNyb3VjaCEJSGl0TWFya2VyDAAAAD/z/wAAAD/z/wwAAAAAGgAAAAAAGgADAAAAAAAAJEAhKWh0dHA6L'
..'y93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTIxMTczNzU3IQtJbWFnZUNvbG9yMwb/AAAhClNjb3BlRnJhbWUhBVNjb3BlBgAAAAwAAAA/9v8AAAAA9v8MAAAAABQAAAAAABQAIShodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTcyMDAyMDIyIQdTY29wZUlkISlodHRwOi8vd3d3LnJvYmxveC5jb20vYX'
..'NzZXQvP2lkPTE4NDkyMjY0NCECRjEMAAAAAPb/AAAAAPb/DAAAAAAAAAAAgD8UACECRjIhC0xvY2FsU2NyaXB0IQVDcm9zcyEFU2Vuc2UMAACAPwAAAACAPyQAIQdUZXh0Qm94IQtTZW5zaXRpdml0eQYyMjIMAAAAP/P/AAAAADIADAAAAABkAAAAAAAaACEDMC41IQpUZXh0U2NhbGVkAwAAAAAAACxAIQhJbnRlcmF'
..'jdAx9/7o+AABaB1o/AAAMAAAAAA0BAAAAABYAIRdQcmVzcyBFIFRvIFJlc3RvY2sgQW1tbyEGT3RoZXJzIQRLaWxsDAAAAD+c/wAAgD84/wwAAAAAyAAAAAAAGQADAAAAAAAACEAhEVRhcmdldCBFbGltaW5hdGVkIRBUZXh0VHJhbnNwYXJlbmN5IQdTaGFkaW5nBggAAAwAAAAA9v8AAAAA6v8MAACAPwoAzcyMPwAA'
..'IQZTY3JpcHQhDlByb2dyYW1fU2VydmVyIQ5Qcm9ncmFtX0NsaWVudCEISW50VmFsdWUhCmlnbm9yZUNvZGUhCE1lc2hQYXJ0IQRCb2x0IQhBbmNob3JlZCEKQnJpY2tDb2xvcgcaACEGQ0ZyYW1lBAIBkQWSBSEKQ2FuQ29sbGlkZSEITWF0ZXJpYWwDAAAAAAAAcUAKpaIjQwDinz4S53XDCq28gT/ypoQ+2jqOPiEGT'
..'WVzaElkIRZyYnhhc3NldGlkOi8vNDc2NjU4NDIyIQhNZXNoU2l6ZQpAqHU/UC17PgCohj4hCEJvbHRCYWNrIRZyYnhhc3NldGlkOi8vNjIwNzE2OTQ1IQtCb2x0Rm9yd2FyZCEWcmJ4YXNzZXRpZDovLzg2NjM3NTg1MiEOVW5pb25PcGVyYXRpb24hCElyb25HbG93BBIBkwWUBQb4+PghC09yaWVudGF0aW9uCgAAoE'
..'AAAAAAAAC0QgoDzCNDQMM8PzfadcMKAD+IPeLPHkCfUVg9IQRQYXJ0CoV2sj1TbJc9F92KPApJCCVD8DA7P4LddcMKKae2PVJslz2crYc8CkkIJUPErTs/Z9V1wwrNzCxBAAA0QwAAtEIKQU1pPRUOLTzU5IM8CkkIJUNHdTs/e9l1wwpxPUpAAAA0QwAAtEIKR4thPU/JAj1RK+o8CgOPIkPPCEE/19l1wwpxPbBCcf0'
..'zQ+H6s0IKAACAPwAAgD8AAIA/CgAAAAAAAAAAAAAAAAo4hmE9AvqgOwckCD0KYjCgPRe3fzwPczw7CjuQSD0Xt388f4OWOwrXo/A/AAAAAAAAtMIhA01hZwQoAZEFkgUKj4MjQwCNu77m2nXDCjaTAD9m94s/AzMHPiEWcmJ4YXNzZXRpZDovLzQ3NjY1NzE5MQoAdfM+aIOEPwAAAD4ELQGRBZIFCmqQJUOA1Jc+0tl1'
..'wwrQy6g/O8KjPvGvQj4hFnJieGFzc2V0aWQ6Ly80NzY2NTg2MjAK0M6fP+gJmz4AUjg+BDIBkQWSBQrq9iJDAOz1Pc7PdcMKeL15QOrjSj9RTbA+IRZyYnhhc3NldGlkOi8vNDc2NjU3NzY1ChBxbEAoFkA/AOqmPiEJTWVzaFBhcnQxB4oABDoBkQWSBQaYgnQKWBgiQwBAgDsi1HXDCjXrG0D9ioE/6D+BPiEWcmJ4Y'
..'XNzZXRpZDovLzQ3NjY1ODAyMQrAnRNALEp1PwC8dD4EPwGRBZIFCjgfI0MAyJi92eB1wwqXsK4/d3/sPqBfcz4hFnJieGFzc2V0aWQ6Ly80NzY2NTY3ODcKQGOlP5Ln3z4AamY+BEUBkQWSBQafiXsKtq0jQwD/qz7R2XXDCthbHkBuM7g+8a9CPiEWcmJ4YXNzZXRpZDovLzQ3NjY1NzUyMwog7RVAcGSuPgBSOD4hCU'
..'1lc2hQYXJ0MgRLAZEFkgUKQZsiQwC8zr7P2XXDCmDLBz9gLhc/KhQgPiEWcmJ4YXNzZXRpZDovLzQ3NjY1Njk3NgpAkAA/gCEPPwCOFz4hCEZpcmVQYXJ0IQ1Cb3R0b21TdXJmYWNlB/EDBFUBlQWSBQb//wAKAAAAAAAAtMIAAAAACqo3JkMAlGE+uNl1wwqeUVg+nlFYPp5RWD4hClRvcFN1cmZhY2UhBEZpcmUhFnJ'
..'ieGFzc2V0aWQ6Ly84NDE4Nzc1OTEhD0ZsYXNoRlgzW0J1cnN0XQoAAAAAAADAvwAAIEEoAgAAAAClpaUAAIA/paWlIRFFbWlzc2lvbkRpcmVjdGlvbgMAAAAAAAAUQBHNzMw+zczMPgMAAAAAAABpQCkCAAAAADMzMz8AAAAAAACAPzMzMz8AAAAAEQAASEIAAEhCIRZyYnhhc3NldGlkOi8vMjQxNTM5NDM4KQQAAAAA'
..'wMxMPAAAAADNT9M+MzNrPzkH/jzvW3A/MzNzP9DMTD0AAIA/AACAPwAAAAAhD0ZsYXNoRlgzW0Zyb250XSgCAAAAAP+qfwAAgD//qn8LAADIQgAAyEIhDkZsYXNoRlhbRmxhc2hdEc3MTD3NzEw9AwAAAAAAAFlAEQAAAAAAALRDKQMAAAAACO0lQAAAAADTx9c+AAAAAAAAAAAAAIA/AAAAAAAAAAARAACgQAAA4EALA'
..'ABwQQAAcEEhFnJieGFzc2V0aWQ6Ly8xNTY1ODAzMTUpAwAAAAAAAIA/AAAAAJVccz4AAAAAAAAAAAAAgD8AAAAAAAAAACEKUG9pbnRMaWdodCEORmxhc2hGWFtMaWdodF0hCkJyaWdodG5lc3MDAAAAAADAWEAG//9/IQdTaGFkb3dzIQVSYW5nZSEER3JpcAR6AZUFkgUKcQwjQwByOb662XXDIQVDbGljayEWcmJ4YX'
..'NzZXRpZDovLzUzNzc0NDgxNCECTTMhKWh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTY2MjM4MTYxIQVNYWdJbiELUm9sbE9mZk1vZGUhFnJieGFzc2V0aWQ6Ly84OTgzODU1MDkhBk1hZ091dCEWcmJ4YXNzZXRpZDovLzg5ODM4NTE1MyEHQ2hhbWJlcgSHAZYFlwUKCtf7QDNzF8M9SizDCgBWI0MASVY'
..'+iNp1wwpcDytDexTiwc3MXEAKn1FYPp9RWD6fUVg+IQlCbG9ja01lc2ghBVNjYWxlCoJ/ZD+Cf2Q/gX9kPyEFU2hlbGwHwgAEkgGYBZkFBqOipQqaGbFCmpm0Qtejt0IK0JIjQwDDeD4k1nXDIQtSZWZsZWN0YW5jZQMAAAAAAADgPwofBbRCmpm5P1yPwj8KkLamPlR56z1VfOs9CuAlJD3nJaQ8guMZPgq6ayNDaNB0'
..'Pi7XdcMKFK5vQuH6L0NxPa5CClcvTT3qJaQ8guMZPgrhZyNDSGx0PkjXdcMKXI9GQlyPBcMfhR1CCp2quD3c+LA+guMZPgpZniNDkep5PtbVdcMKefbrPXu2pj6D4xk+CtCSI0OZwHg+JNZ1wwSjAZoFkQUKAAC0QgAAtEIAAAAACv0qI0MAaCo/INh1wwoAALRCAAAAAAAAtMIKzUGePrvqdT9iGNU+IQxVc2VQYXJ0Q'
..'29sb3IKS/dJPjSKuz7qbD4+CrNDI0M9NzY/EKx1wwoAAAAAUvguQ8P1s0IKQvdJPimKuz7ibD4+Cq9DI0M5E00/MLJ1wwrD9e5BpDAuQxQurkIKe/dJPm6Kuz7zbD4+CrBDI0MLz10/7cJ1wwrhem5CAAAqQ3G9okIKg/dJPl+Kuz7cbD4+CrNDI0Pg7mM/ydl1wwrD9alCSOGzQo/C9bwKX/dJPjWKuz7XbD4+CrdDI0'
..'Nqzl0/pfB1wwrhem5CSOEeQXG9osIKQvdJPiaKuz7kbD4+CrtDI0MREk0/YQF2wwrD9e5BAAC4QBQursIKM/dJPiGKuz7sbD4+Cr5DI0MENjY/gAd2wwoAAAAAPQqfQMP1s8IKVfdJPmWKuz4PbT4+CsBDI0P5WR8/YAF2wwo9Cu/BPQq3QDOzucIKUfdJPkOKuz7wbD4+CsBDI0Mang4/pPB1wwofhW7Cj8IdQXsUxcI'
..'KVfdJPhqKuz7DbD4+Cr1DI0Nofgg/yNl1wwo9CqrCAAC0QsP1M0MKgPdJPmqKuz7qbD4+CrpDI0PYng4/7MJ1wwofhW7CexQqQ3sUxUIKTvdJPj6Kuz7ubD4+CrZDI0MsWx8/MLJ1wwrD9e7BwzUuQzOzuUIKR/dJPsQphj7+9kk+CqRFI0PONjY/yNl1wwoAAAAAUvgzQ8P1s0IKKGQ7PuIqtz960CI+Ckn5IkNnNDY/'
..'zdl1wwoAAAAAAAC0wsP1M8MKHgaBPgotsj12xos+CnpzI0MMNzY/u9l1wwoeBoE+IwYBPnbGiz4KvY4jQ+02Nj+72XXDCuVRuD4fWqQ+wZ86PwpVnSNDgM4UP7vZdcMKAABIQgAAtMIAADRDCh4GgT4fsBI/TZ1vPgoTrSNDAjc2P7vZdcMKbT2KPiMGAT54xos+Cr2OI0PNNjY/u9l1wwroUbg+H1qkPsKfOj8KKJwjQ'
..'/HKFT+72XXDCjW0iD4fsBI/Ced7PgoTrSNDBTc2P7vZdcMKf/dJPvMphj779kk+CtdGI0NUNjY/09l1wwoAAAAAAAC0wsP1M0MKifdJPkyKuz4dbT4+Co90I0ObITg/0tl1wwoAAKDCmpmzwgDAM0MKhvdJPlWKuz4FbT4+Cm9uI0OkJzg/rvB1wwrNzMw+XA8Rwx8FvsIKw/dJPnmKuz4YbT4+CrNdI0NEKjg/awF2ww'
..'o9Ctc+uB7mwj0KvsIKmvdJPneKuz70bD4+Cq5GI0MYKzg/iwd2wwquR+E+uB6qwj0KvsIKi/dJPmWKuz76bD4+CqkvI0OzKTg/awF2wwofhes+cT1cwj0KvsIKhvdJPk+Kuz4LbT4+CsQeI0NjJjg/r/B1wwrXo/A+4XrIwQAAvsIKhvdJPkiKuz4RbT4+CnsYI0MEIjg/09l1wwqPwvU+exSeQMP1vcIKu/dJPn6Kuz4'
..'NbT4+CnIeI0NaHTg/98J1wwrXo/A+j8ILQoXrvcIKkPdJPnOKuz7ubD4+CgUvI0MxGjg/OrJ1wwpmZuY+SOGBQkjhvcIKf/dJPm2Kuz7mbD4+CrhFI0MsGTg/Gqx1wwr2KNw+SOG9QkjhvcIK3/dJPqKKuz4+bT4+CpRcI0MiGjg/OrJ1wwpxPerBH4UAQ5oZxcIKk/dJPmOKuz4ibT4+ClBtI0NKHTg/9sJ1wwoK12nC'
..'UvgnQx8F2MIKvsxMPucrvj7nGEE+CjtvI0M5Zxo/QQd2wwoAgI7CH4UrQrge9UIKf8J1PrQ+Oz5jHoU+CstdI0OBFzU/MeV1wwoUrmdBUrh9wlI46cIKjcxMPr4rvj7RGEE+Cu99I0NfVi0/HAZ2wwpSuHNCj8LUwnsUqcIKysxMPrYrvj6vGEE+ClODI0Nc9EI/Mf11wwofhUPBpPDfwkhh68IKmsxMPvYrvj7fGEE+C'
..'hZHI0OCzw4/LvN1wwoK1wNCAIDSQnsUNUIKjMxMPrYrvj7bGEE+CmU4I0MAQhk/VuN1wwoK1yLCcT3eweH6hsIKwcxMPu8rvj7YGEE+Cmk4I0M2ZEE/Icx1wwq4HmPCrseIQj3KFsMKoMxMPt4rvj62GEE+Ch1HI0MeU1Q//Mp1wwozMw7CSOHHQs2ML8MKkMxMPtMrvj6uGEE+CjBbI0Nsf18/6dF1wwrhehjBPYroQo'
..'WrMEMK48xMPhUsvj4MGUE+CkNvI0N56l8/D991wwrheoxBKdwgQ3G9MMMKu8xMPs0rvj7PGEE+CvR9I0P0d1U/5u51wwpcj5xBH8USwwoXD8MKh8xMPrIrvj7ZGEE+CgQzI0NGxis/E9V1wwopXG7ChesdQVwPxcIKnsxMPtYrvj7AGEE+CiRbI0PeOw8/YwB2wwofhTtBCtdswpqZXsIKHwaBPiWwEj8Kvh8+CodFI0M'
..'GNzY/2dl1wwo0Clc+G67HPo3ASj4KjE0jQ/2HTj//A3bDCilcl8Fcj/LAZqYIwwodBoE+bZtEPlPGiz4KDVMjQwMxNj/W2XXDCvkJVz70rcc+dsBKPgqMTSNDZVlgPy3ydcMKPQoJQgAAMUNmZhRDCjsKVz7qrcc+U8BKPgqOTSNDs95mP9bZdcMKAAAMQh8FtMIz8zNDCgkKVz4trsc+hsBKPgqMTSNDItodP/4DdsMK'
..'ZmYlwuG6DEMUrm9CCvcJVz7trcc+gsBKPgqMTSNDzwgMPy3ydcMKpHDNQQAAMECPwuXBCjEKVz4jrsc+fcBKPgqNTSND0wgMP3/BdcMKPQoJwgAAQEDNzPzBCg0KVz4Mrsc+XcBKPgqNTSNDJtodP66vdcMKKVyAwmZmtkD2KAzCCvwJVz4Arsc+VcBKPgqNTSNDAjE2PyipdcMKexSqwuH6FUPh+jPDClcKVz5Hrsc+s'
..'8BKPgqNTSND5YdOP66vdcMKrkcPwvZoF8MAgP1CCi4KVz79rcc+dMBKPgqOTSNDLFlgP3/BdcMKSOEuQVI4BsPNjApDCvEJVz7orcc+fsBKPgqGTSNDToUFP9rZdcMKrkeJwClcH0BSuPDBCgwKVz4Hrsc+Z8BKPgp/TSNDQDU2P4wKdsMKexSqQvYo8EEK16M8CthGI0NXNjY/09l1wwqQdCNDniE4P9LZdcMKcG4jQ6'
..'cnOD+u8HXDCrRdI0NGKjg/awF2wwqvRiNDGys4P4sHdsMKqi8jQ7YpOD9rAXbDCsUeI0NmJjg/r/B1wwp8GCNDByI4P9PZdcMKcx4jQ10dOD/3wnXDCgYvI0M0Gjg/OrJ1wwq5RSNDLxk4PxqsdcMKlVwjQyUaOD86snXDClFtI0NNHTg/9sJ1wwr4CVc++NiOPtMJVz4KGEMjQ3xmNz/T2XXDCgMKVz4Zrsc+X8BKPgo'
..'NQSNDNxRoP9PZdcMKAAAgQR8FtMLD9TNDCgIKVz4Ersc+ZMBKPgoLQSND6I5hPyrydcMKj8ILQlJ4M0PDtS5DCkEKVz7/rcc+qMBKPgoMQSNDe71PP/sDdsMKSOGBQuH6MkMKFy5DChUKVz7nrcc+lsBKPgoMQSNDHjs3P4EKdsMKexSqQtejoEAK16M8CgQKVz70rcc+esBKPgoMQSNDy7geP/wDdsMKcT1cQlyPQj8f'
..'hYvACv4JVz4Orsc+XMBKPgoMQSNDC7wMPyrydcMK4XrIQY/C9T7D9ZjACvsJVz4Wrsc+UMBKPgoMQSNDDgsGP9PZdcMKexSewK5H4T7Xo6DACjQKVz4yrsc+bsBKPgoNQSNDQmUMP3zBdcMKj8ILwhSuBz+uR6nACgcKVz73rcc+fsBKPgoNQSNDNgseP6uvdcMKSOGBwlyPgj+4Hr3ACvQJVz7frcc+hMBKPgoNQSNDt'
..'jY2PyWpdcMKexSqwuH6LkPh+jPDCnEKVz43rsc+rcBKPgoNQSNDn41OP6uvdcMKuB4sws0MCsPX4wtDCiMKVz4brsc+YcBKPgoNQSND615gP3zBdcMK7FHIwD0K8sIzsxdDCvsFgT4isBI/3b0fPgpmRSNDDDc2P9nZdcMKs9CiPgIrBz7t4qU+ChxpI0O3NjY/09l1wwpLZDs+v/UoPjgaLz4KdR0jQ7U2Nj/T2XXDCg'
..'AAtMIAALRCAAAAAApNZDs+tEehPgq+Hz4K7hYjQ7Y2Nj/T2XXDCihkOz7iKrc/e9AiPgpnECNDsTY2P9PZdcMKcWQ7PkIvXT7zYzs+CrsDI0OyNjY/09l1wwoE9ig+XS9dPQtkOz4KnB4jQ7I2Nj+P7nXDCgAAAAAAALRCCtcjvQrGeGk+dr4fPcS8Hz0Kdr0iQ+y/Nz/S2XXDCktkOz52vh89OBovPgp2vSJDsjY2P9L'
..'ZdcMKJmQ7PuIqtz950CI+CmcQI0O4NjY/09l1wwpLZDs+208NPvJjOz4KOtQiQ6AuNj/S2XXDCihkOz7iKrc/edAiPgpKECNDojE2P9LZdcMKS2Q7PgErBz3yYzs+Clu0IkOaLjY/0tl1wwqF90k+8ymGPvv2ST4K10YjQ0s2Nj/U2XXDCo73ST5Mirs+HW0+PgqPdCNDliE4P9PZdcMKhvdJPlaKuz4IbT4+Cm9uI0Od'
..'Jzg/r/B1wwrD90k+f4q7PhptPj4Ks10jQzoqOD9sAXbDCpr3ST55irs+9Ww+PgquRiNDDCs4P4wHdsMKi/dJPmaKuz77bD4+CqkvI0OlKTg/bAF2wwqG90k+UIq7PgxtPj4KxB4jQ1UmOD+w8HXDCoX3ST5Iirs+EW0+Pgp7GCND+CE4P9TZdcMKvfdJPn+Kuz4PbT4+CnIeI0NPHTg/+MJ1wwqQ90k+dIq7Pu9sPj4KB'
..'S8jQykaOD87snXDCoL3ST5uirs+5Ww+Pgq4RSNDJhk4PxusdcMK4PdJPqSKuz4+bT4+CpRcI0MdGjg/O7J1wwqV90k+Y4q7PiRtPj4KUG0jQ0YdOD/3wnXDCsDMTD7nK74+5RhBPgo6byNDHWcaP0IHdsMKhMJ1Prc+Oz5lHoU+CspdI0NwFzU/MuV1wwqQzEw+xiu+PtIYQT4K7n0jQ0JWLT8dBnbDCs7MTD68K74+sR'
..'hBPgpSgyNDQ/RCPzL9dcMKocxMPvsrvj7jGEE+ChVHI0Nuzw4/L/N1wwqRzEw+uCu+PuAYQT4KZDgjQ/BBGT9X43XDCsjMTD7xK74+2RhBPgpoOCNDL2RBPyLMdcMKpcxMPt4rvj63GEE+ChxHI0MXU1Q//cp1wwqTzEw+1iu+Pq8YQT4KL1sjQ2B/Xz/q0XXDCuTMTD4VLL4+ERlBPgpCbyNDaepfPxDfdcMKvcxMPs8'
..'rvj7RGEE+CvN9I0Pfd1U/5+51wwqJzEw+siu+PtkYQT4KAzMjQzzGKz8U1XXDCqDMTD7ZK74+wRhBPgojWyNDxTsPP2QAdsMKq5tEPBRYWT8xKoc9ChA+I0P2lU4/0NB1wwqFa59CpHAvQpqZTsIKnptEPAJYWT+nvZ89Co4/I0Nqkko/18Z1wwrNTIpCFO4oQzOzj0IKssL1PU/dZD/7mUQ9CvA/I0Pcxlk/Ksl1wwpc'
..'j0JBpPCvwuxRKkMK1VG4Pg5apD66nzo/Cl2vI0PMgw8/OdN1wwpI4W/CSOGzwoXrM0MK5lG4PkNiED6cwvU9CiCoI0MzAms/OdN1wwqk8ItCcT20QgrXoz0KP2Q7PlrjJT6QvZ89CuXgIkPxDU0/YL51wwoUrldBAIC1wjPzJ0MKHgaBPolBsD8Mvh8+CnrJIkOTLhA/oc11wwrD9ZVCHwW0QgAAAAAKHwaBPopBsD8Mv'
..'h8+CoDSIkNta9U+MfB1wwqF629CHwW0QgAAAAAKHgaBPopBsD8Lvh8+Cm3UIkM0xc4+7Nl1wwqcGq8+TGLwPk0/tT4KI+wiQ0w5Nj/12XXDCqTws0LDdbJCFK5Hvwpi53s+aDX+PlXrkT4KxqEjQztNNj//2XXDCqTws0LDdbJCcT1Kvwr9BYE+fUGwP8gHLD4KPCMjQxk/Nj/x2XXDCqTws0L2qLJCexQuvwoeBoE+i0'
..'GwPwq+Hz4K4msjQ4bOkj/12XXDCoXrM0IfBbRCAAAAAApLZDs+F67HPu5jOz4K1AMjQzo1Nj8J2nXDClq+nz3kT4099mM7PgqaDiNDOTU2PyfvdcMKw/WzwoVrJ8PNzEjBCudPjT3kT409Pb/1PArb/iJDOjU2PyfvdcMKAAC0wgAANEMAAAAACvMqBz4aL1099mM7PgqaDiNDd2hJPwnadcMKAAAAAAAAAAAAADTDCnf'
..'C9T2TwnU9+GM7PgqaDiNDAwBYPwnadcMK9ioHPgErBz34Yzs+CpoOI0OI61k/Cdp1wwrxKgc+HC9dPfJjOz4Kmg4jQzg1Nj/VxnXDCgAAtEIAADRDAAAAAAp5wvU9mcJ1PfVjOz4Kmg4jQ0c1Nj8+uHXDCsP1s0K4HmlB9mglwwr4Kgc+BCsHPfVjOz4Kmg4jQ0g1Nj9StnXDCjjjpT1e5VA9PCyyPQoiFyND8FYbPwna'
..'dcMKAAAAAAAAtEIAAAAACkpkOz7hTw0+6mM7Pgo81CJDMTU2P+nZdcMK/VPjPY3CdT0qU+M9Cq/cIkMoNTY/tux1wwoAAAAAAAAAAAAAtEIK/VPjPfhT4z0uU+M9CgHVIkMnNTY/tux1wwojL908LQgsPW5xkzwK4NsiQy41Nj/D+3XDCjEIrD2/dJM9vnQTPQrc1SJDLjU2P7T+dcMKCtczQgAANEIAADTDCuHSTT6Em'
..'0Q9h9JNPgoz5yJDmjI2P/bldcMK4dJNPpCbRD2K0k0+CjPnIkOYMjY/s811wwrgqxw+BgisPAJ46T0Kbd4iQ/qLSj//2XXDCvasoz1046U9JptEPgpe3iJD6bJNP4G9dcMK9ijcP81MoMKkMCpDCrq1IT5y46U9AVG4PQpe3iJDbm1hP03OdcMK7bUhPk/jpT3mULg9Cl/eIkNpbWE/seV1wwpSuN4/M7PHwikcKsMKiq'
..'2jPU/jpT0Km0Q+Cl/eIkPlsk0/fvZ1wwroB6w9pnQTPR0GAT4K+tUiQ5I9Sz++0nXDCh+FXMLNzGrC9mgZQwoHCKw9u3QTPT8K1z0KUtciQ3KITT+o4XXDCmZmXMIUrvLCzUwZwwrxrs49RL6fPce8Hz0KCusiQ2LCUD8BznXDCgAAoMIAAAAAAAC0QgoGvh89Q76fPci8Hz0KCusiQyOETj9JwXXDCiS+Hz3+B6w8VCk'
..'HPQpe3iJDJYROP0nBdcMKEr4fPU6+nz3GvB89CgrrIkMnf04/dfJ1wwoAAKDCAAA0QwAAtMIKba/OPVG+nz3GvB89CgrrIkNpvVA/veV1wwovvh89DQisPFQpBz0KXt4iQyh/Tj918nXDCuarHD4NCKw8AnjpPQpt3iJDOdkhPxbadcMKAAC0QgAAtMIAAAAACv2soz1046U9LptEPgpe3iJDSrIeP5T2dcMK9ijcvzOz'
..'x8LD9RzBCr+1IT5046U9CFG4PQpe3iJDxfcKP8jldcMK8rUhPk7jpT3rULg9Cl/eIkPK9wo/ZM51wwpSuN6/zUygwnE9HkEKkK2jPU7jpT0Qm0Q+Cl/eIkNOsh4/l711wwrsB6w9qHQTPR8GAT4K+tUiQ6EnIT9X4XXDCh+FXEKamfLCUrjUwQoKCKw9vnQTPUAK1z0KUtciQ8HcHj9t0nXDCmZmXELXo2rCmpnVQQr2r'
..'s49SL6fPcm8Hz0KCusiQ9CiGz8U5nXDCgAAoEIAADTDAAC0wgoKvh89R76fPcq8Hz0KCusiQw/hHT/M8nXDCii+Hz0DCKw8VSkHPQpe3iJDDeEdP8zydcMKGL4fPVO+nz3GvB89CgrrIkMM5h0/oMF1wwoAAKBCAAAAAAAAtEIKdK/OPVW+nz3GvB89CgrrIkPKpxs/WM51wwo0vh89EQisPFQpBz0KXt4iQwzmHT+gwX'
..'XDCmJkOz7DygE/AmQ7PgrN8CJDpzY2PwjadcMKKmQ7PuIqtz980CI+ChgRI0O0NjY/CNp1wwpRm0Q9MLSIPvBjOz4Kct4iQ2MuNj/j03XDCkFkOz4xtIg+8GM7Pgpy3iJDYy42P77NdcMKVuVQPTY1nj5Dk9g+CrP+IkM1Z0s/vs11wwoAAHBCCtezwlK4b8IKWOVQPTc1nj4+k9g+Cor+IkOEhks/vs11wwoAADRCSOG'
..'zwgrXM8IKOOVQPR01nj7rYzs+Cor+IkN/qkg/EsN1wwo9ChfCUrh9wkhhxsIKPOVQPRw1nj7pYzs+CrP+IkNcj0g/IsN1wwquR83BrseTws1Mu8IKOuVQPSA1nj7pYzs+CrP+IkPTykA/Xbt1wwoUrmfBUrh9wq7H9sIKOuVQPSA1nj7tYzs+Cor+IkN/2kA/Qrt1wwqamaXBZmZEwgCA/8IKNeVQPSE1nj7rYzs+Cov+'
..'IkNkLjY/Zrh1wwoAAAAAAAA0wsP1FcMKOOVQPSE1nj7pYzs+CrT+IkNkLjY/hbh1wwoAAAAAAABwwsP1FcMKGeVQPR41nj7VYzs+Cor+IkNygis/Qrt1wwoUrqVBpHBEwvYoLMMKJeVQPSA1nj7bYzs+CrP+IkMMkis/Xbt1wwoUrmdBUrh9wh+FMMMKJ+VQPR01nj7kYzs+Cor+IkNrsiM/EsN1wwo9ChdCUrh9wh9FH'
..'0MKJ+VQPR41nj7cYzs+CrP+IkODzSM/IsN1wwquR81BzcyTwuG6GUMKY+VQPT01nj6oIps+CrP+IkN99SA/9dZ1wwoAAHBCCtezQq5HcMIKY+VQPUA1nj6hIps+Cov+IkMx1iA/9dZ1wwoAADRCSOGzQvYoNMIK2lPjPggrBz7gfqo+Ci0PI0O4NjY/CNp1wwr8U+M+CCsHPvp+qj4K+8YiQ7M2Nj8I2nXDCmJikD6Tka'
..'0+5E+NPgor5CJDsjY2P1z9dcMKheuzws3MPMDNDDHDCvNT4z6emZk++X6qPgpH/iJDsDY2PwjadcMKGZtEPQ20iD7wYzs+CnXgIkOvNjY/6tN1wwoMZDs+DrSIPvBjOz4KdeAiQ682Nj/FzXXDCirlUD0MNZ4+NJPYPgo0wCJD3f0gP8XNdcMKAABwwgrXs0LXI/BCCi7lUD0WNZ4+I5PYPgpdwCJDjt4gP8XNdcMKAAA'
..'0wkjhs0I9CgdDCiTlUD3wNJ4+zWM7PgpdwCJDk7ojPxnDdcMKPQoXQlK4fUK4nqFCCjDlUD3vNJ4+wmM7Pgo0wCJDttUjPynDdcMKrkfNQa7Hk0Izs6xCCiflUD3/NJ4+u2M7Pgo0wCJDP5orP2S7dcMKFK5nQVK4fUKkcGJCCiLlUD0CNZ4+vmM7PgpdwCJDk4orP0m7dcMKmpmlQWZmREIAAFFCCgrlUD0WNZ4+tmM7'
..'PgpcwCJDrjY2P224dcMKAAAAAAAANELsUfBBCgrlUD0VNZ4+tmM7PgozwCJDrzY2P4y4dcMKAAAAAAAAcELsUfBBCt7kUD0XNZ4+pmM7PgpdwCJDoOJAP0m7dcMKFK6lwaRwREJI4fpACujkUD0eNZ4+rWM7Pgo0wCJDBtNAP2S7dcMKFK5nwVK4fUJSuF5ACu3kUD0GNZ4+wmM7PgpdwCJDp7JIPxnDdcMKPQoXwlK4f'
..'UIK16XBCvLkUD0NNZ4+s2M7Pgo0wCJDj5dIPynDdcMKrkfNwc3Mk0L2KNLBCjLlUD0PNZ4+niKbPgo0wCJDlW9LP/zWdcMKAABwwgrXs8Ip3O9CCjPlUD0dNZ4+jCKbPgpdwCJD4Y5LP/zWdcMKAAA0wkjhs8LD9QZDCvBjOz7iKrc/TNAiPgrJrSJDsTY2PwjadcMKAAAAAAAAtEIK1yM9CiBU4z44LTI+8n6qPgpDzC'
..'JDtDY2PwnadcMKOGQ7Pim0iD7uYzs+ClDeIkO5NjY/U+Z1wwpJm0Q9KrSIPu5jOz4KUN4iQ7k2Nj8u4HXDClHlUD0yNZ4+9mM7Pgpp/iJD3bJIP//wdcMKPQoXQo/CfULDdaFCClXlUD0yNZ4+9GM7PgqR/iJDxJdIP+/wdcMKrkfNQc3Mk0I9iqxCCl3lUD1INZ4+DmQ7Pgpo/iJDy+JAP8/4dcMKFK6lQaRwREIUrlB'
..'CCl3lUD1JNZ4+DmQ7PgqR/iJDM9NAP7T4dcMKFK5nQVK4fUJ7FGJCCmDlUD1LNZ4+DGQ7PgqS/iJDuTY2P4z7dcMKAAAAAAAAcEIUru9BCmXlUD1MNZ4+CGQ7Pgpp/iJDuTY2P6v7dcMKAAAAAAAANEIUru9BCkrlUD0+NZ4+8mM7PgqR/iJDRporP7T4dcMKFK5nwVK4fULD9VhACkrlUD0+NZ4+82M7PgpN/iJDkZgr'
..'P7f4dcMKmpmlwWZmREIAAPhACnDlUD1JNZ4+EmQ7PgqR/iJDuNUjP+/wdcMKrkfNwa7Hk0LNzNLBCm/lUD1INZ4+EGQ7Pgpo/iJDqLojP//wdcMKPQoXwlK4fULheqbBCljlUD05NZ4+RpPYPgqR/iJDi29LP8DNdcMKXeVQPTo1nj49k9g+Cmj+IkPZjks/wM11wwps5VA9RjWePqoimz4Kkf4iQ9P9ID/31nXDCm7lU'
..'D1INZ4+pyKbPgpo/iJDiN4gP/fWdcMK8FPjPgcrBz7vfqo+ChUPI0O5NjY/Cdp1wwpAYpA+aZGtPj60iD4KEuQiQ7Y2Nj/ct3XDCqTws8LNzDzAzQwxwwr3Yzs+3iq3P07QIj4KABEjQ7U2Nj8J2nXDCihkOz7iKrc/oiwyPgoxECNDaDs2PxDadcMKcMJ1PQ5SOD4YT409CtYDI0POI0E/bct1wwpmZk7CAAAAwezR0E'
..'IK8SqHPQpSOD74wHU9ChIDI0PbD0g//sV1wwow46U9WeOlPc0mET8K21YjQ1OgDD8K2nXDCjQ9Cj4rBoE9MBY5PwqXWSNDuPUXPwradcMKAAAgQXsUtEIK1yM8Ckq0iD4rsBI/UcJ1Pgp1kCND9Cw2PxbadcMKT+OlPV3jpT2Cdj4+Cs15I0MbTxE/Ctp1wwqyGi8+PwgsPusuXT4K/pEjQ1urID8K2nXDCgrXIz0AALR'
..'CAAA0wwq7Ll09QgrXPfg0nj4K+jsjQ01OFD8K2nXDCvkHLD5xZuY/03FiPwpFYyNDPJrBPwradcMKcT0yQXsUtEIK1yM8CvkHLD4wZuY/fGUEPwp8rSNDzNO6PwradcMKCtd1QvYotELNzEw9CvzkUD025VA9VGwnPwqwXyNDkykOPwradcMKAAAAAHsUtEIAAAAACtNRuD2pm0Q8HN8vPwrsXiNDgD0UP/bTdcMKj8L1'
..'PB8FtEIAALRCCt9RuD2lm0Q8It8vPwrqXiNDnj0UPx7gdcMKj8L1vB8FtEIAAAAACtJRuD2Qm0Q811UuPwqvXyNDoxUIPx7gdcMKj8L1vNcjtEIAALRCCtNRuD2Vm0Q821UuPwqxXyNDhBUIP/bTdcMKj8L1vCncs8IAALRCCh/lUD2OwvU88XOTPQp4HCNDNXf6PubxdcMKAAAgQQAAtEIAALTCCgUGgT2nm0Q88XOTP'
..'Qp4HCNDM3f6Ppb0dcMKz1G4PbGbRDyxm0Q8CngcI0M3d/o+5PZ1wwp7FBbCXI9LQpoZK0MKZ74fPiYGgT0QhxY/Cq5aI0MniPo+Ctp1wwo146U9JgaBPUa6KT8KrlojQ2pSCj8K2nXDCjQILD13vp897ascPwquWiNDWoIGPzDvdcMKj8L1vFwPtEIAALRCCjQILD14vp897qscPwquWiNDlgvoPjDvdcMKj8L1vKTws0'
..'IAAAAACh/lUD2PwvU88nOTPQr6kSNDLoj6PtnxdcMKAACgwAAAtEIAALTCCgUGgT2nm0Q88nOTPQr6kSNDLIj6Pon0dcMK0VG4PbGbRDyxm0Q8CvqRI0MwiPo+1/Z1wwofhUHC4XokQoWrLsMETgSaBZsFCqcmI0NALzY/LNp1wwoAALTCAAAAAAAAtEIK151vPiyZYz+jnW8+ClVkOz7MnLA/F74fPgoFESNDrS42PyX'
..'adcMKYmQ7Pii5MT/+4iU+CrcNI0PwLjY/Jdp1wwouBoE+bidePmidbz4KKX0jQ0kvNj8s2nXDCsP1s0KPwiLDHwXZQgokBoE+JnANP+mKbD4KFqgjQwQvNj8s2nXDCiQGgT4B0Pg9fcaLPgrViiNDAS82PyzadcMK7lG4PqnSoD7L5Dc/CjVcI0MkmUk/LNp1wwp7FExCAAC0wgAANEMKLgaBPihwDT9nnW8+ClJdI0M1'
..'LzY/LNp1wwqvGq8+mQBqPrEimz4K28xMPiwXuT4/TD8+Cu1NI0MlWk0/VQJ2wwq4HstB4XoKQoXrksIK18xMPiUXuT47TD8+CudNI0OFUl4/XfF1wwpI4T9CZmZIQq5HQcIK1cxMPiUXuT48TD8+CuNNI0NWiGQ/L9p1wwpxPWxCZuazQgAAAAAK2MxMPiYXuT49TD8+CvJNI0Pd/R4/VAJ2wwopXMvBZmYKQgAA1cIK2'
..'MxMPicXuT49TD8+CvBNI0P6BQ4/XPF1wwo9CkDCrkdIQtejA8MKzcxMPicXuT5LTD8+CuZNI0NrBg4/AMN1wwoAAEDCe9QBQ9ejA0MK18xMPigXuT48TD8+CuBNI0Oi/h4/CLJ1wwquR8vBzUwRQwAA1UIK1sxMPicXuT45TD8+Ct1NI0OiLDY/0qt1wwoK1yO8PQoVQ8P1s0IK9cxMPiUXuT4uTD8+CtxNI0PsWk0/CL'
..'J1wwq4HstBrkcRQ4XrkkIK18xMPiQXuT49TD8+Ct5NI0OwUl4/AMN1wwpI4T9CPcoBQ3E9QUIK18xMPiUXuT5ATD8+CutNI0Md0Ac/Ldp1wwqkcGzCZuazQgAANEMK2cxMPi0XuT45TD8+CvFNI0OQKzY/iwh2wwoK1yO8SOH2QcP1s8IKncJ1PlaLND6WHoU+CvRSI0PULDY/Ldp1wwqk8LNCKVypQtejqMAKYvdJPj7'
..'htD4EXz4+CpRCI0OGLzY/bax1wwoAAAAArscuQ8P1s0IKWvdJPjPhtD77Xj4+CpFCI0OFC00/jbJ1wwrD9e5BUvgtQ+H6rUIKlfdJPnfhtD4JXz4+CpJCI0NZx10/SsN1wwpmZm5C16MpQ7geokIKnfdJPmjhtD7zXj4+CpVCI0Mu52M/Jtp1wwp7lKlCSOGzQo/C9bwKePdJPj7htD7uXj4+CplCI0O4xl0/AvF1wwop'
..'XG5C16MkQbgeosIKWPdJPi/htD7+Xj4+Cp1CI0NdCk0/vgF2wwpI4e5BUri+QOH6rcIKSPdJPizhtD4IXz4+CqBCI0NNLjY/3Qd2wwoAAAAAzcykQMP1s8IKbPdJPm7htD4nXz4+CqJCI0NAUh8/vQF2wwrD9e7BexS+QIXrucIKa/dJPkzhtD4HXz4+CqFCI0Nflg4/AfF1wwpmZm7CH4UjQTOzxcIKb/dJPiThtD7XX'
..'j4+Cp9CI0Osdgg/Jdp1wwoUrqnCAAC0QsP1M0MKnPdJPnDhtD4BXz4+CptCI0Mdlw4/ScN1wwpmZm7CUrgpQzOzxUIKZvdJPkbhtD4JXz4+CpdCI0N0Ux8/jbJ1wwpI4e7BAAAuQ4XruUIKXfdJPo1cgT4Y90k+CnREI0MULzY/Jdp1wwpP90k+PuG0PvBePj4KS0MjQ1gvNj9trHXDCkX3ST4y4bQ+514+PgpIQyNDVQ'
..'tNP42ydcMKgPdJPnbhtD75Xj4+CklDI0Mnx10/SsN1wwqI90k+Z+G0Pt9ePj4KTEMjQ/zmYz8m2nXDCmL3ST494bQ+3V4+PgpQQyNDhsZdPwLxdcMKRfdJPi/htD7qXj4+ClRDI0MtCk0/vgF2wwo190k+K+G0PvJePj4KV0MjQx8uNj/dB3bDClr3ST5u4bQ+FF8+PgpZQyNDFFIfP70BdsMKVvdJPkzhtD72Xj4+Clh'
..'DI0M1lg4/AfF1wwpa90k+JOG0PshePj4KVkMjQ4J2CD8l2nXDCob3ST5v4bQ+714+PgpSQyND85YOP0nDdcMKU/dJPkbhtD71Xj4+Ck5DI0NIUx8/jbJ1wwpL90k+jVyBPgP3ST4KK0UjQ+YuNj8l2nXDCsHMTD4nF7k+LUw/PgqkTiND8llNP1UCdsMKvsxMPiAXuT4sTD8+Cp5OI0NQUl4/XfF1wwq8zEw+Hhe5PixM'
..'Pz4Kmk4jQyGIZD8v2nXDCr/MTD4hF7k+Kkw/PgqpTiNDsP0eP1QCdsMKvsxMPiMXuT4rTD8+CqdOI0PPBQ4/XPF1wwqyzEw+Ihe5PjdMPz4KnU4jQ0AGDj8Aw3XDCrvMTD4hF7k+Kkw/PgqXTiNDdf4ePwiydcMKvMxMPiAXuT4oTD8+CpROI0NyLDY/0qt1wwrbzEw+Hhe5Ph1MPz4Kk04jQ7laTT8IsnXDCrzMTD4dF'
..'7k+K0w/PgqVTiNDelJePwDDdcMKok4jQ/LPBz8t2nXDCsDMTD4nF7k+KEw/PgqoTiNDYCs2P4sIdsMKfsJ1PlaLND6FHoU+CqtTI0OkLDY/Ldp1wwqk8LNCClepQsP1qMAKIAaBPihwDT/fimw+CgleI0MELzY/LNp1wwqbGq8+mQBqPp8imz4H7AME6QScBZ0FCgAAkEIAgCZD9qiKQgpdUCNDQJ9TPx7NdcMKXA/XQu'
..'F6hEC4nsPCCs3MTD0ZEBo/zcxMPQqcwUw9hSnEPohg+jwK2GsjQ10JWT9lz3XDCpzBTD1OPWE+y//5PAorICNDEk5OP9vHdcMK7FGLQqSwGEO4HmFCB08BBOkEngWfBQbn5+wKAICMQppZG0N7FGtCCtcj2EKamQFBcb3DwgrNzEw9rjwRP2ZIgD0KlKWqPVGSPT6+dBM9CugfI0NgQk4/08d1wwqUpao9iCnEPr50Ez0'
..'KSmcjQ7a3Vz8lz3XDCh8FkELheiZDuJ6KQiEHQWltUGFydAT+BJUFkgUKOushQ8DqNT9W2XXDCs3MTD7NzEw+zcxMPiEGT2Zmc2V0CgAAAAAAAAAAAADAPwoK16M8CtejPAAAoEEKCtcjPArXIzwAAHpEB1wBBAcFkQWSBQbt6uoKMh8jQ4C8Nj9o2nXDCpmZGT+WmRk+lpkZPgMAAACgmZnpPyEFU2hhcGUhCVNpZ2h0'
..'TWFyawcHBAQPBZUFkgUGYiXRCi3JIkMA5zU/Vtl1wwrsUTg+7FE4Ps3MTD0hClN1cmZhY2VHdWkhBEZhY2UhBkJvcmRlciELQW5jaG9yUG9pbnQLAAAAPwAAAD8hEENsaXBzRGVzY2VuZGFudHMMAAAAPwAAAAAAPwAAIRdyYnhhc3NldGlkOi8vMTgwNTA3MjQ4OSERSW1hZ2VUcmFuc3BhcmVuY3kMmpkZPwAAmpkZP'
..'wAAISlodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEyNjEyNjkyMiEJRmlyZVBhcnQyB18BBCEFoAWhBQa8m10Kj8J1vT0KtMIK1yM8CpsRJUMANGS9Dtp1wwMAAABAMzPTPwrsUdfCKdyzws1M18IKqfxxPscwUz7nM5E9CstrdT/La3U/y2t1PxHNzEw9mpmZPQMAAAAAAECPQBEAAAAAAAC0QikCAAAAAP'
..'D//z3w//89AACAPwAAAAAAAAAAIRZyYnhhc3NldGlkOi8vMjU3NDMwODcwKQIAAAAAAABAPwAAAD4AAIA/AACAPwAAAAADAAAAAAAAGEAhDVBsYXliYWNrU3BlZWQhFnJieGFzc2V0aWQ6Ly8xMzUwMzk1ODEhAzIwMwQxBZoFkgUKFH0kQwBEVr272XXDCoMMZD4I+3k+2eHWPwols7E9hxtDPIZ+mT8KsT8kQ1Ongj1'
..'o1nXDCqywZz46l3U9O9tyPgpD6yNDuth6vVTZdcMKAAAAAAAAAAAAALTCCqiwZz47l3U/2e5sPgq6bSRDfdh6vRLadcMKUwmrPlaErD+IG0M+ChvNJEMzp269Etp1wwrD9bPCAAAAAAAAAAAKjMltPrOEsD9mPVU+CnGjJEMnqG69Etp1wwoTZoE+pG7FPr4L5D8KEh/qPZqu2ztEf5k/Cm1TJENqwbg99th1wwq23ZM8'
..'m65bPP3S7D4KChYkQ9pZzT1K5XXDCpQqkD4XVww9f7SNPgrrsyRD9dotvXHZdcMKPM4kQ515Lb1y2XXDClvmJENFgy29cNl1wwrAbSRDloAtvXDZdcMKn1UkQ03cLb1x2XXDCuCFJENFgy29cNl1wwqCPSRDAIMtvXDZdcMKzZskQ0WDLb1w2XXDCjIjJENFgy29cNl1wwoSCyRDX90tvXHZdcMKSPwkQ5aALb1w2XXDC'
..'qQnxTubrls83QOUPwofUCRDrVnNPevhdcMKr4IsPcY4wD0UV4w8CsyeI0MqIBW+qth1wwoAAAAAAAC0wgAANEMKr4IsPfY4LD2pQoY8CiehI0PJlFW+qth1wwq4Ht9BAAC0wgAANEMKr4IsPY5zTD00MWI8CpCoI0NDxmy+qth1wwp7FJBCAAC0wgAANEMKr4IsPfvhHT6Rrls8CojBI0PvIXS+qth1wwqvgiw9yoQPPa'
..'dChjwKON8jQytLXb6q2HXDCrge30EAALRCAAAAAAqvgiw9R1QTPbLJgjwKS+EjQy/dPb6q2HXDCjMzA0AAALRCAAAAAAqvgiw9VCUcPWLOdjwKftkjQ7YVbr6q2HXDCjOzmkIAALRCAAAAAAq53ZM98MKkPEJw6D4K+iYlQ4w31D1w2XXDCrvdkz2Vrts8R+i0Pwo3rCRD/CikPXDZdcMKiPFFPPLCJD12hBQ+CjeUJEM'
..'jivY9V+p1wwoAAAAA1yO+QgAAAAAKWTMtPZmuWzyzTc0+CupzJEOQWc09mON1wwoFucY8ma5bPHnZUD4Km9EkQ6ZZzT1Q5HXDCgAAAACF67NCAAAAAAq6++s9mK7bOztJmD8Kc1MkQyPy4T3B2HXDCrv76z2Trts8ojsLPgrbPyRDtyICPsXYdcMKvPvrPZWu2zyiOws+ClHaJEO3IgI+qdh1wwq8++s9OEmYPh9NCT4K'
..'MuEjQ56GojzT2HXDCgAAtMKF67NCAAAAAAo1n4g9230yPiMYuz4KQ8kjQzh/YLzY2HXDCjWfiD2Krls8F6OcPgoAxiND6yikPdjYdcMKBLnGPJmuWzzvhwI+CoDLI0OhWc09fuR1wwo5n4g954eCPh5NCT0KILsjQ+6t8L3a2HXDCjWfiD0eTYk95UDiPQrl6SNDK5oJvtLYdcMKu/vrPZWu2zygOws+Ci3tI0OmIgI+0'
..'9h1wwSIBZoFkgUKaTkkQ4ALwD587nXDCumKdD6tGoY+5aGjPyEXcmJ4YXNzZXRpZDovLzIxNzUyOTI0OTkKACxkPtxAej6brZg/IQhBaW1QYXJ0MgSOBZUFkgUKNYgjQ4Bb8j6MAnbDCszMzD3rUbg9rUfhPQqbmSNDAAC0tYrZdcMKAACAPwAAAAAAAAAACgAAAAAAAIA/AAAAAAoAAEi4WgZ/PzCXsj0KAACAvwAASL'
..'gAwAu2CgAAAAAAAAAAAACAPwpxFWE/UyQIvp446r4KU0RZvVZLe79mvDs+ChHUfz9gic48+nbZPApQXtm8lfpRuujofz8KAAAAAAAAAAAAAIC/CgAAgL8AAAAAAAAAAAqMtgq+pgSUPkyacr8Ksvd8P2RR3z0bJ929CoW7Cr4k95M+LpxyvwonD3s/eWozPj20sb0KHuG0uVJJHTkAAIA/CgQVjjr3/38/6eQcuX0BAAA'
..'BAAIAAwABAAEBAAIAAwAEAAIEAAUABgAHAAgACQAIAAoACwAMAAMBAAUADQAMAAQBAAUADgAPAAUBAAUAEAAPAAUBAAUAEQAPAAUBAAUAEgAPAAUBAAUAEwAMAAQBAAUAFAAPAAoBAAUAFQAPAAoBAAUAFgAMAAQBAAUAFwAYAA0BAAUAGQAYAA0BAAUAGgAMAAQBAAUAGwAcABABAAUAHQAcABABAAUAHgAcABABAAUA'
..'HwAcABABAAUAIAAcABABAAUAIQAcABABAAUAIgAcABABAAUAIwAcABABAAUAJAAcABABAAUAJQAcABABAAUAJgAcABABAAUAJwAoABABAAUAKQAMAAQBAAUAKgAMAAQBAAUAKwAMAAQBAAUALAAtAB8DAAUALgAvADAAMQAyAC0AHwMABQAzADQANQAxADYALQAfAwAFADcANAA4ADEAOQAtAB8DAAUAOgA0ADsAMQA8A'
..'D0AHwwABQA+AD8AQABBAAgAQgBDAEQARQBGAEcASABJAEoASwBMAE0ATgBPAFAAUQBSAFMAPQAfDgAFAFQAVQBWAD8AVwBBAAgAQgBDAFgAWQBEAFoARgBHAEgASQBKAFsATABcAE4AXQBQAFEAUgBTAD0AHwwABQBeAFUAXwA/AGAAQQAIAEIAYQBYAGIARABjAEoAZABMAGUATgBmAFAAUQBSAFMADAAEAQAFAGcAaA'
..'AnAQAFAGkAagAoBQAFAGsAbABtAG4AYgBvAHAASgBxAGoAKQYABQByAGwAcwBuAHQAdQAyAG8AdgBKAHcAeAAqCwAFAHkAbABtAG4AYgB1ADIASgB6AHsAOQB8AH0AfgBtAH8AgACBADIAggCDAHgAKgwABQCEAGwAbQBuAGIAdQAyAG8AhQBKAIYAhwAIAHsAYgB8AIgAfgCJAH8AigCCAIMAeAAqDQAFAIsAbABtAG4'
..'AYgB1ADIAbwCMAEoAjQCOADkAewA5AHwAiAB+AG0AfwCKAIEAMgCCAIMAeAAqDAAFAI8AbABtAG4AYgB1ADIAbwCQAEoAkQCOADkAewBiAHwAkgB+AG0AfwCTAJQAMgB4ACoNAAUAlQBsAG0AbgBiAHUAMgBvAJYASgCXAIcACAB7AGIAfACYAH4AiQB/AJkAmgCbAIIAgwB4ACoNAAUAnABsAG0AbgBiAHUAMgBvAJ0A'
..'SgCeAI4AOQB7ADkAfACYAH4AbQB/AJkAgQAyAIIAgwCfACoJAAUAoABsAHMAbgB0AKEAbQB1ADIAbwCiAEoAowCkAKUApgCnAGoAKgYABQCoAGwAbQBuAKkAdQAyAG8AqgBKAKsAagAqBgAFAKwAbABtAG4AqQB1ADIAbwCtAEoArgBqACoGAAUArwBsAG0AbgCpAHUAMgBvALAASgCuAGoAKgYABQCxAGwAbQBuAKkAd'
..'QAyAG8AsgBKAK4AagAqBQAFALMAbABtAHUAMgBvALQASgCuAHgAKgwABQC1AGwAbQBuAGIAdQAyAG8AtgBKALcAewA5AHwAuAB+AG0AfwCAAIEAMgCCAIMAeAAqDAAFALkAbABtAG4AYgB1ADIAbwC6AEoAuwB7ADkAfAC8AH4AbQB/AIAAgQAyAIIAgwB4ACoMAAUAvQBsAG0AbgBiAHUAMgBvAL4ASgC/AHsAOQB8AM'
..'AAfgBtAH8AgACBADIAggCDAHgAKgwABQDBAGwAbQBuAGIAdQAyAG8AwgBKAMMAewA5AHwAxAB+AG0AfwCAAIEAMgCCAIMAnwApCAAFAMUAbgBiAG8AxgBKAMcAhwAIAI4AyACkAMkAygDLAGoAKAUABQDMAGwAbQBuAGIASgBxAIcACACfADwGAAUAzQBsAM4AbgBiAG8AzwBKANAApADRAJ8APAYABQDSAGwAzgBuAGI'
..'AbwDPAEoA0ACkANMAagA8BgAFANQAbADOAKEAzgB1ADIAbwDVAEoA1gBqADwGAAUA1wBsAM4AoQDOAHUAMgBvANUASgDWANgAPAEABQDZAGoAKAUABQDaAGwAbQBuAGIAbwBwAEoA2wDcAEINAAUA3QBsAN4AbgBiAHUAMgBvAN8ASgDgAIcACAB7AGIAfADhAH4AbQDiAIMAfwDjAIIAgwB4ACgMAAUA5ABsAG0AbgBi'
..'AG8A5QBKAOYAhwAIAHsAYgB8AOcAfgBtAOIAgwB/AOMAggCDAGoAKAQABQDoAGwAbQBuAGIASgBxAHgARQ0ABQDpAGwAbQBuAGIAdQAyAG8A6gBKAOsAewDsAHwA7QB+AMsA4gCDAH8A4wDuAGIAggCDAJ8AKAYABQDvAGwA8ABuAGIAdQAyAG8A8QBKAPIA8wADAQAFAPQA2AADAQAFAPUA9gBJAQAFAPcA+AADCwAFA'
..'PkA+gCDAPsA/AD9AP4A/wAIAD8AcwAAAQEBbwACAUoAAwEEAQUBBgEHAS0ASwMABQAIAS8AyAA0AAkBLQBLAwAFAAoBLwDIADQACwEMAUACQAKAFAEVARYBEQFAAoAUARcBGAEZAQAUARoBGwEcAUACQAKBFAEdAR4BHwGnACABIQEBFAEiAR4BHwGnACABIQHAAgAUASMBHgEfAQAUASQBHgElAQMLAAUADQH6AIMA/Q'
..'AOAf8ACAA/AA8BAAEBARABEQFvABIBSAARAUoAEwFSAGIA+AADCwAFACYB+gCDAPsA/AD9ACcB/wAIAD8AcwAAAQEBbwAoAUoAKQEEASoBBgErAfgAAwoA+gCDAPsA/AD9ACwB/wAIAD8AcwAAAQEBbwAtAUoALgEEAS8BBgEwAfgAAwoA+gCDAPsA/AD9ADEB/wAIAD8AcwAAAQEBbwAyAUoAMwEEATQBBgE1AfgAAws'
..'ABQA2AfoAgwD7ADcB/QA4Af8ACAA/ADkBAAEBAW8AOgFKADsBBAE8AQYBPQH4AAMLAAUANgH6AIMA+wA3Af0APgH/AAgAPwA5AQABAQFvAD8BSgBAAQQBQQEGAUIB+AADCwAFADYB+gCDAPsANwH9AEMB/wAIAD8ARAEAAQEBbwBFAUoARgEEAUcBBgFIAfgAAwsABQBJAfoAgwD7APwA/QBKAf8ACAA/AHMAAAEBAW8A'
..'SwFKAEwBBAFNAQYBTgEUAQMOAAUATwH6AIMAUAEyAPsAUQH9AFIB/wAIAD8AUwEAAQEBEAFUAW8AVQFIAFQBSgBWAVcBMgBSAGIALQBWAwAFAFgBLwAwADQAWQE9AFYNAAUAWgFVAFsBPwBcAV0BXgFBAAgAQgBfAVgAYgBEAGABSgBhAUwAYgFOAE8AUABjAVIAZAE9AFYNAAUAZQFVAFsBPwBmAV0BXgFBAAgAQgBfA'
..'VgAYgBEAGABSgBhAUwAZQBOAGcBUABjAVIAZAE9AFYMAAUAaAFBAAgAQgBpAVgAYgBEAGoBRgBlAEgAawFKAGwBTABtAU4AbgFQAG8BUgBwAXEBVgYABQByAXMBdAE/AHUBQQAIAHYBgwB3AewAFAEDDgAFAHgB+gCDAFABMgD7AFEB/QB5Af8ACAA/AFMBAAEBARABVAFvAHoBSABUAUoAVgFXATIAUgBiAC0AXAMABQ'
..'B7ATQAfAExAGIALQBcAgAFAH0BNAB+AS0AXAUABQB/AS8AyACAATkANACBATEAYgAtAFwFAAUAggEvAMgAgAE5ADQAgwExAGIALQBcAAAUAQMOAAUAhAH6AIMAUAEyAPsAUQH9AIUB/wAIAD8AUwEAAQEBEAGGAW8AhwFIAIgBSgCJAVcBMgBSAGIAigFiAQCLAYwBDAFAAgEUAZcBmAGZAacAIAEhAUACgRQBmgGbAZw'
..'BpwAgASEBQAKBFAGdAZ4BnAGnACABIQEBFAGfAaABmQGnACABIQEDCwAFAI0B+gCDAPsAjgH9AI8BPwCQAQABAQEQAZEBbwCSAZMBlAFIAJUBSgCWAQwBQAJAAkACQALADYAUAacBqAGpAYAUAaoBqwGsAYAUAa0BrgGvAYAUAbABsQGyAYAUAbMBtAG1AYAUAbYBtwG4AYAUAbkBugG7AYAUAbwBvQG+AYAUAb8BwAHB'
..'AYAUAcIBwwHEAYAUAcUBxgHHAYAUAcgByQHKAQAUAcsBzAHNAUACgRQBzgHPAdABpwAgASEBQAhAAkADQAEBFAHRAdIBogGnACABIQFAAgEUAdMB1AGiAacAIAEhAYAUAdUB1gHXAYEUAdgB2QGiAacAIAEhAcACQAIBFAHaAdsBogGnACABIQGAFAHcAd0B1wGBFAHeAd8BogGnACABIQFAAsACQAJAAkACQAJAAkACQ'
..'AJAAkAEABQB4AHhAeIBgBQB4wHkAeUBgBQB5gHnAegBgBQB6QHqAesBgBQB7AHtAe4BgBQB7wHwAfEBgBQB8gHzAfQBgBQB9QH2AfcBgBQB+AH5AfoBgBQB+wH8Af0BgBQB/gH/AQACgBQBAQICAgMCgBQBBAIFAgYCQALAAkACQAKAFAEHAggCCQJAAkACQAJAAkACQANAAwEUAQoCCwIMAqcAIAEhAYAUAQ0CDgIPAo'
..'AUARACEQISAoAUARMCFAIVAoAUARYCFwIYAoAUARkCGgIbAoAUARwCHQIeAoAUAR8CIAIhAoAUASICIwIkAoAUASUCJgInAoAUASgCKQIqAoAUASsCLAItAkACgRQBLgIvAuIBpwAgASEBQAJAAkACgBQBMAIxAjICQAJAAkACQAJAAkADQAMBFAEzAjQCogGnACABIQGAFAE1AjYCNwKAFAE4AjkCOgKAFAE7AjwCPQK'
..'AFAE+Aj8CQAKAFAFBAkICQwKAFAFEAkUCRgKAFAFHAkgCSQKAFAFKAksCTAKAFAFNAk4CTwKAFAFQAlECUgKAFAFTAlQCVQJAAsACQAJAAkACQAJAAkACQAJAAkAEABQB4AFWAuIBgBQB4wFXAuUBgBQB5gFYAugBgBQB6QFZAusBgBQB7AFaAu4BgBQB7wFbAvEBgBQB8gFcAvQBgBQB9QFdAvcBgBQB+AFeAvoBgBQB'
..'+wFfAv0BgBQB/gFgAgACgBQBAQJhAgMCgBQBBAJiAgYCQAJAAkACQAJAAkACQAJAAkACQAJAAkAEABQBYwJkAqIBgBQBZQJmAmcCgBQBaAJpAmoCgBQBawJsAm0CgBQBbgJvAnACgBQBcQJyAnMCgBQBdAJ1AnYCgBQBdwJ4AnkCgBQBegJ7AnwCgBQBfQJ+An8CgBQBgAKBAoICgBQBgwKEAoUCgBQBhgKHAogCgRQBi'
..'QKKAuIBpwAgASEBgBQBiwKMAuIBQAIBFAGNAo4CjwKnACABIQGBFAGQApEC0AGnACABIQFAAoEUAZICkwLQAacAIAEhAUACARQBlAKVAo8CpwAgASEBgBQBlgKXApgCQAMAFAGZApoCjwIBFAGbApwCjwKnACABIQGBFAGdAp4C0AGnACABIQFAAwEUAZ8CoAKPAqcAIAEhAYEUAaECogLQAacAIAEhAQEUAaMCpAKPAq'
..'cAIAEhAUACwAJAAkACQAJAAkACQAJAAkACQAQAFAGlAqYC4gGAFAGnAqgC5QGAFAGpAqoC6AGAFAGrAqwC6wGAFAGtAq4C7gGAFAGvArAC8QGAFAGxArIC9AGAFAGzArQC9wGAFAG1ArYC+gGAFAG3ArgC/QGAFAG5AroCAAKAFAG7ArwCAwKAFAG9Ar4CBgJAAsACQAJAAoAUAb8CwAIJAkACQAJAAkACQAJAA0ADARQ'
..'BwQLCAgwCpwAgASEBgBQBwwLEAg8CgBQBxQLGAhICgBQBxwLIAhUCgBQByQLKAhgCgBQBywLMAhsCgBQBzQLOAh4CgBQBzwLQAiECgBQB0QLSAiQCgBQB0wLUAicCgBQB1QLWAioCgBQB1wLYAi0CQAJAAkAGQAJAA0ADABQB2QLaAtsCABQB3ALdAt4CgBQB3wLgAuECgBQB4gLjAuQCgBQB5QLmAucCgBQB6ALpAuoC'
..'gBQB6wLsAu0CgBQB7gLvAvACgBQB8QLyAvACgRQB8wL0AvUCpwAgASEBgRQB9gL3AvgCpwAgASEBgRQB+QL6AvsCpwAgASEBgBQB/AL9Av4CQAJAAoEUAf8CAAPQAacAIAEhAUADQAIBFAEBAwIDAwOnACABIQEAFAEEAwUDBgNAAwEUAQcDCAMJA6cAIAEhAQEUAQoDCwMJA6cAIAEhAQEUAQwDDQMJA6cAIAEhAUADA'
..'RQBDgMPAxADpwAgASEBARQBEQMSAxMDpwAgASEBARQBFAMVAxMDpwAgASEBARQBFgMXAxgDpwAgASEBQAJAAkAEQAJAAoEUARkDGgPQAacAIAEhAUACARQBGwMcAx0DpwAgASEBARQBHgMfAx0D7AAgASEBQAIAFAEgAyEDHQOAFAEiAyMDJANAAkACARQBJQMmA48CpwAgASEBQAMBFAEnAygDjwKnACABIQFAAkADQA'
..'UAFAEpAyoDjwKAFAErAywDLQOAFAEuAy8DLQOAFAEwAzEDMgOAFAEzAzQDMgOAFAE1AzYDNwOAFAE4AzkDOgNAAkACQAIAFAE7AzwDPQMBFAE+Az8DPQOnACABIQEBFAFAA0EDPQOnACABIQFAAkACARQBQgNDA0QDpwAgASEBABQBRQNGA0QDARQBRwNIA0QDpwAgASEBQAJAA0AFABQBSQNKA0sDgBQBTANNA04DgBQ'
..'BTwNQA04DgBQBUQNSA1MDgBQBVANVA1MDgBQBVgNXA1gDgBQBWQNaA1sDQAJAAkACABQBXANdA14DARQBXwNgA14DpwAgASEBARQBYQNiA14DpwAgASEBQAJAAgEUAWMDZANlA6cAIAEhAQAUAWYDZwNlAwEUAWgDaQNlA6cAIAEhAYEUAWoDawPQAacAIAEhAUACQAKBFAFsA20D0AGnACABIQFAAkACQANAA0ADQANA'
..'A0ADQANAAgAUAW4DbwOPAgEUAXADcQOPAqcAIAEhAYAUAXIDcwN0A4AUAXUDdgN3A4AUAXgDeQN6A4AUAXsDfAN9A4AUAX4DfwOAA4AUAYEDggODA4AUAYQDhQOGA4AUAYcDiAOJA4AUAYoDiwOMA4AUAY0DjgOPA4AUAZADkQOSA4AUAZMDlAOVA4AUAZYDlwOYA4AUAZkDmgObA4AUAZwDnQPiAYAUAZ4DnwPiAYAUA'
..'aADoQOiA0ACgBQBowOkA9ABQAJAA0ADQANAA0ADQANAA0ACABQBpQOmA6IBARQBpwOoA6IBpwAgASEBgBQBqQOqA6sDgBQBrAOtA64DgBQBrwOwA7EDgBQBsgOzA7QDgBQBtQO2A7cDgBQBuAO5A7oDgBQBuwO8A70DgBQBvgO/A8ADgBQBwQPCA8MDgBQBxAPFA8YDgBQBxwPIA8kDgBQBygPLA8wDgBQBzQPOA88DgB'
..'QB0APRA9IDgRQB0wPUA9UDpwAgASEBQAJAAkACgBQB1gPXA+IBQAJAA0ADQANAA0ADQANAA0ACARQB2APZA48CpwAgASEBABQB2gPbA48CgBQB3APdA94DgBQB3wPgA+EDgBQB4gPjA+QDgBQB5QPmA+cDgBQB6APpA+oDgBQB6wPsA+0DgBQB7gPvA/ADgBQB8QPyA/MDgBQB9AP1A/YDgBQB9wP4A/kDgBQB+gP7A3Q'
..'DgBQB/AP9A3cDgBQB/gP/A5gDgBQBAAQBBJsDgBQBAgQDBOIBgBQBBAQFBAYEgRQBBwQIBNABpwAgASEBQAKBFAEJBAoE0AGnACABIQFAAgAUAQsEDAQNBAEUAQ4EDwQNBKcAIAEhAUAEQAJAA0ACABQBEAQRBBgDgBQBEgQTBBQEQAKBFAEVBBYE4gGnACABIQFAAgAUARcEGAQYA4EUARkEGgQbBKcAIAEhAUADABQB'
..'HAQdBBgDgBQBHgQfBCAEgBQBIQQiBCMEwAUAFAEkBCUEJgSAFAEnBCgEKQSAFAEqBCsELASAFAEtBC4ELwSAFAEwBDEEMgRAAwEUATMENAQ1BKcAIAEhAQEUATYENwQ1BKcAIAEhAYAUATgEOQQ6BEAEABQBOwQ8BBgDgBQBPQQ+BCYEgBQBPwRABEEEgBQBQgRDBEQEQAMBFAFFBEYERwSnACABIQEBFAFIBEkERwSnA'
..'CABIQGAFAFKBEsETAQDCgD6AIMA+wD8AP0AoQE/AHMAAAEBARABogFvAKMBSACkAUoApQGmAYMADAFAA0AHgRQBUQRSBI8CpwAgASEBARQBUwRUBI8CpwAgASEBARQBVQRWBFcEpwAgASEBgRQBWARZBKIBpwAgASEBwAIAFAFaBFsEogGAFAFcBF0EXgRAAsACgRQBXwRgBKIBpwAgASEBABQBYQRgBKIBQA2AFAFiBG'
..'MEZASAFAFlBGYEZwSAFAFoBGkEagSAFAFrBGwEbQSAFAFuBG8EcASAFAFxBHIEcwSAFAF0BHUEdgSAFAF3BHgEeQSAFAF6BHsEfASAFAF9BH4EfwSAFAGABIEEggSAFAGDBIQEhQQBFAGGBIcEiASnACABIQFADYAUAYkEigSLBIAUAYwEjQSOBIAUAY8EkASRBIAUAZIEkwSUBIAUAZUElgSXBIAUAZgEmQSaBIAUAZs'
..'EnASdBIAUAZ4EnwSgBIAUAaEEogSjBIAUAaQEpQSmBIAUAacEqASpBIAUAaoEqwSsBAAUAa0ErgTNAcANgBQBrwSwBIsEgBQBsQSyBI4EgBQBswS0BJEEgBQBtQS2BJQEgBQBtwS4BJcEgBQBuQS6BJoEgBQBuwS8BJ0EgBQBvQS+BKAEgBQBvwTABKMEgBQBwQTCBKYEgBQBwwTEBKkEgBQBxQTGBKwEABQBxwTIBM0B'
..'wAJADYAUAckEygRkBIAUAcsEzARnBIAUAc0EzgRqBIAUAc8E0ARtBIAUAdEE0gRwBIAUAdME1ARzBIAUAdUE1gR2BIAUAdcE2AR5BIAUAdkE2gR8BIAUAdsE3AR/BIAUAcsE3QSCBIAUAd4E3wSFBAEUAeAE4QTiBKcAIAEhAcACgRQB4wTkBKIBpwAgASEBABQB5QTkBKIBAwoA+gCDAPsA/AD9AE0EPwBzAAABAQEQA'
..'Y8CbwBOBEgATwRKAFAEpgGDAAwBQAIAFAHsBO0E6AQAFAHuBO8E8AQDCQD6AIMA+wDmBP0A5wQ/AMsAAAEBARAB6ARvAOkESADqBEoA6wQMAUACARQB9wT4BPQEpwAgASEBARQB+QT6BPsEpwAgASEBAwoA+gCDAPsA8QT9APIEPwDzBAABAQEQAfQEbwDpBEgA9QRKAPYEUgCUARQBAw4ABQD8BPoAgwBQATIA+wBRAf'
..'0A/QT/AAgAPwBTAQABAQEQAVQBbwD+BEgAVAFKAP8EVwEyAFIAYgCKAWkCAAAFAQWLAQIFigFpAQCLAQMFFAEDCgBQATIA+wAEBf0ABQU/AAYFAAEBAW8ABwVKAAgFVwEyAFIACQUKBTkAFAEDDgAFAAsF+gCDAFABMgD7AAwF/QANBf8ACAA/AA4FAAEBARABVAFvAA8FSABUAUoAEAVXATIAUgBiABEFbQEAEgU5AJ8'
..'AbgoABQATBRQFFQVsAG0AbgBiABYFgwBvABcFSgBxAI4AOQCkABgFGQWUAZ8AbwcABQDNABQFFQVsAG0AbgBiAG8AFwVKABoFpAAbBYoBbQEAiwEDBRQBAw8ABQAcBfoAgwBQATIA+wAdBf0AHgX/AAgAPwAfBQABAQEQASAFbwAhBZMBIgVIACMFSgAkBVcBMgBSAGIAigFyAQCLASUFPQByDQAFAFoBVQBbAT8AXAFd'
..'AV4BQQAIAEIAXwFYAGIARABgAUoAYQFMAGIBTgBPAFAAYwFSAGQBPQByDQAFAGUBVQBbAT8AZgFdAV4BQQAIAEIAXwFYAGIARABgAUoAYQFMAGUATgBnAVAAYwFSAGQBPQByDAAFAGgBPwBcAV0BXgFBAAgAQgAmBVgAYgBEACcFSAAoBUoAKQVMAGIBUAAqBVIAKwVxAXIGAAUAcgFzAcgAPwB1AUEACAB2AYMAdwEsB'
..'S0AcgQABQBYAS0FNgA0AC4FMQAiBQwBQAJAAQEUATMFNAUYAywFIAEhAUACQAIBFAE1BTYFNwUsBSABIQEBFAE4BTkFNwUsBSABIQFAAoEUAToFOwU8BSwFIAEhAQEUAT0FPgU3BSwFIAEhAQMMAAUALwX6AIMA+wD8AP0AMAX/AAgAPwBzAAABAQEQARgDbwAxBUgAGANKADIFpgGDAAwBQAJAAgEUAUAFQQUYAywFIA'
..'EhAUABARQBQgVDBRgDLAUgASEBQAJACwEUAUQFRQU3BSwFIAEhAQEUAUQFRgU3BSwFIAEhAQEUAUQFRwU3BSwFIAEhAQEUAUQFSAU3BSwFIAEhAQEUAUQFSQU3BSwFIAEhAQEUAUQFSgU3BSwFIAEhAQEUAUQFSwU3BSwFIAEhAQEUAUQFTAU3BSwFIAEhAQEUAUQFTQU3BSwFIAEhAQEUAUQFTgU3BSwFIAEhAQEUAUQ'
..'FTwU3BSwFIAEhAUACARQBUAVRBRgDLAUgASEBQAJAAwEUAVIFUwVUBSwFIAEhAQEUAVUFVgVXBSwFIAEhAQEUAVgFWQVaBSwFIAEhAUACQAIBFAFbBVwFogEsBSABIQFAAwEUAV0FXgVfBSwFIAEhAQEUAWAFYQViBSwFIAEhAQEUAWMFZAVlBSwFIAEhAUACQAIBFAFmBWcFGAMsBSABIQEBFAFoBWkFGAMsBSABIQFA'
..'AkADARQBagVrBWwFLAUgASEBARQBbQVuBWwFLAUgASEBQAIBFAFvBXAFcQUsBSABIQFAAwEUAXIFcwVxBSwFIAEhAQEUAXQFdQVxBSwFIAEhAQEUAXYFdwVxBSwFIAEhAUADQAUBFAF4BXkFegU5ACABIQEBFAF7BXwFcQUsBSABIQEBFAF9BX4FcQUsBSABIQEBFAF/BYAFcQUsBSABIQEBFAGBBYIFegU5ACABIQEBF'
..'AGDBYQFcQUsBSABIQEBFAGFBYYFcQUsBSABIQEDDAAFAC8F+gCDAPsA/AD9ADAF/wAIAD8AcwAAAQEBEAEYA28AMQVIABgDSgA/BaYBgwD4AAMMAPoAgwD7APwA/QCHBf8ACAA/AHMAAAEBARABGANvAIgFSAAYA0oAiQUEAYoFBgGLBRQBAw4ABQCMBfoAgwBQATIA+wBRAf0AjQX/AAgAPwBTAQABAQEQAVQBbwCOBU'
..'gAVAFKAI8FVwEyAFIAYgDzAAEAAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
