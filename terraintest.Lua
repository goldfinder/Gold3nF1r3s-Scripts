local Players = game:GetService("Players")



------------------------------------------------------------------------------------------------------------------------------------------------



local BASE_HEIGHT 		= 100				-- The main height factor for the terrain.

local CHUNK_SCALE 		= 3 				-- The grid scale for terrain generation. Should be kept relatively low if used in real-time.

local RENDER_DISTANCE 	= 50 				-- The length/width of chunks in voxels that should be around the player at all times

local X_SCALE 			= 900			-- How much we should strech the X scale of the generation noise

local Z_SCALE 			= 900			-- How much we should strech the Z scale of the generation noise

local GENERATION_SEED	= math.random() 	-- Seed for determining the main height map of the terrain.

local TERRAIN_TYPE = Enum.Material.Grass --Terrain Type



------------------------------------------------------------------------------------------------------------------------------------------------



local chunks = {} --table to store chunk locations



--Checks player location to see if they have already been there

--If it is a new location, it adds to table

local function chunkExists(chunkX, chunkZ)

	if not chunks[chunkX] then

		chunks[chunkX] = {}

	end

	return chunks[chunkX][chunkZ]

end



--Takes calculated values and generates terrain

local function mountLayer(x, heightY, z, material)

	local beginY = -BASE_HEIGHT

	local endY = heightY

	local cframe = CFrame.new(x * 4 + 2, (beginY + endY) * 4 / 2, z * 4 + 2)

	local size = Vector3.new(4, (endY - beginY) * 4, 4)

	workspace.Terrain:FillBlock(cframe, size, material)	

end



--Prepares values for terrain generation

function makeChunk(chunkX, chunkZ)

	local rootPosition = Vector3.new(chunkX * CHUNK_SCALE, 0, chunkZ * CHUNK_SCALE)

	chunks[chunkX][chunkZ] = true -- Acknowledge the chunk's existance.

	for x = 0, CHUNK_SCALE - 1 do

		for z = 0, CHUNK_SCALE - 1 do

			local cx = (chunkX * CHUNK_SCALE) + x

			local cz = (chunkZ * CHUNK_SCALE) + z

			local noise = math.noise(GENERATION_SEED, cx / X_SCALE, cz / Z_SCALE)

			local cy = noise * BASE_HEIGHT

			mountLayer(cx, cy, cz, TERRAIN_TYPE) --sends values to mountLayer function

		end

	end

end





--Checks player surroundings

--Adds location to table

--Adds new terrain as player moves to new locations

function checkSurroundings(location)

	local chunkX, chunkZ = math.floor(location.X / 4 / CHUNK_SCALE), math.floor(location.Z / 4 / CHUNK_SCALE)

	local range = math.max(1, RENDER_DISTANCE / CHUNK_SCALE)

	for x = -range, range do

		for z = -range, range do

			local cx = chunkX + x

			local cz = chunkZ + z

			if not chunkExists(cx, cz) then --sends player location area to chunkExist function

				makeChunk(cx, cz) --If player is in a new area it will make terrain

			end

		end

	end

end



--Main Loop

--Gets player location every 1 second

while true do

	for _, player in pairs(Players:GetPlayers()) do

		if player.Character then

			local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart then

				checkSurroundings(humanoidRootPart.Position) --sends player location to checkSurroundings function

			end

		end

	end

	wait(1)

end
