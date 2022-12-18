--CREDITS
warn("Model was taken from 'BigToastBoii'.  Handcoded")
print("Controls:")print("V: Fire Selector")print("F: Bolt")print("R: Reload")print("M: Mag Check")print("F1: Weapon Debug Information")
--VARIABLES
local ammocnt,mammocnt,mammowadd,FSC = 31,30,31,1
local magcnt = 3*mammocnt
local maginstances = {}
local OH,CH = 45,0
local OHL,DT,FLE,FA,LE,LA,Bool,OHR = false,false,false,false,false,false,false,false
local RA,LA = nil
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
		script.Parent:FireServer(key.KeyCode,"CG1",mouse.Target,mouse.Hit)
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
--  Developer Toggle
function ToggleDeveloper()
	DT = not DT
	if DT == true then
		print("Developer Mode Toggled. (Active)")
	else
		print("Developer Mode Toggled. (Inactive)")
	end
end
--  Sound Triggers
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
	if ammocnt == 0 then if DT == true then print ("Cannot fire. (No ammo in magazine)") end ClickSound() return end
	if boltpos == 1 then if DT == true then print ("Cannot fire. (Bolt in forwards position)") end return end
	if OHL == true then if DT == true then print ("Cannot fire.  (Too hot)") end ClickSound() return end
	if DT == true then
		print("Firing at hit point of mouse")
	end	
	ammocnt -= 1
	CH+=1
	if CH == 45 then
		OHL = true
	end
	OverheatEffect()
	FireSound()
	FireEffects()
	if ammocnt == 0 then
		if DT == true then
			print("Empty")
		end
		Bolt("NPA")
	end
end
--  Effects
function FireEffects()
	local f = coroutine.create(function()
		weapon.SmokePart.FlashFX.Enabled = true
		weapon.SmokePart["FlashFX[Flash]"].Enabled = true
		weapon.SmokePart.Smoke.Enabled = true
		wait()
		weapon.SmokePart.FlashFX.Enabled = false
		weapon.SmokePart["FlashFX[Flash]"].Enabled = false
		weapon.SmokePart.Smoke.Enabled = false
	end)
	coroutine.resume(f)
end
function OverheatEffect()
	if DT == true then
		print("Checking Overheat")
	end
	if OHR == false then else return end
	OHR = true
	if DT == true then
		print("Overheat added")
	end
	local f = coroutine.create(function()

		repeat 
			CH-=1 
			wait(1)
			if CH >= 12 and OHL ~= true then
				weapon.SmokePart.OverHeat.Enabled = true
			elseif OHL == true then
				weapon.SmokePart.OverHeat.Enabled = true
			else
				weapon.SmokePart.OverHeat.Enabled = false
			end
		until
		CH == 0
		if weapon.SmokePart.OverHeat.Enabled == true then 
			weapon.SmokePart.OverHeat.Enabled = false 
		end
		OHR = false
		if DT == true then
			OHL = false
			print("Closing Overheat")
		end
	end)
	coroutine.resume(f)
end
--  Triggers
function Reload(targ)
	if DT == true then
		print("Reloading")
	end
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
	if DT == true then
		print(targ)
	end
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
		if DT == true then
			print("Unable to change, setting changeable to false.")
		end
		FSSettings.Changeable = true
	end
	if DT == true then
		print(FSCurr)
	end
end
function Bolt(Task)
	if Task == "NPA" then
		if boltpos == 0 then
			if DT == true then
				print("Bolt forward Empty")
			end
			weapon.Bolt.BoltBack.Playing=true
			boltpos = 1
		else

		end
	end
	if Task == "PI" then
		if boltpos == 0 then
			if DT == true then
				print("Bolt Going forward")
			end
			weapon.Bolt.BoltBack.Playing=true
			boltpos = 1
		else
			if DT == true then
				print("Bolt Going Back")
			end
			weapon.Bolt.BoltForward.Playing=true
			boltpos = 0
		end
	end
	if Task == "PIBR" then
		if boltpos == 1 then
			if DT == true then
				print("Bolt released.")
			end
			weapon.Bolt.BoltForward.Playing=true
			boltpos = 0
		end
	end
end
function MagCheck()
	if DT == true then
		print("Checking Mag.")
	end
	print(ammocnt)
	if DT == true then
		print("Returning Mag.")
	end
end
--Connect functions to their events
GetClick.OnServerEvent:Connect(function(plr,extra)
	if DT == true then
		print(plr,extra)
	end
	
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
			if DT == true then
				print(magcnt,ammocnt)
			end
			for i=1,30 do
				if magcnt ~= 0 then
					ammocnt+=1
					magcnt-=1
				end
			end
			if DT == true then
				print(magcnt,ammocnt)
			end
		else
			if DT == true then
				print(magcnt,ammocnt)
			end
			local curammo = ammocnt
			local missing = math.abs(curammo-mammowadd)
			for i=1,missing do
				if magcnt ~= 0 then
					ammocnt+=1
					magcnt-=1
				end
			end
			if DT == true then
				print(magcnt,ammocnt)
			end
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
	if key == Enum.KeyCode.F1 and var == "CG1" then
		ToggleDeveloper()
	end
end)
--Animations
local char = owner.Character
torso = char.Torso
MTP = Instance.new("Model", char)
Run = game:GetService("RunService")
RA.C1 = CFrame.new(-.25,.7,-.01) * CFrame.Angles(0,math.rad(90),math.rad(-90))
