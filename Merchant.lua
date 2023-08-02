--[[

Backpack script by Gold3nF1r3

]]local owner = owner or game.Players:FindFirstChild("Gold3nF1r3")
local folder = Instance.new("Folder",game:GetService("ServerStorage"))
--Remove the folder
owner.Chatted:Connect(function(msg)
	if msg == "g/no." then
		folder:Destroy()
	end
end)
local middle = Instance.new("Part")
middle.Position = Vector3.new(0, -0.1, -0.3)
middle.Transparency = 1
middle.CanCollide = false
middle.Size = Vector3.new(1,1,1)
middle.Parent=folder
function newpart(location,size,partname,material,color)
	local part = Instance.new("Part")
	part.Position=location
	part.Size=size
	part.Name = partname
	part.Color = color
	part.Material=material
	part.Parent=folder
	part.CanCollide=false
	local i = Instance.new("WeldConstraint",part)
	i.Part0=middle
	i.Part1=part
	i.Name=[[Smooth Weld]]
	i.Parent=part
end
local bagstrap1 = newpart(
	Vector3.new(-0.75, 0.178, -0.287),
	Vector3.new(0.3, 1.494, 1.075),
	[[Bag Strap]],
	Enum.Material.Sand,
	Color3.fromRGB(86, 66, 54)
)
local bagstrap2 = newpart(
	Vector3.new(0.75, 0.187, -0.287),
	Vector3.new(0.3, 1.475, 1.075),
	[[Bag Strap]],
	Enum.Material.Sand,
	Color3.fromRGB(86, 66, 54)
)
local bagstrap3 = newpart(
	Vector3.new(0, -0.409, -0.3),
	Vector3.new(2.1, 0.319, 1.1),
	[[Bag Strap]],
	Enum.Material.Sand,
	Color3.fromRGB(86, 66, 54)
)
local backpack1 = newpart(
	Vector3.new(-0, 0.45, 0.475),
	Vector3.new(1.9, 1.1, 0.75),
	[[Backpack Model]],
	Enum.Material.Fabric,
	Color3.fromRGB(117, 0, 0)
)
local backpack2 = newpart(
	Vector3.new(-0, -0.55, 0.2),
	Vector3.new(1.9, 0.9, 0.2),
	[[Backpack Model]],
	Enum.Material.Fabric,
	Color3.fromRGB(117,0,0)
)
local backpack3 = newpart(
	Vector3.new(-0, -0.475, 0.5),
	Vector3.new(1.8, 0.85, 0.6),
	[[Backpack Model]],
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(33, 33, 33)
)
local bagstrapdeco1 = newpart(
	Vector3.new(-0.825, 0.012, 0.462),
	Vector3.new(0.05, 1.875, 0.725),
	[[Backpack Decorator]],
	Enum.Material.Sand,
	Color3.fromRGB(86, 66, 54)
)
local bagstrapdeco2 = newpart(
	Vector3.new(0.025, 0.012, 0.462),
	Vector3.new(0.05, 1.875, 0.725),
	[[Backpack Decorator]],
	Enum.Material.Sand,
	Color3.fromRGB(86, 66, 54)
)
local bagstrapdeco3 = newpart(
	Vector3.new(0.825, 0.012, 0.462),
	Vector3.new(0.05, 1.875, 0.725),
	[[Backpack Decorator]],
	Enum.Material.Sand,
	Color3.fromRGB(86, 66, 54)
)

--Finish code
wait(0.1)
local chrhealth = owner.Character.Humanoid.Health
local damagemsgcnt = 0
folder.Parent=owner.Character
local weldmiddle = Instance.new("Weld",owner.Character.Torso)
weldmiddle.Part0 = owner.Character.Torso
weldmiddle.Part1 = middle
weldmiddle.C0 = CFrame.new(0, 0, 0)
--Character Functions
function soundcall(soundname,parent)
	coroutine.resume(coroutine.create(function()
		local sound = script:FindFirstChild(string.upper(soundname)):Clone()
		sound.Parent = parent
		sound.Playing = true
		wait(sound.TimeLength)
		sound:Destroy()
	end))
