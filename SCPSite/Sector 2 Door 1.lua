-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11528 characters

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
	if Player.Character:FindFirstChild("AccessLevel").Value < 0 then 
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


local Objects = Decode('AEDjASEFTW9kZWwhBE5hbWUhFExldmVsIERldmVsb3BlciBkb29yIQpXb3JsZFBpdm90BKUBpgGnASEERG9vcgSlAagBqQEhElNjcmlwdGVkQ29tcG9uZW50cwSqAasBrAEhBlNjcmlwdCEETWFpbiEOVW5pb25PcGVyYXRpb24hBURvb3IyIQhBbmNob3JlZCIhCkJy'
..'aWNrQ29sb3IHwgAhBkNGcmFtZQQdAKsBrAEhCkNhbkNvbGxpZGUCIQVDb2xvcgajoqUhCE1hdGVyaWFsAwAAAAAAgIlAIQtPcmllbnRhdGlvbgoAAAAAHwW0wo/C9TwhCFBvc2l0aW9uCq0XhkVbUtRBsECMwiEIUm90YXRpb24Kj8L1vAAAtMIAAAAAIQRTaXplCs3M'
..'TD20s0c/JdkPPyEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQRQYXJ0CgNrpjwYa6Y8qdPxPgqSF4ZFV0jRQRpGjMIK6VfYPFX86DymdA09CmEYhkU1LtJBC0SMwgoDa6Y8JXFHPx9rpjwKhhmGRWBT1EEvRozCCpIXhkWqJtRBM0aMwgphGIZFKAbWQS1EjMIK/RaGRWAy'
..'0kEPRIzCCpIXhkWxVNJBI0aMwgqSF4ZFEjvXQU9GjMIK/RaGRev/1UExRIzCCv0WhkVtBtRBIESMwgqSF4ZFZibWQUVGjMIKohWGRWVT1EE7RozCCim9rjzdT0c/8LQFPwqEF4ZF41LUQYw7jMIKAAAAAOH6s0KPwvW8CpfpYT3NJc89cBKDOgqyF4ZFqpzXQbU0jMIK'
..'j8L1POH6M0MAADTDAwAAAAAAABhACgAAgD8AAIA/AACAPwoAAAAAAAAAAAAAAAAKkMDNPAw4Cz5vEoM6CosXhkXNUtZBqzSMwgqPwvU84fozQ7jeLEMK9BICPlXbojxwEoM6CrYXhkWpxNVBpjSMwgqPwvU84fozQ+F6t8IKF5DYPROiQzxvEoM6CqMXhkWXG9ZBqTSM'
..'wgqPwvU84fozQx8FtkIKDHyDPtvacjtvEoM6CqkXhkXIjtdBtTSMwgqZwM08CjgLPm8SgzoKyReGRSR21UGjNIzCCo/C9Tzh+jNDrkeBvwryEgI+XtuiPHASgzoKrheGRRII1kGoNIzCCo/C9Tzh+jNDrse8QgoRkNg9IKJDPG8SgzoKtxeGRZuv1UGlNIzCCo/C9Tzh'
..'+jNDUrilwgoKfIM+4NpyO28SgzoKfxeGRWAW1EGYNIzCCh8fUT3klJM94YCEPwqfF4ZF2lHVQc05jMIKAAC0wuH6M0MAAAAAAwAAAAAAABBACifyej0ECIU64YCEPwqfF4ZF21HVQZs0jMIK3mqzPAkIBTvcpmg+CjkXhkVxCtVBdTSMwgrh+rFCmpmzwpqZs8IKDaAs'
..'PQkIBTtTzvE9CvoXhkUqN9JBcTSMwgqaGYZC4fqzQuH6s0IK6J8sPQkIBTuBzvE9CqwXhkUQC9hBdzSMwgpIYZbCPQq0wuH6s8IK/Wf6PR2DjT3DSkM/CqAXhkWRHtVBijyMwgrh+rHCZma0QpqZs0IKPIT/PXL8mDvBSkM/CqAXhkWRHtVBITWMwgqqsh8+DIxHOyCc'
..'gz8KiBeGRfKx1UGnNYzCCphvXD8vg409GNjdPQqcF4ZFQTXVQSU6jMIKCtdDQD0KtMIAALTCCk2cWDwcCAU7VfdePAqAF4ZFVvrYQXY0jMIK7NGfwlwPtMLh+rPCCjTk8TwcCAU7yqnHOwrXF4ZFD5PXQXQ0jMIKH4VLwT0KtMIAALTCCkXHXzscCAU7tMw4Pgq3F4ZF'
..'j1XYQXU0jMIKSGGYwlwPtMLh+rPCCg5o+j0vg409xkpDPwrTF4ZFKX7TQSM6jMIKcb2lQoXrs0LD9bNCCuoUeDwcCAU7W65CPAo6F4ZFg2vUQXQ0jMIKM7OvQoXrs8JI4bPCChBa3jwcCAU7gTXZOworF4ZFfK7VQXY0jMIK7FH4QcP1s0IAALRCCgbnfzscCAU77Jkh'
..'PgojF4ZFfwLVQXU0jMIKXI+uQincs0Jm5rNCChJo+j0hg409vEpDPwqgF4ZFmB7VQaA3jMIK4fqxwnE9tEJxvbNCCiVq+j0xg409H0lDPwqaF4ZF8KDTQUI6jMIK4fqxwincu0K4HqxCCuQWeDwdCAU7y6xCPAoQGIZFXaDSQXo0jMIKZmafwnG9tEJSOLNCCh9Z3jwd'
..'CAU7azbZOwrwF4ZFo17RQWI0jMIKj8IcwtcjtMLs0bPCCgTpfzsdCAU7ppghPgoRGIZFqQfSQW40jMIK9iipwqRwtUIfhbJCCj2oOj5G7Jw/jzPjPAoTGIZFdHrXQaw2jMIKCtcjPOH6M0MAADTDCj6oOj5I7Jw/czPjPAohF4ZFcXrXQbw2jMIKj8L1PHH9M0MAADTD'
..'Ch8fUT3VlJM95ICEPwqWF4ZF1VHVQc45jMIKAAC0wnH9M0MAAAAACifyej34B4U644CEPwqWF4ZF1lHVQZw0jMIK32qzPPsHBTvepmg+CjAXhkVrCtVBdTSMwgrh+rFCPYqzwj2Ks8IKEaAsPfsHBTtTzvE9CvEXhkUlN9JBcjSMwgrqnyw9+wcFO4bO8T0KoxeGRQsL'
..'2EF4NIzCCkhhlsIfBbTCw/Wzwgr+Z/o9DoONPcVKQz8KlxeGRYse1UGLPIzCCuH6scLDdbRCPYqzQgo+hP89YvyYO8VKQz8KlxeGRYwe1UEiNYzCCq2yHz74i0c7IpyDPwp/F4ZF7bHVQag1jMIKmW9cPyGDjT0Z2N09CpMXhkU8NdVBJzqMwgoK10NAHwW0wgAAtMIK'
..'UpxYPA8IBTtY9148CncXhkVR+thBeDSMwgrs0Z/CXA+0wsP1s8IKM+TxPA8IBTvSqcc7Cs4XhkUKk9dBdjSMwgofhUvBHwW0wgAAtMIKR8dfOw8IBTu2zDg+Cq4XhkWKVdhBdzSMwgpIYZjCPQq0wuH6s8IKFWj6PSGDjT3ISkM/CsoXhkUkftNBJTqMwgpxvaVCpPCz'
..'QsP1s0IK8RR4PA0IBTterkI8CjEXhkV+a9RBdTSMwgozs69CSOGzwincs8IKGFrePA0IBTuCNdk7CiIXhkV3rtVBdzSMwgrsUfhB4fqzQgAAtEIKDud/Ow0IBTvsmSE+ChoXhkV6AtVBdjSMwgpcj65CKdyzQkjhs0IKFGj6PRODjT29SkM/CpcXhkWTHtVBoTeMwgrh'
..'+rHCzUy0QhSus0IKJmr6PSSDjT0jSUM/CpEXhkXqoNNBQzqMwgrh+rHCheu7QlwPrEIK5BZ4PBEIBTvPrEI8CgcYhkVYoNJBezSMwgpmZp/Cj8K0QlI4s0IKI1nePBEIBTtqNtk7CucXhkWeXtFBYjSMwgoI6X87EggFO6aYIT4KCBiGRaQH0kFvNIzCCvYoqcLDdbVC'
..'H4WyQgqe6WE91SXPPXASgzoKhBeGRXza10G5NIzCCpfAzTwQOAs+bxKDOgpwF4ZF/VLWQaw0jMIKj8L1PHH9M0O43ixDCvkSAj5b26I8cBKDOgqbF4ZF2cTVQac0jMIKj8L1PHH9M0PherfCCh2Q2D0bokM8bxKDOgqIF4ZFxhvWQao0jMIKj8L1PHH9M0MfBbZCCg98'
..'gz7k2nI7bxKDOgqOF4ZF+I7XQbY0jMIKCyM1PlYjnjxwEoM6Cp8XhkXowNVBpjSMwgqPwvU8cf0zQ7geusIKHqLDPB+Q2D1wEoM6CpAXhkVDddRBmzSMwgqPwvU8cf0zQ65HgT8KFf51PHw6rD1wEoM6CpkXhkWq+9RBnzSMwgqPwvU8cf0zQxTuMMMKqdswPseMtDtv'
..'EoM6CsEXhkUjBdRBlzSMwgqPwvU8cf0zQ3E9xsIKSNNkPUHTZD0Ea6Y8Cq0ZhkUAY9RByDuMwgqPwvW8CtcjvAAAAAAKAACAPwAAgD/NzMw9CqOdET0uqmA9hU7xPAqWGYZFpa7WQexDjMIKnBmGRQZk1EFdRIzCCrMZhkUsE9JBszuMwgqnGYZFoK3WQVg7jMIKoxmG'
..'RTIU0kFIRIzCIQVTb3VuZCEMQWNjZXNzRGVuaWVkIQdTb3VuZElkIRZyYnhhc3NldGlkOi8vMjAwODg4NTEwIQ1BY2Nlc3NHcmFudGVkIRZyYnhhc3NldGlkOi8vMjAwODg4NDY4IQlEb29yQ2xvc2UhFnJieGFzc2V0aWQ6Ly8yNTc4NDE2NDAhCERvb3JPcGVuIRZy'
..'Ynhhc3NldGlkOi8vMjUxODg1NDk1IQhNZXNoUGFydCEHQnV0dG9uMgfrAwQEAa0BrgEGERERAwAAAAAAAHFACo/C9Txx/TNDAAAAAApt7YVF/4jjQVCxisIKUvgzQwrXIzwAADTDCry8Xz+1o60/AKFgPyEGTWVzaElkIRdyYnhhc3NldGlkOi8vMzIxMzIyMDM1NiEI'
..'TWVzaFNpemUKSuimPla5AD8fhqY+IQlUZXh0dXJlSUQhF3JieGFzc2V0aWQ6Ly8yNDU5OTMwNjk2IQ9Qcm94aW1pdHlQcm9tcHQhDEhvbGREdXJhdGlvbgMAAACgmZnJPyEPS2V5Ym9hcmRLZXlDb2RlAwAAAAAAgFlAIQpPYmplY3RUZXh0IQdCdXR0b24xBBUBrwGw'
..'AQpt7YVFeofjQcMbkMIHZwAEGwGxAbIBBsrItgMAAAAAAACRQAoAAAAAAAC0wgAAAAAKOgiGRZt15EGgWIzCCt3HxT5WltlAPMSOQCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAAAFlAIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQ1Q'
..'bGF5YmFja1NwZWVkAwAAAGBmZvI/IQ5XZWxkQ29uc3RyYWludCEFUGFydDAhBVBhcnQxIQVGcmFtZQSzAagBqQEhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAABDEBtAG1ASEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoAAAAA'
..'AAAAAAAAtMIKSAiGRQq1/0HOiozCIQxSaWdodFN1cmZhY2UKfT81PuOlj0AAAIA/IQpUb3BTdXJmYWNlBDcBqAGpAQoAAAAAAAA0wwAAAAAKGgiGRXiTyEECjYzCCgAANMMAAAAAAAA0wwrHS5dAfT81PgAAgD8hBFdlbGQhAkMwBLYBtwG4ASECQzEEuQG6AbsBBEAB'
..'vAG9AQpw9YVF5YHjQWaNjMIKGQSWPrYe3UAAAIA/BL4BvwGnAQTAAcEBwgEEwwHEAcUBBEYBvAG9AQoKG4ZFcG3jQWqNjMIKGQSWPt163EAAAIA/BMYBwQHCAQTHAbcBpwEEyAHJAcoBBMsBxAHFASEJV2VkZ2VQYXJ0BE8BzAHNAQqamQ9CAAC0QgAAtMIKwRqGRagN'
..'/0EojI3CCgAAtEJmZlhCAAA0wwrNzEw+zcxMPf/Rmz4hC1NwZWNpYWxNZXNoIQVTY2FsZQoAAIA/AUDOPQAAgD8hCE1lc2hUeXBlAwAAAAAAAABABFkBzgHPAQqamQ/C9qixwrieskIKwRqGRcgN/0FojYvCCo/CsMLsUVjCFK6nPwrNzEw+zcxMPWjMmz4KAACAP5w4'
..'zj0AAIA/BF8B0AHRAQoAAAAAAAAAAJoZEEMKwRqGRbQN/0EojIzCCt3Rmz7NzEw+xrV+PwRjAdIB0wEKSOH8QQAAtMIfBbRCCrf1hUWSGf9BFIyNwgrh+rNCXI9pwgAANMMKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwRpAdQB1QEKCtcjPHH9M0NSOPPCCrf1hUW7'
..'Gf9BFIyLwgpx/TNDCtcjPFyPaUIKzcxMPnPKmj7NzEw9CgAAgD8AAIA/lMbSPQRvAdYB1wEKAAAAAAAAAADXYxTDCrf1hUWoGf9BFIyMwgpzypo+zcxMPhirfj8hBHNpZ24EcwGvAbABCo3thUXgXOFBs86QwgpKLRo/sDwQP1mvqz0hF3JieGFzc2V0aWQ6Ly8zMjEz'
..'MjE4MTM0CnSXZD6t2lU+0Iz+PCEXcmJ4YXNzZXRpZDovLzMyMTMyMTMxMTAEeQGtAa4BCo3thUUtX+FBQP6JwiEGRm9sZGVyIQlEb29yUGFydHMhBlN0cmlwZQfpAwSAAdgB2QEG///pCjD/hUVmQvtBoliMwgojWuQ+zcxMPjLdDEAE2gG3AacBBNsB3AHdAQfHAASH'
..'Ad4B3wEGY19iCjoIhkU0D+ZBoFiMwgoZBBY/AAAAP4PAjkAhBExvY2sH+QMEjgHeAd8BBv+qAAMAAAAAAAByQAqqE4ZFNA/mQTBbjMIKne8nP5qZmT4qXA8+BxoABJMB3gHfAQYbKjUKoBaGRTQP5kEwW4zCCp3vJz+amZk+NwjsPgSWAeAB4QEKOgiGRX3wzEHAXYzC'
..'Cvq6Bj9ddUI/zEB8QAdAAQSbAeIB4wEGysvRCjoIhkUC3MxBnliMwgoAGBY/aExmP2D3gUAhDFVzZVBhcnRDb2xvcgpWSkk/0/zLPRQid0AKOgiGRWhCz0GgWIzCCjoIhkXPqM1BoFiMwgo6CIZFNQ/MQaBYjMIKOgiGRZx1ykGgWIzCCiIXFj9oTGY/cPeBQAo6CIZF'
..'AtzMQaBYjMIKbQeGRX4k5EFES4zCCgAAgL8AAAAALr27MwoAAAAAAACAPwAAAAAKAACAv/DMpq4ubbczCurMpi4AAIA/9P8JsAptB4ZF3FbkQURLjMIKw19MuSrqDzrQ/38/Cv8YsDf+/38/3OkPugoAAIC/INqtrSuRNrkKTNDDM/7/fz8cQgm6CgAAgD8I2q0td+s2'
..'OQogMcQz/v9/PxxCCboK71xIMwoAQjDW/38/CugzAC8AAIA/1v9BMAptB4ZFfiTkQTRLjMIKXtGSNQAAgL/fF5k4CgAAgD+aiJI13GICuAoAAIDDAAAgQQAAgEMKAACAvwAAAAAAAAAACgAAAAAAAAAAAACAPwouufbC4dAIPq33zMMKmYVMOb/xDzr+/3+/CgAAgL9s'
..'M6+3sIhMuQoAAIC/iJkwLy5ttzMKgM6tLwAAgD/bv8gxCn0/tT3jpQ/AAAAAPwoAAAAAAAAAAAAAgL8KAFDjvT7wW0AAVQG/CsQGAjh3Gpm4CwCAPwoAAIC/cIOSNdgGAjgKsmP7wpzmTsDI98zDCpmFTDks8g86/v9/vwoAAIC/6DKvt6+ITLkK8NiSQBGUXECAUwG/'
..'Cs3MzDy0s8e+JdmPvgoAfg4+Js8RwABCM74KenhMuZzqD7oKAIA/CsMYsLfy/38/V+oPOgpQ/fHCy0JOwMj3zMMKByEWv5xbT79cG2G4CjCqDzgV5C040/9/vwoHIRY/nFtPP8x6YTgK/flavNagHzzd9n+/CuFbT7+pIBY/KOOAtwqpIBa/4FtPv0/ypTgKHTAGv0sD'
..'Wj9fFT65CmAjEDiNBUm50/9/vwobMAY/SgNav7YcPDkKSwNavxwwBr9dJvi4Cl8DWr/9Lwa/8AKNOAr+LwY/XgNavxZ3OjgKJP6JM2HA/jGs/38/Cma+ZDAAAIA/LcCdsQpwYsY+6kBiwAArFr4KAIDJPvoXzcCACYs/CgAAgL9gAAAuAACArQpgAAAuAACAP5j/CSwK'
..'Jk6PM05gLDKs/38/CvHkgDAAAIA/S8D3sQoovo8zUGAxMqz/fz8KcKeCMAAAgD8m4ACyCibGjzNRYDEyrP9/PwowJ4MwAACAPyfgALI3AQAAAgACAAMABAAFAAEAAQIAAgAGAAQABwABAAICAAIACAAEAAkACgADAQACAAsADABABEAMACQAJQAmABsAACQAJwAoABsA'
..'ACQAKQAqABsAACQAJQArABsAACQAJwAsABsAACQAJwAtABsAACQAJQAuABsAACQAJQAvABsAACQAJwAwABsAACQAJwAxABsAACQAJQAyABsAACQAKQAzABsAACQANAA1ADYAQAJAAkACQAKBJAA3ADgAOQA6ADsAPABAAkADgSQAPQA+AD8AOgA7ADwAgSQAQABBAEIA'
..'OgA7ADwAASQAQwBEAEUAOgA7ADwAASQARgBHAEUAOgA7ADwAQAJAA4EkAEgASQBKADoAOwA8AIEkAEsATABNADoAOwA8AAEkAE4ATwBQADoAOwA8AAEkAFEAUgBQADoAOwA8AEACQAJAAoEkAFMAVABVAFYAOwA8AAEkAFcAWABVAFYAOwA8AEADQAJABIEkAFkAWgBb'
..'ADoAOwA8AIEkAFwAXQBeADoAOwA8AIEkAF8AYABhADoAOwA8AEACgSQAYgBjAGQAVgA7ADwAASQAZQBmAGQAVgA7ADwAgSQAZwBoAGQAOgA7ADwAQANAAoEkAGkAagBrAFYAOwA8AEACQAIBJABsAG0AbgA6ADsAPAABJABvAHAAcQA6ADsAPAABJAByAHMAdAA6ADsA'
..'PABAAoEkAHUAdgB3AFYAOwA8AEACQAIBJAB4AHkAegA6ADsAPAABJAB7AHwAfQA6ADsAPAABJAB+AH8AgAA6ADsAPACBJACBAIIAgwBWADsAPABAAoEkAIQAhQCGAFYAOwA8AEACQAIBJACHAIgAiQA6ADsAPAABJACKAIsAjAA6ADsAPAABJACNAI4AjwA6ADsAPACB'
..'JACQAJEAkgA6ADsAPABAAkACgSQAkwCUAJUAOgA7ADwAQAJAAoEkAJYAlwCYAFYAOwA8AAEkAJkAmgCYAFYAOwA8AEADQAJABIEkAJsAnACdADoAOwA8AIEkAJ4AnwBeADoAOwA8AIEkAKAAoQCiADoAOwA8AEACgSQAowCkAKUAVgA7ADwAASQApgCnAKUAVgA7ADwA'
..'gSQAqACpAKUAOgA7ADwAQANAAoEkAKoAqwCsAFYAOwA8AEACQAIBJACtAK4ArwA6ADsAPAABJACwALEAsgA6ADsAPAABJACzALQAtQA6ADsAPABAAoEkALYAtwC4AFYAOwA8AEACQAIBJAC5ALoAuwA6ADsAPAABJAC8AL0AvgA6ADsAPAABJAC/AMAAwQA6ADsAPACB'
..'JADCAMMAxABWADsAPABAAoEkAMUAxgDHAFYAOwA8AEACQAIBJADIAMkAygA6ADsAPAABJADLAMwAjAA6ADsAPAABJADNAM4AzwA6ADsAPABAAkACgSQA0ADRAJUAOgA7ADwAQAJAA4EkANIA0wDUADoAOwA8AIEkANUA1gDXADoAOwA8AAEkANgA2QDaADoAOwA8AAEk'
..'ANsA3ADaADoAOwA8AEACQAOBJADdAN4A3wA6ADsAPACBJADgAOEA4gA6ADsAPAABJADjAOQA5QA6ADsAPAABJADmAOcA6AA6ADsAPABABgEkAOkA6gDrADoA7AA8AAAkAO0A7gAbAAAkAO0A7wAbAAEkAOkA8ADrADoA7AA8AAEkAOkA8QDrADoA7AA8AAAkAO0A8gAb'
..'AAMMAAIADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAaABsAHAAdAB4AHwAgACEAIgAjAPMABQIAAgD0APUA9gDzAAUCAAIA9wD1APgA8wAFAgACAPkA9QD6APMABQIAAgD7APUA/AD9AAMNAAIA/gAOAA8AEAD/ABIAAAEWAAEBGAACARoAAwEcAAQBHgAFASAABgEH'
..'AQgBCQEKAQsBDAENAQoDAA4BDwEQAREBEgEGAP0AAw0AAgATAQ4ADwAQAP8AEgAUARYAAQEYAAIBGgDrABwAFQEeAOsAIAAGAQcBCAEJAQoBCwEMAQ0BDAMADgEPARABEQESAQYAJAADCgACAAYADgAPABAAFgESABcBFgAYARgAGQEaABoBHAAbAR4AGgEgABwB8wAO'
..'AwACAPQAHQEeAfUA9gDzAA4DAAIA9wAdAR4B9QD4APMADgQAAgD5AB0BHgH1AB8BIAEhAfMADgUAAgD7ACIBIwEdAR4B9QAfASABIQEkAQ4AACQBDgAAJAEOAAAkAQ4AACQBDgAAJAEOAAABAAICAAIAJwEEACgBJAAZDQAOAA8AKQEqASsBLAESAC0BLgEqAS8BKgEY'
..'ABkBGgAwARwAMQEyASoBHgAwASAAMwE0ASwBJAAZDQAOAA8AKQEqASsBLAESADUBLgEqAS8BKgEYABkBGgA2ARwANwEyASoBHgA4ASAAOQE0ASoBOgEbAgA7ATwBPQE+ASQAGQ0ADgAPACkBKgErASwBEgA/AS4BKgEvASoBGAAZARoANgEcAEABMgEqAR4AOAEgAEEB'
..'NAEqAToBHQIAOwFCAT0BQwE6AR0CADsBPAE9AUQBJAAZDQAOAA8AKQEqASsBLAESAEUBLgEqAS8BKgEYABkBGgA2ARwARgEyASoBHgA4ASAARwE0ASoBOgEgAgA7AUIBPQFIAToBIAIAOwFJAT0BSgE6ASACADsBPAE9AUsBTAEZDQAOAA8AKQEqASsBKgESAE0BLgEq'
..'AS8BKgEYABkBGgBOARwATwEyASoBHgBQASAAUQE0ASoBUgEkAgBTAVQBVQFWAUwBGQ0ADgAPACkBKgErASoBEgBXAS4BKgEvASoBGAAZARoAWAEcAFkBMgEqAR4AWgEgAFsBNAEqAVIBJgIAUwFcAVUBVgEkABkJAA4ADwArASwBEgBdARgAGQEaAF4BHABfAR4AXgEg'
..'AGABNAEsAUwBGQ0ADgAPACkBKgErASoBEgBhAS4BKgEvASoBGAAZARoAYgEcAGMBMgEqAR4AZAEgAGUBNAEqAVIBKQIAUwFmAVUBVgFMARkNAA4ADwApASoBKwEqARIAZwEuASoBLwEqARgAGQEaAGgBHABpATIBKgEeAGoBIABrATQBKgFSASsCAFMBbAFVAVYBJAAZ'
..'CQAOAA8AKwEsARIAbQEYABkBGgBuARwAbwEeAG4BIABwATQBLAH9ABkNAAIAcQEOAA8AEAD/ABIAcgEWAAEBGAACARoA6wAcAHMBHgDrACAAdAEHAXUBCQF2AQsBdwH9ABkNAAIAcQEOAA8AEAD/ABIAeAEWAAEBGAACARoAAwEcAHkBHgAFASAAdAEHAXUBCQF2AQsB'
..'dwF6AQEBAAIAewEkADAJAAIAfAEQAH0BEgB+ARYAfwEYABkBGgAaARwAgAEeABoBIACBAToBMQIAOwGCAT0BgwEkADAIABAAhAESAIUBFgCGARgAGQEaABoBHACHAR4AGgEgAIgBJAAwCQACAIkBEACKARIAiwEWAIwBGACNARoAGgEcAI4BHgAaASAAjwEkADAIABAA'
..'kAESAJEBFgCSARgAGQEaABoBHACTAR4AGgEgAJQBJAAwCAAQAJABEgCVARYAkgEYABkBGgAaARwAlgEeABoBIACXAQwAQAWAJACeAZ8BGgGAJACeAaABGgGAJACeAaEBGgGAJACeAaIBGgEAJACjAaQBGgEwCQAQAJgBEgCZARYAmgEYABkBGgAaARwAmwEeABoBIACc'
..'AZ0BDwAWEyUBDhMmATEUJQEOFCYBNxUlAQ4VJgE0FiUBDhYmATUXJQEOFyYBNhglAQ4YJgEzHCYBGx4lARoeJgEdHyYBHSElARohJgEgIiUBBSImASAjJgEgMiYBMQ==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
