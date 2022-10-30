local map = loadstring(game:GetService("HttpService"):GetAsync('https://glot.io/snippets/geuh57fzbn/raw/map.lua'))()
local objects = map:WaitForChild'GameObjects'
local status = map:WaitForChild'GameStatus'
local msg = status:WaitForChild("HintMessage")
local replaced = false
local gui = map:WaitForChild("main")
gui:WaitForChild'hint'.Size = UDim2.new(1,0,0,20)
gui:WaitForChild'hint'.TextEditable = false
gui:WaitForChild'hint'.ClearTextOnFocus = false
gui:WaitForChild'hint'.BorderSizePixel = 0
local players = {}
local playerdata = {}
local teams = {'Red','Blue'}
local scores = {}
local tc = {['Red'] = BrickColor.new("Bright red"),['Blue'] = BrickColor.new("Bright blue")}
local teaminst = {}
local teamss = game:GetService("Teams")
for i,v in pairs(teams) do
	local t = teamss:FindFirstChild(v) or Instance.new("Team")
	t.AutoAssignable = false
	t.TeamColor = tc[v]
	t.Parent = teamss
	t.Name = v
	teaminst[v] = t
end
function flagfunc(flag,team,iscloned)
	local tb = flag:FindFirstChild("Text",true)
	if not iscloned then
		flag:SetAttribute("team",team)
		local bill = Instance.new("BillboardGui")
		bill.LightInfluence = false
		bill.Size = UDim2.new(1,0,1,0)
		bill.AlwaysOnTop = true
		bill.Parent = flag
		tb = Instance.new("TextBox")
		tb.Name = "Text"
		tb.Text = team.."\nFlag"
		tb.Parent = bill
		tb.AnchorPoint = Vector2.new(.5,.5)
		tb.Size = UDim2.new(4,0,2,0)
		tb.Position = UDim2.new(.5,0,.5,0)
		tb.BackgroundTransparency = 1
		tb.TextScaled = true
		tb.TextColor3 = tc[team].Color
		tb.TextStrokeTransparency = 0
	end
	local flagc = flag:Clone()
	local flagtaken = false
	local gotflag = false
	local v = flag
	local cf = flag.CFrame
	local takercons = {}
	local w
	local gotreset = false
	local endtake = function(fallen)
		w:Destroy()
		flag.CanTouch = true
		flag:SetAttribute("Taken",nil)
		for i,v in pairs(takercons) do
			v:Disconnect()
		end
		gotflag = false
		if fallen then
			for i = 40,0,-1 do
				tb.Text = team.."\nFlag\nReturns in : ".. i
				task.wait(1)
				if flag:GetAttribute("Taken") or gotreset then
					break
				end
			end
			tb.Text = team.."\nFlag"
			if not flag:GetAttribute("Taken") then
				flag:SetAttribute("Reset",true)
			end
		end
	end
	flag.Touched:Connect(function(hit)
		if hit ~= nil and hit.Parent ~= nil and hit.Parent:GetAttribute("team") ~= nil and hit.Parent:FindFirstChildWhichIsA("Humanoid") then
			local hum = hit.Parent:FindFirstChildWhichIsA("Humanoid")
			local char = hit.Parent
			local tors = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
			if hit.Parent:GetAttribute("team") ~= team and hum.Health > 0 and not gotflag and tors then
				flagtaken = true
				gotflag = true
				replaced = true
				msg.Value = ("%s Flag has been taken by %s!"):format(team,hit.Parent.Name)
				task.delay(2,function()
					replaced = false
				end)
				flag.CanTouch = false
				flag.Anchored = false
				flag:SetAttribute("Taken",true)
				local obj = Instance.new("ObjectValue")
				obj.Parent = char
				obj.Name = "Flag"
				obj.Value = flag
				w = Instance.new("Weld")
				w.Parent = flag
				w.Part0 = flag
				w.Part1 = tors
				w.C0 = CFrame.new(0,0,-1)
				takercons[#takercons+1] = hum.Died:Connect(function()
					endtake(true)
				end)
				takercons[#takercons+1] = char:GetPropertyChangedSignal("Parent"):Connect(function()
					endtake(true)
				end)
				for i,v in pairs(char:GetDescendants()) do
					if v:isA("BasePart") then
						game:GetService("PhysicsService"):SetPartCollisionGroup(v,"Default")
					end
				end
			end
			if hit.Parent:GetAttribute("team") == team and hum.Health > 0 and not flag:GetAttribute("Taken") then
				if flagtaken then
					flag.Anchored = true
					flag.CFrame = cf
					flagtaken = false
					gotflag = false
				elseif char:FindFirstChild("Flag") then
					replaced = true
					scores[team] = scores[team] + 1
					local flag = char:FindFirstChild("Flag").Value
					flag:SetAttribute("Reset",true)
					msg.Value = ("%s has captured %s's Flag!"):format(hit.Parent.Name,flag:GetAttribute("team"))
					task.delay(2,function()
						replaced = false
					end)
					for i,v in pairs(char:GetDescendants()) do
						if v:isA("BasePart") then
							game:GetService("PhysicsService"):SetPartCollisionGroup(v,char:GetAttribute("team"))
						end
					end
					char:FindFirstChild("Flag"):Destroy()
				end
			end
		end
	end)
	flag.AttributeChanged:Connect(function(att)
		if att == "Reset" and flag:GetAttribute("Reset") == true then
		    gotreset = true
			endtake()
			flag.Anchored = true
			flag.CFrame = cf
			flagtaken = false
			flag.CanTouch = true
			gotflag = false
			flag:SetAttribute("Reset",false)
			task.delay(2,function()gotreset=false end)
		end
	end)
	flag:GetPropertyChangedSignal("Parent"):Connect(function()
		flagc.Parent = objects
		flagfunc(flagc,team,true)
	end)
