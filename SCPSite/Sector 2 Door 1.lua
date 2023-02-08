-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11504 characters

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


local Objects = Decode('AEDgASEFTW9kZWwhBE5hbWUhFExldmVsIERldmVsb3BlciBkb29yIQpXb3JsZFBpdm90BKIBowGkASEERG9vcgSiAaUBpgEhElNjcmlwdGVkQ29tcG9uZW50cwSnAagBqQEhBlNjcmlwdCEETWFpbiEOVW5pb25PcGVyYXRpb24hBURvb3IyIQhBbmNob3JlZCIhCkJy'
..'aWNrQ29sb3IHwgAhBkNGcmFtZQQdAKgBqQEhCkNhbkNvbGxpZGUCIQVDb2xvcgajoqUhCE1hdGVyaWFsAwAAAAAAgIlAIQtPcmllbnRhdGlvbgoAAAAAHwW0wo/C9TwhCFBvc2l0aW9uCq0XhkVbUtRBsECMwiEIUm90YXRpb24Kj8L1vAAAtMIAAAAAIQRTaXplCs3M'
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
..'Ynhhc3NldGlkOi8vMjUxODg1NDk1IQhNZXNoUGFydCEHQnV0dG9uMgfrAwQEAaoBqwEGERERAwAAAAAAAHFACo/C9Txx/TNDAAAAAApt7YVF/4jjQVCxisIKUvgzQwrXIzwAADTDCry8Xz+1o60/AKFgPyEGTWVzaElkIRdyYnhhc3NldGlkOi8vMzIxMzIyMDM1NiEI'
..'TWVzaFNpemUKSuimPla5AD8fhqY+IQlUZXh0dXJlSUQhF3JieGFzc2V0aWQ6Ly8yNDU5OTMwNjk2IQ9Qcm94aW1pdHlQcm9tcHQhDEhvbGREdXJhdGlvbgMAAACgmZnJPyEPS2V5Ym9hcmRLZXlDb2RlAwAAAAAAgFlAIQpPYmplY3RUZXh0IQdCdXR0b24xBBUBrAGt'
..'AQpt7YVFeofjQcMbkMIHZwAEGwGuAa8BBsrItgMAAAAAAACRQAoAAAAAAAC0wgAAAAAKOgiGRZt15EGgWIzCCt3HxT5WltlAPMSOQCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAAAFlAIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQ1Q'
..'bGF5YmFja1NwZWVkAwAAAGBmZvI/IQ5XZWxkQ29uc3RyYWludCEFUGFydDAhBVBhcnQxIQVGcmFtZQSwAaUBpgEhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAABDEBsQGyASEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoAAAAA'
..'AAAAAAAAtMIKSAiGRQq1/0HOiozCIQxSaWdodFN1cmZhY2UKfT81PuOlj0AAAIA/IQpUb3BTdXJmYWNlBDcBpQGmAQoAAAAAAAA0wwAAAAAKGgiGRXiTyEECjYzCCgAANMMAAAAAAAA0wwrHS5dAfT81PgAAgD8hBFdlbGQhAkMwBLMBtAG1ASECQzEEtgG3AbgBBEAB'
..'uQG6AQpw9YVF5YHjQWaNjMIKGQSWPrYe3UAAAIA/BLsBvAGkAQS9Ab4BvwEEwAHBAcIBBEYBuQG6AQoKG4ZFcG3jQWqNjMIKGQSWPt163EAAAIA/BMMBvgG/AQTEAbQBpAEExQHGAccBBMgBwQHCASEJV2VkZ2VQYXJ0BE8ByQHKAQqamQ9CAAC0QgAAtMIKwRqGRagN'
..'/0EojI3CCgAAtEJmZlhCAAA0wwrNzEw+zcxMPf/Rmz4hC1NwZWNpYWxNZXNoIQVTY2FsZQoAAIA/AUDOPQAAgD8hCE1lc2hUeXBlAwAAAAAAAABABFkBywHMAQqamQ/C9qixwrieskIKwRqGRcgN/0FojYvCCo/CsMLsUVjCFK6nPwrNzEw+zcxMPWjMmz4KAACAP5w4'
..'zj0AAIA/BF8BzQHOAQoAAAAAAAAAAJoZEEMKwRqGRbQN/0EojIzCCt3Rmz7NzEw+xrV+PwRjAc8B0AEKSOH8QQAAtMIfBbRCCrf1hUWSGf9BFIyNwgrh+rNCXI9pwgAANMMKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwRpAdEB0gEKCtcjPHH9M0NSOPPCCrf1hUW7'
..'Gf9BFIyLwgpx/TNDCtcjPFyPaUIKzcxMPnPKmj7NzEw9CgAAgD8AAIA/lMbSPQRvAdMB1AEKAAAAAAAAAADXYxTDCrf1hUWoGf9BFIyMwgpzypo+zcxMPhirfj8hBHNpZ24EcwGsAa0BCo3thUXgXOFBs86QwgpKLRo/sDwQP1mvqz0hF3JieGFzc2V0aWQ6Ly8zMjEz'
..'MjE4MTM0CnSXZD6t2lU+0Iz+PCEXcmJ4YXNzZXRpZDovLzMyMTMyMTMxMTAEeQGqAasBCo3thUUtX+FBQP6JwiEGRm9sZGVyIQlEb29yUGFydHMhBlN0cmlwZQfpAwSAAdUB1gEG///pCjD/hUVmQvtBoliMwgojWuQ+zcxMPjLdDEAE1wG0AaQBBNgB2QHaAQfHAASH'
..'AdsB3AEGY19iCjoIhkU0D+ZBoFiMwgoZBBY/AAAAP4PAjkAhBExvY2sHGgAEjQHbAdwBBhsqNQqqE4ZFNA/mQTBbjMIKne8nP5qZmT4qXA8+BJAB2wHcAQqgFoZFNA/mQTBbjMIKne8nP5qZmT43COw+BJMB3QHeAQo6CIZFffDMQcBdjMIK+roGP111Qj/MQHxAB0AB'
..'BJgB3wHgAQbKy9EKOgiGRQLczEGeWIzCCgAYFj9oTGY/YPeBQCEMVXNlUGFydENvbG9yClZKST/T/Ms9FCJ3QAo6CIZFaELPQaBYjMIKOgiGRc+ozUGgWIzCCjoIhkU1D8xBoFiMwgo6CIZFnHXKQaBYjMIKIhcWP2hMZj9w94FACjoIhkUC3MxBoFiMwgptB4ZFfiTk'
..'QURLjMIKAACAvwAAAAAuvbszCgAAAAAAAIA/AAAAAAoAAIC/8Mymri5ttzMK6symLgAAgD/0/wmwCm0HhkXcVuRBREuMwgrDX0y5KuoPOtD/fz8K/xiwN/7/fz/c6Q+6CgAAgL8g2q2tK5E2uQpM0MMz/v9/PxxCCboKAACAPwjarS136zY5CiAxxDP+/38/HEIJugrv'
..'XEgzCgBCMNb/fz8K6DMALwAAgD/W/0EwCm0HhkV+JORBNEuMwgpe0ZI1AACAv98XmTgKAACAP5qIkjXcYgK4CgAAgMMAACBBAACAQwoAAIC/AAAAAAAAAAAKAAAAAAAAAAAAAIA/Ci659sLh0Ag+rffMwwqZhUw5v/EPOv7/f78KAACAv2wzr7ewiEy5CgAAgL+ImTAv'
..'Lm23MwqAzq0vAACAP9u/yDEKfT+1PeOlD8AAAAA/CgAAAAAAAAAAAACAvwoAUOO9PvBbQABVAb8KxAYCOHcambgLAIA/CgAAgL9wg5I12AYCOAqyY/vCnOZOwMj3zMMKmYVMOSzyDzr+/3+/CgAAgL/oMq+3r4hMuQrw2JJAEZRcQIBTAb8KzczMPLSzx74l2Y++CgB+'
..'Dj4mzxHAAEIzvgp6eEy5nOoPugoAgD8Kwxiwt/L/fz9X6g86ClD98cLLQk7AyPfMwwoHIRa/nFtPv1wbYbgKMKoPOBXkLTjT/3+/CgchFj+cW08/zHphOAr9+Vq81qAfPN32f78K4VtPv6kgFj8o44C3CqkgFr/gW0+/T/KlOAodMAa/SwNaP18VPrkKYCMQOI0FSbnT'
..'/3+/ChswBj9KA1q/thw8OQpLA1q/HDAGv10m+LgKXwNav/0vBr/wAo04Cv4vBj9eA1q/Fnc6OAok/okzYcD+Maz/fz8KZr5kMAAAgD8twJ2xCnBixj7qQGLAACsWvgoAgMk++hfNwIAJiz8KAACAv2AAAC4AAICtCmAAAC4AAIA/mP8JLAomTo8zTmAsMqz/fz8K8eSA'
..'MAAAgD9LwPexCii+jzNQYDEyrP9/Pwpwp4IwAACAPybgALIKJsaPM1FgMTKs/38/CjAngzAAAIA/J+AAsjcBAAACAAIAAwAEAAUAAQABAgACAAYABAAHAAEAAgIAAgAIAAQACQAKAAMBAAIACwAMAEAEQAwAJAAlACYAGwAAJAAnACgAGwAAJAApACoAGwAAJAAlACsA'
..'GwAAJAAnACwAGwAAJAAnAC0AGwAAJAAlAC4AGwAAJAAlAC8AGwAAJAAnADAAGwAAJAAnADEAGwAAJAAlADIAGwAAJAApADMAGwAAJAA0ADUANgBAAkACQAJAAoEkADcAOAA5ADoAOwA8AEACQAOBJAA9AD4APwA6ADsAPACBJABAAEEAQgA6ADsAPAABJABDAEQARQA6'
..'ADsAPAABJABGAEcARQA6ADsAPABAAkADgSQASABJAEoAOgA7ADwAgSQASwBMAE0AOgA7ADwAASQATgBPAFAAOgA7ADwAASQAUQBSAFAAOgA7ADwAQAJAAkACgSQAUwBUAFUAVgA7ADwAASQAVwBYAFUAVgA7ADwAQANAAkAEgSQAWQBaAFsAOgA7ADwAgSQAXABdAF4A'
..'OgA7ADwAgSQAXwBgAGEAOgA7ADwAQAKBJABiAGMAZABWADsAPAABJABlAGYAZABWADsAPACBJABnAGgAZAA6ADsAPABAA0ACgSQAaQBqAGsAVgA7ADwAQAJAAgEkAGwAbQBuADoAOwA8AAEkAG8AcABxADoAOwA8AAEkAHIAcwB0ADoAOwA8AEACgSQAdQB2AHcAVgA7'
..'ADwAQAJAAgEkAHgAeQB6ADoAOwA8AAEkAHsAfAB9ADoAOwA8AAEkAH4AfwCAADoAOwA8AIEkAIEAggCDAFYAOwA8AEACgSQAhACFAIYAVgA7ADwAQAJAAgEkAIcAiACJADoAOwA8AAEkAIoAiwCMADoAOwA8AAEkAI0AjgCPADoAOwA8AIEkAJAAkQCSADoAOwA8AEAC'
..'QAKBJACTAJQAlQA6ADsAPABAAkACgSQAlgCXAJgAVgA7ADwAASQAmQCaAJgAVgA7ADwAQANAAkAEgSQAmwCcAJ0AOgA7ADwAgSQAngCfAF4AOgA7ADwAgSQAoAChAKIAOgA7ADwAQAKBJACjAKQApQBWADsAPAABJACmAKcApQBWADsAPACBJACoAKkApQA6ADsAPABA'
..'A0ACgSQAqgCrAKwAVgA7ADwAQAJAAgEkAK0ArgCvADoAOwA8AAEkALAAsQCyADoAOwA8AAEkALMAtAC1ADoAOwA8AEACgSQAtgC3ALgAVgA7ADwAQAJAAgEkALkAugC7ADoAOwA8AAEkALwAvQC+ADoAOwA8AAEkAL8AwADBADoAOwA8AIEkAMIAwwDEAFYAOwA8AEAC'
..'gSQAxQDGAMcAVgA7ADwAQAJAAgEkAMgAyQDKADoAOwA8AAEkAMsAzACMADoAOwA8AAEkAM0AzgDPADoAOwA8AEACQAKBJADQANEAlQA6ADsAPABAAkADgSQA0gDTANQAOgA7ADwAgSQA1QDWANcAOgA7ADwAASQA2ADZANoAOgA7ADwAASQA2wDcANoAOgA7ADwAQAJA'
..'A4EkAN0A3gDfADoAOwA8AIEkAOAA4QDiADoAOwA8AAEkAOMA5ADlADoAOwA8AAEkAOYA5wDoADoAOwA8AEAGASQA6QDqAOsAOgDsADwAACQA7QDuABsAACQA7QDvABsAASQA6QDwAOsAOgDsADwAASQA6QDxAOsAOgDsADwAACQA7QDyABsAAwwAAgANAA4ADwAQABEA'
..'EgATABQAFQAWABcAGAAZABoAGwAcAB0AHgAfACAAIQAiACMA8wAFAgACAPQA9QD2APMABQIAAgD3APUA+ADzAAUCAAIA+QD1APoA8wAFAgACAPsA9QD8AP0AAw0AAgD+AA4ADwAQAP8AEgAAARYAAQEYAAIBGgADARwABAEeAAUBIAAGAQcBCAEJAQoBCwEMAQ0BCgMA'
..'DgEPARABEQESAQYA/QADDQACABMBDgAPABAA/wASABQBFgABARgAAgEaAOsAHAAVAR4A6wAgAAYBBwEIAQkBCgELAQwBDQEMAwAOAQ8BEAERARIBBgAkAAMKAAIABgAOAA8AEAAWARIAFwEWABgBGAAZARoAGgEcABsBHgAaASAAHAHzAA4DAAIA9AAdAR4B9QD2APMA'
..'DgMAAgD3AB0BHgH1APgA8wAOBAACAPkAHQEeAfUAHwEgASEB8wAOBQACAPsAIgEjAR0BHgH1AB8BIAEhASQBDgAAJAEOAAAkAQ4AACQBDgAAJAEOAAAkAQ4AAAEAAgIAAgAnAQQAKAEkABkNAA4ADwApASoBKwEsARIALQEuASoBLwEqARgAGQEaADABHAAxATIBKgEe'
..'ADABIAAzATQBLAEkABkNAA4ADwApASoBKwEsARIANQEuASoBLwEqARgAGQEaADYBHAA3ATIBKgEeADgBIAA5ATQBKgE6ARsCADsBPAE9AT4BJAAZDQAOAA8AKQEqASsBLAESAD8BLgEqAS8BKgEYABkBGgA2ARwAQAEyASoBHgA4ASAAQQE0ASoBOgEdAgA7AUIBPQFD'
..'AToBHQIAOwE8AT0BRAEkABkNAA4ADwApASoBKwEsARIARQEuASoBLwEqARgAGQEaADYBHABGATIBKgEeADgBIABHATQBKgE6ASACADsBQgE9AUgBOgEgAgA7AUkBPQFKAToBIAIAOwE8AT0BSwFMARkNAA4ADwApASoBKwEqARIATQEuASoBLwEqARgAGQEaAE4BHABP'
..'ATIBKgEeAFABIABRATQBKgFSASQCAFMBVAFVAVYBTAEZDQAOAA8AKQEqASsBKgESAFcBLgEqAS8BKgEYABkBGgBYARwAWQEyASoBHgBaASAAWwE0ASoBUgEmAgBTAVwBVQFWASQAGQkADgAPACsBLAESAF0BGAAZARoAXgEcAF8BHgBeASAAYAE0ASwBTAEZDQAOAA8A'
..'KQEqASsBKgESAGEBLgEqAS8BKgEYABkBGgBiARwAYwEyASoBHgBkASAAZQE0ASoBUgEpAgBTAWYBVQFWAUwBGQ0ADgAPACkBKgErASoBEgBnAS4BKgEvASoBGAAZARoAaAEcAGkBMgEqAR4AagEgAGsBNAEqAVIBKwIAUwFsAVUBVgEkABkJAA4ADwArASwBEgBtARgA'
..'GQEaAG4BHABvAR4AbgEgAHABNAEsAf0AGQ0AAgBxAQ4ADwAQAP8AEgByARYAAQEYAAIBGgDrABwAcwEeAOsAIAB0AQcBdQEJAXYBCwF3Af0AGQ0AAgBxAQ4ADwAQAP8AEgB4ARYAAQEYAAIBGgADARwAeQEeAAUBIAB0AQcBdQEJAXYBCwF3AXoBAQEAAgB7ASQAMAkA'
..'AgB8ARAAfQESAH4BFgB/ARgAGQEaABoBHACAAR4AGgEgAIEBOgExAgA7AYIBPQGDASQAMAgAEACEARIAhQEWAIYBGAAZARoAGgEcAIcBHgAaASAAiAEkADAJAAIAiQEQAIoBEgCLARYAjAEYABkBGgAaARwAjQEeABoBIACOASQAMAgAEACKARIAjwEWAIwBGAAZARoA'
..'GgEcAJABHgAaASAAkQEkADAIABAAigESAJIBFgCMARgAGQEaABoBHACTAR4AGgEgAJQBDABABYAkAJsBnAEaAYAkAJsBnQEaAYAkAJsBngEaAYAkAJsBnwEaAQAkAKABoQEaATAJABAAlQESAJYBFgCXARgAGQEaABoBHACYAR4AGgEgAJkBmgEPABYTJQEOEyYBMRQl'
..'AQ4UJgE3FSUBDhUmATQWJQEOFiYBNRclAQ4XJgE2GCUBDhgmATMcJgEbHiUBGh4mAR0fJgEdISUBGiEmASAiJQEFIiYBICMmASAyJgEx')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
