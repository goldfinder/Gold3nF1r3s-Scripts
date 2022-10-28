local gearmodel = Instance.new("Model")
--[[PART LOAD]]
local middle = Instance.new("Part")
middle.Anchored=true
middle.Position=Vector3.new(0.02, -0.5, 0.122)
middle.Transparency=1
middle.Parent=gearmodel
middle.Size=Vector3.new("2, 2, 1")
middle.Name="Middle"
function part(position,color,material,transparency,size,orientation)
	local mat
	local col
	local trp
	if transparency == "" then
		trp = transparency
	else
		trp = transparency
	end
	if material == "" then
		mat = Enum.Material.Plastic
	else
		mat = material
	end
	if color == "" then
		col = Color3.new(1,1,1)
	else
		col = color
	end
	local prt = Instance.new("Part")
	prt.Anchored=true
	prt.Size=size
	prt.Position=position
	prt.Parent=gearmodel
	prt.Color=col
	prt.Material=mat
	prt.Transparency=trp
	prt.Orientation=orientation
	return prt
end
local f = part(Vector3.new(-0.375, -0.014, -0.522),Color3.fromRGB(255, 204, 153),Enum.Material.ForceField,1,Vector3.new(1.25, 0.3, 0.2),Vector3.new(0,0,0))
local gui = Instance.new("SurfaceGui")
gui.Face=Enum.NormalId.Front
gui.SizingMode=Enum.SurfaceGuiSizingMode.FixedSize
gui.CanvasSize=Vector2.new(256,128)
gui.Parent=f
local guiimage = Instance.new("ImageLabel")
guiimage.Size = UDim2.new(0,100,0,100)
guiimage.Image="rbxassetid://73888062"
guiimage.ScaleType=Enum.ScaleType.Stretch
guiimage.Parent=gui

local f = part(Vector3.new(-0.485, -0.68, 0.188),Color3.fromRGB(255, 204, 153),Enum.Material.Metal,0,Vector3.new(0.4,0.4,0.2),Vector3.new(0,180,0))
local mesh = Instance.new("BlockMesh")
mesh.Scale=Vector3.new(1,1,1)
mesh.Offset=Vector3.new(0,0,0.8)
mesh.VertexColor=Vector3.new(1,1,1)
mesh.Parent=f

local f = part(Vector3.new(-0.485, -0.68, 0.188),Color3.fromRGB(255, 204, 153),Enum.Material.Metal,0,Vector3.new(0.4, 0.8, 0.2),Vector3.new(0,180,0))
local mesh = Instance.new("BlockMesh")
mesh.Scale=Vector3.new(1,1,1)
mesh.Offset=Vector3.new(0,0,0.8)
mesh.VertexColor=Vector3.new(1,1,1)
mesh.Parent=f

local f = part(Vector3.new(0.515, -0.68, 0.188),Color3.fromRGB(255, 204, 153),Enum.Material.Metal,0,Vector3.new(0.4,0.4,0.2),Vector3.new(0,180,0))
local mesh = Instance.new("BlockMesh")
mesh.Scale=Vector3.new(1,1,1)
mesh.Offset=Vector3.new(0,0,0.8)
mesh.VertexColor=Vector3.new(1,1,1)
mesh.Parent=f



local g = gearmodel
g.Parent = owner.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "MeshPart" then
		local W = Instance.new("Weld")
		W.Part0 = g.Middle
		W.Part1 = C[i]
		local CJ = CFrame.new(g.Middle.Position)
		local C0 = g.Middle.CFrame:inverse()*CJ
		local C1 = C[i].CFrame:inverse()*CJ
		W.C0 = C0
		W.C1 = C1
		W.Parent = g.Middle
	end
	local Y = Instance.new("Weld")
	Y.Part0 = owner.Character.Torso
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end

local h = g:GetChildren()
for i = 1, # h do
	h[i].Anchored = false
	h[i].CanCollide = false
end
