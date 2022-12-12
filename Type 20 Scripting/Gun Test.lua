--CREDITS
warn("Model was taken from 'BigToastBoii'.  Handcoded")
--VARIABLES
local ammocnt = 31
local mammocnt = 30
local mammowadd = 31
local FSC = 1
local magcnt = 3*mammocnt
local maginstances = {}
local FLE = false
local FA = false
local LE = false
local LA = false
local RA = nil
local LA = nil
local FSCurr = "Semi"
FSSettings = {}
FSSettings.Changeable = true
FSSettings.Semi = true
FSSettings.FullAuto = true
FSSettings.Burst = true
FSSettings.GL = false
FSSettings.Bolt = false
FSSettings.RPG = false
FSSettings.Shotgun = false
local boltpos = 0
GetClick = Instance.new("RemoteEvent")
GetClick.Parent = owner.Character
GetClick.Name = "GetClick"
NLS([==[
game:GetService("RunService").RenderStepped:Connect(function()
    for i, part in pairs(owner.Character:GetChildren()) do
        if part:IsA("Part") and (part.Name == "Right Arm" or part.Name == "Left Arm") then
            part.LocalTransparencyModifier = 0
        end
    end
end)
local mouse = owner:GetMouse()
mouse.Button1Down:Connect(function()
	script.Parent:FireServer(mouse.Hit)
end)
]==],GetClick)
GetKeys = Instance.new("RemoteEvent")
GetKeys.Parent = owner.Character
GetKeys.Name = "GetKey"
NLS([==[
game:GetService("UserInputService").InputBegan:Connect(function(key,isTyping)
	if isTyping == false then
		local mouse = owner:GetMouse()
		script.Parent:FireServer(key.KeyCode,"H",mouse.Target,mouse.Hit)
		script.Parent:FireServer(key.KeyCode,"R",mouse.Target,mouse.Hit)
		script.Parent:FireServer(key.KeyCode,"V",mouse.Target,mouse.Hit)
		script.Parent:FireServer(key.KeyCode,"F",mouse.Target,mouse.Hit)
		script.Parent:FireServer(key.KeyCode,"M",mouse.Target,mouse.Hit)
	end
end)
]==],GetKeys)
for _,a in pairs(owner.Character:GetDescendants()) do
	if a:IsA("Motor6D") and a.Name ~= "Left Hip" and a.Name ~= "Right Hip" then
		local Weld = Instance.new("Weld")
		Weld.Part0 = a.Part0
		Weld.Part1 = a.Part1
		Weld.C0 = a.C0
		Weld.C1 = a.C1
		Weld.Name = a.Name
		Weld.Parent = a.Parent
		if     a.Name == "Right Shoulder" then
			RA = Weld
		elseif a.Name == "Left Shoulder" then
			LA = Weld
		end
		a:Destroy()
	end
end
--Weapon load
local weapon
local HttpService = game:GetService("HttpService")
local code = HttpService:GetAsync("https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/648ce3703491a117ba58eb0ca7f8922a4b586853/Type%2020%20Scripting/Model%20Loading", true)
weapon = loadstring(code)()
weapon.Parent = script
weapon.PrimaryPart = weapon.Lower
for i,v in pairs(weapon:GetDescendants()) do
	if v:IsA("Part") and v ~= weapon.PrimaryPart then
		if v.Parent.Name == "Mag" then 
			v.Anchored = false
			continue
		else
		end
		local NewWeld = Instance.new("Weld")
		NewWeld.Part0 = weapon.PrimaryPart
		NewWeld.Part1 = v
		NewWeld.C0 = weapon.PrimaryPart.CFrame:inverse()
		NewWeld.C1 = v.CFrame:inverse()
		NewWeld.Parent = v
		v.Anchored = false
	end
