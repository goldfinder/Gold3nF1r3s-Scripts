-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 12424 characters

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
	if Player.Character:FindFirstChild("AccessLevel").Value < 7 or Player.UserId ~= owner.UserId then 
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


local Objects = Decode('AEABAiEFTW9kZWwhBE5hbWUhGExldmVsIFNpdGUgRGlyZWN0b3IgZG9vciEKV29ybGRQaXZvdATDAcQBxQEhBERvb3IEwwHGAccBIRJTY3JpcHRlZENvbXBvbmVudHMEyAHJAcoBIQZTY3JpcHQhBE1haW4hDlVuaW9uT3BlcmF0aW9uIQVEb29yMiEIQW5jaG9yZWQi'
..'IQpCcmlja0NvbG9yB8IAIQZDRnJhbWUEHQDJAcoBIQpDYW5Db2xsaWRlAiEFQ29sb3IGo6KlIQhNYXRlcmlhbAMAAAAAAICJQCELT3JpZW50YXRpb24KAAAAAB8FtMKPwvU8IQhQb3NpdGlvbgoXdoZFW1LUQbBAjMIhCFJvdGF0aW9uCo/C9bwAALTCAAAAACEEU2l6'
..'ZQrNzEw9tLNHPyXZDz8hDFRyYW5zcGFyZW5jeQMAAAAAAADwPyEEUGFydAoDa6Y8GGumPKnT8T4K/HWGRVdI0UEaRozCCulX2DxV/Og8pnQNPQrLdoZFNS7SQQtEjMIKA2umPCVxRz8fa6Y8CvB3hkVgU9RBL0aMwgr8dYZFqibUQTNGjMIKy3aGRSgG1kEtRIzCCmd1'
..'hkVgMtJBD0SMwgr8dYZFsVTSQSNGjMIK/HWGRRI710FPRozCCmd1hkXr/9VBMUSMwgpndYZFbQbUQSBEjMIK/HWGRWYm1kFFRozCCgx0hkVlU9RBO0aMwgopva483U9HP/C0BT8K7nWGReNS1EGMO4zCCgAAAADh+rNCj8L1vAqX6WE9zSXPPXASgzoKHHaGRaqc10G1'
..'NIzCCo/C9Tzh+jNDAAA0wwMAAAAAAAAYQAoAAIA/AACAPwAAgD8KAAAAAAAAAAAAAAAACpDAzTwMOAs+bxKDOgr1dYZFzVLWQas0jMIKj8L1POH6M0O43ixDCvQSAj5V26I8cBKDOgogdoZFqcTVQaY0jMIKj8L1POH6M0PherfCCheQ2D0TokM8bxKDOgoNdoZFlxvW'
..'Qak0jMIKj8L1POH6M0MfBbZCCgx8gz7b2nI7bxKDOgoTdoZFyI7XQbU0jMIKmcDNPAo4Cz5vEoM6CjN2hkUkdtVBozSMwgqPwvU84fozQ65Hgb8K8hICPl7bojxwEoM6Chh2hkUSCNZBqDSMwgqPwvU84fozQ67HvEIKEZDYPSCiQzxvEoM6CiF2hkWbr9VBpTSMwgqP'
..'wvU84fozQ1K4pcIKCnyDPuDacjtvEoM6Cul1hkVgFtRBmDSMwgofH1E95JSTPeGAhD8KCXaGRdpR1UHNOYzCCgAAtMLh+jNDAAAAAAMAAAAAAAAQQAon8no9BAiFOuGAhD8KCXaGRdtR1UGbNIzCCt5qszwJCAU73KZoPgqjdYZFcQrVQXU0jMIK4fqxQpqZs8KambPC'
..'Cg2gLD0JCAU7U87xPQpkdoZFKjfSQXE0jMIKmhmGQuH6s0Lh+rNCCuifLD0JCAU7gc7xPQoWdoZFEAvYQXc0jMIKSGGWwj0KtMLh+rPCCv1n+j0dg409w0pDPwoKdoZFkR7VQYo8jMIK4fqxwmZmtEKambNCCjyE/z1y/Jg7wUpDPwoKdoZFkR7VQSE1jMIKqrIfPgyM'
..'RzsgnIM/CvJ1hkXysdVBpzWMwgqYb1w/L4ONPRjY3T0KBnaGRUE11UElOozCCgrXQ0A9CrTCAAC0wgpNnFg8HAgFO1X3XjwK6nWGRVb62EF2NIzCCuzRn8JcD7TC4fqzwgo05PE8HAgFO8qpxzsKQXaGRQ+T10F0NIzCCh+FS8E9CrTCAAC0wgpFx187HAgFO7TMOD4K'
..'IXaGRY9V2EF1NIzCCkhhmMJcD7TC4fqzwgoOaPo9L4ONPcZKQz8KPXaGRSl+00EjOozCCnG9pUKF67NCw/WzQgrqFHg8HAgFO1uuQjwKpHWGRYNr1EF0NIzCCjOzr0KF67PCSOGzwgoQWt48HAgFO4E12TsKlXWGRXyu1UF2NIzCCuxR+EHD9bNCAAC0QgoG5387HAgF'
..'O+yZIT4KjXWGRX8C1UF1NIzCClyPrkIp3LNCZuazQgoSaPo9IYONPbxKQz8KCnaGRZge1UGgN4zCCuH6scJxPbRCcb2zQgolavo9MYONPR9JQz8KBHaGRfCg00FCOozCCuH6scIp3LtCuB6sQgrkFng8HQgFO8usQjwKenaGRV2g0kF6NIzCCmZmn8JxvbRCUjizQgof'
..'Wd48HQgFO2s22TsKWnaGRaNe0UFiNIzCCo/CHMLXI7TC7NGzwgoE6X87HQgFO6aYIT4Ke3aGRakH0kFuNIzCCvYoqcKkcLVCH4WyQgo9qDo+RuycP48z4zwKfXaGRXR610GsNozCCgrXIzzh+jNDAAA0wwo+qDo+SOycP3Mz4zwKi3WGRXF610G8NozCCo/C9Txx/TND'
..'AAA0wwofH1E91ZSTPeSAhD8KAHaGRdVR1UHOOYzCCgAAtMJx/TNDAAAAAAon8no9+AeFOuOAhD8KAHaGRdZR1UGcNIzCCt9qszz7BwU73qZoPgqadYZFawrVQXU0jMIK4fqxQj2Ks8I9irPCChGgLD37BwU7U87xPQpbdoZFJTfSQXI0jMIK6p8sPfsHBTuGzvE9Cg12'
..'hkULC9hBeDSMwgpIYZbCHwW0wsP1s8IK/mf6PQ6DjT3FSkM/CgF2hkWLHtVBizyMwgrh+rHCw3W0Qj2Ks0IKPoT/PWL8mDvFSkM/CgF2hkWMHtVBIjWMwgqtsh8++ItHOyKcgz8K6XWGRe2x1UGoNYzCCplvXD8hg409GdjdPQr9dYZFPDXVQSc6jMIKCtdDQB8FtMIA'
..'ALTCClKcWDwPCAU7WPdePArhdYZFUfrYQXg0jMIK7NGfwlwPtMLD9bPCCjPk8TwPCAU70qnHOwo4doZFCpPXQXY0jMIKH4VLwR8FtMIAALTCCkfHXzsPCAU7tsw4PgoYdoZFilXYQXc0jMIKSGGYwj0KtMLh+rPCChVo+j0hg409yEpDPwo0doZFJH7TQSU6jMIKcb2l'
..'QqTws0LD9bNCCvEUeDwNCAU7Xq5CPAqbdYZFfmvUQXU0jMIKM7OvQkjhs8Ip3LPCChha3jwNCAU7gjXZOwqMdYZFd67VQXc0jMIK7FH4QeH6s0IAALRCCg7nfzsNCAU77JkhPgqEdYZFegLVQXY0jMIKXI+uQincs0JI4bNCChRo+j0Tg409vUpDPwoBdoZFkx7VQaE3'
..'jMIK4fqxws1MtEIUrrNCCiZq+j0kg409I0lDPwr7dYZF6qDTQUM6jMIK4fqxwoXru0JcD6xCCuQWeDwRCAU7z6xCPApxdoZFWKDSQXs0jMIKZmafwo/CtEJSOLNCCiNZ3jwRCAU7ajbZOwpRdoZFnl7RQWI0jMIKCOl/OxIIBTummCE+CnJ2hkWkB9JBbzSMwgr2KKnC'
..'w3W1Qh+FskIKnulhPdUlzz1wEoM6Cu51hkV82tdBuTSMwgqXwM08EDgLPm8SgzoK2nWGRf1S1kGsNIzCCo/C9Txx/TNDuN4sQwr5EgI+W9uiPHASgzoKBXaGRdnE1UGnNIzCCo/C9Txx/TND4Xq3wgodkNg9G6JDPG8SgzoK8nWGRcYb1kGqNIzCCo/C9Txx/TNDHwW2'
..'QgoPfIM+5NpyO28SgzoK+HWGRfiO10G2NIzCCgsjNT5WI548cBKDOgoJdoZF6MDVQaY0jMIKj8L1PHH9M0O4HrrCCh6iwzwfkNg9cBKDOgr6dYZFQ3XUQZs0jMIKj8L1PHH9M0OuR4E/ChX+dTx8Oqw9cBKDOgoDdoZFqvvUQZ80jMIKj8L1PHH9M0MU7jDDCqnbMD7H'
..'jLQ7bxKDOgordoZFIwXUQZc0jMIKj8L1PHH9M0NxPcbCCkjTZD1B02Q9BGumPAoXeIZFAGPUQcg7jMIKj8L1vArXI7wAAAAACgAAgD8AAIA/zczMPQqjnRE9LqpgPYVO8TwKAHiGRaWu1kHsQ4zCCgZ4hkUGZNRBXUSMwgodeIZFLBPSQbM7jMIKEXiGRaCt1kFYO4zC'
..'Cg14hkUyFNJBSESMwiEFU291bmQhDEFjY2Vzc0RlbmllZCEHU291bmRJZCEWcmJ4YXNzZXRpZDovLzIwMDg4ODUxMCENQWNjZXNzR3JhbnRlZCEWcmJ4YXNzZXRpZDovLzIwMDg4ODQ2OCEJRG9vckNsb3NlIRZyYnhhc3NldGlkOi8vMjU3ODQxNjQwIQhEb29yT3Bl'
..'biEWcmJ4YXNzZXRpZDovLzI1MTg4NTQ5NSEITWVzaFBhcnQhB0J1dHRvbjIH6wMEBAHLAcwBBhEREQMAAAAAAABxQAqPwvU8cf0zQwAAAAAKXX+GRf+I40FQsYrCClL4M0MK1yM8AAA0wwq8vF8/taOtPwChYD8hBk1lc2hJZCEXcmJ4YXNzZXRpZDovLzMyMTMyMjAz'
..'NTYhCE1lc2hTaXplCkropj5WuQA/H4amPiEJVGV4dHVyZUlEIRdyYnhhc3NldGlkOi8vMjQ1OTkzMDY5NiEPUHJveGltaXR5UHJvbXB0IQxIb2xkRHVyYXRpb24DAAAAoJmZyT8hD0tleWJvYXJkS2V5Q29kZQMAAAAAAIBZQCEKT2JqZWN0VGV4dCEHQnV0dG9uMQQV'
..'Ac0BzgEKXX+GRXqH40HDG5DCB48ABBsBzwHQAQbO1/8DAAAAAACAmEAKAAAAAAAAtMIAAAAACqRmhkWbdeRBoFiMwgrdx8U+VpbZQDzEjkADAAAAQDMz4z8hElJvbGxPZmZNYXhEaXN0YW5jZQMAAAAAAABZQCEXcmJ4YXNzZXRpZDovLzUwOTY5ODYxNDUhBlZvbHVt'
..'ZQMAAAAAAAAIQCENUGxheWJhY2tTcGVlZAMAAABgZmbyPyEOV2VsZENvbnN0cmFpbnQhBVBhcnQwIQVQYXJ0MSEFRnJhbWUE0QHGAccBIQtCYWNrU3VyZmFjZQMAAAAAAAAkQCENQm90dG9tU3VyZmFjZQMAAAAAAAAAAAQzAdIB0wEhDEZyb250U3VyZmFjZSELTGVm'
..'dFN1cmZhY2UDAAAAAAAAkUAKAAAAAAAAAAAAALTCCrJmhkUKtf9BzoqMwiEMUmlnaHRTdXJmYWNlCn0/NT7jpY9AAACAPyEKVG9wU3VyZmFjZQQ5AcYBxwEKAAAAAAAANMMAAAAACoRmhkV4k8hBAo2MwgoAADTDAAAAAAAANMMKx0uXQH0/NT4AAIA/IQRXZWxkIQJD'
..'MATUAdUB1gEhAkMxBNcB2AHZAQRCAdoB2wEK2lOGReWB40FmjYzCChkElj62Ht1AAACAPwTcAd0BxQEE3gHfAeABBOEB4gHjAQRIAdoB2wEKdHmGRXBt40FqjYzCChkElj7detxAAACAPwTkAd8B4AEE5QHVAcUBBOYB5wHoAQTpAeIB4wEhCVdlZGdlUGFydARRAeoB'
..'6wEKmpkPQgAAtEIAALTCCit5hkWoDf9BKIyNwgoAALRCZmZYQgAANMMKzcxMPs3MTD3/0Zs+IQtTcGVjaWFsTWVzaCEFU2NhbGUKAACAPwFAzj0AAIA/IQhNZXNoVHlwZQMAAAAAAAAAQARbAewB7QEKmpkPwvaoscK4nrJCCit5hkXIDf9BaI2LwgqPwrDC7FFYwhSu'
..'pz8KzcxMPs3MTD1ozJs+CgAAgD+cOM49AACAPwRhAe4B7wEKAAAAAAAAAACaGRBDCit5hkW0Df9BKIyMwgrd0Zs+zcxMPsa1fj8EZQHwAfEBCkjh/EEAALTCHwW0QgohVIZFkhn/QRSMjcIK4fqzQlyPacIAADTDCs3MTD7NzEw9UsqaPgoAAIA/ASDVPQAAgD8EawHy'
..'AfMBCgrXIzxx/TNDUjjzwgohVIZFuxn/QRSMi8IKcf0zQwrXIzxcj2lCCs3MTD5zypo+zcxMPQoAAIA/AACAP5TG0j0EcQH0AfUBCgAAAAAAAAAA12MUwwohVIZFqBn/QRSMjMIKc8qaPs3MTD4Yq34/IQRzaWduBHUBzQHOAQp9f4ZF4FzhQbPOkMIKSi0aP7A8ED9Z'
..'r6s9IRdyYnhhc3NldGlkOi8vMzIxMzIxODEzNAp0l2Q+rdpVPtCM/jwhF3JieGFzc2V0aWQ6Ly8zMjEzMjEzMTEwBHsBywHMAQp9f4ZFLV/hQUD+icIhBkZvbGRlciEJRG9vclBhcnRzB8cABIEB9gH3AQZjX2IKpGaGRTQP5kGgWIzCChkEFj8AAAA/g8COQCEETG9j'
..'awf5AwSIAfYB9wEG/6oAAwAAAAAAAHJAChRyhkU0D+ZBMFuMwgqd7yc/mpmZPipcDz4HGgAEjQH2AfcBBhsqNQoKdYZFNA/mQTBbjMIKne8nP5qZmT43COw+BJAB+AH5AQqkZoZFffDMQcBdjMIK+roGP111Qj/MQHxAB0ABBJUB+gH7AQbKy9EKpGaGRQLczEGeWIzC'
..'CgAYFj9oTGY/YPeBQCEMVXNlUGFydENvbG9yClZKST/T/Ms9FCJ3QAqkZoZFaELPQaBYjMIKpGaGRc+ozUGgWIzCCqRmhkU1D8xBoFiMwgqkZoZFnHXKQaBYjMIKIhcWP2hMZj9w94FACqRmhkUC3MxBoFiMwgSgAfwB/QEKGGKGRTQP5kEwW4zCCp3vJz+ZmZk+B2Et'
..'QCEKU3VyZmFjZUd1aSEOWkluZGV4QmVoYXZpb3IhEENsaXBzRGVzY2VuZGFudHMhBEZhY2UhDkxpZ2h0SW5mbHVlbmNlIQ1QaXhlbHNQZXJTdHVkAwAAAAAAQH9AIQpTaXppbmdNb2RlIQlUZXh0TGFiZWwhEEJhY2tncm91bmRDb2xvcjMG////IRZCYWNrZ3JvdW5k'
..'VHJhbnNwYXJlbmN5DAAAgD8AAAAAgD8AACEERm9udCEEVGV4dCEWU2l0ZSBEaXJlY3RvcidzIE9mZmljZSEKVGV4dENvbG9yMyEKVGV4dFNjYWxlZCEIVGV4dFNpemUDAAAAAAAALEAhC1RleHRXcmFwcGVkB+kDBJAB/gH/AQr0T/k+jjiQP2ZmlkAEuwH+Af8BCqRm'
..'hkWZ8+VBwF2MwgS9Af4B/wEKpGaGRSuw+kHAXYzCBL8BAAIBAgoHVoZFeAngQcBdjMIK9E/5PgzWvEBgJo0+BMIBAAIBAgpNd4ZFeAngQcBdjMIK12WGRX4k5EFES4zCCgAAgL8AAAAALr27MwoAAAAAAACAPwAAAAAKAACAv/DMpq4ubbczCurMpi4AAIA/9P8JsArX'
..'ZYZF3FbkQURLjMIKw19MuSrqDzrQ/38/Cv8YsDf+/38/3OkPugoAAIC/INqtrSuRNrkKTNDDM/7/fz8cQgm6CgAAgD8I2q0td+s2OQogMcQz/v9/PxxCCboK71xIMwoAQjDW/38/CugzAC8AAIA/1v9BMArXZYZFfiTkQTRLjMIKXtGSNQAAgL/fF5k4CgAAgD+aiJI1'
..'3GICuAoAAIDDAAAgQQAAgEMKAACAvwAAAAAAAAAACgAAAAAAAAAAAACAPwouufbC4dAIPq33zMMKmYVMOb/xDzr+/3+/CgAAgL9sM6+3sIhMuQoAAIC/iJkwLy5ttzMKgM6tLwAAgD/bv8gxCn0/tT3jpQ/AAAAAPwoAAAAAAAAAAAAAgL8KAFDjvT7wW0AAVQG/CsQG'
..'Ajh3Gpm4CwCAPwoAAIC/cIOSNdgGAjgKsmP7wpzmTsDI98zDCpmFTDks8g86/v9/vwoAAIC/6DKvt6+ITLkK8NiSQBGUXECAUwG/Cs3MzDy0s8e+JdmPvgoAfg4+Js8RwABCM74KenhMuZzqD7oKAIA/CsMYsLfy/38/V+oPOgpQ/fHCy0JOwMj3zMMKByEWv5xbT79c'
..'G2G4CjCqDzgV5C040/9/vwoHIRY/nFtPP8x6YTgK/flavNagHzzd9n+/CuFbT7+pIBY/KOOAtwqpIBa/4FtPv0/ypTgKHTAGv0sDWj9fFT65CmAjEDiNBUm50/9/vwobMAY/SgNav7YcPDkKSwNavxwwBr9dJvi4Cl8DWr/9Lwa/8AKNOAr+LwY/XgNavxZ3OjgKJk6P'
..'M05gLDKs/38/CvHkgDAAAIA/S8D3sQoovo8zUGAxMqz/fz8KcKeCMAAAgD8m4ACyCibGjzNRYDEyrP9/PwowJ4MwAACAPyfgALIKVU6PM4dgLDIAAIA/Cu/kgDAAAIA/h2AssgoWRpwzhqBJMqz/fz8KqLSiMAAAgD9UIBmyCgjOqDPE4GEyrP9/PwrfwcIwAACAP4pg'
..'MbJCAQAAAgACAAMABAAFAAEAAQIAAgAGAAQABwABAAICAAIACAAEAAkACgADAQACAAsADABABEAMACQAJQAmABsAACQAJwAoABsAACQAKQAqABsAACQAJQArABsAACQAJwAsABsAACQAJwAtABsAACQAJQAuABsAACQAJQAvABsAACQAJwAwABsAACQAJwAxABsAACQA'
..'JQAyABsAACQAKQAzABsAACQANAA1ADYAQAJAAkACQAKBJAA3ADgAOQA6ADsAPABAAkADgSQAPQA+AD8AOgA7ADwAgSQAQABBAEIAOgA7ADwAASQAQwBEAEUAOgA7ADwAASQARgBHAEUAOgA7ADwAQAJAA4EkAEgASQBKADoAOwA8AIEkAEsATABNADoAOwA8AAEkAE4A'
..'TwBQADoAOwA8AAEkAFEAUgBQADoAOwA8AEACQAJAAoEkAFMAVABVAFYAOwA8AAEkAFcAWABVAFYAOwA8AEADQAJABIEkAFkAWgBbADoAOwA8AIEkAFwAXQBeADoAOwA8AIEkAF8AYABhADoAOwA8AEACgSQAYgBjAGQAVgA7ADwAASQAZQBmAGQAVgA7ADwAgSQAZwBo'
..'AGQAOgA7ADwAQANAAoEkAGkAagBrAFYAOwA8AEACQAIBJABsAG0AbgA6ADsAPAABJABvAHAAcQA6ADsAPAABJAByAHMAdAA6ADsAPABAAoEkAHUAdgB3AFYAOwA8AEACQAIBJAB4AHkAegA6ADsAPAABJAB7AHwAfQA6ADsAPAABJAB+AH8AgAA6ADsAPACBJACBAIIA'
..'gwBWADsAPABAAoEkAIQAhQCGAFYAOwA8AEACQAIBJACHAIgAiQA6ADsAPAABJACKAIsAjAA6ADsAPAABJACNAI4AjwA6ADsAPACBJACQAJEAkgA6ADsAPABAAkACgSQAkwCUAJUAOgA7ADwAQAJAAoEkAJYAlwCYAFYAOwA8AAEkAJkAmgCYAFYAOwA8AEADQAJABIEk'
..'AJsAnACdADoAOwA8AIEkAJ4AnwBeADoAOwA8AIEkAKAAoQCiADoAOwA8AEACgSQAowCkAKUAVgA7ADwAASQApgCnAKUAVgA7ADwAgSQAqACpAKUAOgA7ADwAQANAAoEkAKoAqwCsAFYAOwA8AEACQAIBJACtAK4ArwA6ADsAPAABJACwALEAsgA6ADsAPAABJACzALQA'
..'tQA6ADsAPABAAoEkALYAtwC4AFYAOwA8AEACQAIBJAC5ALoAuwA6ADsAPAABJAC8AL0AvgA6ADsAPAABJAC/AMAAwQA6ADsAPACBJADCAMMAxABWADsAPABAAoEkAMUAxgDHAFYAOwA8AEACQAIBJADIAMkAygA6ADsAPAABJADLAMwAjAA6ADsAPAABJADNAM4AzwA6'
..'ADsAPABAAkACgSQA0ADRAJUAOgA7ADwAQAJAA4EkANIA0wDUADoAOwA8AIEkANUA1gDXADoAOwA8AAEkANgA2QDaADoAOwA8AAEkANsA3ADaADoAOwA8AEACQAOBJADdAN4A3wA6ADsAPACBJADgAOEA4gA6ADsAPAABJADjAOQA5QA6ADsAPAABJADmAOcA6AA6ADsA'
..'PABABgEkAOkA6gDrADoA7AA8AAAkAO0A7gAbAAAkAO0A7wAbAAEkAOkA8ADrADoA7AA8AAEkAOkA8QDrADoA7AA8AAAkAO0A8gAbAAMMAAIADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAaABsAHAAdAB4AHwAgACEAIgAjAPMABQIAAgD0APUA9gDzAAUCAAIA9wD1'
..'APgA8wAFAgACAPkA9QD6APMABQIAAgD7APUA/AD9AAMNAAIA/gAOAA8AEAD/ABIAAAEWAAEBGAACARoAAwEcAAQBHgAFASAABgEHAQgBCQEKAQsBDAENAQoDAA4BDwEQAREBEgEGAP0AAw0AAgATAQ4ADwAQAP8AEgAUARYAAQEYAAIBGgDrABwAFQEeAOsAIAAGAQcB'
..'CAEJAQoBCwEMAQ0BDAMADgEPARABEQESAQYAJAADCwACAAYADgAPABAAFgESABcBFgAYARgAGQEaABoBHAAbAR4AGgEgABwBIgAdAfMADgMAAgD0AB4BHwH1APYA8wAOAwACAPcAHgEfAfUA+ADzAA4EAAIA+QAeAR8B9QAgASEBIgHzAA4FAAIA+wAjASQBHgEfAfUA'
..'IAEhASIBJQEOAAAlAQ4AACUBDgAAJQEOAAAlAQ4AACUBDgAAJQEOAAAlAQ4AACUBDgAAJQEOAAAlAQ4AAAEAAgIAAgAoAQQAKQEkAB4NAA4ADwAqASsBLAEtARIALgEvASsBMAErARgAMQEaADIBHAAzATQBKwEeADIBIAA1ATYBLQEkAB4NAA4ADwAqASsBLAEtARIA'
..'NwEvASsBMAErARgAMQEaADgBHAA5ATQBKwEeADoBIAA7ATYBKwE8ASACAD0BPgE/AUABJAAeDQAOAA8AKgErASwBLQESAEEBLwErATABKwEYADEBGgA4ARwAQgE0ASsBHgA6ASAAQwE2ASsBPAEiAgA9AUQBPwFFATwBIgIAPQE+AT8BRgEkAB4NAA4ADwAqASsBLAEt'
..'ARIARwEvASsBMAErARgAMQEaADgBHABIATQBKwEeADoBIABJATYBKwE8ASUCAD0BRAE/AUoBPAElAgA9AUsBPwFMATwBJQIAPQE+AT8BTQFOAR4NAA4ADwAqASsBLAErARIATwEvASsBMAErARgAMQEaAFABHABRATQBKwEeAFIBIABTATYBKwFUASkCAFUBVgFXAVgB'
..'TgEeDQAOAA8AKgErASwBKwESAFkBLwErATABKwEYADEBGgBaARwAWwE0ASsBHgBcASAAXQE2ASsBVAErAgBVAV4BVwFYASQAHgkADgAPACwBLQESAF8BGAAxARoAYAEcAGEBHgBgASAAYgE2AS0BTgEeDQAOAA8AKgErASwBKwESAGMBLwErATABKwEYADEBGgBkARwA'
..'ZQE0ASsBHgBmASAAZwE2ASsBVAEuAgBVAWgBVwFYAU4BHg0ADgAPACoBKwEsASsBEgBpAS8BKwEwASsBGAAxARoAagEcAGsBNAErAR4AbAEgAG0BNgErAVQBMAIAVQFuAVcBWAEkAB4JAA4ADwAsAS0BEgBvARgAMQEaAHABHABxAR4AcAEgAHIBNgEtAf0AHg0AAgBz'
..'AQ4ADwAQAP8AEgB0ARYAAQEYAAIBGgDrABwAdQEeAOsAIAB2AQcBdwEJAXgBCwF5Af0AHg0AAgBzAQ4ADwAQAP8AEgB6ARYAAQEYAAIBGgADARwAewEeAAUBIAB2AQcBdwEJAXgBCwF5AXwBAQEAAgB9ASQANQgAEAB+ARIAfwEWAIABGAAxARoAGgEcAIEBHgAaASAA'
..'ggEkADUJAAIAgwEQAIQBEgCFARYAhgEYAIcBGgAaARwAiAEeABoBIACJASQANQgAEACKARIAiwEWAIwBGAAxARoAGgEcAI0BHgAaASAAjgEkADUIABAAigESAI8BFgCMARgAMQEaABoBHACQAR4AGgEgAJEBDABABYAkAJgBmQEaAYAkAJgBmgEaAYAkAJgBmwEaAYAk'
..'AJgBnAEaAQAkAJ0BngEaATUJABAAkgESAJMBFgCUARgAMQEaABoBHACVAR4AGgEgAJYBlwEPACQANQgAEACKARIAnwEWAIwBGAAxARoAGgEcAKABHgAaASAAoQGiATsGAKMBIwCkAQ8ApQEtAaYBIwCnAagBqQEjAKoBPAkAqwGsAa0BIwAgAK4BrwEiAbABsQGyAawB'
..'swEPALQBtQG2AQ8AJAA1CAAQALcBEgC4ARYArAEYADEBGgAaARwAkAEeABoBIAC5ASQANQgAEAC3ARIAugEWAKwBGAAxARoAGgEcALsBHgAaASAAuQEkADUIABAAtwESALwBFgCsARgAMQEaABoBHAC9AR4AGgEgALkBJAA1CAAQALcBEgC+ARYArAEYADEBGgAaARwA'
..'vwEeABoBIADAASQANQgAEAC3ARIAwQEWAKwBGAAxARoAGgEcAMIBHgAaASAAwAEeEyYBDhQmAQ4UJwE6FSYBDhUnATcWJgEOFicBOBcmAQ4XJwE5GCYBDhgnATYZJgEOGScBPhomAQ4aJwE/GyYBDhsnAUAcJgEOHCcBQR0mAQ4dJwFCIScBICMmAR8jJwEiJCcBIiYm'
..'AR8mJwElJyYBBScnASUoJwEl')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
