-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 57364 characters

local ScriptFunctions = {
function(script,require)
local p = owner
local g = script.Arm1:clone()
g.Parent = p.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
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
	Y.Part0 = p.Character["Left Arm"]
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end

local h = g:GetChildren()
for i = 1, # h do
	if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
		h[i].Anchored = false
		h[i].CanCollide = false
	end
end
local g = script.Chest:clone()
g.Parent = p.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
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
	Y.Part0 = p.Character["Torso"]
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end

local h = g:GetChildren()
for i = 1, # h do
	if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
		h[i].Anchored = false
		h[i].CanCollide = false
	end
end
local g = script.Leg1:clone()
g.Parent = p.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
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
	Y.Part0 = p.Character["Torso"]
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end

local h = g:GetChildren()
for i = 1, # h do
	if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
		h[i].Anchored = false
		h[i].CanCollide = false
	end
end
local g = script.Leg2:clone()
g.Parent = p.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
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
	Y.Part0 = p.Character["Torso"]
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end

local h = g:GetChildren()
for i = 1, # h do
	if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
		h[i].Anchored = false
		h[i].CanCollide = false
	end
end
end
}
local ScriptIndex = 0
local Scripts,ModuleScripts,ModuleCache = {},{},{}
local _require = require
function require(obj,...)
	local index = ModuleScripts[obj]
	if not index then
		local a,b = pcall(_require,obj,...)
		return not a and error(b,2) or b
	end
	
	local res = ModuleCache[index]
	if res then return res end
	res = ScriptFunctions[index](obj,require)
	if res==nil then error("Module code did not return exactly one value",2) end
	ModuleCache[index] = res
	return res
end
local function Script(obj,ismodule)
	ScriptIndex = ScriptIndex + 1
	local t = ismodule and ModuleScripts or Scripts
	t[obj] = ScriptIndex
end

function RunScripts()
	for script,index in pairs(Scripts) do
		coroutine.wrap(ScriptFunctions[index])(script,require)
	end
end


local function DecodeUnion(Values,Flags,Parse,data)
	local m = Instance.new("Folder")
	m.Name = "UnionCache ["..tostring(math.random(1,9999)).."]"
	m.Archivable = false
	m.Parent = game:GetService("ServerStorage")
	local Union,Subtract = {},{}
	if not data then
		data = Parse('B')
	end
	local ByteLength = (data % 4) + 1
	local Length = Parse('I'..ByteLength)
	local ValueFMT = ('I'..Flags[1])
	for i = 1,Length do
		local data = Parse('B')
		local part
		local isNegate = bit32.band(data,0b10000000) > 0
		local isUnion =  bit32.band(data,0b01000000) > 0
		if isUnion then
			part = DecodeUnion(Values,Flags,Parse,data)
		else
			local isMesh = data % 2 == 1
			local ClassName = Values[Parse(ValueFMT)]
			part = Instance.new(ClassName)
			part.Size = Values[Parse(ValueFMT)]
			part.Position = Values[Parse(ValueFMT)]
			part.Orientation = Values[Parse(ValueFMT)]
			if isMesh then
				local mesh = Instance.new("SpecialMesh")
				mesh.MeshType = Values[Parse(ValueFMT)]
				mesh.Scale = Values[Parse(ValueFMT)]
				mesh.Offset = Values[Parse(ValueFMT)]
				mesh.Parent = part
			end
		end
		part.Parent = m
		table.insert(isNegate and Subtract or Union,part)
	end
	local first = table.remove(Union,1)
	if #Union>0 then
		first = first:UnionAsync(Union)
	end
	if #Subtract>0 then
		first = first:SubtractAsync(Subtract)
	end
	m:Destroy()
	return first
end

local function Decode(str)
	local StringLength = #str
	
	-- Base64 decoding
	do
		local decoder = {}
		for b64code, char in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split('')) do
			decoder[char:byte()] = b64code-1
		end
		local n = StringLength
		local t,k = table.create(math.floor(n/4)+1),1
		local padding = str:sub(-2) == '==' and 2 or str:sub(-1) == '=' and 1 or 0
		for i = 1, padding > 0 and n-4 or n, 4 do
			local a, b, c, d = str:byte(i,i+3)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8),bit32.extract(v,0,8))
			k = k + 1
		end
		if padding == 1 then
			local a, b, c = str:byte(n-3,n-1)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8))
		elseif padding == 2 then
			local a, b = str:byte(n-3,n-2)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000
			t[k] = string.char(bit32.extract(v,16,8))
		end
		str = table.concat(t)
	end
	
	local Position = 1
	local function Parse(fmt)
		local Values = {string.unpack(fmt,str,Position)}
		Position = table.remove(Values)
		return table.unpack(Values)
	end
	
	local Settings = Parse('B')
	local Flags = Parse('B')
	Flags = {
		--[[ValueIndexByteLength]] bit32.extract(Flags,6,2)+1,
		--[[InstanceIndexByteLength]] bit32.extract(Flags,4,2)+1,
		--[[ConnectionsIndexByteLength]] bit32.extract(Flags,2,2)+1,
		--[[MaxPropertiesLengthByteLength]] bit32.extract(Flags,0,2)+1,
		--[[Use Double instead of Float]] bit32.band(Settings,0b1) > 0
	}
	
	local ValueFMT = ('I'..Flags[1])
	local InstanceFMT = ('I'..Flags[2])
	local ConnectionFMT = ('I'..Flags[3])
	local PropertyLengthFMT = ('I'..Flags[4])
	
	local ValuesLength = Parse(ValueFMT)
	local Values = table.create(ValuesLength)
	local CFrameIndexes = {}
	
	local ValueDecoders = {
		--!!Start
		[1] = function(Modifier)
			return Parse('s'..Modifier)
		end,
		--!!Split
		[2] = function(Modifier)
			return Modifier ~= 0
		end,
		--!!Split
		[3] = function()
			return Parse('d')
		end,
		--!!Split
		[4] = function(_,Index)
			table.insert(CFrameIndexes,{Index,Parse(('I'..Flags[1]):rep(3))})
		end,
		--!!Split
		[5] = {CFrame.new,Flags[5] and 'dddddddddddd' or 'ffffffffffff'},
		--!!Split
		[6] = {Color3.fromRGB,'BBB'},
		--!!Split
		[7] = {BrickColor.new,'I2'},
		--!!Split
		[8] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = ColorSequenceKeypoint.new(Parse('f'),Color3.fromRGB(Parse('BBB')))
			end
			return ColorSequence.new(kpts)
		end,
		--!!Split
		[9] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = NumberSequenceKeypoint.new(Parse(Flags[5] and 'ddd' or 'fff'))
			end
			return NumberSequence.new(kpts)
		end,
		--!!Split
		[10] = {Vector3.new,Flags[5] and 'ddd' or 'fff'},
		--!!Split
		[11] = {Vector2.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[12] = {UDim2.new,Flags[5] and 'di2di2' or 'fi2fi2'},
		--!!Split
		[13] = {Rect.new,Flags[5] and 'dddd' or 'ffff'},
		--!!Split
		[14] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Axes.new(unpack(t))
		end,
		--!!Split
		[15] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Faces.new(unpack(t))
		end,
		--!!Split
		[16] = {PhysicalProperties.new,Flags[5] and 'ddddd' or 'fffff'},
		--!!Split
		[17] = {NumberRange.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[18] = {UDim.new,Flags[5] and 'di2' or 'fi2'},
		--!!Split
		[19] = function()
			return Ray.new(Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')),Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')))
		end
		--!!End
	}
	
	for i = 1,ValuesLength do
		local TypeAndModifier = Parse('B')
		local Type = bit32.band(TypeAndModifier,0b11111)
		local Modifier = (TypeAndModifier - Type) / 0b100000
		local Decoder = ValueDecoders[Type]
		if type(Decoder)=='function' then
			Values[i] = Decoder(Modifier,i)
		else
			Values[i] = Decoder[1](Parse(Decoder[2]))
		end
	end
	
	for i,t in pairs(CFrameIndexes) do
		Values[t[1]] = CFrame.fromMatrix(Values[t[2]],Values[t[3]],Values[t[4]])
	end
	
	local InstancesLength = Parse(InstanceFMT)
	local Instances = {}
	local NoParent = {}
	
	for i = 1,InstancesLength do
		local ClassName = Values[Parse(ValueFMT)]
		local obj
		local MeshPartMesh,MeshPartScale
		if ClassName == "UnionOperation" then
			obj = DecodeUnion(Values,Flags,Parse)
			obj.UsePartColor = true
		elseif ClassName:find("Script") then
			obj = Instance.new("Folder")
			Script(obj,ClassName=='ModuleScript')
		elseif ClassName == "MeshPart" then
			obj = Instance.new("Part")
			MeshPartMesh = Instance.new("SpecialMesh")
			MeshPartMesh.MeshType = Enum.MeshType.FileMesh
			MeshPartMesh.Parent = obj
		else
			obj = Instance.new(ClassName)
		end
		local Parent = Instances[Parse(InstanceFMT)]
		local PropertiesLength = Parse(PropertyLengthFMT)
		local AttributesLength = Parse(PropertyLengthFMT)
		Instances[i] = obj
		for i = 1,PropertiesLength do
			local Prop,Value = Values[Parse(ValueFMT)],Values[Parse(ValueFMT)]
			
			-- ok this looks awful
			if MeshPartMesh then
				if Prop == "MeshId" then
					MeshPartMesh.MeshId = Value
					continue
				elseif Prop == "TextureID" then
					MeshPartMesh.TextureId = Value
					continue
				elseif Prop == "Size" then
					if not MeshPartScale then
						MeshPartScale = Value
					else
						MeshPartMesh.Scale = Value / MeshPartScale
					end
				elseif Prop == "MeshSize" then
					if not MeshPartScale then
						MeshPartScale = Value
						MeshPartMesh.Scale = obj.Size / Value
					else
						MeshPartMesh.Scale = MeshPartScale / Value
					end
					continue
				end
			end
			
			obj[Prop] = Value
		end
		if MeshPartMesh then
			if MeshPartMesh.MeshId=='' then
				if MeshPartMesh.TextureId=='' then
					MeshPartMesh.TextureId = 'rbxasset://textures/meshPartFallback.png'
				end
				MeshPartMesh.Scale = obj.Size
			end
		end
		for i = 1,AttributesLength do
			obj:SetAttribute(Values[Parse(ValueFMT)],Values[Parse(ValueFMT)])
		end
		if not Parent then
			table.insert(NoParent,obj)
		else
			obj.Parent = Parent
		end
	end
	
	local ConnectionsLength = Parse(ConnectionFMT)
	for i = 1,ConnectionsLength do
		local a,b,c = Parse(InstanceFMT),Parse(ValueFMT),Parse(InstanceFMT)
		Instances[a][Values[b]] = Instances[c]
	end
	
	return NoParent
end


