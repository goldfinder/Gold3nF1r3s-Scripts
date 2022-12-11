for _,a in pairs(owner.Character:GetDescendants()) do
	if a:IsA("Motor6D") then
		local Weld = Instance.new("Weld")
		Weld.Part0 = a.Part0
		Weld.Part1 = a.Part1
		Weld.C0 = a.C0
		Weld.C1 = a.C1
		Weld.Name = a.Name
		Weld.Parent = a.Parent
		a:Destroy()
	end
end
--CREDITS
warn("Model was taken from 'BigToastBoii'.  Handcoded")
--VARIABLES
local ammocnt = 31
local mammocnt = 30
local mammowadd = 31
local magcnt = 3*ammocnt
local FLE = false
local FA = false
local LE = false
local LA = false
local FSM = {}
FSM.Curr = "Semi"
FSM.Changeable = true
FSM.Semi = true
FSM.FullAuto = true
FSM.Burst = true
FSM.GL = false
FSM.Bolt = false
FSM.RPG = false
FSM.Shotgun = false
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
		script.Parent:FireServer(key.KeyCode,"P",mouse.Target,mouse.Hit)
	end
end)
game:GetService("UserInputService").InputEnded:Connect(function(key,isTyping)
	if isTyping == false then
		local mouse = owner:GetMouse()
		script.Parent:FireServer(key.KeyCode,"R",mouse.Target,mouse.Hit)
	end
end)
game:GetService("UserInputService").InputEnded:Connect(function(key,isTyping)
	if isTyping == false then
		local mouse = owner:GetMouse()
		script.Parent:FireServer(key.KeyCode,"V",mouse.Target,mouse.Hit)
	end
end)
game:GetService("UserInputService").InputEnded:Connect(function(key,isTyping)
	if isTyping == false then
		local mouse = owner:GetMouse()
		script.Parent:FireServer(key.KeyCode,"F",mouse.Target,mouse.Hit)
	end
end)
game:GetService("UserInputService").InputEnded:Connect(function(key,isTyping)
	if isTyping == false then
		local mouse = owner:GetMouse()
		script.Parent:FireServer(key.KeyCode,"M",mouse.Target,mouse.Hit)
	end
end)
]==],GetKeys)
--Weapon load
local weapon
local HttpService = game:GetService("HttpService")
local code = HttpService:GetAsync("https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/main/Type%2020%20Scripting/Model%20Loading", true)
weapon = loadstring(code)()
weapon.Parent = script
weapon.PrimaryPart = weapon.Lower
for i,v in pairs(weapon:GetDescendants()) do
	if v:IsA("Part") and v ~= weapon.PrimaryPart then
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
HandleWeld.Part1 = weapon['BCM Gunfighter Mod 3 Grip']
HandleWeld.C0 = CFrame.new(0,-.75,0) * CFrame.Angles(0,math.pi/2,math.rad(-90))
HandleWeld.C1 = CFrame.new(0,0,0)
HandleWeld.Parent = owner.Character["Right Arm"]
task.spawn(function()
	while true do
		task.wait()
		HandleWeld.C1 = HandleWeld.C1 * CFrame.Angles(0,math.rad(0),math.rad(16))
	end
end)
weapon.PrimaryPart.Anchored = false
function Shoot(plr,hit)
	if boltpos == 1 then print ("Cannot fire. (Bolt in forwards position)") return end
	if ammocnt == 0 then print ("Cannot fire. (No ammo in magazine)") return end
	print("Firing at hit point of mouse")
	ammocnt -= 1
	if ammocnt == 0 then
		Bolt("NPI")
	end
end
function Reload()
	print("Reloading.")
end
function FireSelect()
	if FSM.Changeable == false then return end
	if FSM.Curr == "Semi" then
		if FSM.FullAuto == true then
			FSM.Curr = "Full"
		elseif FSM.Burst == true then
			FSM.Curr = "Burs"
		elseif FSM.GL == true then
			FSM.Curr = "GL"
		elseif FSM.Bolt == true then
			FSM.Curr = "Bolt"
		elseif FSM.RPG == true then
			FSM.Curr = "RPG"
		elseif FSM.Shotgun == true then
			FSM.Curr = "Shot"
		else
			FSM.Changeable = false
		end
	elseif FSM.Curr == "Full" then
		if FSM.Burst == true then
			FSM.Curr = "Burs"
		elseif FSM.GL == true then
			FSM.Curr = "GL"
		elseif FSM.Bolt == true then
			FSM.Curr = "Bolt"
		elseif FSM.RPG == true then
			FSM.Curr = "RPG"
		elseif FSM.Shotgun == true then
			FSM.Curr = "Shot"
		elseif FSM.Semi == true then
			FSM.Curr = "Semi"
		else
			FSM.Changeable = false
		end
	elseif FSM.Curr == "Burs" then
		if FSM.GL == true then
			FSM.Curr = "GL"
		elseif FSM.Bolt == true then
			FSM.Curr = "Bolt"
		elseif FSM.RPG == true then
			FSM.Curr = "RPG"
		elseif FSM.Shotgun == true then
			FSM.Curr = "Shot"
		elseif FSM.Semi == true then
			FSM.Curr = "Semi"
		elseif FSM.FullAuto == true then
			FSM.Curr = "Full"
		else
			FSM.Changeable = false
		end
	elseif FSM.Curr == "GL" then
		if FSM.Bolt == true then
			FSM.Curr = "Bolt"
		elseif FSM.RPG == true then
			FSM.Curr = "RPG"
		elseif FSM.Shotgun == true then
			FSM.Curr = "Shot"
		elseif FSM.Semi == true then
			FSM.Curr = "Semi"
		elseif FSM.FullAuto == true then
			FSM.Curr = "Full"
		elseif FSM.Burst == true then
			FSM.Curr = "Burs"
		else
			FSM.Changeable = false
		end
	end
	print(FSM.Curr)