end
for i,v in pairs(teams) do
	pcall(function()
		game:GetService("PhysicsService"):CreateCollisionGroup(v)
	end)
	scores[v] = 0
	game:GetService("PhysicsService"):CollisionGroupSetCollidable(v,v,false)
	if objects:FindFirstChild(v.."Door") then
		game:GetService("PhysicsService"):SetPartCollisionGroup(objects[v..'Door'],v)
	end
	if objects:FindFirstChild(v.."Flag") then
		flagfunc(objects:FindFirstChild(v.."Flag"),v)
	end
end
--
local pad = Instance.new("Part")
pad.Name = "pad"
pad.BottomSurface = Enum.SurfaceType.Smooth
pad.TopSurface = Enum.SurfaceType.Smooth
pad.Color = Color3.fromRGB(196, 40, 28)
pad.Size = Vector3.new(6, 1, 6)
pad.CFrame = CFrame.new(-26, 0.5000010132789612, 81)

local BillboardGui = Instance.new("BillboardGui")
BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BillboardGui.Active = true
BillboardGui.LightInfluence = 1
BillboardGui.AlwaysOnTop = true
BillboardGui.Size = UDim2.new(13, 0, 1, 0)
BillboardGui.Parent = pad

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, 0, 1, 0)
TextBox.BackgroundTransparency = 0.8
TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextBox.FontSize = Enum.FontSize.Size14
TextBox.TextWrapped = true
TextBox.TextSize = 14
TextBox.TextWrap = true
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Text = "CTF Paintball\n(You must disable UI Lock before joining)"
TextBox.Font = Enum.Font.SourceSans
TextBox.TextScaled = true
TextBox.Parent = BillboardGui

local ClickDetector = Instance.new("ClickDetector")
ClickDetector.MaxActivationDistance = 12
ClickDetector.Parent = pad

pad.Anchored = true
pad.Parent = map
--

