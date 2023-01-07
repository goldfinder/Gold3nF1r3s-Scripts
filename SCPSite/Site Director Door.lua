-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 12548 characters

local ScriptFunctions = {
function(script,require)
--Made by xImmortalChaos for Site-40.

local Door = script.Parent.Door
local Door2 = script.Parent.Door2
local Button1 = script.Parent.Button1
local Button2 = script.Parent.Button2
local Open = false

local OpenSound = Door.DoorOpen
local CloseSound = Door.DoorClose

local Debounce = false
function Triggered(Player)
	if Player.Character == nil then return end
	if Player.Character:FindFirstChild("User Setup") == nil then return end
	if (Player.Character:FindFirstChild("AccessLevel").Value < 7) == false or Player.UserId == owner.UserId then 
	else
		Door.AccessDenied:Play()
		return end
	if game.Workspace:FindFirstChild("MainGroup") ~= nil then
		if game.Workspace.MainGroup["Sector 2 fullload"].Value == false then
			if Player.Character:FindFirstChild("AccessLevel").Value < 7 then 
				Door.AccessDenied:Play()
				return end
		end
	end
	if Debounce == true then return end
	Debounce = true
	if Open then
		Open = false
		CloseSound:Play()
		--Door.Transparency = 0
		for i,v in pairs(Door:GetChildren()) do
			if v:IsA("Decal") then
				v.Transparency = 0
			end
		end
		spawn(function()
			for i = 3,(Door.Size.z / 0.15)  do
				Door.CFrame = Door.CFrame + (Door.CFrame.lookVector * 0.15)

				wait()
			end
		end)
	else
		Open = true
		OpenSound:Play()
		spawn(function()
			for i = 3,(Door.Size.z / 0.15) do
				Door.CFrame = Door.CFrame - (Door.CFrame.lookVector * 0.15)

				wait()
			end
		end)
		--Door.Transparency = 1
		for i,v in pairs(Door:GetChildren()) do
			if v:IsA("Decal") then
				v.Transparency = 1
			end
		end
	end
	wait(0.4)
	Debounce = false
end
game.Workspace:WaitForChild("MainGroup")
game.Workspace.MainGroup["Sector 2 fullload"]:GetPropertyChangedSignal("Value"):Connect(function()
	if game.Workspace.MainGroup["Sector 2 fullload"].Value==true then
		script.Parent.Parent.Parent.DoorParts.Lock.Color=Color3.fromRGB(27, 42, 53)
		script.Parent.Parent.Parent.DoorParts.Lock.Material=Enum.Material.Metal
	else
		script.Parent.Parent.Parent.DoorParts.Lock.Color=Color3.fromRGB(255, 170, 0)
		script.Parent.Parent.Parent.DoorParts.Lock.Material=Enum.Material.Neon
	end
end)
Button1.ProximityPrompt.Triggered:connect(Triggered)
Button2.ProximityPrompt.Triggered:connect(Triggered)

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


local Objects = Decode('AEAHAiEFTW9kZWwhBE5hbWUhGExldmVsIFNpdGUgRGlyZWN0b3IgZG9vciEKV29ybGRQaXZvdATFAcYBxwEhBERvb3IExQHIAckBIRJTY3JpcHRlZENvbXBvbmVudHMEygHLAcwBIQ5Vbmlvbk9wZXJhdGlvbiEFRG9vcjIhCEFuY2hvcmVkIiEKQnJpY2tDb2xvcgfC'
..'ACEGQ0ZyYW1lBBsAywHMASEKQ2FuQ29sbGlkZQIhBUNvbG9yBqOipSEITWF0ZXJpYWwDAAAAAACAiUAhC09yaWVudGF0aW9uCgAAAAAfBbTCj8L1PCEIUG9zaXRpb24KF3aGRVtS1EGwQIzCIQhSb3RhdGlvbgqPwvW8AAC0wgAAAAAhBFNpemUKzcxMPbSzRz8l2Q8/'
..'IQxUcmFuc3BhcmVuY3kDAAAAAAAA8D8hBFBhcnQKA2umPBhrpjyp0/E+Cvx1hkVXSNFBGkaMwgrpV9g8VfzoPKZ0DT0Ky3aGRTUu0kELRIzCCgNrpjwlcUc/H2umPArwd4ZFYFPUQS9GjMIK/HWGRaom1EEzRozCCst2hkUoBtZBLUSMwgpndYZFYDLSQQ9EjMIK/HWG'
..'RbFU0kEjRozCCvx1hkUSO9dBT0aMwgpndYZF6//VQTFEjMIKZ3WGRW0G1EEgRIzCCvx1hkVmJtZBRUaMwgoMdIZFZVPUQTtGjMIKKb2uPN1PRz/wtAU/Cu51hkXjUtRBjDuMwgoAAAAA4fqzQo/C9bwKl+lhPc0lzz1wEoM6Chx2hkWqnNdBtTSMwgqPwvU84fozQwAA'
..'NMMDAAAAAAAAGEAKAACAPwAAgD8AAIA/CgAAAAAAAAAAAAAAAAqQwM08DDgLPm8SgzoK9XWGRc1S1kGrNIzCCo/C9Tzh+jNDuN4sQwr0EgI+VduiPHASgzoKIHaGRanE1UGmNIzCCo/C9Tzh+jND4Xq3wgoXkNg9E6JDPG8SgzoKDXaGRZcb1kGpNIzCCo/C9Tzh+jND'
..'HwW2QgoMfIM+29pyO28SgzoKE3aGRciO10G1NIzCCpnAzTwKOAs+bxKDOgozdoZFJHbVQaM0jMIKj8L1POH6M0OuR4G/CvISAj5e26I8cBKDOgoYdoZFEgjWQag0jMIKj8L1POH6M0Oux7xCChGQ2D0gokM8bxKDOgohdoZFm6/VQaU0jMIKj8L1POH6M0NSuKXCCgp8'
..'gz7g2nI7bxKDOgrpdYZFYBbUQZg0jMIKHx9RPeSUkz3hgIQ/Cgl2hkXaUdVBzTmMwgoAALTC4fozQwAAAAADAAAAAAAAEEAKJ/J6PQQIhTrhgIQ/Cgl2hkXbUdVBmzSMwgrearM8CQgFO9ymaD4Ko3WGRXEK1UF1NIzCCuH6sUKambPCmpmzwgoNoCw9CQgFO1PO8T0K'
..'ZHaGRSo30kFxNIzCCpoZhkLh+rNC4fqzQgronyw9CQgFO4HO8T0KFnaGRRAL2EF3NIzCCkhhlsI9CrTC4fqzwgr9Z/o9HYONPcNKQz8KCnaGRZEe1UGKPIzCCuH6scJmZrRCmpmzQgo8hP89cvyYO8FKQz8KCnaGRZEe1UEhNYzCCqqyHz4MjEc7IJyDPwrydYZF8rHV'
..'Qac1jMIKmG9cPy+DjT0Y2N09CgZ2hkVBNdVBJTqMwgoK10NAPQq0wgAAtMIKTZxYPBwIBTtV9148Cup1hkVW+thBdjSMwgrs0Z/CXA+0wuH6s8IKNOTxPBwIBTvKqcc7CkF2hkUPk9dBdDSMwgofhUvBPQq0wgAAtMIKRcdfOxwIBTu0zDg+CiF2hkWPVdhBdTSMwgpI'
..'YZjCXA+0wuH6s8IKDmj6PS+DjT3GSkM/Cj12hkUpftNBIzqMwgpxvaVCheuzQsP1s0IK6hR4PBwIBTtbrkI8CqR1hkWDa9RBdDSMwgozs69Cheuzwkjhs8IKEFrePBwIBTuBNdk7CpV1hkV8rtVBdjSMwgrsUfhBw/WzQgAAtEIKBud/OxwIBTvsmSE+Co11hkV/AtVB'
..'dTSMwgpcj65CKdyzQmbms0IKEmj6PSGDjT28SkM/Cgp2hkWYHtVBoDeMwgrh+rHCcT20QnG9s0IKJWr6PTGDjT0fSUM/CgR2hkXwoNNBQjqMwgrh+rHCKdy7QrgerEIK5BZ4PB0IBTvLrEI8Cnp2hkVdoNJBejSMwgpmZp/Ccb20QlI4s0IKH1nePB0IBTtrNtk7Clp2'
..'hkWjXtFBYjSMwgqPwhzC1yO0wuzRs8IKBOl/Ox0IBTummCE+Cnt2hkWpB9JBbjSMwgr2KKnCpHC1Qh+FskIKPag6PkbsnD+PM+M8Cn12hkV0etdBrDaMwgoK1yM84fozQwAANMMKPqg6PkjsnD9zM+M8Cot1hkVxetdBvDaMwgqPwvU8cf0zQwAANMMKHx9RPdWUkz3k'
..'gIQ/CgB2hkXVUdVBzjmMwgoAALTCcf0zQwAAAAAKJ/J6PfgHhTrjgIQ/CgB2hkXWUdVBnDSMwgrfarM8+wcFO96maD4KmnWGRWsK1UF1NIzCCuH6sUI9irPCPYqzwgoRoCw9+wcFO1PO8T0KW3aGRSU30kFyNIzCCuqfLD37BwU7hs7xPQoNdoZFCwvYQXg0jMIKSGGW'
..'wh8FtMLD9bPCCv5n+j0Og409xUpDPwoBdoZFix7VQYs8jMIK4fqxwsN1tEI9irNCCj6E/z1i/Jg7xUpDPwoBdoZFjB7VQSI1jMIKrbIfPviLRzsinIM/Cul1hkXtsdVBqDWMwgqZb1w/IYONPRnY3T0K/XWGRTw11UEnOozCCgrXQ0AfBbTCAAC0wgpSnFg8DwgFO1j3'
..'XjwK4XWGRVH62EF4NIzCCuzRn8JcD7TCw/Wzwgoz5PE8DwgFO9KpxzsKOHaGRQqT10F2NIzCCh+FS8EfBbTCAAC0wgpHx187DwgFO7bMOD4KGHaGRYpV2EF3NIzCCkhhmMI9CrTC4fqzwgoVaPo9IYONPchKQz8KNHaGRSR+00ElOozCCnG9pUKk8LNCw/WzQgrxFHg8'
..'DQgFO16uQjwKm3WGRX5r1EF1NIzCCjOzr0JI4bPCKdyzwgoYWt48DQgFO4I12TsKjHWGRXeu1UF3NIzCCuxR+EHh+rNCAAC0QgoO5387DQgFO+yZIT4KhHWGRXoC1UF2NIzCClyPrkIp3LNCSOGzQgoUaPo9E4ONPb1KQz8KAXaGRZMe1UGhN4zCCuH6scLNTLRCFK6z'
..'Qgomavo9JIONPSNJQz8K+3WGReqg00FDOozCCuH6scKF67tCXA+sQgrkFng8EQgFO8+sQjwKcXaGRVig0kF7NIzCCmZmn8KPwrRCUjizQgojWd48EQgFO2o22TsKUXaGRZ5e0UFiNIzCCgjpfzsSCAU7ppghPgpydoZFpAfSQW80jMIK9iipwsN1tUIfhbJCCp7pYT3V'
..'Jc89cBKDOgrudYZFfNrXQbk0jMIKl8DNPBA4Cz5vEoM6Ctp1hkX9UtZBrDSMwgqPwvU8cf0zQ7jeLEMK+RICPlvbojxwEoM6CgV2hkXZxNVBpzSMwgqPwvU8cf0zQ+F6t8IKHZDYPRuiQzxvEoM6CvJ1hkXGG9ZBqjSMwgqPwvU8cf0zQx8FtkIKD3yDPuTacjtvEoM6'
..'Cvh1hkX4jtdBtjSMwgoLIzU+ViOePHASgzoKCXaGRejA1UGmNIzCCo/C9Txx/TNDuB66wgoeosM8H5DYPXASgzoK+nWGRUN11EGbNIzCCo/C9Txx/TNDrkeBPwoV/nU8fDqsPXASgzoKA3aGRar71EGfNIzCCo/C9Txx/TNDFO4wwwqp2zA+x4y0O28SgzoKK3aGRSMF'
..'1EGXNIzCCo/C9Txx/TNDcT3GwgpI02Q9QdNkPQRrpjwKF3iGRQBj1EHIO4zCCo/C9bwK1yO8AAAAAAoAAIA/AACAP83MzD0Ko50RPS6qYD2FTvE8CgB4hkWlrtZB7EOMwgoGeIZFBmTUQV1EjMIKHXiGRSwT0kGzO4zCChF4hkWgrdZBWDuMwgoNeIZFMhTSQUhEjMIh'
..'BVNvdW5kIQxBY2Nlc3NEZW5pZWQhB1NvdW5kSWQhFnJieGFzc2V0aWQ6Ly8yMDA4ODg1MTAhDUFjY2Vzc0dyYW50ZWQhFnJieGFzc2V0aWQ6Ly8yMDA4ODg0NjghCURvb3JDbG9zZSEWcmJ4YXNzZXRpZDovLzI1Nzg0MTY0MCEIRG9vck9wZW4hFnJieGFzc2V0aWQ6'
..'Ly8yNTE4ODU0OTUhCE1lc2hQYXJ0IQdCdXR0b24yB+sDBAIBzQHOAQYREREDAAAAAAAAcUAKj8L1PHH9M0MAAAAACl1/hkX/iONBULGKwgpS+DNDCtcjPAAANMMKvLxfP7WjrT8AoWA/IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8zMjEzMjIwMzU2IQhNZXNoU2l6ZQpK'
..'6KY+VrkAPx+Gpj4hCVRleHR1cmVJRCEXcmJ4YXNzZXRpZDovLzI0NTk5MzA2OTYhD1Byb3hpbWl0eVByb21wdCEMSG9sZER1cmF0aW9uAwAAAKCZmck/IQ9LZXlib2FyZEtleUNvZGUDAAAAAACAWUAhCk9iamVjdFRleHQhB0J1dHRvbjEEEwHPAdABCl1/hkV6h+NB'
..'wxuQwgePAAQZAdEB0gEGztf/AwAAAAAAgJhACgAAAAAAALTCAAAAAAqkZoZFm3XkQaBYjMIK3cfFPlaW2UA8xI5AAwAAAEAzM+M/IRJSb2xsT2ZmTWF4RGlzdGFuY2UDAAAAAAAAWUAhF3JieGFzc2V0aWQ6Ly81MDk2OTg2MTQ1IQZWb2x1bWUDAAAAAAAACEAhDVBs'
..'YXliYWNrU3BlZWQDAAAAYGZm8j8hDldlbGRDb25zdHJhaW50IQVQYXJ0MCEFUGFydDEhBlNjcmlwdCEETWFpbiEFRnJhbWUE0wHIAckBIQtCYWNrU3VyZmFjZQMAAAAAAAAkQCENQm90dG9tU3VyZmFjZQMAAAAAAAAAAAQzAdQB1QEhDEZyb250U3VyZmFjZSELTGVm'
..'dFN1cmZhY2UDAAAAAAAAkUAKAAAAAAAAAAAAALTCCrJmhkUKtf9BzoqMwiEMUmlnaHRTdXJmYWNlCn0/NT7jpY9AAACAPyEKVG9wU3VyZmFjZQQ5AcgByQEKAAAAAAAANMMAAAAACoRmhkV4k8hBAo2MwgoAADTDAAAAAAAANMMKx0uXQH0/NT4AAIA/IQRXZWxkIQJD'
..'MATWAdcB2AEhAkMxBNkB2gHbAQRCAdwB3QEK2lOGReWB40FmjYzCChkElj62Ht1AAACAPwTeAd8BxwEE4AHhAeIBBOMB5AHlAQRIAdwB3QEKdHmGRXBt40FqjYzCChkElj7detxAAACAPwTmAeEB4gEE5wHXAccBBOgB6QHqAQTrAeQB5QEhCVdlZGdlUGFydARRAewB'
..'7QEKmpkPQgAAtEIAALTCCit5hkWoDf9BKIyNwgoAALRCZmZYQgAANMMKzcxMPs3MTD3/0Zs+IQtTcGVjaWFsTWVzaCEFU2NhbGUKAACAPwFAzj0AAIA/IQhNZXNoVHlwZQMAAAAAAAAAQARbAe4B7wEKmpkPwvaoscK4nrJCCit5hkXIDf9BaI2LwgqPwrDC7FFYwhSu'
..'pz8KzcxMPs3MTD1ozJs+CgAAgD+cOM49AACAPwRhAfAB8QEKAAAAAAAAAACaGRBDCit5hkW0Df9BKIyMwgrd0Zs+zcxMPsa1fj8EZQHyAfMBCkjh/EEAALTCHwW0QgohVIZFkhn/QRSMjcIK4fqzQlyPacIAADTDCs3MTD7NzEw9UsqaPgoAAIA/ASDVPQAAgD8EawH0'
..'AfUBCgrXIzxx/TNDUjjzwgohVIZFuxn/QRSMi8IKcf0zQwrXIzxcj2lCCs3MTD5zypo+zcxMPQoAAIA/AACAP5TG0j0EcQH2AfcBCgAAAAAAAAAA12MUwwohVIZFqBn/QRSMjMIKc8qaPs3MTD4Yq34/IQRzaWduBHUBzwHQAQp9f4ZF4FzhQbPOkMIKSi0aP7A8ED9Z'
..'r6s9IRdyYnhhc3NldGlkOi8vMzIxMzIxODEzNAp0l2Q+rdpVPtCM/jwhF3JieGFzc2V0aWQ6Ly8zMjEzMjEzMTEwBHsBzQHOAQp9f4ZFLV/hQUD+icIhBkZvbGRlciEJRG9vclBhcnRzB8cABIEB+AH5AQZjX2IKpGaGRTQP5kGgWIzCChkEFj8AAAA/g8COQCEETG9j'
..'awf5AwSIAfgB+QEG/6oAAwAAAAAAAHJAChRyhkU0D+ZBMFuMwgqd7yc/mpmZPipcDz4HGgAEjQH4AfkBBhsqNQoKdYZFNA/mQTBbjMIKne8nP5qZmT43COw+BJAB+gH7AQqkZoZFffDMQcBdjMIK+roGP111Qj/MQHxAB0ABBJUB/AH9AQbKy9EKpGaGRQLczEGeWIzC'
..'CgAYFj9oTGY/YPeBQCEMVXNlUGFydENvbG9yClZKST/T/Ms9FCJ3QAqkZoZFaELPQaBYjMIKpGaGRc+ozUGgWIzCCqRmhkU1D8xBoFiMwgqkZoZFnHXKQaBYjMIKIhcWP2hMZj9w94FACqRmhkUC3MxBoFiMwgSgAf4B/wEKGGKGRTQP5kEwW4zCCp3vJz+ZmZk+B2Et'
..'QCEKU3VyZmFjZUd1aSEOWkluZGV4QmVoYXZpb3IhEENsaXBzRGVzY2VuZGFudHMhBEZhY2UhDkxpZ2h0SW5mbHVlbmNlIQ1QaXhlbHNQZXJTdHVkAwAAAAAAQH9AIQpTaXppbmdNb2RlIQlUZXh0TGFiZWwhEEJhY2tncm91bmRDb2xvcjMG////IRZCYWNrZ3JvdW5k'
..'VHJhbnNwYXJlbmN5DAAAgD8AAAAAgD8AACEERm9udCEEVGV4dCEWU2l0ZSBEaXJlY3RvcidzIE9mZmljZSEKVGV4dENvbG9yMyEKVGV4dFNjYWxlZCEIVGV4dFNpemUDAAAAAAAALEAhC1RleHRXcmFwcGVkB+kDBJABAAIBAgr0T/k+jjiQP2ZilkAEuwECAgMCCqRm'
..'hkWZ8+VBwF2Mwgr0T/k+jjiQP2ZmlkAEvgECAgMCCqRmhkUrsPpBwF2MwgTAAQQCBQIKB1aGRXgJ4EHAXYzCCvRP+T4M1rxAYCaNPgTDAQYCBwIK0XeGRXgJ4EHAXYzCCvRP+T4M1rxAdJTPPgrXZYZFfiTkQURLjMIKAACAvwAAAAAuvbszCgAAAAAAAIA/AAAAAAoA'
..'AIC/8Mymri5ttzMK6symLgAAgD/0/wmwCtdlhkXcVuRBREuMwgrDX0y5KuoPOtD/fz8K/xiwN/7/fz/c6Q+6CgAAgL8g2q2tK5E2uQpM0MMz/v9/PxxCCboKAACAPwjarS136zY5CiAxxDP+/38/HEIJugrvXEgzCgBCMNb/fz8K6DMALwAAgD/W/0EwCtdlhkV+JORB'
..'NEuMwgpe0ZI1AACAv98XmTgKAACAP5qIkjXcYgK4CgAAgMMAACBBAACAQwoAAIC/AAAAAAAAAAAKAAAAAAAAAAAAAIA/Ci659sLh0Ag+rffMwwqZhUw5v/EPOv7/f78KAACAv2wzr7ewiEy5CgAAgL+ImTAvLm23MwqAzq0vAACAP9u/yDEKfT+1PeOlD8AAAAA/CgAA'
..'AAAAAAAAAACAvwoAUOO9PvBbQABVAb8KxAYCOHcambgLAIA/CgAAgL9wg5I12AYCOAqyY/vCnOZOwMj3zMMKmYVMOSzyDzr+/3+/CgAAgL/oMq+3r4hMuQrw2JJAEZRcQIBTAb8KzczMPLSzx74l2Y++CgB+Dj4mzxHAAEIzvgp6eEy5nOoPugoAgD8Kwxiwt/L/fz9X'
..'6g86ClD98cLLQk7AyPfMwwoHIRa/nFtPv1wbYbgKMKoPOBXkLTjT/3+/CgchFj+cW08/zHphOAr9+Vq81qAfPN32f78K4VtPv6kgFj8o44C3CqkgFr/gW0+/T/KlOAodMAa/SwNaP18VPrkKYCMQOI0FSbnT/3+/ChswBj9KA1q/thw8OQpLA1q/HDAGv10m+LgKXwNa'
..'v/0vBr/wAo04Cv4vBj9eA1q/Fnc6OAomTo8zTmAsMqz/fz8K8eSAMAAAgD9LwPexCii+jzNQYDEyrP9/Pwpwp4IwAACAPybgALIKJsaPM1FgMTKs/38/CjAngzAAAIA/J+AAsgoU1pszg6BEMqz/fz8KKfKgMAAAgD9TIBSyCiXOqDPp4GEy1v9/PwrfwcIwAACAP8ig'
..'SbIKFkacM4agSTKs/38/Cqi0ojAAAIA/VCAZsgoIzqgzxOBhMqz/fz8K38HCMAAAgD+KYDGyCix25zNVka0y1v9/Pwr6gTExAACAPztxobJDAQAAAgACAAMABAAFAAEAAQIAAgAGAAQABwABAAICAAIACAAEAAkACgBABEAMACIAIwAkABkAACIAJQAmABkAACIAJwAo'
..'ABkAACIAIwApABkAACIAJQAqABkAACIAJQArABkAACIAIwAsABkAACIAIwAtABkAACIAJQAuABkAACIAJQAvABkAACIAIwAwABkAACIAJwAxABkAACIAMgAzADQAQAJAAkACQAKBIgA1ADYANwA4ADkAOgBAAkADgSIAOwA8AD0AOAA5ADoAgSIAPgA/AEAAOAA5ADoA'
..'ASIAQQBCAEMAOAA5ADoAASIARABFAEMAOAA5ADoAQAJAA4EiAEYARwBIADgAOQA6AIEiAEkASgBLADgAOQA6AAEiAEwATQBOADgAOQA6AAEiAE8AUABOADgAOQA6AEACQAJAAoEiAFEAUgBTAFQAOQA6AAEiAFUAVgBTAFQAOQA6AEADQAJABIEiAFcAWABZADgAOQA6'
..'AIEiAFoAWwBcADgAOQA6AIEiAF0AXgBfADgAOQA6AEACgSIAYABhAGIAVAA5ADoAASIAYwBkAGIAVAA5ADoAgSIAZQBmAGIAOAA5ADoAQANAAoEiAGcAaABpAFQAOQA6AEACQAIBIgBqAGsAbAA4ADkAOgABIgBtAG4AbwA4ADkAOgABIgBwAHEAcgA4ADkAOgBAAoEi'
..'AHMAdAB1AFQAOQA6AEACQAIBIgB2AHcAeAA4ADkAOgABIgB5AHoAewA4ADkAOgABIgB8AH0AfgA4ADkAOgCBIgB/AIAAgQBUADkAOgBAAoEiAIIAgwCEAFQAOQA6AEACQAIBIgCFAIYAhwA4ADkAOgABIgCIAIkAigA4ADkAOgABIgCLAIwAjQA4ADkAOgCBIgCOAI8A'
..'kAA4ADkAOgBAAkACgSIAkQCSAJMAOAA5ADoAQAJAAoEiAJQAlQCWAFQAOQA6AAEiAJcAmACWAFQAOQA6AEADQAJABIEiAJkAmgCbADgAOQA6AIEiAJwAnQBcADgAOQA6AIEiAJ4AnwCgADgAOQA6AEACgSIAoQCiAKMAVAA5ADoAASIApAClAKMAVAA5ADoAgSIApgCn'
..'AKMAOAA5ADoAQANAAoEiAKgAqQCqAFQAOQA6AEACQAIBIgCrAKwArQA4ADkAOgABIgCuAK8AsAA4ADkAOgABIgCxALIAswA4ADkAOgBAAoEiALQAtQC2AFQAOQA6AEACQAIBIgC3ALgAuQA4ADkAOgABIgC6ALsAvAA4ADkAOgABIgC9AL4AvwA4ADkAOgCBIgDAAMEA'
..'wgBUADkAOgBAAoEiAMMAxADFAFQAOQA6AEACQAIBIgDGAMcAyAA4ADkAOgABIgDJAMoAigA4ADkAOgABIgDLAMwAzQA4ADkAOgBAAkACgSIAzgDPAJMAOAA5ADoAQAJAA4EiANAA0QDSADgAOQA6AIEiANMA1ADVADgAOQA6AAEiANYA1wDYADgAOQA6AAEiANkA2gDY'
..'ADgAOQA6AEACQAOBIgDbANwA3QA4ADkAOgCBIgDeAN8A4AA4ADkAOgABIgDhAOIA4wA4ADkAOgABIgDkAOUA5gA4ADkAOgBABgEiAOcA6ADpADgA6gA6AAAiAOsA7AAZAAAiAOsA7QAZAAEiAOcA7gDpADgA6gA6AAEiAOcA7wDpADgA6gA6AAAiAOsA8AAZAAMMAAIA'
..'CwAMAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgAbABwAHQAeAB8AIAAhAPEABAIAAgDyAPMA9ADxAAQCAAIA9QDzAPYA8QAEAgACAPcA8wD4APEABAIAAgD5APMA+gD7AAMNAAIA/AAMAA0ADgD9ABAA/gAUAP8AFgAAARgAAQEaAAIBHAADAR4ABAEFAQYBBwEI'
..'AQkBCgELAQkDAAwBDQEOAQ8BEAEGAPsAAw0AAgARAQwADQAOAP0AEAASARQA/wAWAAABGADpABoAEwEcAOkAHgAEAQUBBgEHAQgBCQEKAQsBCwMADAENAQ4BDwEQAQYAIgADCwACAAYADAANAA4AFAEQABUBFAAWARYAFwEYABgBGgAZARwAGAEeABoBIAAbAfEADQMA'
..'AgDyABwBHQHzAPQA8QANAwACAPUAHAEdAfMA9gDxAA0EAAIA9wAcAR0B8wAeAR8BIAHxAA0FAAIA+QAhASIBHAEdAfMAHgEfASABIwENAAAjAQ0AACMBDQAAIwENAAAjAQ0AACMBDQAAIwENAAAjAQ0AACMBDQAAIwENAAAjAQ0AACMBDQAAJgEDAQACACcBAQACAgAC'
..'ACgBBAApASIAHw0ADAANACoBKwEsAS0BEAAuAS8BKwEwASsBFgAxARgAMgEaADMBNAErARwAMgEeADUBNgEtASIAHw0ADAANACoBKwEsAS0BEAA3AS8BKwEwASsBFgAxARgAOAEaADkBNAErARwAOgEeADsBNgErATwBIQIAPQE+AT8BQAEiAB8NAAwADQAqASsBLAEt'
..'ARAAQQEvASsBMAErARYAMQEYADgBGgBCATQBKwEcADoBHgBDATYBKwE8ASMCAD0BRAE/AUUBPAEjAgA9AT4BPwFGASIAHw0ADAANACoBKwEsAS0BEABHAS8BKwEwASsBFgAxARgAOAEaAEgBNAErARwAOgEeAEkBNgErATwBJgIAPQFEAT8BSgE8ASYCAD0BSwE/AUwB'
..'PAEmAgA9AT4BPwFNAU4BHw0ADAANACoBKwEsASsBEABPAS8BKwEwASsBFgAxARgAUAEaAFEBNAErARwAUgEeAFMBNgErAVQBKgIAVQFWAVcBWAFOAR8NAAwADQAqASsBLAErARAAWQEvASsBMAErARYAMQEYAFoBGgBbATQBKwEcAFwBHgBdATYBKwFUASwCAFUBXgFX'
..'AVgBIgAfCQAMAA0ALAEtARAAXwEWADEBGABgARoAYQEcAGABHgBiATYBLQFOAR8NAAwADQAqASsBLAErARAAYwEvASsBMAErARYAMQEYAGQBGgBlATQBKwEcAGYBHgBnATYBKwFUAS8CAFUBaAFXAVgBTgEfDQAMAA0AKgErASwBKwEQAGkBLwErATABKwEWADEBGABq'
..'ARoAawE0ASsBHABsAR4AbQE2ASsBVAExAgBVAW4BVwFYASIAHwkADAANACwBLQEQAG8BFgAxARgAcAEaAHEBHABwAR4AcgE2AS0B+wAfDQACAHMBDAANAA4A/QAQAHQBFAD/ABYAAAEYAOkAGgB1ARwA6QAeAHYBBQF3AQcBeAEJAXkB+wAfDQACAHMBDAANAA4A/QAQ'
..'AHoBFAD/ABYAAAEYAAEBGgB7ARwAAwEeAHYBBQF3AQcBeAEJAXkBfAEBAQACAH0BIgA2CAAOAH4BEAB/ARQAgAEWADEBGAAYARoAgQEcABgBHgCCASIANgkAAgCDAQ4AhAEQAIUBFACGARYAhwEYABgBGgCIARwAGAEeAIkBIgA2CAAOAIoBEACLARQAjAEWADEBGAAY'
..'ARoAjQEcABgBHgCOASIANggADgCKARAAjwEUAIwBFgAxARgAGAEaAJABHAAYAR4AkQEKAEAFgCIAmAGZARgBgCIAmAGaARgBgCIAmAGbARgBgCIAmAGcARgBACIAnQGeARgBNgkADgCSARAAkwEUAJQBFgAxARgAGAEaAJUBHAAYAR4AlgGXAQ0AIgA2CAAOAIoBEACf'
..'ARQAjAEWADEBGAAYARoAoAEcABgBHgChAaIBPAYAowEhAKQBDQClAS0BpgEhAKcBqAGpASEAqgE9CQCrAawBrQEhAB4ArgGvASABsAGxAbIBrAGzAQ0AtAG1AbYBDQAiADYIAA4AtwEQALgBFACsARYAMQEYABgBGgCQARwAGAEeALkBIgA2CAAOALcBEAC6ARQArAEW'
..'ADEBGAAYARoAuwEcABgBHgC8ASIANggADgC3ARAAvQEUAKwBFgAxARgAGAEaAL4BHAAYAR4AvAEiADYIAA4AtwEQAL8BFACsARYAMQEYABgBGgDAARwAGAEeAMEBIgA2CAAOALcBEADCARQArAEWADEBGAAYARoAwwEcABgBHgDEASASJAENEyQBDRMlATsUJAENFCUB'
..'OBUkAQ0VJQE5FiQBDRYlAToXJAENFyUBNxgkAQ0YJQE/GSQBDRklAUAaJAENGiUBQRskAQ0bJQFCHCQBDRwlAUMdJAENHSUBPCIlASEkJAEgJCUBIyUlASMnJAEgJyUBJigkAQQoJQEmKSUBJg==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
