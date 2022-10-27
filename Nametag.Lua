function nametag()
	owner.Character.Humanoid.DisplayName = " "
	local chr = owner.Character
	local GUIPARENT = chr.Head
	local guiMAIN = Instance.new("BillboardGui")
	guiMAIN.ExtentsOffset = Vector3.new(0,4,0)
	guiMAIN.MaxDistance = math.huge
	guiMAIN.Size = UDim2.new(6,0,2,0)
	guiMAIN.LightInfluence = 0
	guiMAIN.Parent = GUIPARENT
	local gui = Instance.new("Frame")
	gui.BackgroundTransparency = 1
	gui.Size = UDim2.new(1,0,0.5,0)
	local text1 = Instance.new("TextLabel")
	text1.Text = owner.Name
	text1.BackgroundTransparency=1
	text1.Size = UDim2.new(1,0,1,0)
	text1.TextScaled = true
	text1.TextColor3=Color3.new(1, 1, 1)
	text1.Parent=gui
	local text = Instance.new("TextLabel")
	text.Text = owner.Name
	text.BackgroundTransparency=1
	text.Size = UDim2.new(1,0,1,0)
	text.Position=UDim2.new(0,3,0,3)
	text.TextScaled = true
	text.TextColor3=Color3.new(0,0,0)
	text.TextTransparency=.05
	text.Parent=text1
	gui.Parent=guiMAIN
	text.ZIndex=-50
	local gui = Instance.new("Frame")
	gui.BackgroundTransparency = 1
	gui.Position=UDim2.new(0,0,0.5,0)
	gui.Size = UDim2.new(1,0,0.25,0)
	local settings = Instance.new("UIListLayout")
	settings.Parent=gui
	settings.FillDirection = Enum.FillDirection.Horizontal
	settings.HorizontalAlignment = Enum.HorizontalAlignment.Center
	if owner.UserId==21490931 then
		local icon = Instance.new("ImageLabel")
		icon.BackgroundTransparency=1
		icon.Image = "rbxassetid://11380160461"
		icon.Size = UDim2.new(1,0,1,0)
		icon.SizeConstraint=Enum.SizeConstraint.RelativeYY
		icon.Parent=gui
	end
	if owner.UserId==1201130161 then
		local icon = Instance.new("ImageLabel")
		icon.BackgroundTransparency=1
		icon.Image = "rbxassetid://11395396633"
		icon.Size = UDim2.new(1,0,1,0)
		icon.SizeConstraint=Enum.SizeConstraint.RelativeYY
		icon.Parent=gui
	end
	gui.Parent=guiMAIN
	local TweenService = game:GetService('TweenService')
	local object = text1
	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)

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
