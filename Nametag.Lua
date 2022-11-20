local Dataset1="https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/main/nametag.Lua%20Data/Scripters"
local Dataset2="https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/main/nametag.Lua%20Data/PSA%20Staff"
local HttpService=game:GetService("HttpService")
local str1
local str2
local plist1
local plist2
local scripter=false
local PSAStaff=false
local afkbool2=Instance.new("BoolValue")
afkbool2.Parent=owner
afkbool2.Value=false
wait()
function nametag()
	local code=HttpService:GetAsync(Dataset1, true)
	str1=code
	local code=HttpService:GetAsync(Dataset2, true)
	str2=code
	Afk=Instance.new("RemoteEvent")
	Afk.Parent=owner.Character
	Afk.Name = "GetKey"
	--[[Scripter]]plist1 = string.split(str1,"|") for i=1,#plist1 do if tonumber(plist1[i])==owner.UserId then scripter = true end end
	--[[PSA]]plist1 = string.split(str2,"|") for i=1,#plist1 do if tonumber(plist1[i])==owner.UserId then PSAStaff = true end end
	NLS([==[
game:GetService("UserInputService").WindowFocusReleased:Connect(function()
	script.Parent:FireServer("WFR")
end)
game:GetService("UserInputService").WindowFocused:Connect(function()
	script.Parent:FireServer("WF")
end)]==],Afk)
	owner.Character.Humanoid.DisplayName = " "
	local chr = owner.Character
	local GUIPARENT = chr.Head
	local guiMAIN = Instance.new("BillboardGui")
	guiMAIN.ExtentsOffsetWorldSpace = Vector3.new(0,4.5,0)
	guiMAIN.MaxDistance = math.huge
	guiMAIN.Size = UDim2.new(6,0,2,0)
	guiMAIN.LightInfluence = 0
	guiMAIN.Parent = GUIPARENT
	local gui = Instance.new("Frame")
	gui.BackgroundTransparency = 1
	gui.Size = UDim2.new(1,0,0.5,0)
	gui.Position=UDim2.new(0,0,.25,0)
	local text1M = Instance.new("TextLabel")
	text1M.Text = owner.Name
	text1M.BackgroundTransparency=1
	text1M.Size = UDim2.new(1,0,1,0)
	text1M.TextScaled = true
	text1M.TextColor3=Color3.new(1, 1, 1)
	text1M.Parent=gui
	local text = Instance.new("TextLabel")
	text.Text = owner.Name
	text.BackgroundTransparency=1
	text.Size = UDim2.new(1,0,1,0)
	text.Position=UDim2.new(0,3,0,3)
	text.TextScaled = true
	text.TextColor3=Color3.new(0,0,0)
	text.TextTransparency=.05
	text.Parent=text1M
	gui.Parent=guiMAIN
	text.ZIndex=-50
	local gui = Instance.new("Frame")
	gui.BackgroundTransparency = 1
	gui.Position=UDim2.new(0,0,0.75,0)
	gui.Size = UDim2.new(1,0,0.25,0)
	local settings = Instance.new("UIListLayout")
	settings.Parent=gui
	settings.FillDirection = Enum.FillDirection.Horizontal
	settings.HorizontalAlignment = Enum.HorizontalAlignment.Center
	if PSAStaff==true then
		local icon = Instance.new("ImageLabel")
		icon.BackgroundTransparency=1
		icon.Image = "rbxassetid://11380160461"
		icon.Size = UDim2.new(1,0,1,0)
		icon.SizeConstraint=Enum.SizeConstraint.RelativeYY
		icon.Parent=gui
	end
	if scripter==true then
		local icon = Instance.new("ImageLabel")
		icon.BackgroundTransparency=1
		icon.Image = "rbxassetid://11395396633"
		icon.Size = UDim2.new(1,0,1,0)
		icon.SizeConstraint=Enum.SizeConstraint.RelativeYY
		icon.Parent=gui
	end
	gui.Parent=guiMAIN
	local guiafk = Instance.new("Frame")
	guiafk.BackgroundTransparency = 1
	guiafk.Size = UDim2.new(1,0,0.25,0)
	local text1 = Instance.new("TextLabel")
	text1.BackgroundTransparency=1
	text1.Text="AFK"
	text1.TextColor3=Color3.new(1,1,1)
	text1.Size=UDim2.new(1,0,1,0)
	text1.Parent=guiafk
	text1.TextScaled = true
	text1.ZIndex=1
	local text2 = Instance.new("TextLabel")
	text2.BackgroundTransparency=1
	text2.Parent=text1
	text2.Position=UDim2.new(0,3,0,3)
	text2.Text="AFK"
	text2.TextScaled = true
	text2.Size=UDim2.new(1,0,1,0)
	text2.ZIndex=0
	local backgroundframe = Instance.new("Frame")
	backgroundframe.Parent=text1
	backgroundframe.Size=UDim2.new(1,0,1,0)
	backgroundframe.ZIndex=-500
	backgroundframe.BackgroundTransparency=1
	local settings = Instance.new("UIListLayout")
	settings.Parent=backgroundframe
	settings.FillDirection = Enum.FillDirection.Horizontal
	settings.HorizontalAlignment = Enum.HorizontalAlignment.Center
	local BGF = Instance.new("Frame")
	BGF.Parent=backgroundframe
	BGF.Size=UDim2.new(.2,0,1,0)
	BGF.ZIndex=-500
	BGF.BackgroundColor3=Color3.new(0,0,0)
	BGF.BackgroundTransparency=.45
	local BGUC = Instance.new("UICorner")
	BGUC.CornerRadius=UDim.new(0,16)
	BGUC.Parent=BGF
	guiafk.Parent=guiMAIN
	if afkbool2.Value == false then
		guiafk.Visible=false
	else
		guiafk.Visible=true
	end
	local TweenService = game:GetService('TweenService')
	local object = text1M
	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)
	Afk.OnServerEvent:Connect(function(plr,t)
		if t == "WFR" then
			guiafk.Visible = true
			afkbool2.Value=true
		elseif t == "WF" then
			guiafk.Visible = false
			afkbool2.Value=false
		end
	end)
	while true do
		local r, g, b = math.random(), math.random(), math.random()
		local goal = {TextColor3 = Color3.new(r, g, b)}

		local tween = TweenService:Create(object, tweenInfo, goal)
		tween:Play()
		tween.Completed:Wait()
	end
end
owner.CharacterAdded:Connect(function()
	nametag()
end)
nametag()
