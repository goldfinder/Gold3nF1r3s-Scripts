local noise = math.noise

local sizeX = 90
local sizeY = 90
local sizeZ = 90

local air = Enum.Material.Air
local grass = Enum.Material.Grass
local sand = Enum.Material.Sand

local mat = {}
local occ = {}

function fBm(x, y, z)
    local octaves = 3
    local lacunarity = 2.0
    local gain = 0.5
    local amplitude = 1.0
    local frequency = 0.01
    
    local sum = 0.0
    for i = 0, octaves do
        sum = sum + amplitude * noise(x * frequency, y * frequency, z * frequency)
        amplitude = amplitude * gain
        frequency = frequency * lacunarity
    end
    return sum;
end 

for x=1, sizeX do
    mat[x] = {}
    occ[x] = {}
    
    for y=1, sizeY do
        mat[x][y] = {}
        occ[x][y] = {}
        
        for z=1, sizeZ do
            local p = fBm(x, y, z)
            
            if p > 0 then
                mat[x][y][z] = p < 0.1 and grass or sand
                occ[x][y][z] = p
            else
                mat[x][y][z] = air
                occ[x][y][z] = 0
            end 
        end
    end
end

workspace.Terrain:WriteVoxels(Region3.new(Vector3.new(0, 0, 0), Vector3.new(128, 128, 128)), 4, mat, occ)
