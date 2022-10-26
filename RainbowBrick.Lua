local part = Instance.new("Part")
part.Parent = Workspace
local TweenService = game:GetService('TweenService')
local object = part
local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)

while true do
	local r, g, b = math.random(), math.random(), math.random()
	local goal = {Color = Color3.new(r, g, b)}

	local tween = TweenService:Create(object, tweenInfo, goal)
	tween:Play()
	tween.Completed:Wait()
end