end
weapon.PrimaryPart.CFrame = owner.Character["Right Arm"].CFrame * CFrame.Angles(math.rad(-80),math.rad(90-20),0) * CFrame.new(0,-1.25,0)
local HandleWeld = Instance.new("Weld")
HandleWeld.Part0 = owner.Character["Right Arm"]
HandleWeld.Part1 = weapon['Grip']
HandleWeld.C0 = CFrame.new(-0.25,-0.9,-0.4) * CFrame.Angles(math.rad(-90),math.rad(0),0,0)
HandleWeld.C1 = CFrame.new(0,0,0)
HandleWeld.Parent = owner.Character["Right Arm"]
maginstances.main = weapon:FindFirstChild("Mag")
maginstances["1"] = weapon:FindFirstChild("Mag").Bullets
maginstances["2"] = weapon:FindFirstChild("Mag").Mag2
weapon.PrimaryPart.Anchored = false
--Weapon Functionality
function FireSound()
	local f = coroutine.create(function()
		local sound = weapon.Grip.Fire:Clone()
		sound.Playing = true
		sound.Parent = weapon.Grip
		wait(sound.TimeLength)
		sound:Destroy()
	end)
	coroutine.resume(f)
end
function ClickSound()
	local f = coroutine.create(function()
		local sound = weapon.Grip.Click:Clone()
		sound.Playing = true
		sound.Parent = weapon.Grip
		wait(sound.TimeLength)
		sound:Destroy()
	end)
	coroutine.resume(f)
end
function Shoot(plr,hit)
	if ammocnt == 0 then print ("Cannot fire. (No ammo in magazine)") ClickSound() return end
	if boltpos == 1 then print ("Cannot fire. (Bolt in forwards position)") return end
	print("Firing at hit point of mouse")
	ammocnt -= 1
	FireSound()
	if ammocnt == 0 then
		print("Empty")
		Bolt("NPA")
	end
end
function Reload(targ)
	print("Reloading.")
	if weapon:FindFirstChild("Mag") ~= nil then
		local ammodrop = weapon.Mag:clone()
		ammodrop.Anchored = false
		ammodrop.CanCollide = true
		ammodrop:BreakJoints()
		game.Debris:AddItem(ammodrop,3)
		weapon:FindFirstChild("Mag").Transparency = 1
		weapon:FindFirstChild("Mag").Bullets.Transparency = 1
		weapon:FindFirstChild("Mag").Mag2.Transparency = 1
		weapon:FindFirstChild("Mag").Transparency = 0
		weapon:FindFirstChild("Mag").Bullets.Transparency = 0
		weapon:FindFirstChild("Mag").Mag2.Transparency = 0
	else
		return "Error getting mag."
	end
	print(targ)
end
function FireSelect()
	if FSSettings.Changeable == false then return end
	ClickSound()
	local CONTLOOP = false
	for i=1,6 do
		if CONTLOOP == true then continue end
		FSC+=1
		if FSC == 8 then
			FSC = 1
		end
		if FSC == 1 and FSSettings.Semi == true then
			FSCurr="Semi"
			CONTLOOP = true
		elseif FSC == 2 and FSSettings.FullAuto == true then
			FSCurr="Full"
			CONTLOOP = true
		elseif FSC == 3 and FSSettings.Burst == true then
			FSCurr="Burs"
			CONTLOOP = true
		elseif FSC == 4 and FSSettings.GL == true then
			FSCurr="GL"
			CONTLOOP = true
		elseif FSC == 5 and FSSettings.Bolt == true then
			FSCurr="Bolt"
			CONTLOOP = true
		elseif FSC == 6 and FSSettings.RPG == true then
			FSCurr="RPG"
			CONTLOOP = true
		elseif FSC == 7 and FSSettings.Shotgun == true then
			FSCurr="Shot"
			CONTLOOP = true
		end
	end
	if CONTLOOP ~= true then
		print("Unable to change, setting changeable to false.")
		FSSettings.Changeable = true
	end
	print(FSCurr)