local Objects = Decode('AEBQCSEFTW9kZWwhCldvcmxkUGl2b3QEDgkPCRAJIQZTY3JpcHQhBE5hbWUhBkhlbG1ldAQRCRIJEwkhBFBhcnQhBk1pZGRsZSEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yBwYEIQZDRnJhbWUEHAAUCRUJIQpDYW5Db2xsaWRlAiEKQ2FzdFNoYWRvdyEFQ29sb3IG/8yZIQhNYXRlcmlhbAMAAAAAAACRQCELT3JpZW50YXRpb24Kj8L1vPYotUIAAAAAIQhQb3NpdGlvbgrrCVpChjubQEptQMMhCFJvdGF0aW9uCh8FMcMp3LJCHwUxQyEEU2l6ZQoAAABAAACAPwAAgD8hCl'
..'RvcFN1cmZhY2UhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyELU3BlY2lhbE1lc2ghBVNjYWxlCgAAoD8AAKA/AACgPyEMVmVjdG9yM1ZhbHVlIQxPcmlnaW5hbFNpemUhBVZhbHVlIQpCYWxhY2xhdmExB+sDBC4AFAkVCQYREREKKAZaQjAhmkAQbUDDCs3MTD3NzEw9zcxMPSELVmVydGV4Q29sb3IKAACAPgAAgD4AAIA+IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8xNjU3NDMxMDg1IQlUZXh0dXJlSWQhFnJieGFzc2V0aWQ6Ly8xMjczMDM4MzEhCE1lc2hUeXBlAwAAAAAAABRAIQhNZXNoUGFydAQ7ABYJFQkKj8L1'
..'PArXssIAAAAACvy0WUK81adAE25AwwpSuD5AKdyywlK4PkAKzebJP4AfPz7IsrA+IRdyYnhhc3NldGlkOi8vNDA2NzQ0NDUzNCEITWVzaFNpemUhCVRleHR1cmVJRCEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD00MDY3ODk0MzM2IQdiYXRlcmlhBEUAFwkYCQoK16M84XoUPxSu70AKS0ldQtAEokBVckDDCgwE8j569/s+XQOWPyEXcmJ4YXNzZXRpZDovLzMzMjczNTUwNDcKdA06QtSzQUIYpuZCIRdyYnhhc3NldGlkOi8vMjgyOTYwODQyNSEQRkFTVCBFU1MgSEVBRFNFVARNABIJEwkKAAAAAO'
..'F6FD+PwvU8CuNRWUJ8LZlAI2xAwwqeUZU//q2cPwJD5D8hF3JieGFzc2V0aWQ6Ly8zMTc1MjYxNTIzClHv30LO391CyNEpQyEXcmJ4YXNzZXRpZDovLzM3OTc5NDIzNjUhGE1lc2hlcy91bnRpdGxlZF9DdWJlLjAwMgcaAARWAA8JEAkGKioqCgvrV0KQ+KVA42pAwwqXJhU/SBI1Pk3mwz8hF3JieGFzc2V0aWQ6Ly8zNzQ0MjIzMjg5CjluYkL4cYlBIqwVQyEYTWVzaGVzL3VudGl0bGVkX0N1YmUuMDMwBFwAEgkTCQpsElpCFMifQGBuQMMK2zHWP2ZL1j+jL8k/IRdyYnhhc3NldGlkOi8vMzc0NDIyMjYxOAoV'
..'ciNDk4UjQ+iEGUMhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9Mzc3ODc0OTA0NiEGRyBMZW5zB+wDBGcAGQkaCQb/AAADAAAAAAAAckAKAAC0Qtcjt0IAAAAACg7WV0I2WqFAzW1AwwoAALRCCtejvNcjt8IKYAOEPx0Sez4BrtI+AwAAAEAzM9M/IRdyYnhhc3NldGlkOi8vMzc4NTY0ODA3NAoczhw+XBwVPcA+ej0hB0dvZ2dsZXMHlQAEcQAZCRoJBhwcHApXMVhC2AOiQHhuQMMKk/eQP1zo3D4r1fc+IRdyYnhhc3NldGlkOi8vMzc4NTY0NzEzOQoWMSw+ajKDPQ0wkz0EdgAZCRoJChcnWEJMtq'
..'FAmm5Awwrbr5c/zCXnPg+pAT8hDlVuaW9uT3BlcmF0aW9uIQ5Hb2dnbGVzIE1vZHVsZQR9ABsJHAkGHR4fCgrXIzw9irZCCtejPAofjVpC3oWhQFhyQMMKw3UzQ+F6sUKkcDPDCmwBpT95s1w+KFeBPyEMVXNlUGFydENvbG9yClEnKEAzJyg/UyeoPwpg5FVCpiOgQDKOQMMKCtejvOG6MsMK1yM8Cm6zXD6JAaU/2aQdQAp//llCGoahQI5xQMMKCtejvOG6MsPh+rPCAwAAAAAAABBACgAAgD8AAIA/AACAPwoAAAAAAAAAAAAAAAAhB0dhc21hc2sEjwAdCR4JBiEhIQMAAAAAAICYQAqPwgXApHC0wnE98kAKskJX'
..'QsaVk0A+bkDDCgAAwMLNzK/CSOGwwgp/GJg/3P9GP6HmHD8hFnJieGFzc2V0aWQ6Ly84NTYwMDk4NTUKnHCUQWA3QkEuIRlBIQZjYW1lcmEElwAfCSAJCh+FR0Ls0TLDUngywwqC9VlCApmxQAbJP8MKKRwCQ1yPQr+uRyE/Civ3Hz+qcac+nRWKPiEXcmJ4YXNzZXRpZDovLzQyNTk4OTkyMjAKmVF1QtBkAEI2w9NBIRdyYnhhc3NldGlkOi8vNDI1OTkwMjg3NwSfACEJIgkKKVw2wgCAvsK4HpVACsAQVkKc06tAe3NAwyELUmVmbGVjdGFuY2UDAAAAoJmZ4T8Kj0K+whSuMMIpXLnCCmHGwD/dAFI/VHMtPwMAAA'
..'BAMzPjPyEXcmJ4YXNzZXRpZDovLzQwNjc0NDMxMDkKYcbAP2wAiT9Ucy0/BKoAIwkkCQMAAAAAAABxQArD9T/Crse4wvYoPEAKWcNXQvixsUBbc0DDCs1MuMIK1yfCPYq0wgqF79U/8L6lPpRwiT8hF3JieGFzc2V0aWQ6Ly80MDY3NDQ0MTA0CoXv1T/wvqU+vMyYPyEHSEVMU1RBUgSyACUJJgkKCleUQh8Fw0KkcAFBCqXHWkJSIrtA9m9AwwpxPbhCPQp7QYVrs8IKjAaNPtpHAj9ID6s+CpyZxj2AMcA9+B+APApkG1pCLie/QH5rQMMKdGGzPHRhszx0YbM8CtwfWkIBub5Ak25AwwMAAAAAAAAIQArjgKM8xICj'
..'PMcQjz0K08xbQoWiukBOcEDDCvYoDMDDtTNDCtf7QArZgCM8NUH1POOAIz0KeOhZQkxxvUD/bkDDCvYoDMDDtTND4XoXQiEJV2VkZ2VQYXJ0CtqAIzzOgCM9VEH1PAoR9VlChSa+QH9yQMMK9igMQOF6lL7hehfCCur0WUIjHb5A12pAwwq/EI89AWFMPeOAIz0Kz/pZQtRnv0BFbkDDCr8Qjz0CYUw944AjPQqn21lC6jG+QOh4QMMKPttZQuYYvkB8ZEDDCkZB9TzOgCM944CjPQpz7VlCTty9QGtxQMMKRkF1Pc6Aoz3jgCM9ClfWWUJKJL1A4mRAwwrA1llCTz29QE55QMMK2oAjPDVBdT1UQXU9CtrgWUI1WL1ACW'
..'9AwwpxVeU9DOlaPipdHD4KW8RbQpaWu0CHlEDDCurCW0KMPrtAp0xAwwpuNrE+DOlaPgyjuz4KruVaQoNjvEBwc0DDCnZV5T0M6Vo+Ll0cPgrP/VlCwYC9QJqKQMMKtvxZQsQ9vUDqU0DDCmZuBT1rfFA9/MmmPQoC+VpC28u+QOVZQMMKNFxbQjFlvkDkWUDDCvYoDMDDtTNDMzPDQApnbgU9bXxQPfzJpj0KSI9aQjgpv0DqWUDDCvcu+jz7Lvo9/8mmPQpv9lpC1QC/QH+RQMMKmpmHQQCALcO4HhlBCvYu+jz6Lvo9/smmPQrlXltCOpy+QAaTQMMKrkeNQSmcMsOPwuVACvcu+jz6Lvo9/8mmPQoFkFpCC3q/QGWP'
..'QMMK/y76PPwu+j37yaY9ChbSW0IWLb5A+oZAwwqamctBXE8BQxSuR78K+C76PPou+j39yaY9CkcoWkIN2L9AuYxAwwpI4cRB7NEgwx+Fb0EK7skmPiIcFj4JyqY9Cj/BW0Lq/71AOElAwwqF68nB4foYw4WrLsMK6MkmPi4cFj4FyqY9CpEMWkLXgr9AJlFAwwquRwXC4TodQyncL8MK7skmPhkcFj4VyqY9CgqsW0IIZLxAc1BAwwrXoyDCPcoawxSuLcMK+skmPjYcFj7qyaY9CqjZWUJ/JsBA9VZAwwqPwpXB9qjyQoXrKMMK+skmPjQcFj7tyaY9CoT5WUJmML5AEWBAwwofhSzCSOHlQs2MJcMK8skmPjEcFj74ya'
..'Y9ChsJWkKwFb5AOlxAwwpcjzfCAMADQwDAKMMK9MkmPiocFj79yaY9Ck/YW0Jpbb5AM01Awwq4HoXBe5QDw4UrMcMK78kmPjccFj71yaY9CuyQW0I+3rxA+ItAwwqamRbCpHBpwbieKUMK68kmPh8cFj4SyqY9CgaYW0IqdLxAI05AwwqamRrC7JEqw49CLMMK7skmPiscFj4AyqY9CtjFW0IWeL5A0UdAwwrhenTBHwUYwwAAL8MK78kmPjccFj74yaY9CmSoW0J/+75AdZRAwwofhU/BXI+YwXuUK0MK68kmPi0cFj4ByqY9Cg+pW0J2j75AoURAwwquR13BwzUnw67HLcMK8skmPjMcFj72yaY9CrHzWULXjr9AXVNA'
..'wwrD9fjBSCEHQ7jeKsMK98kmPi8cFj76yaY9CkHRW0IRSr5AdYtAwwq4HtnBuB5WwqRwLkMK9MkmPiIcFj4HyqY9Ci/SW0JM9r1ASU5AwwrD9dTBSCEEw1L4MMMK78kmPjccFj72yaY9CgCkW0IFgr5AIJNAwwrNzLbBheuLwQoXK0MK8skmPjQcFj72yaY9CpDvWUKd/79AZFFAwwqF66nBe9QIQ7ieK8MK68kmPigcFj4JyqY9CtelW0InFr5AK0ZAwwp7FL7B12Mow2ZmLcMK98kmPjAcFj73yaY9Ck3YW0I+wL5AQoxAwwofhYnB9ihawuzRLkMK88kmPi4cFj79yaY9CnigW0ILy7xAFotAwwqamSHCXI8NwgBAK0'
..'MK9MkmPjEcFj76yaY9Cpa8W0KlY75A4pBAwwrsUczBXI8XwkihLEMK9MkmPhQcFj4SyqY9CsG0W0IYYLxA1lNAwwpmZibCFC4Fw7heMMMK9MkmPjMcFj74yaY9CqjCW0IK275A9pFAwwqF63nBSOEcwgoXLUMK6MkmPi8cFj4ByqY9CiQKWkIK8r9A7U5AwwrNzLrBjwIeQ+E6MMMK+skmPjccFj7ryaY9CsfeWULPs79AqVhAwwr2KOTB7FHuQj0KKMMK98kmPiUcFj4EyqY9Ct+vW0L6t7xAJ4dAwwpxPSjCKVxOwntULUMK9skmPkgcFj7XyaY9Cun2WULOXL5A/HtAwwrNzCXCj8JwQs1MLEMK8ckmPkwcFj7cyaY9'
..'ClrqWUKH279AwYdAwwqPwuHB4XoTQqRwMEMK9skmPkkcFj7XyaY9ClnWWULCZ8BAroNAwwrD9YTBMzNjQuH6LUMK9skmPk4cFj7XyaY9CqPbWUIq8b9ATYJAwwrhetTBSOFnQs2MLUMK6ckmPkgcFj7myaY9Ct0BWkKHRsBAaY1AwwpxPZbBMzOlQc0MM0MK8ckmPkgcFj7hyaY9CnXmWULgUMBAe4lAwwoK15HBSOEQQjOzMEMK6ckmPkocFj7jyaY9CnEEWkKZ0b9AgotAwwpxPebBUrimQeH6MkMKcgN2PkccFj7myaY9Cko2WkI/Qb5A04VAwwq4Hi/CmpmpQY/CMkMKfGOEPiocFj4IyqY9CqVGWkJ/+r1AEFdAww'
..'p7FEHCuJ4bQz3KLsMK8ckmPkscFj7dyaY9CiT+WULeTb5Aj39AwwpSuCzCH4UYQjOzL0MK5MkmPkmBaT1y9ao+CsKSW0JonbxApGhAwwr2KAxAFK6Hv5rZK8MK6ckmPkGBaT1y9ao+CvYoDEAUroe/ZiYyQwr1ySY+5SAvPbREfD4KdCxaQhREvkAIaUDDCvYoDEAUroe/ZiYjQwoCyiY+2CAvPbREfD4K9igMQBSuh79mJhRDCscuJD+xVeU93E2CPgqOEVtCdBS+QDOVQMMKFK6MwgqXH0N71BrDCscuJD+tVeU93k2CPgr1DFtCZ8i8QFePQMMKPQpmwntUKkPNjCTDCscuJD+vVeU93E2CPgoK1yjChesvQyncKMMK'
..'xy4kP8BV5T3STYI+CsMKW0JL6LtAo4dAwwp7FErBZmYyw+yRK8MK0S4kP9xV5T3cTYI+CnoJW0Intr1AV0ZAwwoAgIbCUrjOQADAJUMK0S4kP+VV5T3WTYI+Cr4IW0KIdrxA8ExAwwrXo1fCKVxPPzOzKkMK0S4kP+5V5T3RTYI+CmZmGcLsURjArgctQwrRLiQ/61XlPdJNgj4KGgpbQo6nu0AbVUDDCuF6CMHNzLzA4XouQwoK6Vo+CsqmPdsPxj4KueZbQvKivUBjc0DDCvYoDMCk8DJDhSsCQwob6Vo+/8mmPdsPxj4KJgxcQmbQvkDbckDDCvYoDMCk8DJDe5TkQgr+6Fo+FcqmPdsPxj4KTKdbQj48vEAcdEDDCv'
..'YoDMCk8DJD16MgQwr/6Fo+E8qmPdsPxj4K9igMwKTwMkNIYRJDCgbpWj4PyqY92w/GPgr7aFtCR9+7QIJ0QMMK9igMwKTwMkPX4zJDCjzpWj7oyaY92w/GPgoA31lCyZW/QDJ1QMMK9igMQBSuh7/D9ehCCjzpWj7ryaY92w/GPgqAw1lCjgHBQON0QMMK9igMQBSuh78zM8lCCifpWj73yaY92w/GPgoTElpCLcG9QIV1QMMK9igMQBSuh78z8xJDCjTpWj7tyaY92w/GPgr2KAxAFK6Hv6SwBEMKFelaPgfKpj3bD8Y+CuVLWkLo8LxAgHVAwwr2KAxAFK6HvzMzJUMKMEbLPtVV5T7jLvo9CtSbWULvDMJARH9AwwqP'
..'wuXArkfdwo/CM8MKKUbLPtRV5T7pLvo9CjSdWUJI88FAdWxAwwpI4drAmpm1ws3MMUMKIEbLPtVV5T73Lvo9CqCnWULeysFA6lRAwwrNzKzAPYqGwgBAL0MKZG4FPsvwkT2aR5o+CsLHWkKJSb9AT15AwwoUrt/AZma+wntUMkMKZG4FPsvwkT1UXZw+CjTKWkLccL9Ag35AwwrNzNTAzcyswnsULsAKy/CRPV7Cbz5Lwm8+CuctWkIh8r9AAm9AwwpI4drAmpm1wpqZr0IKHYQHPsvwkT1luow+ConyWkJjNb9AU25AwwrL8JE9DCeXPvnajz4KIV1bQhPPvkD0bUDDCihGyz7IVeU+5i76PQrZHlxCbIu/QDlqQMMKIU'
..'bLPsxV5T7uLvo9CrkVXEKrsr9A0oFAwwrsUcDAH4WWws0MMEMKLEbLPsxV5T7hLvo9Cm8YXEIGf79A51tAwwp7FObA9qjZwuH6M8MKL0bLPtVV5T7kLvo9Cr6gWUJ6JcNA135AwwoeollC0wvDQAhsQMMKIUbLPtVV5T71Lvo9CoqsWUJp48JAfVRAwwplbgU+y/CRPZpHmj4KrMxaQhRiwEDiXUDDCmRuBT7L8JE9U12cPgoez1pCZ4nAQBZ+QMMKy/CRPV/Cbz5Lwm8+CtEyWkKsCsFAlW5AwwoehAc+y/CRPWS6jD4Kc/daQu5NwEDmbUDDCsvwkT0NJ5c++dqPPgoLYltCnue/QIdtQMMKK0bLPshV5T7mLvo9CsMj'
..'XEL3o8BAzGlAwwolRss+zFXlPu4u+j0KoxpcQjbLwEBlgUDDCi9Gyz7MVeU+4S76PQpZHVxCkZfAQHpbQMMK9i76PPsu+j3/yaY9CjfxWkI7rb5AzUpAwwqPwtFBrkcdwQrXKUMK+S76PPku+j3+yaY9ClKLWkJoNb9Ad01Awwr3Lvo89y76Pf/Jpj0KU1lbQn5AvkCjR0DDCoXr10GamYnA7FEsQwr2Lvo8/C76PQDKpj0KHCRaQiKhv0CfUEDDCuF6wEFI4aTBAEAlQwr9Lvo8+y76PfvJpj0K1tlbQusAvkCsUUDDCsP1iEEzMzRCM/MvQwr5Lvo88i76PfrJpj0KkupaQlRyvUAWS0DDCo/CkcE9CifApDAuQwr4Lv'
..'o88C76PfvJpj0KtVJbQqT/vEA0SUDDCkjhjMGF6yFAcb0rQwr9Lvo88i76PfrJpj0KyINaQuDMvUCJTUDDCvsu+jzxLvo9+smmPQpHxltC4n+8QNtUQMMKZmZewc3MVEKuhylDCvou+jzxLvo998mmPQqcHFpCW0S+QJBQQMMKcT3mwbgeTcGFKzNDCu7JJj4jHBY+CsqmPQqwultCF8e8QKqSQMMKcT2OQexRA8LD9QTBCufJJj4uHBY+BsqmPQqpB1pCnMi+QDmMQMMKmpkWQnE9PkFmZlLBCu7JJj4YHBY+FsqmPQresltCVIG+QIKLQMMKZmYCQh+FDcJcjxbBCvrJJj41HBY+7MmmPQrs0FlCWZK+QJaGQMMKH4X3'
..'QXE9WEKF6wFACvrJJj40HBY+7smmPQox/1lCRDjAQF99QMMKFK5fQilcXkI9CkdACvPJJj4xHBY++MmmPQpRD1pCBzLAQCiBQMMKcT1eQs3MBkK4Hs3ACvbJJj4qHBY+/cmmPQpPzVtCxS68QJuOQMMKXI+qQPYoTMLsUdjACvDJJj43HBY+9cmmPQqfkVtCoki+QBZQQMMK4XoDQq5HHMOPwtVACuvJJj4fHBY+E8qmPQofn1tCIJq+QOONQMMKUrgKQtejpsEzMx/BCu7JJj4rHBY+AcqmPQplu1tCXUm8QA2UQMMK9ij8QD0K+8EUrv/ACvDJJj44HBY++MmmPQqxlltCXw68QIRHQMMK9igAQUghH8OkcLVACuvJJj'
..'4uHBY+A8qmPQr8nltC4Gy8QFaXQMMKFK4fQdejhMHNzATBCvPJJj4zHBY+98mmPQob71lCxO++QBeKQMMKH4UiQh+FD0LXo5jACvfJJj4uHBY++8mmPQpSxFtCBGa8QGBQQMMKZmZyQSnc98JmZmZACvbJJj4hHBY+B8qmPQoby1tCi668QIqNQMMKAAB0QT0KUcIpXN/ACvDJJj44HBY+98mmPQpglltCooy8QN1IQMMKFK6PQQoXHsPNzLxACvPJJj40HBY+9smmPQqj51lC3Iq+QBWMQMMKrkf1QWZmE0JSuIbACuvJJj4mHBY+CsqmPQqjn1tC6ui8QM+VQMMKPQqfQUjhkME9CgvBCvfJJj4xHBY++cmmPQpYx1tC'
..'e+W7QI1PQMMKpHClQJoZ+cIpXF9ACvTJJj4uHBY+/cmmPQpQoVtChzu+QOpQQMMKPQr5QXsUCcP2KKxACvTJJj4xHBY++8mmPQo8r1tC1ne8QAZLQMMKH4WBQR+FCsOuR5lACvbJJj4UHBY+E8qmPQo+u1tCznO+QBaIQMMKPQrxQSlcWcKuR/nACkKxW0Ik+LtA7UlAwwo9CsdAKVwLw/YolEAK58kmPjAcFj4CyqY9CucBWkK/Yb5AdI5Awwq4Ht9BKVxnQfYoPMEK+skmPjYcFj7tyaY9Cm3ZWUIQ975A3oRAwwqPwiNCexRaQgrXE0AKBbFbQkQuvkDLVEDDCsP18EEzs/XC16OAQArJ+VlCohXAQHdhQMMKexRXQu'
..'H6/0JI4YpACvLJJj5MHBY+28mmPQrf4FlCOb6+QL5VQMMKj8IRQtcjFkNSuC5BCkrJWULHXr5A4llAwwrheuZBrsf7QkjhOkAKPtJZQpnGvkA+W0DDCjMzG0KaGf1CXI9SQArq81lCmCe+QAFQQMMKcT28QXH9I0MK119BCvLJJj5IHBY+4MmmPQpK2VlC0VS+QAZUQMMKzczUQa4HFEPD9RxBCunJJj5LHBY+48mmPQo4+llCP5O+QOVRQMMKCtcEQrjeJkOPwnVBCnQDdj5IHBY+5smmPQpwN1pCnrC/QGlXQMMK9ig+QjOzLEMpXJlBCnxjhD4rHBY+CsqmPQr4S1pCyM6/QB2GQMMKmplQQuF6zEBcj4jBCvLJJj5L'
..'HBY+3MmmPQoQAVpCxxXAQN5dQMMKKVxMQimcGkPXo2BBCuTJJj5HgWk9b/WqPgpRl1tCzn++QGZzQMMK9igMwMO1M0PD9bZBCuvJJj4+gWk9b/WqPgr2KAzAw7UzQ4XrTUEK+ckmPuMgLz2vRHw+ClsvWkK/vr9APHRAwwr2KAzAw7UzQ+xRCMAKBsomPtQgLz2vRHw+CvYoDMDDtTNDPQqJwQrLLiQ/q1XlPdpNgj4KGwxbQkYgvkBKR0DDCsP1i0L2KLLBw/WYwQrLLiQ/qlXlPdtNgj4KghJbQiVqv0ApTUDDCq5HY0JSuGLBrkc9wQrLLiQ/rFXlPdlNgj4KZmYlQkjhHsGkcAnBCssuJD+/VeU9z02CPgrnF1tCi0'
..'bAQN5UQMMKj8I5QZqZscBcj9LACtcuJD/ZVeU9202CPgpzC1tCXoO+QCuWQMMKw3WBQh8FGsMpXK9BCtcuJD/gVeU91U2CPgqJFFtCurq/QJOPQMMKuB5PQhQuIsNSuG5BCtcuJD/pVeU90U2CPgqF6xFC9ignw0jhNkEK1y4kP+hV5T3STYI+Cv0bW0ILgcBAZodAwwpmZt5ASOEswxSuE0EKBOlaPhHKpj3ZD8Y+CqrfW0J02bxAX2hAwwr2KAxA4XqUvpoZgcIKFulaPgXKpj3ZD8Y+ClL6W0LOabtAxmhAwwr2KAxA4XqUvincoMIK/ehaPhnKpj3ZD8Y+CqutW0JNtb5A3WdAwwr2KAxA4XqUvuxRCMIK+uhaPhjK'
..'pj3ZD8Y+CvYoDEDhepS+KVxBwgoK6Vo+EMqmPdkPxj4KVHRbQtSNv0CtZ0DDCvYoDEDhepS+uB59wQpG6Vo+58mmPdkPxj4KF9lZQrsWv0BWaEDDCvYoDMDDtTNDcT1DwgpB6Vo+7MmmPdkPxj4K97JZQrPuvUC8aEDDCvYoDMDDtTNDKVyBwgoz6Vo+9MmmPdkPxj4KWBlaQkd0wEDWZ0DDCvYoDMDDtTND16OSwQpA6Vo+6smmPdkPxj4K9igMwMO1M0MpXALCCiDpWj4FyqY92Q/GPgrgV1pCSsjAQKhnQMMK9igMwMO1M0MK16O9Ci9Gyz7NVeU+5i76PQqPg1lCyT29QIBeQMMKuB7VwApXjMIUrpfACihGyz7MVe'
..'U+7C76PQqzhllCw1G9QE1xQMMKCtf7wMP1s8KkcA3ACiBGyz7NVeU+9y76PQpNk1lCJWG9QM6IQMMKpHABwc1M48IpXI8/CmVuBT7K8JE9nkeaPgrTvVpCRYW9QG1+QMMKj8L1wPYoq8IK1zPACmRuBT7K8JE9V12cPgo+vVpCv129QDheQMMK9igAwc3MvMJmZjJDCsrwkT1ewm8+UsJvPgrLIlpCfhy+QEFuQMMKCtf7wMP1s8KFa7jCCh2EBz7K8JE9aLqMPgr+5lpCmkO9QERuQMMKyvCRPQwnlz792o8+CllRW0IJzrxARm5AwwomRss+xVXlPuku+j0K6wZcQgCOukBYcUDDCiJGyz7IVeU+8C76PQqa+1tCIX26'
..'QMhZQMMKUrgCwTMz08IK16O8CixGyz7IVeU+5C76PQrdAVxCeqW6QLB/QMMKhevZwKTwj8LD9ZDACm9/WUJoJLxA6V5AwwqTgllCYji8QLZxQMMKIEbLPs1V5T74Lvo9Ci2PWULER7xAN4lAwwqzuVpC5Gu8QNZ+QMMKHrlaQl5EvEChXkDDCqseWkIdA71Aqm5Awwre4lpCOSq8QK1uQMMKOU1bQqi0u0CvbkDDCssCXEKfdLlAwXFAwwp691tCwGO5QDFaQMMKvf1bQhmMuUAZgEDDCvgu+jzzLvo9+cmmPQro61pCJ8a9QMqRQMMKUrjcwRRuMsPD9chACvsu+jzzLvo9+cmmPQrmhFpCrRG+QHmPQMMK+C76PPEu+j'
..'35yaY9CjdUW0KIW71AmpRAwwofhdfBcf0vQ65HDUEK+y76PPIu+j36yaY9Cn4dWkJye75ArIxAwwoK1+HB1yMnw+xReD8K+i76PO8u+j38yaY9Cv3RW0IZlbxAIIpAwwofhcvA7BEEQ1K4xkAKFUXHPgrR4D5RQfU9CsyAWUIq0rlA1mBAwwoVRcc+CdHgPk9B9T0K4INZQr/luUBFc0DDChZFxz4K0eA+UUH1PQo7kFlC0/S5QE+KQMMKhc0CPqsQjz2gPZc+CuC0WkI7GLpAI4BAwwqEzQI+qxCPPdJImT4KTrRaQnzxuUCQYEDDCqsQjz1MCWs+QwlrPgrlHFpCeqy6QEhwQMMKutgEPqsQjz2/9Ik+CjvdWkLc17lA'
..'THBAwwqrEI89ziyUPo4FjT4KfUVbQptkuUBNcEDDChNFxz4D0eA+T0H1PQp991tC6i+3QFBzQMMKE0XHPgbR4D5PQfU9CmTsW0JgH7dAN1xAwwoURcc+BtHgPk9B9T0KiPJbQu1Gt0BfgUDDCi6ZEz6U1gQ+RJmTPQpcoFtCy228QI2OQMMK+5gTPrvWBD5NmZM9CmMfWkI4NL5A2YhAwwoumRM+d9YEPmSZkz0KcZlbQib1vUA3iEDDCmZmAkIfhQ3CZmYWwQoZmRM+ztYEPhuZkz0K8u5ZQjMEvkDdg0DDChmZEz7T1gQ+FZmTPQrkF1pCk3m/QLV7QMMKB5kTPsnWBD4xmZM9CiomWkINdL9AD39Awwo8mRM+p9YEPi'
..'KZkz0K17BbQgDnu0D1ikDDCgqZEz7E1gQ+NZmTPQoFfFtC/cK9QKFTQMMKH5kTPonWBD5gmZM9CviHW0IYC75AUopAwwoumRM+q9YEPiuZkz0K/aBbQoj+u0DHj0DDCgqZEz7D1gQ+OZmTPQqCgFtCWMq7QAxMQMMKH5kTPrDWBD41mZM9CtiHW0L1HbxAr5JAwwoHmRM+ytYEPjGZkz0KqQlaQt5WvkD3hkDDCg6ZEz6r1gQ+UZmTPQriqFtC5xe8QONTQMMKPJkTPo7WBD5AmZM9CuSuW0ITWLxAA4pAwwoKmRM+xdYEPjeZkz0KOoBbQhQ6vEA9TUDDChSuj0GaGR7Dzcy8QAoHmRM+yNYEPjOZkz0KDQNaQpL9vUC5'
..'iEDDCh+ZEz6f1gQ+SJmTPQpsiFtCuou8QFWRQMMKw/WeQUjhkME9CgvBCg6ZEz601gQ+R5mTPQqPq1tCKKa7QClTQMMKCJkTPq/WBD5SmZM9CuiJW0Jlt71AXVRAwwoImRM+tdYEPkyZkz0KOpZbQqwnvEAnT0DDCjyZEz5q1gQ+ZJmTPQraoFtCL+m9QDGFQMMKCJkTPrvWBD5FmZM9CgSYW0KstrtALk5Awwr7mBM+wNYEPkiZkz0KShpaQjDZvUDTikDDChmZEz7T1gQ+F5mTPQp59llCU12+QFeCQMMKDpkTPpvWBD5imZM9Cs6XW0Koq71AzFdAwwo/mRM+5tYEPtmYkz0KHBNaQu5av0ADY0DDCnsUV0LD9f9CSO'
..'GKQAo0mRM+79YEPtyYkz0KEP1ZQgkrvkCjWEDDCj+ZEz7u1gQ+0JiTPQoy6FlCkta9QE1cQMMKP5kTPvPWBD7OmJM9Ch3wWUJyMr5AgV1AwwoemRM+6dYEPveYkz0K6g1aQr2lvUCPU0DDCjSZEz7r1gQ+4ZiTPQpa9llCws29QB5XQMMKHpkTPuzWBD70mJM9Cn8TWkIBBb5APFVAwwoUtVk+4dYEPv6Ykz0Kq0laQosBv0AdWkDDCrFPaj621gQ+VJmTPQrWW1pCOxy/QHGDQMMKNJkTPuXWBD7mmJM9Co0ZWkIPW79A1F9AwwoamRM+WaNOPdhJlz4KOYFbQuz2vUDockDDCiSZEz5Ko0492EmXPgo0mRM+ZvoaPR4+'
..'Xz4KrkJaQicRv0Clc0DDCkGZEz5W+ho9Hj5fPgrJShE/l/LKPW+fZj4KCAZbQmSivUDeS0DDCslKET+P8so9d59mPgqyC1tCTsa+QBFRQMMKrkdjQlyPYsGuRz3BCslKET+M8so9fJ9mPgrJShE/mPLKPWyfZj4KeBBbQliJv0DjV0DDCs9KET/I8so9Z59mPgpzBVtCD/q9QKyRQMMK4XqBQo8CGsMpXK9BCs9KET/M8so9YJ9mPgp9DVtCmA2/QNaLQMMKz0oRP9Dyyj1en2Y+Cs9KET/C8so9bJ9mPgoVFFtCGL2/QJuEQMMK6LhBPkuZkz3sRa8+Cj/BW0IsgbxAJGlAwwr5uEE+QJmTPexFrz4K1thbQtM7u0CAaU'
..'DDCuy4QT5LmZM97EWvPgoAlVtCRSa+QLFoQMMK47hBPk+Zkz3sRa8+CgC5QT48mZM97EWvPgpDYltC4eW+QIdoQMMKOblBPhWZkz3sRa8+Clf2WUJ5fL5AHGlAwwouuUE+HpmTPexFrz4KmtRZQoF2vUB3aUDDCi65QT4bmZM97EWvPgozL1pCzrG/QKtoQMMKOLlBPhWZkz3sRa8+Chm5QT4umZM97EWvPgqJZlpCJ/y/QINoQMMKv+KzPqnyyj65Zd09CqaqWULy2bxAaGBAwwq34rM+p/LKPsJl3T0Kba1ZQp/rvEALcUDDCqvisz6p8so+0GXdPQqUuFlCOfm8QNiFQMMKWSjsPQ4mgT1Kh4g+CsHAWkI0Gb1AqXxA'
..'wwpTKOw9DiaBPZpfij4KPcBaQjz2vEApYEDDCg4mgT0/LFQ+LyxUPgqPN1pCB5+9QFpuQMMK9tjvPQ4mgT18Enk+Ci/lWkIZ37xAXW5AwwoOJoE918KFPmubfj4KTkNbQg93vEBebkDDCrTisz6i8so+v2XdPQr841tCT3m6QBVxQMMKreKzPqPyyj7JZd09CvjZW0JiarpAPFxAwwq84rM+o/LKPrdl3T0Kg99bQhSOukDHfUDDCsHisz6p8so+u2XdPQr/pllC8eC7QMRgQMMKueKzPqfyyj7DZd09CsapWUKe8rtAZ3FAwwqt4rM+qfLKPtJl3T0K7bRZQjgAvEA0hkDDCloo7D0OJoE9S4eIPgoavVpCMyC8QAV9QM'
..'MKVCjsPQ4mgT2cX4o+Cpa8WkI7/btAhWBAwwoOJoE9QCxUPjEsVD4K6DNaQgamvEC2bkDDCvnY7z0OJoE9fRJ5PgqI4VpCGOa7QLluQMMKDiaBPdjChT5sm34+Cqc/W0IOfrtAum5Awwq34rM+ovLKPsFl3T0KVeBbQk6AuUBxcUDDCq/isz6j8so+ymXdPQpR1ltCYXG5QJhcQMMKvuKzPqPyyj65Zd09CtzbW0ITlblAI35Awwqb2AQ/SNHgPb8Qjz4KnchaQlIUvUCca0DDCi2ZEz6W1gQ+RJmTPQpPn1tCc068QNyOQMMK+pgTPrzWBD5NmZM9ClYeWkLgFL5AKIlAwwotmRM+eNYEPmWZkz0KZJhbQs7VvUCGiEDD'
..'ChmZEz7P1gQ+G5mTPQrl7VlC2+S9QCyEQMMKGZkTPtPWBD4WmZM9CtcWWkI7Wr9ABHxAwwoHmRM+ydYEPjKZkz0KHSVaQrVUv0Bef0DDCjuZEz6p1gQ+IpmTPQrKr1tCqMe7QESLQMMKCpkTPsXWBD42mZM9Cvh6W0Klo71A8FNAwwoemRM+i9YEPmGZkz0K64ZbQsDrvUChikDDCi2ZEz6t1gQ+K5mTPQrwn1tCMN+7QBaQQMMKCpkTPsbWBD44mZM9CnV/W0IAq7tAW0xAwwoemRM+sdYEPjWZkz0Ky4ZbQp3+u0D+kkDDCpwIWkKGN75ARodAwwoOmRM+rNYEPk+Zkz0K1adbQo/4u0AyVEDDCjuZEz6Q1gQ+QJmTPQ'
..'rXrVtCuzi8QFKKQMMKLX9bQrwavECMTUDDCgACWkI63r1ACIlAwwoemRM+oNYEPkiZkz0KX4dbQmJsvECkkUDDCg6ZEz621gQ+RZmTPQqCqltC0Ia7QHhTQMMKB5kTPq/WBD5SmZM9CtuIW0INmL1ArFRAwwoImRM+ttYEPkqZkz0KLZVbQlQIvEB2T0DDCjuZEz5r1gQ+ZJmTPQrNn1tC18m9QICFQMMKCJkTPrzWBD5DmZM9CveWW0JUl7tAfU5Awwr6mBM+wdYEPkeZkz0KPRlaQti5vUAii0DDCmz1WUL7Pb5ApoJAwwoOmRM+nNYEPmGZkz0KwZZbQlCMvUAbWEDDCj2ZEz7m1gQ+2ZiTPQoPElpClju/QFJjQMMK'
..'MpkTPvHWBD7cmJM9CgP8WUKxC75A8lhAwwo9mRM+79YEPtCYkz0KJedZQjq3vUCcXEDDCj2ZEz701gQ+z5iTPQoQ71lCGhO+QNBdQMMKHZkTPurWBD73mJM9Ct0MWkJlhr1A3lNAwwoymRM+7dYEPuKYkz0KTfVZQmquvUBtV0DDCh2ZEz7t1gQ+9ZiTPQpyElpCqeW9QItVQMMKErVZPuHWBD4AmZM9Cp5IWkIz4r5AbFpAwwqxT2o+tdYEPlSZkz0KyVpaQuP8vkDAg0DDCjKZEz7l1gQ+6JiTPQqAGFpCtzu/QCNgQMMKGJkTPlujTj3YSZc+CiyAW0KU171AN3NAwwohmRM+TKNOPdhJlz4KNJkTPmj6Gj0ePl8+Cq'
..'FBWkLP8b5A9HNAwwpBmRM+WfoaPR4+Xz4KyUoRP5byyj1yn2Y+CvsEW0IMg71ALUxAwwrJShE/jfLKPXufZj4KpQpbQvamvkBgUUDDCslKET+M8so9fZ9mPgrJShE/mfLKPWyfZj4Kaw9bQgBqv0AyWEDDCs9KET/I8so9ap9mPgpmBFtCt9q9QPuRQMMKz0oRP8zyyj1jn2Y+CnAMW0JA7r5AJYxAwwrPShE/0PLKPWCfZj4Kz0oRP8Xyyj1tn2Y+CggTW0LAnb9A6oRAwwrsuEE+S5mTPfFFrz4KMsBbQtRhvEBzaUDDCvy4QT5AmZM98UWvPgrJ11tCexy7QM9pQMMK7bhBPkyZkz3xRa8+CvOTW0LtBr5AAGlAwwrl'
..'uEE+UJmTPfFFrz4KAblBPj6Zkz3xRa8+CjZhW0KJxr5A1mhAwwo5uUE+FpmTPe1Frz4KSvVZQiFdvkBraUDDCi65QT4emZM97UWvPgqN01lCKVe9QMZpQMMKLrlBPhyZkz3tRa8+CiYuWkJ2kr9A+mhAwwo3uUE+FZmTPe1Frz4KGblBPi6Zkz3tRa8+CnxlWkLP3L9A0mhAwwrC4rM+qfLKPrll3T0KmalZQpq6vEC3YEDDCrrisz6n8so+wmXdPQpgrFlCR8y8QFpxQMMKruKzPqnyyj7TZd09Coe3WULh2bxAJ4ZAwwpcKOw9DiaBPUqHiD4KtL9aQtz5vED4fEDDClYo7D0OJoE9ml+KPgowv1pC5Na8QHhgQMMKDi'
..'aBPUEsVD4vLFQ+CoI2WkKvf71AqW5Awwr62O89DiaBPXwSeT4KIuRaQsG/vECsbkDDCg4mgT3awoU+a5t+PgpBQltCt1e8QK1uQMMKuOKzPqLyyj6/Zd09Cu/iW0L3WbpAZHFAwwrr2FtCCku6QItcQMMKv+KzPqPyyj62Zd09CnbeW0K8brpAFn5AwwrC4rM+qfLKPrtl3T0K8qVZQpnBu0ATYUDDCrrisz6n8so+w2XdPQq5qFlCRtO7QLZxQMMKr+KzPqnyyj7TZd09CuCzWULg4LtAg4ZAwwpcKOw9DiaBPUuHiD4KDbxaQtsAvEBUfUDDClYo7D0OJoE9nF+KPgqJu1pC4927QNRgQMMKDiaBPUEsVD4xLFQ+Ctsy'
..'WkKuhrxABW9Awwr62O89DiaBPX0SeT4Ke+BaQsDGu0AIb0DDCg4mgT3awoU+bJt+PgqaPltCtl67QAlvQMMKuOKzPqLyyj7BZd09CkjfW0L2YLlAwHFAwwpE1VtCCVK5QOdcQMMKv+KzPqPyyj65Zd09Cs/aW0K7dblAcn5AwwqSSgI/8YAjPkU0xD0Ksb1aQl0EvECDh0DDCq5HQcAULi7DMzPzQAqZSgI/8IAjPjY0xD0K9b9aQuzHu0AQWUDDCuF61L/26C9DAAAAQSEJSEVMU1RBUlhPBBMEJwkoCQpxPY5BrkcDwsP1BMEKJ8daQsLZu0Cjb0DDCrgep0Fcj/jBuB41QApxo9g+B3IzPvZLqj4KXKULPqlc+z1lpY'
..'s9CimTW0LkQrxAg41Awwo+pQs+2lz7PWiliz0K7iZaQrXwvUAaiEDDCpqZFkJcjz5BZmZSwQpcpQs+jlz7PXOliz0KnoxbQiq1vUCEh0DDCmZmAkLheg3CZmYWwQpPpQs+7Fz7PU+liz0KGvlZQkPDvUBig0DDCh+F90GuR1hChesBQApPpQs++1z7PUaliz0K2B9aQoskv0Cre0DDChSuX0JmZl5CPQpHQApFpQs+8lz7PVSliz0KWC1aQlIfv0DXfkDDCnE9XkIK1wZCuB7NwApkpQs+vVz7PVSliz0KwaJbQl/Du0AdikDDClyPqkC4HkzC7FHYwApIpQs+41z7PVyliz0Kz3BbQr+FvUDDVUDDCuF6A0IfRRzDj8LV'
..'QApTpQs+o1z7PXCliz0KFXxbQuvJvUCCiUDDClK4CkJcj6bBMzMfwQpcpQs+wFz7PViliz0KwZNbQqDZu0CsjkDDCvYo/EDD9frBFK7/wApIpQs+3Fz7PWOliz0KEHVbQk2ou0CXTkDDCvYoAEG4Hh/DuB61QApTpQs+xlz7PV6liz0K93tbQlj3u0BskUDDChSuH0Fcj4TB16MEwQpFpQs+7Vz7PVeliz0KXxJaQnwRvkBRhkDDCh+FIkJcjw9C16OYwApKpQs+wlz7PW2liz0KQ5tbQrDxu0ACVkDDCmZmckEK1/fCZmZmQApkpQs+olz7PWKliz0K6aBbQlouvEA4iUDDCvYodEEAAFHCKVzfwApIpQs+3lz7PWCliz'
..'0KzHRbQgMSvEC4T0DDCkWlCz7mXPs9XKWLPQoeDFpC/7y9QPyHQMMKrkf1QaRwE0JSuIbAClOlCz64XPs9ZqWLPQqDfFtCM1+8QCSQQMMKw/WeQc3MkME9CgvBCkqlCz7MXPs9aaWLPQrLnVtCEoa7QFJVQMMKpHClQHsU+cIpXF9ACkalCz7NXPs9a6WLPQrzfVtCx3q9QHZWQMMKPQr5QewRCcP2KKxACkalCz7OXPs9a6WLPQqciVtCmgC8QIdRQMMKZKULPn5c+z1ypYs9CqGTW0LZqb1Ap4RAwwo9CvFB7FFZwq5H+cAKRqULPtFc+z1opYs9Ck6LW0KxlbtAm1BAwwopXMdAmlkLw/YolEAKPqULPtxc+z1mpYs9'
..'ChsiWkKUmr1A+IlAwwo9Ct9BH4VnQfYoPMEKT6ULPvRc+z1KpYs9CjkAWkKXF75A8YFAwwpSuCNCuB5aQgrXE0AKSqULPrZc+z1zpYs9ChmLW0Ktb71AtVlAwwrD9fBBFK71wtejgEAKZaULPg5d+z0jpYs9ClUbWkKSB79ATWRAwwp7FFdC4fr/QlyPikAKX6ULPhJd+z0ppYs9CnwGWkIO6L1AfFpAwwqPwhFC1yMWQ1yPLkEKZaULPg1d+z0jpYs9Cr3yWUIhmL1A9F1AwwrheuZBzcz7QkjhOkAKZaULPhhd+z0ipYs9Cjv6WUIO771AF19AwwozMxtCmhn9QoXrUUAKUqULPghd+z06pYs9Cm4WWkLzab1ArlVAww'
..'pxPbxBAAAkQwrXX0EKX6ULPgpd+z0upYs9CiMAWkLNj71ADFlAwwrNzNRBPQoUQ8P1HEEKUqULPg9d+z03pYs9CrUbWkIVxL1ARFdAwwoK1wRCSOEmQ4/CdUEKRvpNPgdd+z06pYs9CvZOWkIHs75A41tAwwozMz5Cw7UsQylcmUEK9q9dPtxc+z1npYs9Ch9gWkI+zL5A/YJAwwqamVBCzczMQFyPiMEKX6ULPg1d+z0rpYs9Cm4hWkKzB79ASmFAwwopXExCuJ4aQ+F6YEEKXqULPgGBQz0hI48+Crd1W0Latr1AWnNAwwr2KAzAUrgzQ8P1tkEKYKULPv6AQz0hI48+CvYoDMBSuDNDhetNQQpjpQs+vqASPfQ2Uz4K'
..'VEhaQsXBvkAJdEDDCvYoDMBSuDND7FEIwApfpQs+waASPfQ2Uz4K9igMwFK4M0M9ConBCsl2CT9nA8A9RjJaPgouAVtC32a9QGlOQMMKw/WLQgAAssFI4ZjBCsl2CT9gA8A9TjJaPgqJBltCDnu+QFRTQMMKrkdjQmZmYsG4Hj3BCsl2CT9TA8A9WjJaPgpmZiVCXI8ewaRwCcEKyXYJP0UDwD1uMlo+CgwLW0KUM79AyFlAwwqPwjlBrkexwHE90sAK13YJP3cDwD1ZMlo+CpcAW0K/ub1AdJBAwwrheoFCjwIaw65Hr0EK13YJP3ADwD1fMlo+CjIIW0Jyvr5A74pAwwr2KE9CFC4iw1K4bkEK13YJP2kDwD1pMlo+Co'
..'XrEUJmJifDUrg2QQrXdgk/WwPAPXgyWj4KcQ5bQn9kv0AXhEDDCmZm3kC43izDFK4TQQr4SDc+XKWLPWnUpT4KSrJbQkVVvEAdakDDCvYoDEApXI++mhmBwgrySDc+YqWLPWnUpT4KnMhbQnYhu0B0akDDCvYoDEApXI++KdygwgoKSTc+UKWLPWnUpT4KbYhbQqrjvUCwaUDDCvYoDEApXI++rkcIwgoBSTc+VaWLPWnUpT4K9igMQClcj74pXEHCChJJNz5KpYs9adSlPgprWFtC7pi+QIdpQMMK9igMQClcj764Hn3BCv5INz5cpYs9ZdSlPgoaAFpCFTW+QBFqQMMK9igMwFK4M0NxPUPCCvZINz5ipYs9ZdSlPgov'
..'4FlCOD29QGdqQMMK9igMwFK4M0MpXIHCCg5JNz5PpYs9ZdSlPgrmNVpCxFm/QKdpQMMK9igMwFK4M0PXo5LBCgZJNz5UpYs9ZdSlPgr2KAzAUrgzQ2ZmAsIKFEk3Pkuliz1l1KU+CkBqWkIgoL9AgWlAwwr2KAzAUrgzQwrXo70KkDGqPkkDwD4ReNE9CoC4WUIXqbxA1WFAwwq4HtXA7FGMwhSul8AKkDGqPkgDwD4ReNE9Ch+7WULMubxAk3FAwwofhfvAw/WzwqRwDcAKjzGqPkkDwD4TeNE9CqnFWUKnxrxAQYVAwwqkcAHBrkfjwilcjz8KB2/fPUNhdD0wLIE+Cpy/WkIB5bxAk3xAwwqkcPXA1yOrwgrXM8AKB2'
..'/fPUNhdD0M64I+CiO/WkLzw7xAm2FAwwr2KADBrse8wmZmMkMKQ2F0PcO9SD6+vUg+CtA9WkKWY71AB29AwwofhfvAw/WzwoVruMIKwuziPUNhdD0Xp2s+ChXiWkIOrrxADG9AwwpDYXQ9xRt9PrDjcD4KIjtbQqhLvEAOb0DDCo8xqj5DA8A+EXjRPQoo01tCbGm6QKFxQMMKjzGqPkMDwD4SeNE9CrHJW0JRW7pA511AwwpSuALBFC7TwgrXo7wKkDGqPkMDwD4QeNE9CuvOW0IPfbpAo31AwwqamdnAheuPwsP1kMAKkDGqPkkDwD4VeNE9Cgy1WUKAvbtALGJAwwqQMao+SAPAPhR40T0Kq7dZQjXOu0DqcUDDCo8x'
..'qj5JA8A+FnjRPQo1wllCENu7QJiFQMMKCG/fPUNhdD0wLIE+Cii8WkJq+btA6nxAwwoJb989Q2F0PQzrgj4Kr7taQlzYu0DyYUDDClw6WkL/d7xAXm9AwwrD7OI9Q2F0PRmnaz4Kod5aQnfCu0Bjb0DDCkNhdD3GG30+sONwPgquN1tCEWC7QGVvQMMKtM9bQtV9uUD4cUDDCj3GW0K6b7lAPl5Awwp3y1tCeJG5QPp9QMMhCEhFTFNUQVJYBO4EKQkqCQr2KAzAUrgzQwrX+0AKG9BaQvi0vEBJb0DDAwAAAKCZmak/ClzPMcMpXI8+1yMswwpD4v4+Cq/VPfPvjD4DAAAAAAAA6D8KQ1XlPQjpWj4MXRw+CknEW0LSlb'
..'tAipRAwwrfwltC2D27QKpMQMMKSjaxPgjpWj7oors+Cp/lWkLFYrxAcnNAwwpHVeU9COlaPhBdHD4Kvv1ZQv1/vUCaikDDCqr8WUINPb1A61NAwwpMbgU9aHxQPd3Jpj0K9fhaQiPLvkDnWUDDCkxuBT1nfFA93cmmPQonXFtCemS+QOdZQMMK9igMwFK4M0MzM8NACkxuBT1pfFA93cmmPQo7j1pCgCi/QOxZQMMKyy76PO4u+j3jyaY9Clz2WkIRAL9AgpFAwwrJLvo86y76PeTJpj0K0l5bQnabvkAKk0DDCilcjUGamTLDj8LlQArLLvo87C76PeLJpj0K8o9aQkd5v0Boj0DDCtIu+jztLvo938mmPQoE0ltCVSy+'
..'QP6GQMMKyi76POgu+j3lyaY9CjUoWkJK179Au4xAwwpI4cRBXM8gwx+Fb0EK1ckmPhwcFj7uyaY9CjLBW0I5/71AO0lAwwrPySY+JBwWPuzJpj0KhAxaQiKCv0AnUUDDCtXJJj4RHBY++8mmPQr9q1tCVWO8QHZQQMMK16Mgwq7HGsMUri3DCuHJJj4uHBY+08mmPQqa2VlCySXAQPZWQMMKj8KVwRSu8kKF6yjDCuHJJj4kHBY+3MmmPQp2+VlCri++QBFgQMMKH4Uswmbm5ULNjCXDCtnJJj4iHBY+5smmPQoNCVpC+RS+QDpcQMMKXI83wo/CA0MAwCjDCtvJJj4jHBY+4smmPQpC2FtCt2y+QDZNQMMK1ckmPiUcFj'
..'7myaY9CtmQW0J93bxA+4tAwwrQySY+GBwWPvjJpj0K+ZdbQndzvEAmTkDDCszFW0Jmd75A1EdAwwrVySY+LhwWPuHJpj0KUKhbQrv6vkB4lEDDCtDJJj4mHBY+6MmmPQoDqVtCxo6+QKREQMMKuB5dwcM1J8Ouxy3DCtnJJj4oHBY+38mmPQqk81lCIY6/QF5TQMMKw/X4wdcjB0O43irDCt/JJj4jHBY+48mmPQou0VtCUEm+QHmLQMMKuB7ZwXsUVsKkcC5DCtvJJj4bHBY+7MmmPQoi0ltCmvW9QE1OQMMKw/XUwUghBMPD9TDDCtXJJj4qHBY+4smmPQrto1tCQoG+QCOTQMMKSOG2wYXri8EKFytDCtnJJj4rHBY+'
..'3cmmPQqD71lC6P6/QGRRQMMK0MkmPiEcFj7uyaY9CsqlW0J3Fb5ALkZAwwrfySY+KBwWPt/Jpj0KOthbQn2/vkBGjEDDCh+FicG4HlrCe9QuQwrbySY+HhwWPu3Jpj0KZaBbQkrKvEAZi0DDCpqZIcJcjw3Cj0IrQwrcySY+JRwWPuTJpj0Kg7xbQuNivkDlkEDDCmZmzMFcjxfCSKEsQwrbySY+DBwWPvjJpj0Ks7RbQmRfvEDZU0DDCtzJJj4qHBY+38mmPQqVwltCSNq+QPmRQMMKhet5wUjhHMKaGS1DCs/JJj4oHBY+58mmPQoXClpCVvG/QO5OQMMKUri6wY8CHkPhOjDDCuHJJj4rHBY+1smmPQq53llCGLO/QK'
..'pYQMMK38kmPhccFj7xyaY9CsyvW0I7t7xAKodAwwpxPSjCKVxOwgpXLUMK3ckmPjMcFj7OyaY9Ctj2WUIPXL5A/XtAwwrNzCXCzcxwQs1MLEMK18kmPjocFj7OyaY9CkjqWULF2r9AwYdAwwqPwuHBH4UTQqRwMEMK3ckmPjscFj7EyaY9CkfWWUIBZ8BAr4NAwwrD9YTBcT1jQuH6LUMK3ckmPjwcFj7IyaY9CpHbWUJp8L9ATYJAwwrQySY+OhwWPtTJpj0KygFaQsNFwEBqjUDDCuxRlsGuR6VBzQwzQwrXySY+OhwWPs/Jpj0KY+ZZQh1QwEB8iUDDCoXrkcGF6xBCM7MwQwrQySY+OBwWPtXJpj0KXgRaQtbQv0CD'
..'i0DDCuxR5sFSuKZB4foyQwpOA3Y+MRwWPtzJpj0KODZaQn5AvkDUhUDDCrgeL8IUrqlBj8IyQwppY4Q+HhwWPvTJpj0Kl0ZaQsn5vUARV0DDCnsUQcK4nhtDzcwuwwrXySY+NRwWPtPJpj0KE/5ZQh5NvkCPf0DDClK4LMJcjxhCM7MvQwrMySY+RoFpPVT1qj4KspJbQq6cvECoaEDDCvYoDEBmZoa/mtkrwwrPySY+QoFpPVT1qj4K9igMQGZmhr9mJjJDCt3JJj7nIC89iUR8PgplLFpCWkO+QAlpQMMK9igMQGZmhr9mJiNDCu3JJj7VIC89iUR8Pgr2KAxAZmaGv2YmFEMKrS4kP45V5T3XTYI+CnoRW0KxE75ANp'
..'VAwwr2qIzCCpcfQ3vUGsMKrS4kP5NV5T3UTYI+CuIMW0Klx7xAWo9Awwo9CmbCClcqQ82MJMMKrS4kP6FV5T3NTYI+CgrXKMIU7i9DKdwowwqtLiQ/v1XlPbxNgj4KsApbQovnu0Cmh0DDCnsUSsHXYzLD7JErwwqzLiQ/ulXlPdlNgj4KbglbQna1vUBaRkDDCgCAhsI9Cs9AAMAlQwqzLiQ/ylXlPdBNgj4KsQhbQtV1vEDzTEDDCtejV8KF61E/M7MqQwqzLiQ/3VXlPcZNgj4Ksy4kP+lV5T2+TYI+Cg0KW0LZprtAHlVAwwr+6Fo+98mmPbYPxj4KquZbQjeivUBoc0DDCvYoDMAz8zJDhSsCQwoY6Vo+5smmPbYP'
..'xj4KFwxcQqvPvkDgckDDCvYoDMAz8zJDe5TkQgri6Fo+D8qmPbYPxj4KPadbQoI7vEAgdEDDCvYoDMAz8zJD16MgQwrq6Fo+CMqmPbYPxj4K9igMwDPzMkNIYRJDCuPoWj4QyqY9tg/GPgrsaFtCi967QIZ0QMMK9igMwDPzMkPX4zJDCjTpWj7VyaY9uA/GPgrx3llCDJW/QDR1QMMK9igMQGZmhr/D9ehCCjrpWj7RyaY9uA/GPgpxw1lC0QDBQOV0QMMK9igMQGZmhr8zM8lCCg7pWj7xyaY9uA/GPgoEElpCccC9QId1QMMK9igMQGZmhr8z8xJDCiLpWj7hyaY9uA/GPgr2KAxAZmaGv6SwBEMK9OhaPgXKpj24D8'
..'Y+CtZLWkIs8LxAgnVAwwr2KAxAZmaGvzMzJUMKD0bLPtNV5T67Lvo9CsKbWUIvDMJARX9AwwqPwuXAj0Ldwo/CM8MKCEbLPtNV5T7ALvo9CiWdWUKN8sFAdmxAwwpI4drAe5S1ws3MMUMK/0XLPtNV5T7OLvo9CpOnWUIpysFA61RAwwpObgU+zfCRPYJHmj4KtMdaQtJIv0BSXkDDChSu38BIYb7Ce1QyQwpMbgU+zfCRPTpdnD4KI8paQh5wv0CGfkDDCs3M1MCux6zCexQuwArN8JE9NcJvPibCbz4K1y1aQmbxv0AEb0DDCkjh2sB7lLXCmpmvQgoGhAc+zfCRPU+6jD4KefJaQqk0v0BWbkDDCs3wkT3zJpc+49qP'
..'PgoRXVtCWM6+QPhtQMMKB0bLPspV5T6/Lvo9CsoeXEKzir9AP2pAwwoCRss+zVXlPsgu+j0KpxVcQu2xv0DXgUDDCuxRwMAAgJbCzQwwQwoMRss+zVXlPrku+j0KYRhcQlB+v0DsW0DDCo/C5cDXo9nC4fozwwoLRss+01XlPrsu+j0KrKBZQrokw0DYfkDDCgRGyz7TVeU+wC76PQoPollCGAvDQAlsQMMK/UXLPtNV5T7NLvo9Cn2sWUK04sJAflRAwwqezFpCXWHAQOVdQMMKS24FPs3wkT06XZw+Cg3PWkKpiMBAGX5AwwrN8JE9NMJvPibCbz4KwTJaQvEJwUCXbkDDCgWEBz7N8JE9T7qMPgpj91pCNE3AQOltQM'
..'MKzfCRPfImlz7j2o8+CvthW0Lj5r9Ai21AwwoERss+ylXlPr8u+j0KtCNcQj6jwEDSaUDDCv9Fyz7NVeU+yC76PQqRGlxCeMrAQGqBQMMKCkbLPs1V5T64Lvo9CksdXELblsBAf1tAwwrKLvo86y76PeXJpj0KK/FaQoesvkDQSkDDCo/C0UG4Hh3BCtcpQwrKLvo86y76PeTJpj0KRYtaQrQ0v0B6TUDDCssu+jzpLvo95MmmPQpHWVtCzD++QKdHQMMKyy76POwu+j3lyaY9ChAkWkJsoL9AoFBAwwpmZsBBSOGkwQBAJUMK0S76PPEu+j3cyaY9CsnZW0I3AL5AsVFAwwrOLvo86C76Pd7Jpj0KhupaQqBxvUAYS0DD'
..'Co/CkcFmZibApDAuQwrLLvo85S76Pd/Jpj0KqlJbQvD+vEA2SUDDCsP1jMFcjyJAcb0rQwrOLvo85i76Pd3Jpj0KvINaQivMvUCKTUDDCs8u+jzkLvo938mmPQo6xltCLX+8QN5UQMMKZmZewc3MVEIfhSlDCs4u+jziLvo938mmPQqPHFpCpUO+QJFQQMMKz8kmPhccFj7vyaY9Cp26W0JTxrxArpJAwwrNySY+HhwWPurJpj0KlwdaQtnHvkA6jEDDCpqZFkJmZj5BZmZSwQrPySY+DBwWPvvJpj0KzLJbQpGAvkCFi0DDCuDJJj4oHBY+z8mmPQra0FlCl5G+QJeGQMMK4MkmPh8cFj7XyaY9Ch//WUKEN8BAYH1Aww'
..'rZySY+HhwWPuLJpj0KPw9aQkYxwEApgUDDCtfJJj4fHBY+4smmPQo8zVtCAi68QJ6OQMMK1MkmPiMcFj7gyaY9CpGRW0LuR75AGVBAwwrhegNCH0Ucw3sU1kAKzckmPhIcFj74yaY9CgyfW0Jdmb5A5o1AwwrPySY+HxwWPubJpj0KUrtbQphIvEAQlEDDCtTJJj4qHBY+3smmPQqklltCrQ28QIdHQMMK9igAQbgeH8OkcLVACs3JJj4hHBY+6MmmPQronltCGmy8QFmXQMMKFK4fQVyPhMHNzATBCtnJJj4iHBY+3MmmPQoJ71lCAe++QBiKQMMK3skmPh0cFj7fyaY9CkTEW0JQZbxAZFBAwwrXySY+FRwWPuzJpj0K'
..'CMtbQsitvECNjUDDCgAAdEEAAFHCKVzfwArUySY+JxwWPt/Jpj0KU5ZbQvCLvEDgSEDDCtnJJj4lHBY+2cmmPQqQ51lCGIq+QBWMQMMKzckmPhscFj7uyaY9Co+fW0Il6LxA0pVAwwreySY+IhwWPtrJpj0KS8dbQsfku0CQT0DDCtrJJj4aHBY+58mmPQpDoVtC0zq+QO1QQMMK2skmPiAcFj7gyaY9Ci+vW0Iid7xACUtAwwofhYFBH4UKw5qZmUAK18kmPgccFj74yaY9Ciy7W0IMc75AGohAwwraySY+JRwWPtvJpj0KNbFbQnH3u0DwSUDDCs3JJj4jHBY+5cmmPQrUAVpC+mC+QHWOQMMKPQrfQSlcZ0H2KDzBCu'
..'DJJj4lHBY+0smmPQpb2VlCTva+QN6EQMMKj8IjQrgeWkIK1xNACt7JJj4RHBY+68mmPQr3sFtCjy2+QM5UQMMK2ckmPjMcFj7IyaY9Crr5WULoFMBAeGFAwwrTySY+ORwWPsrJpj0K0uBZQoK9vkC+VUDDCtnJJj44HBY+wsmmPQo8yVlCD16+QOJZQMMK2ckmPjocFj7DyaY9Ci/SWULhxb5AP1tAwwrLySY+NhwWPtLJpj0K3fNZQuMmvkABUEDDCtPJJj42HBY+zMmmPQo92VlCG1S+QAdUQMMKy8kmPjccFj7RyaY9Civ6WUKJkr5A5lFAwwpHA3Y+MRwWPtbJpj0KYjdaQuevv0BqV0DDCjMzPkIzsyxDKVyZQQpn'
..'Y4Q+GBwWPvDJpj0K5UtaQgbOv0AehkDDCtPJJj40HBY+zsmmPQoCAVpCDhXAQN9dQMMKKVxMQrieGkPXo2BBCsfJJj4+gWk9TvWqPgpBl1tCEX++QGpzQMMKzMkmPjiBaT1O9ao+CtvJJj7bIC89fkR8PgpKL1pCAL6/QD10QMMK7ckmPsggLz1+RHw+CqsuJD+EVeU9002CPgoODFtCkx++QExHQMMKw/WLQnsUssHD9ZjBCqsuJD+JVeU90E2CPgp1EltCcGm/QCxNQMMKqy4kP5dV5T3ITYI+CmZmJUJSuB7BpHAJwQqrLiQ/tFXlPbZNgj4K2RdbQtRFwEDhVEDDCrUuJD+uVeU9002CPgpfC1tCmIK+QC6WQMMKtS'
..'4kP71V5T3JTYI+CnUUW0L1ub9Alo9Awwq1LiQ/0lXlPb5Ngj4KhesRQmYmJ8NI4TZBCrUuJD/eVeU9t02CPgrqG1tCSIDAQGqHQMMKZmbeQEjhLMMK1xNBCvPoWj74yaY9rQ/GPgqZ31tCudi8QGNoQMMKCulaPufJpj2tD8Y+CkH6W0ITabtAy2hAwwrb6Fo+DMqmPa0Pxj4Kmq1bQpO0vkDhZ0DDCvYoDEApXI++7FEIwgrg6Fo+B8qmPa0Pxj4K4OhaPgnKpj2tD8Y+CkN0W0IYjb9AsWdAwwov6Vo+0MmmPbEPxj4KBtlZQv8Vv0BWaEDDCjDpWj7QyaY9sQ/GPgrmsllC9+29QL1oQMMKD+laPufJpj2xD8Y+CkcZ'
..'WkKLc8BA12dAwwoh6Vo+2cmmPbEPxj4K9igMwFK4M0MpXALCCvfoWj77yaY9sQ/GPgrPV1pCjsfAQKpnQMMKBEbLPshV5T66Lvo9Cn+DWUIPPb1AgF5Awwr+Rcs+x1XlPsAu+j0KoYZZQgVRvUBOcUDDCvhFyz7IVeU+yS76PQo5k1lCYWC9QM+IQMMKSG4FPsXwkT2BR5o+CsC9WkKFhL1AcH5AwwqPwvXA1yOrwgrXM8AKRm4FPsXwkT05XZw+Ci69WkIGXb1AO15AwwrF8JE9KcJvPiTCbz4KuiJaQsEbvkBDbkDDCv+DBz7F8JE9TbqMPgrs5lpC3kK9QEduQMMKxfCRPeomlz7h2o8+CkdRW0JNzbxASm5Awwr5Rc'
..'s+ulXlPr0u+j0K2gZcQkSNukBdcUDDCvVFyz69VeU+wy76PQqK+1tCany6QM1ZQMMK/kXLPr1V5T64Lvo9CsoBXEK6pLpAtX9Awwpff1lCriO8QOleQMMKgYJZQqQ3vEC3cUDDChmPWUIAR7xAOIlAwwqguVpCJGu8QNl+QMMKRm4FPsXwkT04XZw+Cg65WkKlQ7xApF5AwwrF8JE9KcJvPiLCbz4Kmh5aQmACvUCsbkDDCv+DBz7F8JE9TLqMPgrM4lpCfSm8QLBuQMMKJ01bQuyzu0CzbkDDCvlFyz66VeU+uy76PQq6AlxC43O5QMZxQMMK9UXLPr1V5T7BLvo9Cmr3W0IJY7lANlpAwwr+Rcs+vVXlPrcu+j0Kqv1b'
..'QlmLuUAegEDDCssu+jzmLvo938mmPQrV61pCYsW9QM2RQMMKzS76POgu+j3fyaY9CtOEWkLpEL5Ae49AwwrLLvo84i76Pd3Jpj0KI1RbQsRavUCdlEDDCqRw18Fx/S9DrkcNQQrMLvo85y76Pd/Jpj0KbB1aQq56vkCtjEDDCgrX4cFIISfD7FF4PwrJLvo86S76Pd7Jpj0K69FbQleUvEAkikDDCh+Fy8B7FARDUrjGQAp7zQI98GBMPdiAoz0KB/haQku4vkBcWkDDCkVZW0KnU75AXFpAwwp8zQI98GBMPdiAoz0KYpBaQtETv0BgWkDDCkRB9Tw0QfU92oCjPQp79VpCLey+QN+QQMMKREH1PDNB9T3bgKM9CuJbW0'
..'KNib5AXpJAwwpFQfU8NEH1PdqAoz0KFZFaQgBjv0DPjkDDCklB9Tw1QfU914CjPQrPzFtCnRy+QJCGQMMKQ0H1PDlB9T3WgKM9CmMrWkIpv79AL4xAwwrQgCM+EycTPuaAoz0KVLxbQmTwvUAESkDDCsWAIz4hJxM+4YCjPQpAEFpCrmu/QMhRQMMK0IAjPgonEz7wgKM9ComnW0KdXLxAGlFAwwrWgCM+KicTPsmAoz0KV95ZQhwMwEB5V0DDCtaAIz4sJxM+x4CjPQqR/VlC5R++QGdgQMMKz4AjPignEz7TgKM9CtoMWkK3Bb5Ao1xAwwrVgCM+HCcTPtqAoz0K79JbQrpbvkDrTUDDCs2AIz4uJxM+z4CjPQrujFtC'
..'XtS8QHOLQMMKzIAjPhEnEz7tgKM9CuuTW0JubLxA1k5AwwrQgCM+HScTPtyAoz0K1sBbQjJmvkCkSEDDCs2AIz4rJxM+1YCjPQrvo1tC8+a+QMaTQMMKzIAjPh4nEz7egKM9Cp+kW0Idfb5AhEVAwwrd91lCcXe/QPRTQMMK0oAjPiEnEz7ZgKM9Cv/LW0IGOb5A84pAwwrVgCM+EicTPuSAoz0K7sxbQvXmvUD8TkDDCs2AIz4sJxM+0YCjPQqin1tC3W++QHeSQMMKz4AjPiYnEz7VgKM9CtHzWUL/5b9ABFJAwwrMgCM+GCcTPuWAoz0KdqFbQjEGvkAGR0DDCtKAIz4jJxM+2YCjPQro0ltC36y+QLyLQMMK0IAjPi'
..'UnEz7YgKM9CiycW0KMwbxAlYpAwwq8t1tCGFK+QESQQMMK1YAjPgYnEz7ugKM9ChSwW0LAWLxAbVRAwwrQgCM+JicTPtaAoz0Kr71bQiLHvkBTkUDDCsWAIz4jJxM+34CjPQrfDVpCsti/QJpPQMMK1oAjPisnEz7JgKM9ClzjWUKtm79AJVlAwwrSgCM+GycTPt+Aoz0KRatbQtyuvEC7hkDDCtWAIz5CJxM+rYCjPQoA+1lCZ0u+QMV7QMMK0oAjPkMnEz6ygKM9CrDuWUKTwr9AT4dAwwrVgCM+PicTPrCAoz0KFNtZQgxMwEBRg0DDCtWAIz5DJxM+r4CjPQpD4FlCyte/QPaBQMMKyoAjPj0nEz69gKM9CrwFWkJ2'
..'K8BA24xAwwrSgCM+PScTPrmAoz0K3+pZQpw1wEABiUDDCsqAIz5AJxM+uoCjPQpDCFpC17i/QP6KQMMKzCpxPj8nEz66gKM9CiE5WkJhML5Aa4VAwwrWx4E+IScTPuKAoz0KLUlaQhDrvUCUV0DDChcCWkLCPL5ARn9AwwrBgCM+pudkPUmXpz4KvY5bQtWUvEDSaEDDCsiAIz6d52Q9SZenPgrTgCM+qq0rPXxMdz4Kfy9aQi0zvkAxaUDDCt6AIz6erSs9fEx3PgrO8iA/IdHgPWZ5fz4KERBbQnQEvkB/lEDDCs7yID8c0eA9bHl/PgqQC1tC8768QMGOQMMKzvIgPxrR4D1seX8+Cs7yID8l0eA9Xnl/PgppCVtCQ+'
..'O7QDSHQMMK1vIgP0/R4D1leX8+Ci0IW0IVqL1AMUdAwwrW8iA/U9HgPVx5fz4KdAdbQr9uvECpTUDDCtbyID9V0eA9W3l/PgrW8iA/TdHgPWV5fz4KyAhbQteju0CqVUDDCgOZVj7ogKM9BCnCPgoN4VtCNpW9QFtzQMMKEZlWPt6Aoz0EKcI+Cr4FXEK6vL5A1nJAwwoAmVY+7YCjPQQpwj4K36JbQpM1vEAQdEDDCv2YVj7ugKM9BCnCPgoLmVY+5ICjPQQpwj4KyWVbQnDau0B0dEDDCjiZVj7FgKM9BCnCPgqQ41lCOH6/QB91QMMKM5lWPsqAoz0EKcI+CpvIWULT4sBA0XRAwwosmVY+zYCjPQQpwj4KohVaQtiy'
..'vUBwdUDDCjSZVj7GgKM9BCnCPgodmVY+24CjPQQpwj4KUE5aQq7mvEBsdUDDChJFxz410eA+M0H1PQq2oVlC7OjBQPx+QMMKC0XHPjPR4D45QfU9ChGjWULLz8FAjGxAwwoCRcc+NdHgPkhB9T0KS61ZQjOowUB4VUDDCn7NAj7EEI89jz2XPgq/x1pCfjO/QLBeQMMKfM0CPsQQjz3HSJk+CiLKWkIEWr9AQX5AwwrEEI89PwlrPi8Jaz4K6zBaQsDYv0ANb0DDCrPYBD7EEI89sfSJPgqt8VpCux+/QGNuQMMKxBCPPccslD6CBY0+CitaW0Juu75ABm5AwwoGRcc+KtHgPjhB9T0KExhcQhN0v0BgakDDCgBFxz4u0e'
..'A+QUH1PQoeD1xCh5q/QIGBQMMKC0XHPi7R4D4yQfU9CsoRXELvZ79AVlxAwwoSRcc+NdHgPjBB9T0Kh6ZZQvH7wkCSfkDDCgtFxz4z0eA+NUH1PQrip1lC0OLCQCJsQMMKAUXHPjXR4D5FQfU9ChyyWUI4u8JADlVAwwp/zQI+xBCPPY49lz4KkMxaQoNGwEBGXkDDCn3NAj7EEI89xkiZPgrzzlpCCW3AQNd9QMMKxBCPPUEJaz4uCWs+Crw1WkLF68BAo25Awwqz2AQ+xBCPPbD0iT4KfvZaQsAywED5bUDDCsQQjz3ILJQ+gQWNPgr8XltCc86/QJxtQMMKCEXHPirR4D43QfU9CuQcXEIYh8BA9mlAwwoCRcc+LtHg'
..'Pj9B9T0K7xNcQoytwEAXgUDDCg5Fxz4u0eA+L0H1PQqbFlxC9HrAQOxbQMMKQEH1PDZB9T3agKM9CmTwWkJJmr5AkUtAwwpFQfU8NUH1PdmAoz0KgIxaQsYfv0AtTkDDCkRB9Tw1QfU92YCjPQpzVltCsS++QHdIQMMKQEH1PDdB9T3agKM9ClMnWkJgib9ARFFAwwpKQfU8NEH1PdiAoz0KbdRbQl3xvUBPUkDDCkRB9TwrQfU91YCjPQrh6VpClmW9QNdLQMMKQ0H1PClB9T3WgKM9CvhPW0Ip9bxA/0lAwwpFQfU8K0H1PdWAoz0KHoVaQli+vUA9TkDDCkZB9TwpQfU91YCjPQpBwVtC6Xe8QGxVQMMKQUH1PC5B9T'
..'3RgKM9CvkfWkJ4M75ANFFAwwrOgCM+DScTPuOAoz0K37VbQqm9vEAEkkDDCsOAIz4bJxM+34CjPQprC1pCEbW+QLCLQMMKzoAjPgQnEz7ugKM9CjauW0Iyb75A/4pAwwrTgCM+JCcTPseAoz0KwtVZQuF/vkAqhkDDCtOAIz4nJxM+w4CjPQoeA1pCfh3AQCJ9QMMKzIAjPiQnEz7OgKM9Cu0SWkJfF8BA2IBAwwrTgCM+FCcTPteAoz0KIMhbQlkovEAJjkDDCsqAIz4rJxM+yYCjPQqjjVtCqze+QL9QQMMKyoAjPgwnEz7rgKM9CtqaW0KAh75AVI1AwwrOgCM+FicTPtmAoz0KkbZbQmlCvEBfk0DDCsqAIz4lJxM+'
..'0oCjPQqckltCpgi8QFhIQMMKyoAjPhgnEz7cgKM9CraaW0I4ZbxAmJZAwwrMgCM+IicTPtGAoz0KWfNZQnTbvkCaiUDDCs+AIz4cJxM+14CjPQpWv1tCj168QAhRQMMK04AjPgwnEz7hgKM9CvjFW0KapbxA/YxAwwrKgCM+JycTPs6Aoz0KTZJbQmyEvECqSUDDCsyAIz4hJxM+04CjPQoG7FlCiHi+QI2LQMMKyoAjPhMnEz7jgKM9ClqbW0LR3rxAGJVAwwrPgCM+HicTPteAoz0KTcJbQo7gu0A5UEDDCsyAIz4iJxM+1ICjPQoFnVtC0iq+QI9RQMMKzYAjPiAnEz7VgKM9CquqW0IHcLxAyUtAwwrTgCM+ACcTPu'
..'uAoz0Ka7ZbQvFhvkClh0DDCs2AIz4gJxM+1ICjPQqnrFtC2vK7QLVKQMMKw4AjPh0nEz7dgKM9CsUFWkI6UL5A4I1AwwrTgCM+JScTPsaAoz0KGN5ZQpzivkB6hEDDCs+AIz4YJxM+24CjPQprrFtC0R2+QF1VQMMK04AjPj4nEz6ngKM9CtT9WUKQ+79AxmFAwwrRgCM+PycTPq2Aoz0KaeVZQu6qvkBIVkDDCtOAIz45JxM+q4CjPQpLzllCXE2+QFdaQMMK04AjPkAnEz6qgKM9ChHXWUIis75ArFtAwwrIgCM+OCcTPrqAoz0KFfhZQkYXvkCoUEDDCtGAIz44JxM+tICjPQr73VlCmkO+QJlUQMMKyIAjPj0nEz61'
..'gKM9CkP+WULOgL5Ag1JAwwrKKnE+PCcTPrOAoz0KRTpaQoyYv0DrV0DDCtPHgT4cJxM+34CjPQphTlpCFLa/QLOFQMMK0YAjPkAnEz6rgKM9CvcEWkK1+79AP15Awwq/gCM+m+dkPUOXpz4KNZNbQrhtvkBec0DDCsWAIz6S52Q9Q5enPgrTgCM+oK0rPXVMdz4KVjJaQl+mv0AudEDDCt6AIz6UrSs9dUx3PgrM8iA/F9HgPVV5fz4KwQpbQhwQvkAfSEDDCszyID8Q0eA9XHl/PgoHEVtCelO/QOFNQMMKzPIgPw7R4D1feX8+CszyID8Y0eA9VXl/PgpQFltChivAQHBVQMMK1vIgP0bR4D1aeX8+ChYKW0Iucb5Acp'
..'VAwwrW8iA/StHgPVR5fz4K/hJbQmmiv0D7jkDDCtbyID9L0eA9Unl/PgrW8iA/QtHgPV55fz4KTRpbQtNkwED4hkDDCvqYVj7ngKM9+ijCPgog2ltCs8+8QI5oQMMKBplWPt6Aoz36KMI+CkL0W0JLZ7tA9GhAwwr8mFY+54CjPfoowj4KHalbQiyivkAOaEDDCvaYVj7qgKM9+ijCPgoKmVY+3YCjPfoowj4K6HBbQm52v0DfZ0DDCjeZVj7BgKM9+ijCPgrF3VlCrgG/QIJoQMMKLplWPsiAoz36KMI+Cma4WUJ7371A52hAwwovmVY+xYCjPfoowj4KwhxaQldYwEAGaEDDCjaZVj7AgKM9+ijCPgohmVY+0oCjPfoo'
..'wj4KD1paQrOqwEDZZ0DDCghFxz4o0eA+MkH1PQruiVlCDzK9QN1eQMMKAkXHPifR4D45QfU9CgCNWUKhRb1AS3FAwwr8RMc+KNHgPkRB9T0KWZlZQq9UvUBWiEDDCnvNAj68EI89jz2XPgr+vVpCHHi9QCx+QMMKeM0CPrwQjz3FSJk+Cm+9WkJlUb1AmV5Awwq8EI89NglrPiwJaz4KBSZaQl4MvkBQbkDDCq7YBD68EI89sPSJPgpb5lpCwDe9QFVuQMMKvBCPPcEslD6ABY0+Cp1OW0KAxLxAV25AwwoCRcc+INHgPjRB9T0KnABcQtGPukBbcUDDCvxExz4j0eA+O0H1PQqG9VtCTH+6QEJaQMMKBUXHPiPR4D4vQf'
..'U9Cqf7W0LQprpAan9AwwoGRcc+KNHgPjJB9T0K44VZQjkevEBDX0DDCgBFxz4n0eA+OUH1PQr1iFlCyzG8QLFxQMMK+UTHPijR4D5BQfU9Ck6VWULZQLxAvIhAwwp6zQI+vBCPPY89lz4K87laQkZkvECSfkDDCnfNAj68EI89xUiZPgpkuVpCjz28QP9eQMMKvBCPPTUJaz4sCWs+CvohWkKI+LxAtm5Awwqt2AQ+vBCPPbD0iT4KUOJaQuojvEC7bkDDCrwQjz2/LJQ+gAWNPgqSSltCqrC7QL1uQMMK/kTHPiDR4D40QfU9CpH8W0L7e7lAwXFAwwr6RMc+I9HgPjtB9T0Ke/FbQnZruUCoWkDDCgRFxz4j0eA+L0H1'
..'PQqc91tC+pK5QNB/QMMKQ0H1PC1B9T3UgKM9CirrWkKyt71AJ5FAwwpEQfU8LUH1PdOAoz0KL4ZaQrwBvkDhjkDDCkNB9TwqQfU90oCjPQpqUVtCLU+9QOmTQMMKQUH1PC5B9T3TgKM9CtIgWkJrab5AIoxAwwpDQfU8KEH1PdeAoz0Kt8xbQqqMvECliUDDIQRMZWcxBCsJEgkTCSEgTWVzaGVzL3JhcHRvciBzdHVmZl9DeWxpbmRlci4wMDAEBwgSCRMJCtXEWUIxusY/EeU/wwrx9Zk/3RmCP4pohz8hF3JieGFzc2V0aWQ6Ly8zNzQzOTM5NzE2Cta060IMALxCcL/SQiEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2'
..'Fzc2V0Lz9pZD0zNzg2ODQwMzU4BA0IFAkVCQrdEFpCWNysP0TtP8MKAACAPwAAAEAAAIA/IQRMZWcyBCwJEgkTCQQSCBIJEwkKa7pZQh+6xj+o50DDBBQIFAkVCQqeBlpCRtysP0ntQMMhBUNoZXN0BC0JDwkQCSEcTWVzaGVzL3JhcHRvciBzdHVmZl9DdWJlLjAxMgQaCC4JLwkKAAAAAI+CMsOPwvW8Co09XUJ7QkdAPdVAwwoAADRDUri+v1L4M0MKckFcPlBaLj8sSBg/IRdyYnhhc3NldGlkOi8vMzc0MzkzNDczNQqACLxBgNiUQvcAgkIhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MzgyMTg2'
..'OTcwOQQhCBQJFQkKc+lZQhm0UUCeRj/DIQpBTiBQUkMgMTUyBCUIMAkTCQoAAAAAhWszw4/C9bwKWM5cQvdRaUDIxT/DCgAANEPhehS/UvgzQwpiFD8+IdfjP1F9sz4hF3JieGFzc2V0aWQ6Ly8yMzE2NDg0NjI3CmyZNUGIotxCQXOvQSEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0zODA2NTE5NTgwIRxNZXNoZXMvcmFwdG9yIHN0dWZmX0N1YmUuMDI4BC0IDwkQCQqxEVpCndBkQC9rQMMK+6KtP8gf4T+7lgRAIRdyYnhhc3NldGlkOi8vMzc0MzkzNzg1NAq6bwVD4wAtQ5jIS0MhKmh0dHA6Ly'
..'93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9Mzc5NjcwOTU3OSEUTWVzaGVzL3Jlc3RfQ3ViZS4wMDkENQgxCTIJClK4PkGF61HASOF2wQr16ldCwOSHQAn2P8MKSOE+QaRwTcAAAGzBCqDY/T3NfdI+xyWFPiEXcmJ4YXNzZXRpZDovLzM3NDQxNjI0MzIKyLSEQRAVXELgNgtCISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTM3OTY3NDA2NjkhBVNvdW5kIQ5Qb2xpY2UgY2hhdHRlciEGTG9vcGVkIQtSb2xsT2ZmTW9kZSEHU291bmRJZCEWcmJ4YXNzZXRpZDovLzUyNDQ0OTg4NiEGVm9sdW1lAwAA'
..'AAAAACRAIRRNZXNoZXMvcmVzdF9DdWJlLjAxMQRFCBIJEwkKLndXQo1zfEAJ0UDDChwaBD7HUuk+sxg7PiEXcmJ4YXNzZXRpZDovLzM3NDQxNjEzODAKnUtNQdBMNUJgYZFBISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTM4MTQxNzYzNzkETggWCRUJBhQUFCEYQ3VzdG9tUGh5c2ljYWxQcm9wZXJ0aWVzEArXIzzNzEw+AAAAPwAAgD8AAIA/Cs1yXELLVHBASmpAwwrdHoE/tON3PjP03z0hCUJsb2NrTWVzaAoAAIA/AACAP87MTD4hClN1cmZhY2VHdWkhCkNhbnZhc1NpemULAACvQwAAyEIhDk'
..'xpZ2h0SW5mbHVlbmNlIQlUZXh0TGFiZWwhEEJhY2tncm91bmRDb2xvcjMG////IRZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5DAAAgD8AAAAAgD8AACEERm9udAMAAAAAAAAmQCEEVGV4dCEJU0VDVVJJVFkgIQpUZXh0Q29sb3IzIQpUZXh0U2NhbGVkIQhUZXh0U2l6ZQMAAAAAAABOQCEQVGV4dFRyYW5zcGFyZW5jeSELVGV4dFdyYXBwZWQhCWR1bXBwb3VjaARoCDMJNAkKZmaGv0jhAEI9Ctc+CnniXEJ9wwdAS4w/wwpSuJ6/CtcAQnE9ij8K/Es7PxgDkj/eK1g/IRdyYnhhc3NldGlkOi8vMzMyNzg0NzY5MArD'
..'P4BCsvXHQkkFlEIhF3JieGFzc2V0aWQ6Ly8zMzI3ODQ4NjgyIRNwb3J0YWdyYW5hZGFfYWJlcnRvBHEINQk2CQrNzEw9MzOTP0jh2r8KwgxdQiuccEBRzEDDCkkmSD5/Hc0+wNFWPiEXcmJ4YXNzZXRpZDovLzMzMjczNTU3NDUKcJC3QU4ePEK1BMVBIRdyYnhhc3NldGlkOi8vMzMyNzM2MjUzMAR4CBIJEwkhEENvbGxpc2lvbkdyb3VwSWQKjHJcQstUcEBqakDDCgpb+z31H5s+GYGKPwqxjzQ/AACAPwAAgD8EfAgSCRMJCvN4V0KOc3xAMZ9AwyEEVmVzdASACDcJOAkKCtcjvPZoMsOPwvW8Csz+XEKxPUlAQj'
..'5Awwpx/TPDH4XLv1L4M0MKtN44PlmP2T6xPgg/IRdyYnhhc3NldGlkOi8vMzc0MzkzMTAzMwoIWqhByFluQqB0YkIhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MzgyMDM5MDczOQSHCBQJFQkKugpaQvpuVkBDbUDDCgAAAEAAAABAAACAPyEcTWVzaGVzL3JhcHRvciBzdHVmZl9DdWJlLjAxNQSLCDAJEwkKTeZcQovbVEDQxD/DCs5Anj6BWJ0/3HLmPiEXcmJ4YXNzZXRpZDovLzM3NDM5MzY4OTkKaBrVQTwAm0IcKRtCISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTM4MTQ2Njkz'
..'NTkhCkFQWC0xMDAwIDEEkwg5CToJCo/CNb+Pwt1B7FF4vwpnZ1dCPm9cQH2eP8MKKVxPv4/C3UE9Che/CmaKIz7eAZs/KFSQPiEXcmJ4YXNzZXRpZDovLzIyNjk5NTgwNjEKqOKPQJhgCELw9v1AIRdyYnhhc3NldGlkOi8vMjI2OTk1ODc0MyELQVBYLTEwMDAgMiAEnAg7CTwJCuxReL/2KHnCj8I1PwpAVldC8EtIQGOVP8MKj8IFwLgeecKF65G/CiXapj7QFCw/zrZwPiEXcmJ4YXNzZXRpZDovLzM4MDYwMjIwMjQK4MVxQKRZ+UCAZi5AISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTM3OTcyND'
..'k2NTYhBE1hZ3MEpQg9CT4JCgrXI7wK16M+j8L1PAqgPFdCRItQQJhwQMMKSyMiPmxlgT9zF54/IRdyYnhhc3NldGlkOi8vMzc0MzkzNDQ0MAr03mpBEHG7QnYC5UIhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MzgyMTA0MDM4NiEIQ2ludG8gTkEErQg/CUAJCgAAAADhepS+CtcjPQok+FlChdIiQBtkQMMKsXqQP+aQmT7F/AVAIRdyYnhhc3NldGlkOi8vMzA4MzQyNjU0NAqMp+BCoMjuQcSpS0MhF3JieGFzc2V0aWQ6Ly8zMDgzNDI5OTk4BLMIEgkTCQrpfFdCj3N8QHc9QMMEtQgSCRMJCiR7'
..'V0KPc3xAUG9AwwS3CD0JPgkKi6JWQvmJUEA0cEDDIQdncmFuYWRhBLoINQk2CQpl/1xCH2JxQKnNQMMK8VYuPrCSvD72oDo+IRdyYnhhc3NldGlkOi8vMzMyNzM1NTkzNgqc5J9Ba/IsQu8pq0EhF3JieGFzc2V0aWQ6Ly8zMzI3MzYxOTI1IQZhbnRlbmEEwghBCUIJCgAAAAB71B1DCtcjPAoSVFdC1taSQAUyQcMKAAA0QylcsUFx/TPDClI1kT0Gnog/yPwuPiEXcmJ4YXNzZXRpZDovLzMzMjczNTYwMTYK4ELfQGgN0kIQhoZBIRdyYnhhc3NldGlkOi8vMzMyNzM2MDI0MiEUTWVzaGVzL3Jlc3RfQ3ViZS4wMD'
..'gH9wMEzQhDCUQJBqoAqgoAAAAAAMAyw4/C9bwKLy5WQm30REAz8T/DCgAANEMAAKC/UvgzQwpcRis+yobxPrCUTz4hF3JieGFzc2V0aWQ6Ly8zNzQ0MTU5NTIyCtKAp0E0NWxCgALLQSEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0zODE0MzA5MzQ0BNQIRQlGCQqwKVZCZ/REQGYkQMME1ghDCUQJCj0lVkJh9ERAlldAwwTYCEUJRgkKtyNWQmT0REDWt0DDBNoIQwlECQo2KFZCavREQKSEQMME3AhDCUQJCkQfVkJe9ERAButAwwTeCDUJNgkKSQ9dQi2ccEDkjUDDBOAINQk2CQrjE11CL5xwQFMc'
..'QMME4gg1CTYJCosRXUIunHBAOlZAwwTkCDUJNgkK7AFdQiFicUA7j0DDBOYINQk2CQotBF1CIWJxQJJXQMME6Ag1CTYJCoYGXUIjYnFAqh1AwyEKcG9ydGFyYWRpbwTrCEEJQgkKbGpXQpE4bEDmQkHDCgTclj5Pf+Q/Wt+6PiEXcmJ4YXNzZXRpZDovLzMzMjczNTYxMjQKMvPnQfmoL0MSqQ9CIRdyYnhhc3NldGlkOi8vMzMyNzM2MDA4OQTyCEcJSAkKCtcjPAAAG0MK16O8CgarV0IGo2dAbSNBwwpx/TNDAADIQXH9M0ME9ghJCUoJCo/C9bzh+rZCAAAAAAr0ClpCln1EQNBKP8MKCtcywx8FsUIK1zJDIQZhbG'
..'dlbWEE/AhLCUwJEDMzMz+amZk+zcxMPgAAgD8AAIA/CqTws0L2qLRCpPAKQwqgBV1CLW5HQGBUQcMKAAC0Qo/C9TykcEJCCoXyaj1Kgwo/c0I/PyEXcmJ4YXNzZXRpZDovLzMzMjczNTczODcK2OowQVCa0EImBRBDIRdyYnhhc3NldGlkOi8vMzMyNzM2MzQ0MwQECU0JTgkKpPCzQvaotEIz8xVDCks2XUJPwUZAFUNBwwoAALRCj8L1POF6bkIhF2JvbHNvbXVsdGlmdW5jYW9fY29uZG9yBAkJTwlQCQoAAAAApHA9P4/C9TwKiT1aQrC2RUD5okHDCvYBhz/69zM/MX/FPiEXcmJ4YXNzZXRpZDovLzMzMjc5OTI3'
..'NjAKBhHOQpRYiUISuRZCIRdyYnhhc3NldGlkOi8vMzMyNzk5Mzk2MAq2c1lCNwxOQKhpQMMKGACAP0xihTAVAICyCkxihTAAAIA/EQAArQrpYllC+MafQN5sQMMK0fx/P6LkCTpB3yW8Cs3iCbr+/38/VmqyNgps+SW8nBsgttL8f78K4R0Kuv7/fz9KFkY2Cmz5JTycGyA20vx/Pwq0zX0/VnsFPi24I7wKw3gFvtLQfT/fUto6Cm6C4Lw7jWw2kud/vwqR538/ZoC2uXyC4LwKQnS1vGMItTkb8H+/Crb/YDn+/38/zpWyOQo/I4M699AGPrDFfT8KBgsWPZuZfT9ywwa+Cnb2fz+OF4282UMXuQo0+zO8T+Ukv9rMQz'
..'8K+VIJvfakaD1+cX8/Ch1rNz80izI/ngKAvAriMGi787EMPRrZfz8KLFo+P4oZKz+tlqa8CvgInjsVOx09H89/vwo2dXY/nEaKPtsbdjwKK/9aPw/rDL48n/8+Co1iLb2+NnE/hhyqPgpCl32/HiwMPptFvTkKExUMPrxmfT/i2B09Cu7EWUJ52aw/XeU/wwqHullCZ9msP6jnQMMKxyFaQudYXEB4TUDDCuHpf7+YxQm6kKfVPArnxgm6/v9/P0ZHzDYK0fx/v6LkCbpB3yU8Chctdz91RYW+ZWiKOQqxKII+OHVxP3cLWz4KwI1YP1FS8Tu8hAi/CrAog7w1838/MuI9vAq91X8/qvb0vIz7o7wKcwz1PKzifz/BKmI5'
..'CvDmf7/j3Am69lDjPAq/mgi6/v9/P3D1PDkKzptiPyi0irwDC+6+CsWLFjyD8X8/iPSavAr/Ie4+suFLPKWaYj8KuhsXPIPxfz/U1pq8CiP/fz/7vgY6WVm4uwr1BQe6/v9/PyO2Q7kKXP9/PzBQJjrlaaM7Cu1RJrr9/38/2Hx0NgoKE22/NWIJOa40wb4K2osVOQEAgD/vTDu2CoTwf79H+Qm6pBSzPAp5+Qm6/v9/Py7MuzYKhPB/v4f8CbqkFLM8Crj8Cbr+/38/qda7NgouBGi/lnGQuZNg2L4KKW5euQAAgD/Oj065Chan1bxaXSK35Ol/vwriPgq6/v9/P1DTiDYKwUQpP6fPtDmpDUA/CqgNQL+Ik8+5xkQpPw'
..'qdfAE/FtWJOZTWXD8KlNZcvyRA7rmjfAE/Csb6fz/7xwk6JmZSvAo+xwm6/v9/P0ybjDZNAQAAAQACAAMABAABAAABAAICAAUABgACAAcACAADDwAFAAkACgALAAwADQAOAA8AEAARABIAEwAUABMAFQAWABcAGAAZABoAGwAcAB0AHgAfACAAIQANACIAIwAkAAQBACUAJgAnAAUCAAUAKAApACYACAADDQAFACoACgALAAwADQAOACsAEAAsABIAEwAVAC0AFwAYABkAGgAbAC4AHQAeAB8ALwAhAA0AJAAHBAAwADEAMgAzADQANQA2ADcAOAADCwAKAAsAEAA5ABIAEwAXABgAGQA6ABsAOwAdADwAHwA9ADIAPgA/'
..'AD0AQABBADgAAwwABQBCAAoACwAQAEMAEgATABcAGAAZAEQAGwBFAB0ARAAfAEYAMgBHAD8ASABAAEkAOAADDgAFAEoACgALAA4AKwAQAEsAEgATABUALQAXABgAGQBMABsATQAdAEwAHwBOADIATwA/AFAAQABRADgAAwsABQBSAAoACwAOAFMAEABUABIAEwAVAFUAFwAYABsAVgAfAFcAMgBYAD8AWQA4AAMMAAUAWgAKAAsAEABbABIAEwAXABgAGQBMABsAXAAdAEwAHwBdADIAXgA/AF8AQABgADgAAw4ABQBhAAoACwAOAGIAEABjABIAEwAVAGQAFwBlABkAZgAbAGcAHQBoAB8AaQAiAGoAMgBrAD8AbAA4AA'
..'MNAAUAbQAKAAsADgBuABAAbwASABMAFQBwABcAGAAZAGYAGwBxAB0AaAAfAHIAMgBzAD8AdAA4AAMNAAUAbQAKAAsADgBuABAAdQASABMAFQBwABcAGAAZAGYAGwB2AB0AaAAfAHcAMgBzAD8AdAB4AEACgAgAgQCCAIMAAQgAhACFAIYAhwCIAIkAAwwABQB5AAoACwAOAG4AEAB6ABIAEwAVAHsAFwAYABkAfAAbAH0AHQB+AB8AfwCAAAsAOAADDAAFAIoACgALAA4AbgAQAIsAFQCMABcAjQAZAI4AGwCPAB0AkAAfAJEAMgCSAD8AkwA4AAMMAAUAlAAKAAsAEACVABIAEwAXABgAGQCWABsAlwAdAJgAHwCZADIA'
..'mgA/AJsAQACcADgAAw4ACgALAA4AYgAQAJ0AEgATABUAZAAXAGUAGQCeABsAnwCgAKEAHQCiAB8AowAiAKQAMgClAD8ApgA4AAMLAAoACwAQAKcAEgATABcAqAAZAKkAGwCqAB0AqwAfAKwAMgCtAD8ArgBAAEEAeABAAkACgAgAtQC2ALEAAQgAtwC4ALEAuQCIAIkAQARAAkACAAgAugC7ALwAQAMACAC9AL4AvwBABQDAAMEAwgDDAADAAMEAxAC/AIAIAMUAxgC/AIAIAMcAyAC/AIAIAMcAyQC/AEACgAgAygDLAL8AQAOACADMAM0AvwCACADMAM4AvwABCADPANAAvwCHAIgAiQBAAsAFAAgA0QDSALwAAAgA0Q'
..'DTALwAAAgA1ADVALwAAAgA1gDXALwAAAgA0QDYALwAQASACADZANoAvACACADZANsA3ACACADdAN4AvABAAsALgAgA3wDgAOEAgAgA4gDjAOQAgAgA5QDmAOEAgAgA5wDoAOkAgAgA6gDrAOwAQALAJAAIAO0A7gDvAAAIAPAA8QDyAAAIAPMA9AD1AAAIAPYA9wD4AAAIAPkA+gD7AAAIAPwA/QD+AAAIAP8AAAEBAQAIAAIBAwEEAQAIAAUBBgEHAQAIAAgBCQEKAQAIAAsBDAENAQAIAA4BDwEQAQAIABEBEgETAQAIABQBFQEWAQAIABcBGAEZAQAIABoBGwEcAQAIAB0BHgEfAQAIACABIQEiAQAIACMBJAElAQAI'
..'ACYBJwEoAQAIACkBKgErAQAIACwBLQEuAQAIAC8BMAExAQAIADIBMwE0AQAIADUBNgE3AQAIADgBOQE6AQAIADsBPAE9AQAIAD4BPwFAAQAIAEEBQgFDAQAIAEQBRQFGAQAIAEcBSAFJAQAIAEoBSwFMAQAIAE0BTgFPAQAIAFABUQFSAQAIAFMBVAFVAQAIAFYBVwFYAUACwAIACABZAVoBWwEACABcAVoBXQFAAsACAAgAXgFfAWABAAgAYQFfAWIBQAPABAAIAGMBZAFlAQAIAGYBZwFoAQAIAGkBZwFqAQAIAGsBbAFtAcAEAAgAbgFvAXABAAgAcQFyAXMBAAgAdAFyAXUBAAgAdgF3AXgBQAPABQAIAHkBegF7AQ'
..'AIAHwBfQF+AQAIAH8BgAGBAQAIAIIBgAGDAQAIAIQBhQGGAcAFAAgAhwGIAYkBAAgAigGLAYwBAAgAjQGOAY8BAAgAkAGOAZEBAAgAkgGTAZQBQAJAB8ADAAgAlQGWAZcBAAgAmAGZAZoBAAgAmwGcAZ0BAAgAngGfAaABAAgAoQGiAaMBAQgApAGlAaYBhwCIAIkAAAgApwGoAZoBAQgAqQGqAaYBhwCIAIkAwAMACACrAawBmgEACACtAa4BrwEACACwAbEBsgFAB8ADAAgAswG0AZcBAAgAmAG1AZoBAAgAtgG3AZ0BAAgAuAG5AaABAAgAugG7AaMBAQgAvAG9AaYBhwCIAIkAAAgAvgG/AZoBAQgAwAHBAaYBhwCI'
..'AIkAwAMACADCAcMBmgEACADEAcUBrwEACADGAccBsgGACADIAckBygGACADLAcwBygGACADNAc4BzwGACADQAdEB0gGACADTAdQB1QFAC4AIANYB1wHYAYAIANkB2gHbAYAIANwB3QHYAYAIAN4B3wHgAYAIAOEB4gHjAUACwCQACADkAeUB5gEACADnAegB6QEACADqAesB7AEACADtAe4B7wEACADwAfEB8gEACADzAfQB9QEACAD2AfcB+AEACAD5AfoB+wEACAD8Af0B/gEACAD/AQACAQIACAACAgMCBAIACAAFAgYCBwIACAAIAgkCCgIACAALAgwCDQIACAAOAg8CEAIACAARAhICEwIACAAUAhUCFgIACAAXAh'
..'gCGQIACAAaAhsCHAIACAAdAh4CHwIACAAgAiECIgIACAAjAiQCJQIACAAvASYCJwIACAAoAikCKgIACAArAiwCLQIACAA4AS4CLwIACABBATACMQIACAAyAjMCNAIACABBATUCNgIACABEATcCOAIACABHATkCOgIACAA7AjwCPQIACAA+Aj8CQAIACABBAkICQwIACABEAkUCRgIACABHAkgCSQJAAsACAAgASgJLAkwCAAgATQJLAk4CQALAAgAIAE8CUAJRAgAIAFICUAJTAkADwAQACABUAlUCVgIACABXAlgCWQIACABaAlgCWwIACABcAl0CXgLABAAIAF8CYAJhAgAIAGICYwJkAgAIAGUCYwJmAgAIAGcCaAJp'
..'AkADwAUACABqAmsCbAIACABtAm4CbwIACABwAnECcgIACABzAnECdAIACAB1AnYCdwLABQAIAHgCeQJ6AgAIAHsCfAJ9AgAIAH4CfwKAAgAIAIECfwKCAgAIAIMChAKFAkACQAfAAwAIAIYChwKIAgAIAIkCigKLAgAIAIwCjQKOAgAIAI8CkAKRAgAIAJICkwKUAgEIAJUClgKXAocAiACJAAAIAJgCmQKLAgEIAJoCmwKXAocAiACJAMADAAgAnAKdAosCAAgAngKfAqACAAgAoQKiAqMCQAfAAwAIAIYCpAKIAgAIAIkCpQKLAgAIAKYCpwKOAgAIAI8CqAKRAgAIAJICqQKUAgEIAJUCqgKXAocAiACJAAAIAJgCqw'
..'KLAgEIAJoCrAKXAocAiACJAMADAAgAnAKtAosCAAgAngKuAqACAAgAoQKvAqMCgAgAsAKxArICgAgAswK0ArICgAgAtQK2ArcCgAgAuAK5AroCgAgAuwK8Ar0CQAfAAwAIAL4CvwKIAgAIAMACwQKLAgAIAMICwwKOAgAIAMQCxQKRAgAIAMYCxwKUAgEIAMgCyQKXAocAiACJAAAIAMoCywKLAgEIAMwCzQKXAocAiACJAMADAAgAzgLPAosCAAgA0ALRAqACAAgA0gLTAqMCQAJAAsAkAAgA1ALVAuYBAAgA1gLXAukBAAgA2ALZAtoCAAgA2wLcAu8BAAgA3QLeAvIBAAgA3wLgAvUBAAgA4QLiAvgBAAgA4wLkAvsB'
..'AAgA5QLmAv4BAAgA5wLoAgECAAgA6QLqAgQCAAgA6wLsAgcCAAgA7QLuAgoCAAgA7wLwAg0CAAgA8QLyAhACAAgA8wL0AvUCAAgA9gL3AhYCAAgA+AL5AvoCAAgA+wL8AhwCAAgA/QL+Ah8CAAgA/wIAAyICAAgAAQMCAyUCAAgAAwMEAycCAAgABQMGAyoCAAgABwMIAy0CAAgACQMKAy8CAAgACwMMAw0DAAgADgMPAzQCAAgAEAMRAzYCAAgAEgMTAzgCAAgAFAMVAzoCAAgAFgMXAz0CAAgAGAMZA0ACAAgAGgMbA0MCAAgAHAMdA0YCAAgAHgMfA0kCQALAAgAIACADIQNMAgAIACIDIQNOAkACwAIACAAjAyQDUQ'
..'IACAAlAyQDUwJAA8AEAAgAJgMnA1YCAAgAKAMpAyoDAAgAKwMpA1sCAAgALAMtA14CwAQACAAuAy8DMAMACAAxAzIDZAIACAAzAzIDZgIACAA0AzUDaQJAA8AFAAgANgM3A2wCAAgAOAM5A28CAAgAOgM7A3ICAAgAPAM7A3QCAAgAPQM+A3cCwAUACAA/A0ADegIACABBA0IDfQIACABDA0QDgAIACABFA0QDggIACABGA0cDhQJAAkAHwAMACABIA0kDiAIACABKA0sDiwIACABMA00DjgIACABOA08DkQIACABQA1EDlAIBCABSA1MDlwKHAIgAiQAACABUA1UDiwIBCABWA1cDlwKHAIgAiQDAAwAIAFgDWQOLAgAI'
..'AFoDWwOgAgAIAFwDXQOjAkAHwAMACABeA18DiAIACABgA2EDiwIACABiA2MDjgIACABkA2UDkQIACABmA2cDlAIBCABoA2kDlwKHAIgAiQAACABqA2sDiwIBCABsA20DlwKHAIgAiQDAAwAIAG4DbwOLAgAIAHADcQOgAgAIAHIDcwOjAoAIAHQDdQO8AEADQALAJAAIAHYDdwPmAQAIAHgDeQPpAQAIAHoDewPaAgAIAHwDfQPvAQAIAH4DfwPyAQAIAIADgQP1AQAIAIIDgwP4AQAIAIQDhQP7AQAIAIYDhwP+AQAIAIgDiQMBAgAIAIoDiwMEAgAIAIwDjQMHAgAIAO0CjgMKAgAIAI8DkAMNAgAIAJEDkgMQAgAIAP'
..'MCkwP1AgAIAIADlAMWAgAIAJUDlgP6AgAIAJcDmAMcAgAIAJkDmgMfAgAIAJsDnAMiAgAIAJ0DngMlAgAIAJ8DoAMnAgAIAKEDogMqAgAIAH4DowMtAgAIAKQDpQMvAgAIAKYDpwMNAwAIAKgDqQM0AgAIAKoDqwM2AgAIAKwDrQM4AgAIAK4DrwM6AgAIALADsQM9AgAIALIDswNAAgAIALQDtQNDAgAIALYDtwNGAgAIALgDuQNJAkACwAIACAC6A7sDTAIACAC8A7sDTgJAAsACAAgAvQO+A1ECAAgAvwO+A1MCQAPABAAIAMADwQNWAgAIAMIDwwMqAwAIAMQDwwNbAgAIAMUDxgNeAsAEAAgAxwPIAzADAAgAyQPK'
..'A2QCAAgAywPKA2YCAAgAzAPNA2kCQAPABQAIAM4DzwNsAgAIANAD0QNvAgAIANID0wNyAgAIANQD0wN0AgAIANUD1gN3AsAFAAgA1wPYA3oCAAgA2QPaA30CAAgA2wPcA4ACAAgA3QPcA4ICAAgA3gPfA4UCQAJAB8ADAAgA4APhA4gCAAgA4gPjA4sCAAgA5APlA44CAAgA5gPnA5ECAAgA6APpA5QCAQgA6gPrA5cChwCIAIkAAAgA7APtA4sCAQgA7gPvA5cChwCIAIkAwAMACADwA/EDiwIACABwA/IDoAIACADzA/QDowJAB8ADAAgA9QP2A4gCAAgA9wP4A4sCAAgA+QP6A44CAAgA+wP8A5ECAAgA/QP+A5QCAQ'
..'gA/wMABJcChwCIAIkAAAgAAQQCBIsCAQgAAwQEBJcChwCIAIkAwAMACAAFBAYEiwIACABwAwcEoAIACAAIBAkEowKACAAKBAsEDASACAANBA4EDwQDDAAFAK8ACgALAA4AKwAQALAAEgATABUALQAXAGUAGQCxABsAsgAdALMAHwC0AIAACwB4AEACwCQACAAWBBcEEgQACAAYBBkEGgQACAAbBBwEHQQACAAeBB8EIAQACAAhBCIEIwQACAAkBCUEJgQACAAnBCgEKQQACAAqBCsELAQACAAtBC4ELwQACAAwBDEEMgQACAAzBDQENQQACAA2BDcEOAQACAA5BDoEOwQACAA8BD0EPgQACAA/BEAEQQQACABCBEMEEwIA'
..'CABEBEUERgQACABHBEgESQQACABKBEsETAQACABNBE4ETwQACABQBFEEIgIACABSBFMEVAQACABVBFYEVwQACABYBFkEWgQACABbBFwEXQQACABeBF8EYAQACABhBGIEYwQACABkBGUEZgQACABnBGgEaQQACABqBGsEbAQACABtBG4EbwQACABwBHEEcgQACABzBHQEdQQACAB2BHcEeAQACAB5BHoEewQACAB8BH0EfgRAAsACAAgAfwSABIEEAAgAggSABIMEQALAAgAIAIQEhQSGBAAIAIcEhQSIBEADwAQACACJBIoEiwQACACMBI0EjgQACACPBI0EkAQACACRBJIEkwTABAAIAJQElQSWBAAIAJcEmASZBAAIAJ'
..'oEmASbBAAIAJwEnQSeBEADwAUACACfBKAEoQQACACiBKMEpAQACAClBKYEpwQACACoBKYEqQQACACqBKsErATABQAIAK0ErgSvBAAIALAEsQSyBAAIALMEtAS1BAAIALYEtAS3BAAIALgEuQS6BEACQAfAAwAIALsEvAS9BAAIAL4EvwTABAAIAMEEwgTDBAAIAMQExQTGBAAIAMcEyATJBAEIAMoEywTMBIcAiACJAAAIAM0EzgTABAEIAM8E0ATMBIcAiACJAMADAAgA0QTSBMAEAAgA0wTUBNUEAAgA1gTXBNgEQAfAAwAIANkE2gS9BAAIANsE3ATABAAIAN0E3gTDBAAIAN8E4ATGBAAIAOEE4gTJBAEIAMoE4wTM'
..'BIcAiACJAAAIAOQE5QTABAEIAOYE5wTMBIcAiACJAMADAAgA0QToBMAEAAgA0wTpBNUEAAgA1gTqBNgEAwwABQAQBAoACwAOAGIAEAARBBIAEwAVAGQAFwBlABkAEgQbABMEHQAUBB8AFQSAAAsAeABAAsACwAUACADzBPQE7QQACADzBPUE7QQACAD2BPcE7QQACAD4BPkE7QQACADzBPoE7QRABIAIAPsE/ATtBIAIAP0E/gT/BIAIAAAFAQXtBEACwAuACAACBQMF4QCACAAEBQUFBgWACAAHBQgF4QCACAAJBQoF6QCACAALBQwFDQVAAsAkAAgADgUPBe8AAAgAEAURBfIAAAgAEgUTBRQFAAgAFQUWBRcFAAgAGA'
..'UZBRoFAAgAGwUcBR0FAAgAHgUfBQEBAAgAIAUhBQQBAAgAIgUjBQcBAAgAIAUkBQoBAAgAJQUmBQ0BAAgAJwUoBSkFAAgAKgUrBSwFAAgALQUuBS8FAAgAMAUxBTIFAAgAMwU0BTUFAAgANgU3BR8BAAgAOAU5BSIBAAgAOgU7BTwFAAgAPQU+BT8FAAgAQAVBBUIFAAgAQwVEBS4BAAgARQVGBUcFAAgASAVJBUoFAAgASwVMBTcBAAgATQVOBU8FAAgAUAVRBVIFAAgAUwVUBVUFAAgAVgVXBVgFAAgAWQVaBUYBAAgAWwVcBV0FAAgAXgVfBWAFAAgAYQViBWMFAAgAZAVlBWYFAAgAZwVoBWkFAAgAagVrBWwFQALA'
..'AgAIAG0FbgVvBQAIAHAFbgVxBUACwAIACAByBXMFdAUACAB1BXMFdgVAA8AEAAgAdwV4BXkFAAgAegV7BXwFAAgAfQV7BX4FAAgAfwWABYEFwAQACACCBYMFhAUACACFBYYFhwUACACIBYYFdQEACACJBYoFeAFAA8AFAAgAiwWMBY0FAAgAjgWPBZAFAAgAkQWSBZMFAAgAlAWSBZUFAAgAlgWXBZgFwAUACACZBZoFmwUACACcBZ0FngUACACfBaAFoQUACACiBaAFowUACACkBaUFpgVAAkAHwAMACACnBagFqQUACACqBasFrAUACACtBa4FnQEACACvBbAFsQUACACyBbMFtAUBCAC1BbYFtwWHAIgAiQAACAC4Bb'
..'kFrAUBCAC6BbsFtwWHAIgAiQDAAwAIALwFvQWsBQAIAL4FvwXABQAIAMEFwgXDBUAHwAMACADEBcUFqQUACADGBccFrAUACADIBckFnQEACACvBcoFsQUACADLBcwFtAUBCADNBc4FtwWHAIgAiQAACADPBdAFrAUBCADRBdIFtwWHAIgAiQDAAwAIANMF1AWsBQAIANUF1gXABQAIANcF2AXDBYAIANkF2gXbBYAIANwF3QXbBYAIAN4F3wXPAYAIAOAF4QXiBYAIAOMF5AXVAUALgAgA5QXmBecFgAgA6AXpBeoFgAgA6wXsBecFgAgA7QXuBe8FgAgA8AXxBeMBQALAJAAIAPIF8wXmAQAIAPQF9QX2BQAIAPcF+AUd'
..'BAAIAPkF+gXvAQAIAPsF/AXyAQAIAP0F/gUmBAAIAP8FAAYpBAAIAAEGAgYDBgAIAAQGBQb+AQAIAAYGBwYyBAAIAAgGCQYKBgAIAAsGDAYNBgAIAA4GDwY7BAAIABAGEQY+BAAIABIGEwYUBgAIABUGFgYTAgAIABcGGAYWAgAIABkGGgZJBAAIABsGHAYcAgAIAB0GHgZPBAAIAB8GIAYhBgAIACIGIwZUBAAIACQGJQYnAgAIACYGJwYoBgAIACkGKgYrBgAIACwGLQZgBAAIAC4GLwYxAgAIADAGMQY0AgAIADIGMwZpBAAIADQGNQY4AgAIADYGNwZvBAAIADgGOQY9AgAIADoGOwZAAgAIADwGPQY+BgAIAD8GQA'
..'ZGAgAIAEEGQgZDBkACwAIACABEBkUGgQQACABGBkUGgwRAAsACAAgARwZIBoYEAAgASQZIBogEQAPABAAIAEoGSwZMBgAIAE0GTgYqAwAIAE8GTgZQBgAIAFEGUgZeAsAEAAgAUwZUBjADAAgAVQZWBpkEAAgAVwZWBlgGAAgAWQZaBlsGQAPABQAIAFwGXQahBAAIAF4GXwakBAAIAGAGYQZiBgAIAGMGYQapBAAIAGQGZQasBMAFAAgAZgZnBq8EAAgAaAZpBrIEAAgAagZrBrUEAAgAbAZrBm0GAAgAbgZvBroEQAJAB8ADAAgAcAZxBr0EAAgAcgZzBosCAAgAdAZ1BsMEAAgAdgZ3BngGAAgAeQZ6BskEAQgAewZ8'
..'BpcChwCIAIkAAAgAfQZ+BosCAQgAfwaABpcChwCIAIkAwAMACACBBoIGiwIACACDBoQG1QQACACFBoYGowJAB8ADAAgAcAaHBr0EAAgAcgaIBosCAAgAdAaJBsMEAAgAdgaKBngGAAgAiwaMBskEAQgAjQaOBpcChwCIAIkAAAgAjwaQBosCAQgAfwaRBpcChwCIAIkAwAMACACSBpMGiwIACACUBpUG1QQACACWBpcGowKACACYBpkGsgKACACaBpsGsgKACACcBp0GngaACACfBqAGoQaACACiBqMGpAZABIAIAKUGpgbtBIAIAKUGpwb/BIAIAKgGqQbtBEACwAuACACqBqsG4QCACACsBq0GBgWACACuBq8G4QCACA'
..'CwBrEG6QCACACyBrMGDQVAAsAkAAgAtAa1Bu8AAAgAtga3BvIAAAgAuAa5BhQFAAgAuga7BhcFAAgAvAa9BhoFAAgAvga/Bh0FAAgAwAbBBgEBAAgAwgbDBgQBAAgAxAbFBgcBAAgAxgbHBgoBAAgAyAbJBg0BAAgAygbLBikFAAgAvgbMBiwFAAgAzQbOBi8FAAgAzwbQBjIFAAgA0QbSBjUFAAgA0wbUBh8BAAgA1QbWBiIBAAgA1wbYBjwFAAgA2QbaBj8FAAgA2QbbBkIFAAgA3AbdBi4BAAgA3gbfBkcFAAgA4AbhBkoFAAgA4gbjBjcBAAgA5AblBk8FAAgA5gbnBlIFAAgA6AbpBlUFAAgA6gbrBlgFAAgA7Abt'
..'BkYBAAgA7gbvBl0FAAgA8AbxBmAFAAgA8gbzBmMFAAgA9Ab1BmYFAAgA9gb3BmkFAAgA6Ab4BmwFQALAAgAIAPkG+gZvBQAIAPsG+gZxBUACwAIACAD8Bv0GdAUACAD+Bv0GdgVAA8AEAAgA/wYAB3kFAAgAAQcCB3wFAAgAAwcCB34FAAgABAcFB4EFwAQACAAGBwcHhAUACAAIBwkHhwUACAAKBwkHdQEACAALBwwHeAFAA8AFAAgADQcOB40FAAgADwcQB5AFAAgAEQcSB5MFAAgAEwcSB5UFAAgAFAcVB5gFwAUACAAWBxcHmwUACAAYBxkHngUACAAaBxsHoQUACAAcBxsHowUACAAdBx4HpgVAAkAHwAMACAAfBy'
..'AHqQUACAAhByIHrAUACAAjByQHnQEACAAlByYHsQUACAAnBygHtAUBCAApByoHtwWHAIgAiQAACAArBywHrAUBCAAtBy4HtwWHAIgAiQDAAwAIAC8HMAesBQAIADEHMgfABQAIADMHNAfDBUAHwAMACAA1BzYHqQUACAA3BzgHrAUACAA5BzoHnQEACAA7BzwHsQUACAA9Bz4HtAUBCAA/B0AHtwWHAIgAiQAACABBB0IHrAUBCABDB0QHtwWHAIgAiQDAAwAIAEUHRgesBQAIAEcHSAfABQAIAEkHSgfDBYAIAEsHTAfbBYAIAE0HTgfbBYAIAE8HUAfPAYAIAFEHUgfiBYAIAFMHVAfVAUALgAgAVQdWB+cFgAgAVwdY'
..'B+oFgAgAWQdaB+cFgAgAWwdcB+8FgAgAXQdeB+MBQALAJAAIAF8HYAfmAQAIAGEHYgf2BQAIAGMHZAcdBAAIAGUHZgfvAQAIAGcHaAfyAQAIAGkHagcmBAAIAGsHbAcpBAAIAG0HbgcDBgAIAG8HcAf+AQAIAHEHcgcyBAAIAHMHdAcKBgAIAHUHdgcNBgAIAHcHeAc7BAAIAHkHegc+BAAIAHsHfAcUBgAIAH0HfgcTAgAIAH8HgAcWAgAIAIEHggdJBAAIAIMHhAccAgAIAIUHhgdPBAAIAIcHiAchBgAIAIkHigdUBAAIAIsHjAcnAgAIAI0HjgcoBgAIAI8HkAcrBgAIAJEHkgdgBAAIAJMHlAcxAgAIAJUHlgc0Ag'
..'AIAJcHmAdpBAAIAJkHmgc4AgAIAJsHnAdvBAAIAJ0Hngc9AgAIAJ8HoAdAAgAIAKEHogc+BgAIAKMHpAdGAgAIAKUHpgdDBkACwAIACACnB6gHgQQACACpB6gHgwRAAsACAAgAqgerB4YEAAgArAerB4gEQAPABAAIAK0HrgdMBgAIAK8HsAcqAwAIALEHsAdQBgAIALIHswdeAsAEAAgAtAe1BzADAAgAtge3B5kEAAgAuAe3B1gGAAgAuQe6B1sGQAPABQAIALsHvAehBAAIAL0HvgekBAAIAL8HwAdiBgAIAMEHwAepBAAIAMIHwwesBMAFAAgAxAfFB68EAAgAxgfHB7IEAAgAyAfJB7UEAAgAygfJB20GAAgAywfM'
..'B7oEQAJAB8ADAAgAzQfOB70EAAgAzwfQB4sCAAgA0QfSB8MEAAgA0wfUB3gGAAgA1QfWB8kEAQgA1wfYB5cChwCIAIkAAAgA2QfaB4sCAQgA2wfcB5cChwCIAIkAwAMACADdB94HiwIACADfB+AH1QQACADhB+IHowJAB8ADAAgA4wfkB70EAAgA5QfmB4sCAAgA5wfoB8MEAAgA6QfqB3gGAAgA6wfsB8kEAQgA7QfuB5cChwCIAIkAAAgA7wfwB4sCAQgA8QfyB5cChwCIAIkAwAMACADzB/QHiwIACAD1B/YH1QQACAD3B/gHowKACAD5B/oHsgKACAD7B/wHsgKACAD9B/4HngaACAD/BwAIoQaACAABCAIIpAYDDQ'
..'AFAOsECgALAA4AKwAQAOwEEgATABUALQAXAI0AGQDtBBsA7gSgAO8EHQDwBB8A8QQiAPIEAQACAgAFAAMIAgAECDgAGQwABQAFCAoACwAQAAYIEgATABcAGAAZAEwAGwAHCB0ATAAfAAgIMgAJCD8ACghAAAsICAAZDAAFAAkACgALAAwADQAQAAwIEgATABcAGAAZABoAGwANCB0AHgAfAA4IIQANACIAIwABAAICAAUADwgCABAIOAAcDAAFAAUICgALABAAEQgSABMAFwAYABkATAAbABIIHQBMAB8ACAgyAAkIPwAKCEAACwgIABwMAAUACQAKAAsADAANABAAEwgSABMAFwAYABkAGgAbABQIHQAeAB8ADgghAA0A'
..'IgAjAAEAAgIABQAVCAIAFgg4AB8MAAUAFwgKAAsAEAAYCBIAEwAXABgAGQAZCBsAGggdABsIHwAcCDIAHQg/AB4IQAAfCDgAHw0ABQAXCAoACwAQACAIEgATABcAGAAZABoAGwAhCB0AHgAfABwIIgAjADIAHQg/AB4IQAAfCDgAHwwABQAiCAoACwAQACMIEgATABcAGAAZACQIGwAlCB0AJggfACcIMgAoCD8AKQhAACoIOAAfCgAFACsICgALABAALAgSABMAFwAYABsALQgfAC4IMgAvCD8AMAhAADEIOAAfDAAFADIICgALABAAMwgSABMAFwAYABkANAgbADUIHQA2CB8ANwgyADgIPwA5CEAAOgg7CCQFAAUAPA'
..'g9CAsAPggjAD8IQAhBCEIIOAAfDAAFAEMICgALABAARAgSABMAFwAYABkATAAbAEUIHQBMAB8ARggyAEcIPwBICEAASQgIAB8OAAoACwAMAA0ADgArABAASggSABMAFQBLCEwITQgXABgAGQA6ABsATggdADwAHwBPCCEADQAiACMAUAgnAQAlAFEIUggnAgBTCFQIVQgjAFYIKQoAVwhYCFkIIwAfAFoIWwhcCF0IXghfCFgIYAgLAGEIYghjCCMAZAgLADgAHwwABQBlCAoACwAQAGYIEgATABcAGAAZAGcIGwBoCB0AaQgfAGoIMgBrCD8AbAhAAG0IOAAfDAAFAG4ICgALABAAbwgSABMAFwAYABkAcAgbAHEIHQBw'
..'CB8AcggyAHMIPwB0CEAAdQgIAB8NAAoACwAMAA0ADgBuABAAdggSABMAdwgjABUAjAAXABgAGQBMABsAeAgdAEwAHwB5CCEADQBQCC0BACUAegg4AB8MAAUAQwgKAAsAEAB7CBIAEwAXABgAGQBMABsAfAgdAEwAHwBGCDIARwg/AEgIQABJCDgAHwwABQB9CAoACwAQAH4IEgATABcAGAAZAH8IGwCACB0AgQgfAIIIMgCDCD8AhAhAAIUICAAfDAAFAAkACgALAAwADQAQAIYIEgATABcAGAAZABoAGwCHCB0AHgAfAIgIIQANACIAIwA4AB8MAAUAiQgKAAsAEACKCBIAEwAXABgAGQAkCBsAiwgdACYIHwCMCDIAjQ'
..'g/AI4IQACPCDgAHwwABQCQCAoACwAQAJEIEgATABcAGAAZAJIIGwCTCB0AlAgfAJUIMgCWCD8AlwhAAJgIOAAfCwAFAJkICgALABAAmggXABgAGQCbCBsAnAgdAJ0IHwCeCDIAnwg/AKAIQAChCDgAHwsABQCiCAoACwAQAKMIFwAYABkApAgbAKUIHQCkCB8ApggyAKcIPwCoCEAAqQg4AB8MAAUAqggKAAsAEACrCBIAEwAXABgAGQCsCBsArQgdAKwIHwCuCDIArwg/ALAIQACxCDgAHwwABQBDCAoACwAQALIIEgATABcAGAAZAEwAGwCzCB0ATAAfAEYIMgBHCD8ASAhAAEkIOAAfDAAFAEMICgALABAAtAgSABMA'
..'FwAYABkATAAbALUIHQBMAB8ARggyAEcIPwBICEAASQg4AB8LAAUAoggKAAsAEAC2CBcAGAAZAKQIGwC3CB0ApAgfAKYIMgCnCD8AqAhAAKkIOAAfDAAFALgICgALABAAuQgSABMAFwAYABkAcAgbALoIHQBwCB8AuwgyALwIPwC9CEAAvgg4AB8MAAUAvwgKAAsAEADACBIAEwAXABgAGQDBCBsAwggdAMMIHwDECDIAxQg/AMYIQADHCDgAHw4ABQDICAoACwAOAMkIEADKCBIAEwAVAMsIFwAYABkAzAgbAM0IHQDOCB8AzwgyANAIPwDRCEAA0gg4AB8MAAUAyAgKAAsAEADTCBIAEwAXABgAGQDMCBsA1AgdAM4IHw'
..'DPCDIA0Ag/ANEIQADSCDgAHwwABQDICAoACwAQANUIEgATABcAGAAZAMwIGwDWCB0AzggfAM8IMgDQCD8A0QhAANIIOAAfDAAFAMgICgALABAA1wgSABMAFwAYABkAzAgbANgIHQDOCB8AzwgyANAIPwDRCEAA0gg4AB8OAAUAyAgKAAsADgDJCBAA2QgSABMAFQDLCBcAGAAZAMwIGwDaCB0AzggfAM8IMgDQCD8A0QhAANIIOAAfDAAFAMgICgALABAA2wgSABMAFwAYABkAzAgbANwIHQDOCB8AzwgyANAIPwDRCEAA0gg4AB8MAAUAbggKAAsAEADdCBIAEwAXABgAGQBwCBsA3ggdAHAIHwByCDIAcwg/AHQIQAB1'
..'CDgAHwwABQBuCAoACwAQAN8IEgATABcAGAAZAHAIGwDgCB0AcAgfAHIIMgBzCD8AdAhAAHUIOAAfDAAFAG4ICgALABAA4QgSABMAFwAYABkAcAgbAOIIHQBwCB8AcggyAHMIPwB0CEAAdQg4AB8MAAUAuAgKAAsAEADjCBIAEwAXABgAGQBwCBsA5AgdAHAIHwC7CDIAvAg/AL0IQAC+CDgAHwwABQC4CAoACwAQAOUIEgATABcAGAAZAHAIGwDmCB0AcAgfALsIMgC8CD8AvQhAAL4IOAAfDAAFALgICgALABAA5wgSABMAFwAYABkAcAgbAOgIHQBwCB8AuwgyALwIPwC9CEAAvgg4AB8MAAUA6QgKAAsAEADqCBIAEw'
..'AXABgAGQDBCBsA6wgdAMMIHwDsCDIA7Qg/AO4IQADvCDgAHw0ABQDpCAoACwAQAPAIEgATABcAGAAZAPEIGwDyCB0A8wgfAOwIIgAjADIA7Qg/AO4IQADvCDgAHwwABQAXCAoACwAQAPQIEgATABcAGAAZAPUIGwD2CB0A9wgfABwIMgAdCD8AHghAAB8IOAAfEAAFAPgICgALAA4AKwAQAPkIEgATABUALQBMCPoIFwAYABkA+wgbAPwIoAAjAB0A/QgfAP4IMgD/CD8AAAlAAAEJOAAfEAAFAPgICgALAA4AKwAQAAIJEgATABUALQBMCPoIFwAYABkAAwkbAAQJoAAjAB0ABQkfAP4IMgD/CD8AAAlAAAEJOAAfDAAF'
..'AAYJCgALABAABwkSABMAFwAYABkACAkbAAkJHQAICR8ACgkyAAsJPwAMCUAADQkA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
