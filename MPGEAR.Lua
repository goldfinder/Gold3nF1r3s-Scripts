-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 10100 characters

local ScriptFunctions = {
function(script,require)
function RMP()
	local id = math.random(1,23)
	if id == 1 then
		return "PVT."
	elseif id == 2 then
		return "PFC."
	elseif id == 3 then
		return "CPL."
	elseif id == 4 then
		return "SPC."
	elseif id == 5 then
		return "SGT."
	elseif id == 6 then
		return "SSG."
	elseif id == 7 then
		return "SFC."
	elseif id == 8 then
		return "MSG."
	elseif id == 9 then
		return "1SG."
	elseif id == 10 then
		return "SGM."
	elseif id == 11 then
		return "CSM."
	elseif id == 12 then
		return "WO1"
	elseif id == 13 then
		return "CW2"
	elseif id == 14 then
		return "CW3"
	elseif id == 15 then
		return "CW4"
	elseif id == 16 then
		return "CW5"
	elseif id == 17 then
		return "2LT."
	elseif id == 18 then
		return "1LT."
	elseif id == 19 then
		return "CPT."
	elseif id == 20 then
		return "MAJ."
	elseif id == 21 then
		return "LTC."
	elseif id == 22 then
		return "COL."
	elseif id == 23 then
		return "BG."
	end
end

local PLR = owner
if PLR.Character:FindFirstChild("Shirt")~=nil then PLR.Character.Shirt:Destroy()end
if PLR.Character:FindFirstChild("Pants")~=nil then PLR.Character.Pants:Destroy()end
script.Parent.Pants.Parent=PLR.Character
script.Parent.Shirt.Parent=PLR.Character
PLR.Character.Humanoid.MaxHealth=200
PLR.Character.Humanoid.Health=200
local d = PLR.Character:GetChildren()for i=1, #d do if (d[i].className == "Accessory") then d[i]:remove() end end
PLR.Character.Humanoid.DisplayName = RMP().." "..PLR.Name
local g = script.Parent["Enlisted Honor Guards Cap"]
g.Parent = PLR.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" then
		local W = Instance.new("Weld")
		W.Part0 = g.Middle
		W.Part1 = C[i]
		local CJ = CFrame.new(g.Middle.Position)
		local C0 = g.Middle.CFrame:inverse()*CJ
		local C1 = C[i].CFrame:inverse()*CJ
		W.C0 = C0
		W.C1 = C1
		W.Parent = g.Middle
		g.Middle.Transparency = 1
	end
	local Y = Instance.new("Weld")
	Y.Part0 = PLR.Character.Head
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end
local h = g:GetChildren()
for i = 1, # h do
	h[i].Anchored = false
	h[i].CanCollide = false
end
local g = script.Parent.Vest
g.Parent = PLR.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" then
		local W = Instance.new("Weld")
		W.Part0 = g.Middle
		W.Part1 = C[i]
		local CJ = CFrame.new(g.Middle.Position)
		local C0 = g.Middle.CFrame:inverse()*CJ
		local C1 = C[i].CFrame:inverse()*CJ
		W.C0 = C0
		W.C1 = C1
		W.Parent = g.Middle
		g.Middle.Transparency = 1
	end
	local Y = Instance.new("Weld")
	Y.Part0 = PLR.Character.Torso
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
	for script, index in pairs(Scripts) do
		coroutine.wrap(function()
			ScriptFunctions[index](script, require)
		end)()
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


local Objects = Decode('AECeASEFTW9kZWwhBE5hbWUhBk1QR0VBUiEKV29ybGRQaXZvdARxAXIBcwEhBVBhbnRzIQ1QYW50c1RlbXBsYXRlIRdyYnhhc3NldGlkOi8vMTk0MDAwMzM3OCEFU2hpcnQhDVNoaXJ0VGVtcGxhdGUhFnJieGFzc2V0aWQ6Ly8yMTA0ODIwODEhBFZlc3QEdAF1AXYB'
..'IQRQYXJ0IQZNaWRkbGUhCEFuY2hvcmVkIiENQm90dG9tU3VyZmFjZQMAAAAAAAAAACEGQ0ZyYW1lBBkAdwF4ASEKQ2FuQ29sbGlkZQIhCFBvc2l0aW9uCsBCHkGvrltA5MoOwyEEU2l6ZQoAAABAAAAAQAAAgD8hClRvcFN1cmZhY2UhDFRyYW5zcGFyZW5jeQMAAAAA'
..'AADwPyEOVW5pb25PcGVyYXRpb24hBUN1ZmZzIQtCYWNrU3VyZmFjZQMAAAAAAAAAQCEKQnJpY2tDb2xvcgfrAwQuAHkBegEhBUNvbG9yBhERESEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZSEITWF0ZXJpYWwDAAAAAAAAkUAhC09yaWVudGF0aW9uCgAAAADD9TPD'
..'AAAAAApAeCZBUyA6QNAqDsMhC1JlZmxlY3RhbmNlIQxSaWdodFN1cmZhY2UhCFJvdGF0aW9uCgAANEMK1yO9AAA0wwoyTRw/Sbw8P9qauz0hDFVzZVBhcnRDb2xvcgoEFXo9ChV6PQ8Vej0KZXgmQfR8JEAzKw7DCiJNnD4mTRw+zY+7PQpReCZBWV8pQM8qDsMKIU2c'
..'PmfSWj7Njzs+ChOKI0F8mh9A6CYOwwqPwvU8j8J1PQAAAAAKIk2cPmrSWj7Njzs+Cp9mKUGbmh9A5yYOwwqPwvW8KVyPPQAAAAAKpxT6PgpNHD5b7is/CkB4JkE5Lj5A0CoOwwoAAAAACtcjPQrXI70DAAAAAAAAEEAKAACAPwAAgD8AAIA/CgAAAAAAAAAAAAAAAAoz'
..'7is/3xT6PFzuKz8KUu4rP7yPuz0YTRw/CgAAtELD9TPDAAAAACEEV2VsZCECQzAEewF8AX0BIQJDMQR+AX8BgAEhBVBhcnQwIQhNZXNoUGFydCEYRHVhbCBQaXN0b2wgQ2xpcCBDYXJyaWVyBFMAgQGCAQMAAAAAAICUQAoAAAAAAAC0wgAAAAAKwCcWQc3YLEBkXw/D'
..'Cjt//T1qP+Q+CDG3PiEGTWVzaElkIRdyYnhhc3NldGlkOi8vMzMyNzc5MjM0MCEITWVzaFNpemUKwM9YQVo3Q0I0rhxCIQlUZXh0dXJlSUQhF3JieGFzc2V0aWQ6Ly8zMzI3Nzk1MDEyIQpFbXB0eSBiZWx0BF4AgwGEAQoAAAAAAAC0wgrXIzwKwE8eQTNYLEB80A7D'
..'CgrXI7wAALTCAAAAAAqxepA/5pCZPrn6AkAhF3JieGFzc2V0aWQ6Ly8zMDgzNDI2NTQ0Coyn4EKgyO5BxKlLQyEXcmJ4YXNzZXRpZDovLzMwODM0Mjk5OTghEkZ1bGwgTW9sbGUgQ2FycmllcgeNAARqAHUBdgEGNzc3AwAAAAAAQJRACgAAAAAAALRCAAAAAApAPx5B'
..'92VtQADQDsMK3PyhP2pIzj/RqghAIRdyYnhhc3NldGlkOi8vMjgyNTg2ODIxNwr83/dC79MdQxshUUMhDUdyZW5hZGUgcG91Y2gEcACBAYIBCsB0JkEXVS1AWCYOwwpP/ZA+7dzQPolr4T4hF3JieGFzc2V0aWQ6Ly8zMzI3MzU1NzQ1CnCQt0FOHjxCtQTFQSEXcmJ4'
..'YXNzZXRpZDovLzMzMjczNjI1MzAhA0d1bgR4AIUBhgEKj8KzwqTwscIAAMzBCsBpMEG/qi1AaJ8OwwoAALTCAAAAAAAAAAAKke+NPoorIj+KnHo/Ck2TcT5o3+s9O9/rPQrBdTBBHCsxQIW1DsMDAAAAAAAAGEAKmZmZPgAAAD+ZmZk+Ck+TcT5o3+s9Ot/rPQq0dTBB'
..'QNgRQOraDsMKAAC0wgAANEMAAAAACjMzcz+amVk/AABAPwpPk3E+aN/rPca6AT4KI08xQUOPHkCM4Q7DCpqZGT+amRk/AAAAQArNzEw9AAAAAM3MzL0KtXUwQUfYEUDr6A7DCgAAQD/MzMw9AABAPwpPk3E+at/rPTrf6z0KtnUwQe55EUBX7Q7DCszMTD7MzEw+AACA'
..'PgpPk3E+at/rPe+FDT4KXNYwQYaQLEAD1Q7DCgAAQD9nZuY+AACAPwpPk3E+at/rPQDNtj4KYNYwQYhpPEDo2g7DCgAAQD+amVk/AACAPwq9dTBBftQyQMHjDsMKAABAP2Zm5j7NzAxACgAAAAAAAAAAexQuPgpPk3E+2gZjP2rf6z0KjQovQYp1K0Bs5w7DCgAAAAAA'
..'ADRDAAAAAArMzEw+AACAP8zMTD4KT5NxPgDNtj5q3+s9CkvfMUGKaTxAa+cOwwpPk3E+at/rPRAUYD4KQt8xQXicG0Dk2g7DCszMTD6amVk/AACAPwpPk3E+at/rPe3pTD8KjQovQSE5LkDk2g7DCk2TcT5q3+s974UNPgrOvTBBjpAsQELiDsMKMzMzP2dm5j4AAIA/'
..'Ck2TcT5k3+s9QN/rPQpSdTBBdX8yQP6mDsMKAACKwgAANEMAADTDCmZmJj8AAIA+mZkZPwpNk3E+at/rPTrf6z0KUnUwQRZUL0DFtg7DCpmZmT7MzMw+zMxMPgrn54o+at/rPWjnMD4KunUwQWT9MEAitg7DCgAAgD/NzAw/AACAPwrn54o+UZjCPj8cJT4KuXUwQTIm'
..'NkCXjQ7DCufnij5q3+s95uQUPwq7dTBB84oxQGbDDsMKw/WzwvYo0EHh+hlDCgAAgD8zM7M+AACAPwrn54o+at/rPTXf6z0KvHUwQYa1S0Dyag7DCgAAtEIAADRDAAAAAAoAAIA/AABAPzMzsz4KT5NxPsO6gT5q3+s9CrV1MEEnHhdAxsoOwwpmZqY+AACAP2Zmpj4K'
..'Nd/rPefnij5q3+s9Crd1MEFcyDxAGVQOwwoAAAAAAAA0QwAAtEIKzMzMPgAAgD/MzMw+Ck+TcT5q3+s9Nd/rPQq1dTBB9ucjQM+dDsMKZmYmP5mZmT6ZmRk+Cufnij7ONh8+dy5aPgq6dTBB0plDQBpiDsMKT5NxPmff6z063+s9Crl1MEEDnzBAZacOwwoAAJZCcf0z'
..'w3H9M8MKmZmZPs3MDD+ZmZk+Ck+TcT5q3+s99o99Pgq1dTBBzgEXQLy/DsMKMzNzP8zMzD0AAIA/Cufnij6Q5zA+ON/rPQq+dTBBYklHQCGMDsMKAACAPwAAgD+amVk/Ck+TcT5q3+s9QRwlPgq4dTBBvxcrQFmcDsMKZmYmP8zMTD4AAIA/Ck+TcT5q3+s9ON/rPQq4'
..'dTBBzNomQNW5DsMKAAC0QgAAAAAAAAAACmZmJj+ZmZk+AACAPgrn54o+PhTgPu6FDT4KvHUwQUC7P0AhjA7DCrd1MEF9WiNA1rkOwwpmZiY/mZmZPpmZmT4KTWIuQYFVNkD4yQ7DCszMzD0zM7M+zcwMPwpPk3E+oPStPmrf6z0KonUwQfQ3GUDo3g7DCkjhGj8AAIA/'
..'SOEaPwpPk3E+at/rPfiPfT4KpHUwQVSPF0DAwg7DCufnij5q3+s9Ot/rPQrWdTBB6cJIQJfLDsMKAACAP8zMTD6ZmRk+Ck+TcT6iaxM+Ot/rPQq1dTBBMzIlQOarDsMKZmYmPwAAgD/MzEw+Ck+TcT5q3+s9UmNOPgo7vjBBkXA3QLThDsMKMzMzP8zMzD4AAIA/Cjv4'
..'MUHMARdAcckOwwqZmRk+MzOzPgAAgD8KT5NxPmPf6z0/3+s9Crl1MEH6AjRAcZsOwwofBYrCAAA0QwAAAAAKZmYmPwAAgD7MzMw+Cufnij5q3+s9QhwlPwq8dTBB3JEzQKbLDsMKAACAP8zMTD4AAIA/CjDzLkHYARdAcckOwwo63+s95+eKPmrf6z0Ku3UwQT1rSkCo'
..'WA7DCjMzMz8AAIA/MzMzPwrn54o+Ot/rPWrf6z0KwHUwQRrQRUBGxA7DCgAAgD/NzAw/mZmZPiENTGVnIGhvbHN0ZXIgMgT7AIcBiAEKAAAAAOH6s8IK1yO8CsCRJkG5jDBA7MoOwwoK1yM8AAC0wgAAAAAKNgBvP8zIqT9KosU/IRdyYnhhc3NldGlkOi8vMzA4MzQy'
..'NjcwMgqwrdVCQgAEQ7jDAkMhF3JieGFzc2V0aWQ6Ly8zMDgzNDI5NDYxIQZaaXB0aWUEAwGJAYoBCkD5FkFjeFdAhGoPwwraKKk9ZtdXP9/A5z0hF3JieGFzc2V0aWQ6Ly8zMzI3MzU3NTYyCiALAkFA7qVCyCkyQSEXcmJ4YXNzZXRpZDovLzMzMjczNjMzNTEECQGJ'
..'AYoBCkAzFEFjeFdAVGgPwyEFTGFiZWwHGgAEDwGLAYwBBiwsLAoK1yM8AAA0wwAAAAAKQEgeQSwPgEDwOA7DCnH9M0MAAAAAAAA0Qwq9Vls/Hn3rPs3MTD0hClN1cmZhY2VHdWkhCkNhbnZhc1NpemULAABIQwAAyEIhDkxpZ2h0SW5mbHVlbmNlIQlUZXh0TGFiZWwh'
..'BFRleHQhEEJhY2tncm91bmRDb2xvcjMGAAAAIRZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5DAAAgD8AAAAAgD8AACEERm9udCEPTUlMSVRBUlkgUE9MSUNFIQpUZXh0Q29sb3IzBv///yEKVGV4dFNjYWxlZCEIVGV4dFNpemUDAAAAAAAASEAhFlRleHRTdHJva2VUcmFu'
..'c3BhcmVuY3khC1RleHRXcmFwcGVkBCYBgQGCAQqA+hdBF1UtQDAmDsMEKAF5AXoBCgD+F0FTIDpAqCoOwwol/hdB9HwkQAsrDsMKEf4XQVlfKUCnKg7DCtMPFUF8mh9AwCYOwwpf7BpBm5ofQL8mDsMKAP4XQTkuPkCoKg7DIQRTaWduBDABjQGOAQrAqR5BKDCAQFhl'
..'D8MKgGUsP+jRjj6PwvU8AwAAAKCZmek/IQhSaWNoVGV4dCEGUE9MSUNFIQpNYW51YWxXZWxkIRJTaWduIFRlcnJhaW4gSm9pbnQhBVBhcnQxIRRNZXNoZXMvcmVzdF9DdWJlLjAwOAQ7AY8BkAEDAAAAAAAAcUAKAA0iQR+9VEDogw/DClxGKz7KhvE+sJRPPiEXcmJ4'
..'YXNzZXRpZDovLzM3NDQxNTk1MjIK0oCnQTQ1bEKAAstBISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTM4MTQzMDkzNDQEQQGPAZABCsBjHkEfvVRA6IMPwwRDAY8BkAEKQLsaQR+9VEDogw/DIRxNZXNoZXMvcmFwdG9yIHN0dWZmX0N1YmUuMDExBEYB'
..'kQGSAQrAfSdBn91UQDCED8MKAAA0wwAAAAAAADRDCiXapj7QFCw/zrZwPiEXcmJ4YXNzZXRpZDovLzM4MDYwMjIwMjQK4MVxQKRZ+UCAZi5AISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTM3OTcyNDk2NTYhCEFQWCAxMDAwBE4BkwGUAQqAfydBMzdp'
..'QIB9D8MKZoojPt4Bmz8oVJA+IRdyYnhhc3NldGlkOi8vMjI2OTk1ODA2MQqo4o9AmGAIQvD2/UAhF3JieGFzc2V0aWQ6Ly8yMjY5OTU4NzQzIRlFbmxpc3RlZCBIb25vciBHdWFyZHMgQ2FwIQtQcmltYXJ5UGFydASVAZYBlwEhFU1lc2hlcy9BaXIgRm9yY2UgSGF0'
..'MwdOAQRbAXIBmAEG+MpdCo/Cdb1IYbTCAAAAAAp819RAhISnP4fwEMMDAAAAoJmZyT8K4Xoiw5qZs8JSeCLDCrD5GD6oOLY+oDy8PiEXcmJ4YXNzZXRpZDovLzY1MTMwOTE2MzIhGE1lc2hlcy9BaXIgRm9yY2UgSGF0ICgxKQRiAXIBcwEKCN/UQF7elz9HQxDDCoY6'
..'5j+qCUY/sArYPyEXcmJ4YXNzZXRpZDovLzY1MTMwOTIxOTMhF3JieGFzc2V0aWQ6Ly83MzU3Nzk0NjI4B30ABGkBmQGaAQbquJIK/tbUQAIAAD8UPBDDCgAAAEAAAIA/AACAPyELU3BlY2lhbE1lc2ghBVNjYWxlCgAAoD8AAKA/AACgPwSbAZwBnQEEngGcAZ0BIQZT'
..'Y3JpcHQKmK8GQRh6EEBXlQ/DCiJVWbtrDWk2pP9/PwoZQok69/9/P/f/f6sKwAogQd+IU0B00A7DCtA7xDMofbk0AACAvwqdH2AzAACAPyh9uTQKAACAPwAAgCEAAECHCgAAgCEAAIA/AAAAAAr8/3+/537MMv8wNToK5bxyMgAAgD8T5Wq3CgAAAAAAAAAA2po7PQoA'
..'AIA/AAAAAAAAAAAKAAAAAAAAgD8AAAAACgDA8zoAAE65ALg6vQoAAIA/AACcrQAAAAAKAACcrQEAgD8AAAAACgCATDTfvz0wAACAPwrgfswyAACAPzHAPbAKzIBMNLmW5DgAAIA/CtaUAjMAAIA/uZbkuAoEAIA/L3DxsgYgH7QKEsActPEJfTMAAIC/CpYNFDlAjg25'
..'AACAPwrinAIzAACAP0CODTkKT//3NWfCM7AAAIC/CnwbAzMAAIA/b74zsAoAAIC/oEF7twGATDQKwUF7twAAgD9nrSW5CgAAgD8tLg6p0DvEMwoAAHwhAACAPyh9uTQKn3zDs8B7ubQAAIA/Cpc+4KwAAIA/wH65NAoAAIC/XzLuLID7xLMK8AwFrQAAgD+Afrk0CoFZ'
..'MjhSdsY3AACAPwpyACQ1AACAP1N2xrcKANfUQAAAAD8UPBDDCgAAgD8AAACwAAAAGwoAAACwAACAPwAAgKsKGEKJOvf/fz/6/5+rCgAAgD8AACCwAAAAAAoAACCwAACAPwAAoKsKAAB8OAYJTz9QczS/CiJVWbtoDWk2pP9/PwodQok69/9/PwAAAAAKAKCAOrq8Lz8A'
..'YOa8JgEAAAIAAgADAAQABQAGAAECAAIABgAHAAgACQABAgACAAkACgALAAEAAQIAAgAMAAQADQAOAAQJAAIADwAQABEAEgATABQAFQAWABcAGAAZABoAGwAcABMAHQAeAB8AQAIADgA1ADYALQBAAkADAA4ANwA4AC0AgA4AOQA6ADsAgA4APAA9AD4AQAKBDgA/AEAA'
..'QQBCAEMARABAAoEOAEUAQABBAEIAQwBEAAEOAEYAQABHAEIAQwBEAAQTAAIAIAAQABEAIQAiABIAIgAjACQAFAAlABYAFwAmACcAKAAiACkAIgAqACsALAAtABgALgAvAB4AMAAiADEAMgAaADMAHAAiADQAEQBIAAYCAEkASgBLAEwATgAEDAACAE8AEAARABQAUAAW'
..'ABcAKgBRACwAUgAYAFMAMQBSABoAVABVAFYAVwBYAFkAWgBOAAQMAAIAWwAQABEAFABcABYAFwAqAFEALABdABgAXgAxAF8AGgBgAFUAYQBXAGIAWQBjAE4ABA0AAgBkABAAEQAjAGUAFABmABYAFwAmAGcAKgBoACwAaQAYAGoAMQBpABoAawBVAGwAVwBtAE4ABAwA'
..'AgBuABAAEQAUAG8AFgAXACoAUQAsAFIAGABwADEAUgAaAHEAVQByAFcAcwBZAHQAHwBAAgEOAHsAfAB5AH0AfgBEAEACQAJAAwEOAH8AgACBAH0AggBEAAEOAIMAhACBAH0AhQCGAAEOAH8AhwCBAH0AiABEAEAEAQ4AiQCKAIEAfQCLAEQAAQ4AjACNAIEAfQCOAEQA'
..'AQ4AjwCQAIEAfQCRAEQAAQ4AiQCSAIEAfQCTAJQAQAJAAkAEAQ4AlQCWAJcAQgCYAEQAAQ4AmQCaAJcAQgCYAEQAAQ4AmwCcAIEAfQCdAEQAAQ4AngCfAIEAfQCdAEQAQAMBDgCgAKEAgQB9AKIARAABDgCjAKQApQAiAKYARAABDgCnAKgAgQAiAKkARABAAkACQAJA'
..'AkAHAQ4AqgCrAIEAIgCsAEQAAQ4ArQCuAIEAIgBDAEQAAQ4ArwCwALEAfQCyAEQAAQ4AswC0ALUAIgC2AEQAAQ4AtwC4AJcAQgC5AEQAAQ4AugC7ALwAQgC9AEQAAQ4AvgC/AHkAIgDAAEQAQAIBDgDBAMIAgQB9AEMARAABDgDDAMQAxQAiAMYARABABgEOAMcAyACB'
..'ACIAyQBEAAEOAMoAywC1ACIAzABEAAEOAM0AzgCBAH0AzwBEAAEOANAA0QDSACIA0wBEAAEOANQA1QCBAH0AQwBEAAEOANAA1gCBACIA1wBEAEAGAQ4AiQDYAIEAfQDZAEQAAQ4A2gDbAJcAQgDcAEQAAQ4A3QDeAIEAfQDJAEQAAQ4A3wDgALUAIgDhAEQAAQ4A4gDj'
..'AIEAfQDkAEQAAQ4A5QDmAIEAfQDnAEQAQAYBDgDdAOgAgQB9AOkARAABDgDqAOsA7AAiAO0ARAABDgDuAO8AsQB9APAARAABDgDdAPEAgQB9AOkARAABDgDyAPMAvABCAPQARAABDgD1APYAlwAiAPcARAAECwACAHUAEAARACMAJAAUAHYAFgAXACYAJwAqACsALAB3'
..'ABgAeAAxAHkAGgB6AE4ABAwAAgD4ABAAEQAUAPkAFgAXACoAUQAsAPoAGAD7ADEA/AAaAP0AVQD+AFcA/wBZAAABTgAEDAACAAEBEAARABQAAgEWABcAKgBRACwAaQAYAAMBMQBpABoABAFVAAUBVwAGAVkABwFOAAQMAAIAAQEQABEAFAAIARYAFwAqAFEALABpABgA'
..'CQExAGkAGgAEAVUABQFXAAYBWQAHAQ4ABA0AAgAKARAAEQASABMAIwALARQADAEWABcAJgANASoAaAAsAA4BGAAPATEAEAEaABEBHAATABIBEAIAEwEUARUBHgAWARELAAIAFwEYARkBGgEeABoAGwEcAR4AFwEdAR4BHwEgAREAIQEiASMBEwAkAREATgAEDAACAG4A'
..'EAARABQAJQEWABcAKgBRACwAUgAYACYBMQBSABoAcQBVAHIAVwBzAFkAdAAfAEACAA4ANQApAS0AQAJAAwAOADcAKgEtAIAOADkAKwE7AIAOADwALAE+AEACgQ4APwAtAUEAQgBDAEQAQAKBDgBFAC0BQQBCAEMARAABDgBGAC0BRwBCAEMARAAEEwACACAAEAARACEA'
..'IgASACIAIwAkABQAJwEWABcAJgAnACgAIgApACIAKgArACwALQAYACgBLwAeADAAIgAxADIAGgAzABwAIgA0ABEASAAUAgBJAEoASwBMAA4ABAkAAgAuARAAEQAjACQAFAAvASYAJwAqACsAGAAwARoAMQEdADIBEgEWAQATARQBFgEXCwAYAR8BGgEeABoAGwEcAR4A'
..'MwERABcBNAEeAR8BIAERACEBIgEjARMAJAERADUBFgEAAgA2AU4ABAsAAgA4ARAAEQAUADkBKgA6ASwAUgAYADsBMQBSABoAPAFVAD0BVwA+AVkAPwFOAAQLAAIAOAEQABEAFABAASoAOgEsAFIAGABBATEAUgAaADwBVQA9AVcAPgFZAD8BTgAECwACADgBEAARABQA'
..'QgEqADoBLABSABgAQwExAFIAGgA8AVUAPQFXAD4BWQA/AU4ABAsAAgBEARAAEQAUAEUBKgA6ASwAlwAYAEYBMQBHARoASAFVAEkBVwBKAVkASwFOAAQMAAIATAEQABEAFABNARYAFwAqAFEALABSABgATgExAFIAGgBPAVUAUAFXAFEBWQBSAQEAAQIAAgBTAQQAVQFO'
..'AB8NAAIAVgEjAFcBFABYARYAFwAmAFkBKgA6ASwAWgEYAFsBLwBcATEAXQEaAF4BVQBfAVcAXgFOAB8KAAIAYAEUAGEBFgAXACwAWgEYAGIBMQBdARoAYwFVAGQBVwBjAVkAZQEOAB8LAAIADwASABMAIwBmARQAZwEWABcAJgBoASoAOgEYAGkBGgBqARwAEwAdAB4A'
..'awEiAQBsAW0BSAAiAgACAFYBSQBuAUgAIgIAAgBgAUkAbwFwAQEAAAgHTQAGFU0AFBk3ARYfVAEiJE0AIiQ3ASAlTQAiJTcBIQ==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
