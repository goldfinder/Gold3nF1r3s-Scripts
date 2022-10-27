local gearmodel = Instance.new("Model")
--[[PART LOAD]]
local middle = Instance.new("Part")
middle.Position=Vector3.new(-0.023, -0.092, -0.124)
middle.Transparency=0
middle.Parent=gearmodel
function mesh(MID,TID,LOC)
	if TextureID == "" then
		local mesh = Instance.new("MeshPart")
		mesh.MeshId=MID
		mesh.TextureID=TID
		mesh.Position=LOC
		mesh.Parent=gearmodel

	else
		local mesh = Instance.new("MeshPart")
		mesh.MeshId=MID
		mesh.Position=LOC
		mesh.Parent=gearmodel
	end
end
mesh("rbxassetid://2316484627","http://www.roblox.com/asset/?id=3806519580",Vector3.new(0.669, 0.203, 0.53))
mesh("rbxassetid://2269958061","rbxassetid://2269958743",Vector3.new(-0.682, 0.001, 0.684))
if
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
end