local function Paintball(ball,col)
	local damage = math.random(20,40)

	local connection
	local tag = ball:findFirstChild("creator")
	local owner = tag.Value
	local function tagHumanoid(humanoid)
		-- todo: make tag expire
		local tag = ball:findFirstChild("creator")
		if tag ~= nil then
			local new_tag = tag
			new_tag.Parent = humanoid
		end
	end


	local function untagHumanoid(humanoid)
		if humanoid ~= nil then
			local tag = humanoid:findFirstChild("creator")
			if tag ~= nil then
				tag.Parent = nil
			end
		end
	end

	local function onTouched(hit,team)
		if hit.Parent:IsA("Accessory") then return end
		local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")

		if hit:getMass() < 1.2 * 200 and hit:IsDescendantOf(objects) == false and owner.Character:GetAttribute("team") ~= hit.Parent:GetAttribute("team") then
			hit.Color = ball.Color
		end
		-- make a splat
		for i=1,3 do
			local s = Instance.new("SpawnLocation")
			s.Shape = 1 -- block
			s.formFactor = 2 -- plate
			s.Size = Vector3.new(1,.4,1)
			s.Color = col
			s.Enabled = false
			local v = Vector3.new(math.random(-1,1), math.random(0,1), math.random(-1,1))
			s.Velocity = 15 * v
			s.CFrame = CFrame.new(ball.Position + v, v)
			game:GetService("Debris"):AddItem(s,4)
			s.Parent = workspace:FindFirstChildWhichIsA("Terrain")

		end


		if humanoid ~= nil and owner.Character:GetAttribute("team") ~= humanoid.Parent:GetAttribute("team") then
			tagHumanoid(humanoid)
			humanoid:TakeDamage(damage)
			wait(2)
			untagHumanoid(humanoid)
		end

		connection:disconnect()
		ball:Destroy()
	end

	connection = ball.Touched:connect(onTouched)
	game:GetService("Debris"):AddItem(ball,8)
	return
