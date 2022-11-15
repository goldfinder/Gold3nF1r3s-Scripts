local hidpart = Instance.new("Part")
hidpart.Transparency = 1
hidpart.Locked = true
hidpart.Anchored = true
hidpart.CanCollide = false
hidpart.Parent = workspace
hidpart.Position=Vector3.new(0,0,0)
local TAS = Instance.new("RemoteEvent")
TAS.Name = "HOD"
TAS.Parent=owner.Character.HumanoidRootPart
local nlr1 = NLS([[
local plr = owner
local mouse = plr:GetMouse()
mouse.Button1Down:Connect(function()
local event
if owner.Character.HumanoidRootPart:FindFirstChild("HOD") ~= nil then event = owner.Character.HumanoidRootPart.HOD print("Found HOD") end
print("Running event. "..mouse.Hit.X,mouse.Hit.Y,mouse.Hit.Z)
event:FireServer(mouse.Hit.X,mouse.Hit.Y,mouse.Hit.Z)
end)]]
	
	,
	
owner.Character

)
TAS.OnServerEvent:Connect(function(_,PX,PY,PZ)
	print(PX,PY,PZ)
	local beam = Instance.new("Beam")
	local attachment0 = Instance.new("Attachment")
	local attachment1 = Instance.new("Attachment")
	attachment0.Parent=game.Workspace.Terrain
	attachment1.Parent=game.Workspace.Terrain
	beam.Segments = 1
	beam.Width0 = 10
	beam.Width1 = 10
	beam.Transparency = NumberSequence.new(0,0)
	beam.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1, 1, 0)),ColorSequenceKeypoint.new(1,Color3.new(1, 1, 0))})
	beam.FaceCamera = true
	beam.Attachment0 = attachment0
	beam.Attachment1 = attachment1
	beam.Parent = game.Workspace
	attachment0.WorldPosition = Vector3.new(PX,PY+2000,PZ)
	attachment1.WorldPosition = Vector3.new(PX,PY-5,PZ)
	local hitbox = Instance.new("Part")
	hitbox.Position = Vector3.new(PX,PY+2.5,PZ)
	hitbox.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			hit.Parent:FindFirstChildOfClass("Humanoid").Health=0
		end
	end)
	hitbox.Anchored=true
	hitbox.CanCollide=false
	hitbox.Transparency=1
	hitbox.Size=Vector3.new(15,20,15)
	hitbox.Parent=game.Workspace
	local light = Instance.new("PointLight")
	light.Color=Color3.new(1,1,0)
	light.Brightness=50
	light.Range=20
	light.Parent=hitbox
	local light = Instance.new("PointLight")
	light.Color=Color3.new(1,1,0)
	light.Brightness=50
	light.Range=20
	light.Parent=hitbox
	local light = Instance.new("PointLight")
	light.Color=Color3.new(1,1,0)
	light.Brightness=50
	light.Range=20
	light.Parent=hitbox
	local light = Instance.new("PointLight")
	light.Color=Color3.new(1,1,0)
	light.Brightness=50
	light.Range=20
	light.Parent=hitbox
	wait(3)
	attachment0:Destroy()
	attachment1:Destroy()
	beam:Destroy()
	hitbox:Destroy()
end)