end
function Bolt(Task)
	if task == "NPA" then
		if boltpos == 0 then
			print("Bolt Going forward")
			boltpos = 1
		else return end
	end
	if task == "PI" then
		if boltpos == 0 then
			print("Bolt Going forward")
			boltpos = 1
		else return end
	end
	if task == "PIBR" then
		
	end
end
function MagCheck()
	print("Checking Mag.")
	print(ammocnt)
	print("Returning magazine.")
end
--Connect functions to their events
GetClick.OnServerEvent:Connect(Shoot)
GetKeys.OnServerEvent:Connect(function(plr,key,var,targ,hit)
	if key == Enum.KeyCode.R and var == "R" then
		Reload()
		if boltpos == 1 then
			Bolt("PIBR")
		else
			Bolt("PI")
			Bolt("PIBR")
		end
		if ammocnt == 0 then
			print(magcnt)
			ammocnt = mammocnt
			magcnt -= 1*mammocnt
			print(magcnt)
		else
			local curammo = ammocnt
			ammocnt = mammowadd
			print(magcnt)
			magcnt -= math.abs(curammo-ammocnt)
			print(magcnt)
		end
	end
	if key == Enum.KeyCode.V and var == "V" then
		FireSelect()
	end
	if key == Enum.KeyCode.F and var == "F" then
		Bolt()
	end
	if key == Enum.KeyCode.M and var == "M" then
		MagCheck()
	end
end)
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
Run.Stepped:Connect(function()
	Tick = Tick + 1
	if running == false then
		RootJoint.C1 = RootJoint.C1:Lerp(RootJointC1 *CFrame.new(0,0,0.1+-.05 * math.cos(Tick/25)),0.1)
		RightHip.C1 = RightHip.C1:Lerp(RightHipC1 * CFrame.new(-0.2,-0.1+.05*math.cos(Tick/25),0),0.1)
		LeftHip.C1 = LeftHip.C1:Lerp(LeftHipC1 * CFrame.new(0.25,-0.1+.05*math.cos(Tick/25),0),0.1)
		RightHip.C0 = RightHip.C0:Lerp(RightHipC0 * CFrame.Angles(0,math.rad(-10),0),0.1)
		LeftHip.C0 = LeftHip.C0:Lerp(LeftHipC0 * CFrame.Angles(0,math.rad(15),0),0.1)
		RightShoulder.C0 = RightShoulder.C0:Lerp(RightShoulderC0 * CFrame.Angles(math.rad(-15),math.rad(27) + .05 *math.cos(Tick/600),math.rad(50)) * CFrame.new(0,0,-0.5),0.1)
		LeftShoulder.C0 = LeftShoulder.C0:Lerp(LeftShoulderC0 * CFrame.Angles(math.rad(50),0,math.rad(-80)) * CFrame.new(0,-0.7,0),0.1)
	else
		RootJoint.C0 = RootJoint.C0:Lerp(RootJointC0 * CFrame.new(0,0,0 + .1 * math.sin(Tick/5)),0.1)
		RightHip.C0 = RightHip.C0:Lerp(RightHipC0 * CFrame.new(0,0 - 0.2 * math.sin(Tick/20),0) * CFrame.Angles(0,0,math.rad(-25)+math.rad(35)*math.cos(Tick/10)),0.1)
		LeftHip.C0 = LeftHip.C0:Lerp(LeftHipC0 * CFrame.new(0,0 + 0.2 * math.sin(Tick/20),0) * CFrame.Angles(0,0,math.rad(25)-math.rad(35)*-math.cos(Tick/10)),0.1)
		RightShoulder.C0 = RightShoulder.C0:Lerp(RightShoulderC0*CFrame.Angles(0,0,math.rad(120)),0.1)
		LeftShoulder.C0 = LeftShoulder.C0:Lerp(LeftShoulderC0*CFrame.Angles(0,-0.1*math.cos(Tick/10),-0.5*math.cos(Tick/10)),0.1)
	end
end)

game:GetService("VoiceChatService")