end
function tool()
	local Tool = Instance.new("Tool")
	local Handle = Instance.new("Part")
	local Mesh = Instance.new("SpecialMesh")
	Mesh.MeshType = Enum.MeshType.FileMesh
	Mesh.MeshId = "rbxasset://fonts/PaintballGun.mesh"
	Mesh.TextureId = "rbxasset://textures/PaintballGunTex128.png"
	Mesh.Parent = Handle
	Tool.CanBeDropped = false
	Handle.Name = "Handle"
	Handle.Parent = Tool
	Handle.Size = Vector3.new(1,1,1)
	Tool.Grip = CFrame.new(0, 0.400000006, 0.5, 1, 0, -0, 0, 0, 1, 0, -1, -0 )
	Tool.TextureId = "rbxasset://Textures/PaintballIcon.png"
	Tool.Name = "ClassicPaintballGun"
	local Fire = Instance.new("Sound")
	Fire.Parent = Handle
	Fire.SoundId = "rbxasset://sounds//paintball.wav"
	Fire.Volume = 1

	local colors = {Color3.new(0.705882, 0.823529, 0.894118),Color3.new(0.643137, 0.741176, 0.278431),Color3.new(0.768628, 0.156863, 0.109804),Color3.new(0.960784, 0.803922, 0.188235),Color3.new(0.0509804, 0.411765, 0.67451),Color3.new(0.886275, 0.607843, 0.25098),Color3.new(0.419608, 0.196078, 0.486275),}


	local function fire(plr,v)

		Fire:play()


		local vCharacter = Tool.Parent
		local vPlayer = plr

		local missile = Instance.new("SpawnLocation")
		missile.Enabled = false


		local spawnPos = vCharacter.PrimaryPart.Position



		spawnPos  = spawnPos + (v * 4)

		local chose = colors[math.random(1, #colors)]
		missile.Position = spawnPos
		missile.Size = Vector3.new(1,1,1)
		missile.Velocity = v * 400
		missile.Color = chose
		missile.Shape = 0
		missile.BottomSurface = 0
		missile.TopSurface = 0
		missile.Name = "Paintball"
		missile.Elasticity = 0
		missile.Reflectance = 0
		missile.Friction = .9

		local force = Instance.new("BodyForce")
		force.force = Vector3.new(0,90 * missile:GetMass(),0)
		force.Parent = missile

		local creator_tag = Instance.new("ObjectValue")
		creator_tag.Value = vPlayer
		creator_tag.Name = "creator"
		creator_tag.Parent = missile

		local new_script = Paintball(missile,chose)

		missile.Parent = workspace:FindFirstChildWhichIsA("Terrain")
		missile:SetNetworkOwner(nil)

	end

	Tool.Enabled = true
	local function onActivated(plr,pos)

		if not Tool.Enabled then
			return
		end

		Tool.Enabled = false

		local character = Tool.Parent;
		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if humanoid == nil then
			return 
		end

		local targetPos = pos
		local shootpart = (character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
		local lookAt = (targetPos - shootpart.Position).unit

		fire(plr,lookAt)

		wait(.5)

		Tool.Enabled = true
	end

	local con 
	local function onequip()
		con = Tool.Parent:WaitForChild("Remote").Value.OnServerEvent:Connect(onActivated)
	end

	local function unequip()
		if con then
			con:Disconnect()
			con = nil
		end
	end

	Tool.Equipped:Connect(onequip)
	Tool.Unequipped:Connect(unequip)
	return Tool
end
function addchar(char,team,rem)
	for i,v in pairs(char:GetDescendants()) do
		if v:isA("BasePart") then
			game:GetService("PhysicsService"):SetPartCollisionGroup(v,team)
		end
	end
	char:SetAttribute("team",team)
	local obj = Instance.new("ObjectValue")
	obj.Value = rem
	obj.Name = "Remote"
	obj.Parent = char
end
function leave(plr,ls)
	if table.find(players,plr) == nil then return end
	ls:Destroy()
	table.remove(players,table.find(players,plr))
	for i,v in pairs(playerdata[plr].connections) do
		v:Disconnect()
	end
	plr.Team = nil
	playerdata[plr] = nil
	plr:LoadCharacter()
end
function join(plr)
	if table.find(players,plr) then return end
	table.insert(players,plr)
	local ls = NLS([[
	local rem = script:WaitForChild(game:service'Players'.LocalPlayer.UserId)
	local status = script:WaitForChild'Stat'.Value
	local gui = script:WaitForChild("LocalScript"):WaitForChild"main"
	local hint = gui:WaitForChild"hint"
	local o = game:service'Players'.LocalPlayer
	local mou = o:GetMouse()
	function act()
		rem:FireServer(mou.Hit.Position)
	end
	mou.Button1Down:Connect(act)
	while task.wait() do
		hint.Text = status.HintMessage.Value
	end
	]],plr.PlayerGui)
	local loca = Instance.new("LocalScript")
	local ui = gui:Clone()
	ui.Parent = loca
	loca.Parent = ls
	local rem = Instance.new("RemoteEvent")
	rem.Name = plr.UserId
	rem.Parent = ls
	rem.OnServerEvent:Connect(function()end)
	local cons = {}
	local obj = Instance.new("ObjectValue")
	obj.Parent = ls
	obj.Value = status
	obj.Name = "Stat"
	local myteam = teams[(#players%#teams)+1]
	plr.Team = teaminst[myteam]
	playerdata[plr] = {
		connections = {},
		team = myteam
	}
	table.insert(playerdata[plr].connections,plr.Chatted:Connect(function(m)
		if m == "leave/" then
			leave(plr,ls)
		end
	end))
	table.insert(playerdata[plr].connections,plr.CharacterAdded:Connect(function(m)
		task.wait(1/30)
		m:PivotTo(objects[playerdata[plr].team.."Spawn"].CFrame)
		addchar(plr.Character,playerdata[plr].team,rem)
		tool().Parent = plr.Backpack
	end))
	if plr.Character then
		plr.Character:PivotTo(objects[playerdata[plr].team.."Spawn"].CFrame)
		addchar(plr.Character,playerdata[plr].team,rem)
		tool().Parent = plr.Backpack
	end
end
ClickDetector.MouseClick:Connect(join)
while task.wait() do
	if not replaced then
		local t = ""
		local c = 0
		for i,v in pairs(scores) do
			c = c + 1
			t = t..("%s : %s"):format(i,v)
			if c ~= #teams then
				t = t.." / "
			end
		end
		msg.Value = t
	end
end