end
function Bolt(Task)
	if Task == "NPA" then
		if boltpos == 0 then
			print("Bolt forward Empty")
			weapon.Bolt.BoltBack.Playing=true
			boltpos = 1
		else

		end
	end
	if Task == "PI" then
		if boltpos == 0 then
			print("Bolt Going forward")
			weapon.Bolt.BoltBack.Playing=true
			boltpos = 1
		else
			print("Bolt Going Back")
			weapon.Bolt.BoltForward.Playing=true
			boltpos = 0
		end
	end
	if Task == "PIBR" then
		if boltpos == 1 then
			print("Bolt released.")
			weapon.Bolt.BoltForward.Playing=true
			boltpos = 0
		else

		end
	end
end
function MagCheck()
	print("Checking Mag.")
	print(ammocnt)
	print("Returning magazine.")
end
--Connect functions to their events
GetClick.OnServerEvent:Connect(function(plr,extra)
	print(plr,extra)
	Shoot(plr)
end )
GetKeys.OnServerEvent:Connect(function(plr,key,var,targ,hit)
	if key == Enum.KeyCode.R and var == "R" then
		Reload()
		if boltpos == 1 then
			Bolt("PIBR")
		else
			Bolt("PI")
			Bolt("PI")
		end
		if ammocnt == 0 then
			print(magcnt,ammocnt)
			for i=1,30 do
				if magcnt ~= 0 then
					ammocnt+=1
					magcnt-=1
				end
			end
			print(magcnt,ammocnt)
		else
			print(magcnt,ammocnt)
			local curammo = ammocnt
			local missing = math.abs(curammo-mammowadd)
			for i=1,missing do
				if magcnt ~= 0 then
					ammocnt+=1
					magcnt-=1
				end
			end
			print(magcnt,ammocnt)
		end
	end
	if key == Enum.KeyCode.V and var == "V" then
		FireSelect()
	end
	if key == Enum.KeyCode.F and var == "F" then
		Bolt("PI")
	end
	if key == Enum.KeyCode.M and var == "M" then
		MagCheck()
	end
end)
--Animations
local char = owner.Character
torso = char.Torso
LS = torso["Left Shoulder"]
MTP = Instance.new("Model", char)
Run = game:GetService("RunService")
local RightShoulder = char.Torso["Right Shoulder"]
local RightShoulderC0 = RightShoulder.C0
local LeftShoulder = char.Torso["Left Shoulder"]
local LeftShoulderC0 = LeftShoulder.C0
local Neck = char.Torso["Neck"]
local NeckC0 = Neck.C0
local torso = char.Torso
local targeted = nil
local RootPart = char.HumanoidRootPart
local RootJoint = RootPart.RootJoint
local RootJointC0 = RootJoint.C0
local RootJointC1 = RootJoint.C1
local LeftHip = torso["Left Hip"]
local LeftHipC0 = LeftHip.C0
local LeftHipC1 = LeftHip.C1
local RightHip = torso["Right Hip"]
local RightHipC0 = RightHip.C0
local RightHipC1 = RightHip.C1
local Run = game:GetService("RunService")
LeftShoulder.C0 = CFrame.new(-1,0.5,0,0,0,-1,0,1,0,1,0,0)
RightShoulder.C0 = CFrame.new(1,0.5,0,0,0,1,0,1,0,-1,0,0)
LeftHip.C0 = CFrame.new(-1,-1,0,0,0,-1,0,1,0,1,0,0)
RightHip.C0 = CFrame.new(1,-1,0,0,0,1,0,1,0,-1,0,0)
RootJoint.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(180))
Neck.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0)
LSC0 = LeftShoulder.C0
RSC0 = RightShoulder.C0
RJC0 = RootJoint.C0
LHC0 = LeftHip.C0
RHC0 = RightHip.C0
NKC0 = Neck.C0
owner.Character.Humanoid.Running:Connect(function(speed)
	if speed == 0 then
		running = false
	else
		running = true
	end
end)
local Tick = 0
