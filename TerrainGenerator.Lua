--[[ all code by okeanskiy. ]]--

--[[
	Script #1 of 2: game.ServerScriptService.Terrain (Server Script)
]]
local X = 20
local Z = 20
local plr = owner.Character
local posx = plr.HumanoidRootPart.Position.X
local posy = plr.HumanoidRootPart.Position.Y
local posz = plr.HumanoidRootPart.Position.Z
local increment = 1

local grid = {}

for x = 1, X do
	grid[x] = {}

	for z = 1, Z do
		grid[x][z] = (math.noise(x/20, z/20) * 30)
	end
end
for x = 1, X do
	for z = 1, Z do
		wait(0.06)
		local yPos = grid[x][z]

		local part = Instance.new("Part")
		part.Anchored = true
		part.Material = Enum.Material.SmoothPlastic
		part.BrickColor = BrickColor.new("Bright green")
		increment = increment+1
		if increment == 1 and x%2 == 0 or increment == 2 and x%2 == 1 then
			part.BrickColor = BrickColor.new("Storm blue")
		elseif increment == 2 and x%2 == 0 or increment == 1 and x%2 == 1 then
			part.BrickColor = BrickColor.new("White")
		end
		if x==1 or z==1 or z==Z or x==X then
			local increment = increment-1
			part.BrickColor = BrickColor.new("Black")
			part.Material = Enum.Material.Concrete
		end
		if increment == 2 then
			increment = 0
		end
		part.Position = Vector3.new((posx+(x*1-((X*1)/2))), (posy+((yPos/8))), (posz+(z*1-((Z*1)/2))))
		part.Size = Vector3.new(1, 0.5, 1)
		local f = instance.New("WeldConstraint")
		part.Parent = workspace
	end
end

--[[
	Script #2 of 2: game.ServerScriptService.RandomVsNoise (Server Script)
]]

print("10 RANDOM NUMBERS:")
for i = 1, 10 do
	print(math.random())
end

print("10 NUMBERS GENERATED FROM NOISE")
for i = 1, 10 do
	print(math.noise(i/10))
end