end
--SFX
local sfx = Instance.new("Sound")
sfx.SoundId = "rbxassetid://147982968"
sfx.Parent = script
sfx.Name = "SFX"
--Message
local msgbinded = Instance.new("BindableEvent",folder)
function createmessage(msg,damageinstance:boolean)
	if not (damagemsgcnt == 1 and damageinstance) then
		coroutine.resume(coroutine.create(function()
			if damageinstance then
				damagemsgcnt+=1
			end
			msgbinded:Fire()
			local newmsg = msg
			local bg = Instance.new("BillboardGui")
			bg.Parent = owner.Character.Head
			bg.Size = UDim2.new(20, 0, .5, 0)
			bg.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
			bg.AlwaysOnTop = false
			bg.LightInfluence = 0
			msgbinded.Event:Connect(function()
				bg.StudsOffsetWorldSpace = Vector3.new(0, 0.5+bg.StudsOffsetWorldSpace.Y, 0)
			end)
			local textbox = Instance.new("TextLabel")
			textbox.RichText=true
			textbox.Parent = bg
			textbox.Size = UDim2.new(1, 0, 1, 0)
			textbox.Position = UDim2.new(0, 0, 0, 0)
			textbox.TextScaled = true
			textbox.TextColor3 = Color3.new(1,1,1)
			textbox.BackgroundTransparency = 1
			local textlength = #newmsg
			local skip = false
			local skip2 = false
			local set = 0
			for i=1,textlength do
				skip2 = false
				if string.sub(newmsg,i,i) == "<" then
					skip = true
					set+=1
				end
				if string.sub(newmsg,i,i) == ">" then
					skip = false
					skip2 = true
				end
				if set == 2 then
					set = 0
				end
				if set == 0 then
					textbox.Text = string.sub(newmsg,1,i)
				else
					textbox.Text = string.sub(newmsg,1,i)..[[</font>]]
				end
				if skip == false and skip2 == false then
					wait()
					if owner.Character ~= nil then
						soundcall("sfx",owner.Character.Head)
					end
					if string.sub(newmsg,i,i) == "," or string.sub(newmsg,i,i) == "." or string.sub(newmsg,i,i) == "?" or string.sub(newmsg,i,i) == "!" then
						wait(.5)
					end
				end
			end
			wait(5)
			for i=1,textlength do
				skip2 = false
				if string.sub(newmsg,#newmsg-i,#newmsg-i) == ">" then
					skip = true
					set+=1
				end
				if string.sub(newmsg,#newmsg-i,#newmsg-i) == "<" then
					skip = false
					skip2 = true
				end
				if set == 2 then
					set = 0
				end
				if set == 0 then
					textbox.Text = string.sub(newmsg,1,#newmsg-i)
				else
					textbox.Text = string.sub(newmsg,1,#newmsg-i)..[[</font>]]
				end
				if skip == false and skip2 == false then
					wait()
					if owner.Character ~= nil then
						soundcall("sfx",owner.Character.Head)
					end
				end
			end
			bg:Destroy()
			if damageinstance then
				damagemsgcnt-=1
			end
		end))
	end
end
createmessage("Hello "..[[<font color="#ffcc33">]].."traveller"..[[</font>]].."!",false)
--Wares Menu
local att = Instance.new("Attachment",middle)
att.Position=Vector3.new(0,0,-3)
local waresprompt = Instance.new("ProximityPrompt")
waresprompt.Parent=att
waresprompt.Enabled = false
waresprompt.ActionText=[[Wares Menu]]
--ChatFunctions
owner.Chatted:Connect(function(msg)
	if msg == "/e wares" then
		createmessage("Would you like to look at my "..[[<font color="#507b9c">]].."wares"..[[</font>]]..", "..[[<font color="#ffcc33">]].."traveller"..[[</font>]].."?",false)
	end
	if msg == "/e wares10s" then
		createmessage("Heres my menu of "..[[<font color="#507b9c">]].."wares"..[[</font>]]..", "..[[<font color="#ffcc33">]].."traveller"..[[</font>]].."!",false)
		waresprompt.Enabled = true
		wait(30)
		createmessage("My wares menu has been retracted!",false)
		waresprompt.Enabled = false
	end
	if msg == "/e guards" then
		createmessage("Help! "..[[<font color="#ffcc33">]].."Guards"..[[</font>]]..", "..[[<font color="#ff0000">]].."thief"..[[</font>]].."!")
	end
	if msg == "/e randommsg" then
		local msgrandom = {
			"Oh, hello "..[[<font color="#ffcc33">]].."traveller"..[[</font>]]..", Nice weather today.",
			"Good day, fellow "..[[<font color="#ffcc33">]].."trad"..[[</font>]].."-, Oh sorry "..[[<font color="#ffcc33">]].."traveller"..[[</font>]]..".",
			"I could really go get a bag of "..[[<font color="#507b9c">]].."waff"..[[</font>]].."-, oh never mind, they don't exist."
		}
		local msgnumber = math.random(1,#msgrandom)
		local randommsg = msgrandom[msgnumber]
		print(randommsg)  -- Add this line for debugging
		createmessage(randommsg)
	end
end)
owner.Character.Humanoid.Changed:Connect(function(prop)
	if prop=="Health" then
		if chrhealth > owner.Character.Humanoid.Health then
			createmessage("Argh! I have been "..[[<font color="#ff0000">]].."attacked"..[[</font>]].."!",true)
		end
		chrhealth = owner.Character.Humanoid.Health
	end
end)
