-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11544 characters

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


local Objects = Decode('AEDkASEFTW9kZWwhBE5hbWUhFExldmVsIERldmVsb3BlciBkb29yIQpXb3JsZFBpdm90BKIBowGkASEERG9vcgSiAaUBpgEhElNjcmlwdGVkQ29tcG9uZW50cwSnAagBqQEhBlNjcmlwdCEETWFpbiEOVW5pb25PcGVyYXRpb24hBURvb3IyIQhBbmNob3JlZCIhCkJy'
..'aWNrQ29sb3IHwgAhBkNGcmFtZQQdAKgBqQEhCkNhbkNvbGxpZGUCIQVDb2xvcgajoqUhCE1hdGVyaWFsAwAAAAAAgIlAIQtPcmllbnRhdGlvbgoAAAAA4fqzQo/C9TwhCFBvc2l0aW9uCh4lhUVbUtRBzNiMwiEIUm90YXRpb24Kj8L1PAAAtEIAAAAAIQRTaXplCs3M'
..'TD20s0c/JdkPPyEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQRQYXJ0CgVrpjwYa6Y8qdPxPgo5JYVFV0jRQWLTjMIK61fYPFX86DymdA09CmokhUU1LtJBcdWMwgoFa6Y8JXFHPx9rpjwKRSOFRWBT1EFN04zCCjklhUWqJtRBSdOMwgpqJIVFKAbWQU/VjMIKziWFRWAy'
..'0kFt1YzCCjklhUWxVNJBWdOMwgo5JYVFEjvXQS3TjMIKziWFRev/1UFL1YzCCs4lhUVtBtRBXNWMwgo5JYVFZibWQTfTjMIKKSeFRWVT1EFB04zCCiu9rjzdT0c/8LQFPwpHJYVF41LUQfDdjMIKAAAAAB8FtMKPwvW8CpfpYT3NJc89cBKDOgoZJYVFqpzXQcfkjMIK'
..'j8L1PArXo7wAADTDAwAAAAAAABhACgAAgD8AAIA/AACAPwoAAAAAAAAAAAAAAAAKkMDNPAw4Cz5vEoM6CkAlhUXNUtZB0eSMwgqPwvU8CtejvLjeLEMK9BICPlXbojxwEoM6ChUlhUWpxNVB1uSMwgqPwvU8CtejvOF6t8IKF5DYPROiQzxvEoM6CiglhUWXG9ZB0+SM'
..'wgqPwvU8CtejvB8FtkIKDHyDPtvacjtvEoM6CiIlhUXIjtdBx+SMwgqZwM08CjgLPm8SgzoKAiWFRSR21UHZ5IzCCo/C9TwK16O8rkeBvwryEgI+XtuiPHASgzoKHSWFRRII1kHU5IzCCo/C9TwK16O8rse8QgoRkNg9IKJDPG8SgzoKFCWFRZuv1UHX5IzCCo/C9TwK'
..'16O8UrilwgoKfIM+4NpyO28SgzoKTCWFRWAW1EHk5IzCCh8fUT3llJM94YCEPwosJYVF2lHVQa/fjMIKAAC0wgrXo7wAAAAAAwAAAAAAABBACifyej0FCIU64YCEPwosJYVF21HVQeHkjMIK3mqzPAcIBTvcpmg+CpIlhUVxCtVBB+WMwgrh+rFCZma0QpqZs8IKDaAs'
..'PQcIBTtTzvE9CtEkhUUqN9JBC+WMwgqaGYZCHwW0wuH6s0IK6J8sPQcIBTuBzvE9Ch8lhUUQC9hBBeWMwgpIYZbCw/WzQuH6s8IK/Wf6PRuDjT3DSkM/CislhUWRHtVB8tyMwgrh+rHCmpmzwpqZs0IKPIT/PXD8mDvBSkM/CislhUWRHtVBW+SMwgqqsh8+C4xHOyCc'
..'gz8KQyWFRfKx1UHV44zCCphvXD8vg409GNjdPQovJYVFQTXVQVffjMIKCtdDQMP1s0IAALTCCk2cWDwcCAU7VfdePApLJYVFVvrYQQbljMIK7NGfwqTws0Lh+rPCCjTk8TwcCAU7yqnHOwr0JIVFD5PXQQjljMIKH4VLwcP1s0IAALTCCkXHXzscCAU7tMw4PgoUJYVF'
..'j1XYQQfljMIKSGGYwqTws0Lh+rPCCg5o+j0vg409xkpDPwr4JIVFKX7TQVnfjMIKcb2lQnsUtMLD9bNCCuoUeDwcCAU7W65CPAqRJYVFg2vUQQjljMIKM7OvQnsUtEJI4bPCChBa3jwcCAU7gTXZOwqgJYVFfK7VQQbljMIK7FH4QT0KtMIAALRCCgbnfzscCAU77Jkh'
..'PgqoJYVFfwLVQQfljMIKXI+uQtcjtMJm5rNCChJo+j0hg409vEpDPworJYVFmB7VQdzhjMIK4fqxwo/Cs8JxvbNCCiVq+j0yg409H0lDPwoxJYVF8KDTQTrfjMIK4fqxwtcjrMK4HqxCCuQWeDwfCAU7y6xCPAq7JIVFXaDSQQLljMIKZmafwo9Cs8JSOLNCCh9Z3jwf'
..'CAU7azbZOwrbJIVFo17RQRrljMIKj8Icwincs0Ls0bPCCgTpfzsfCAU7ppghPgq6JIVFqQfSQQ7ljMIK9iipwlyPssIfhbJCCj2oOj5G7Jw/jzPjPAq4JIVFdHrXQdDijMIKCtcjPArXo7wAADTDCj6oOj5I7Jw/djPjPAqqJYVFcXrXQcDijMIKj8L1PArXI7wAADTD'
..'Ch8fUT3XlJM95ICEPwo1JYVF1VHVQa7fjMIKAAC0wgrXI7wAAAAACifyej35B4U644CEPwo1JYVF1lHVQeDkjMIK32qzPP0HBTvepmg+CpslhUVrCtVBB+WMwgrh+rFCw3W0Qj2Ks8IKEaAsPf0HBTtTzvE9CtokhUUlN9JBCuWMwgrqnyw9/QcFO4bO8T0KKCWFRQsL'
..'2EEE5YzCCkhhlsLh+rNCw/Wzwgr+Z/o9EIONPcVKQz8KNCWFRYse1UHx3IzCCuH6scI9irPCPYqzQgo+hP89ZPyYO8VKQz8KNCWFRYwe1UFa5IzCCq2yHz76i0c7IpyDPwpMJYVF7bHVQdTjjMIKmW9cPyGDjT0Z2N09CjglhUU8NdVBVd+MwgoK10NA4fqzQgAAtMIK'
..'UpxYPA8IBTtY9148ClQlhUVR+thBBOWMwgrs0Z/CpPCzQsP1s8IKM+TxPA8IBTvSqcc7Cv0khUUKk9dBBuWMwgofhUvB4fqzQgAAtMIKR8dfOw8IBTu2zDg+Ch0lhUWKVdhBBeWMwgpIYZjCw/WzQuH6s8IKFWj6PSODjT3ISkM/CgElhUUkftNBV9+MwgpxvaVCXA+0'
..'wsP1s0IK8RR4PA8IBTterkI8CpolhUV+a9RBB+WMwgozs69CuB60Qincs8IKGFrePA8IBTuCNdk7CqklhUV3rtVBBeWMwgrsUfhBHwW0wgAAtEIKDud/Ow8IBTvsmSE+CrElhUV6AtVBBuWMwgpcj65C1yO0wkjhs0IKFGj6PRSDjT29SkM/CjQlhUWTHtVB2+GMwgrh'
..'+rHCM7OzwhSus0IKJmr6PSaDjT0jSUM/CjolhUXqoNNBOd+Mwgrh+rHCexSswlwPrEIK5BZ4PBUIBTvPrEI8CsQkhUVYoNJBAeWMwgpmZp/CcT2zwlI4s0IKI1nePBUIBTtqNtk7CuQkhUWeXtFBGuWMwgoI6X87FAgFO6aYIT4KwySFRaQH0kEN5YzCCvYoqcI9irLC'
..'H4WyQgqe6WE91SXPPXASgzoKRyWFRXza10HD5IzCCpfAzTwQOAs+bxKDOgpbJYVF/VLWQdDkjMIKj8L1PArXI7y43ixDCvkSAj5b26I8cBKDOgowJYVF2cTVQdXkjMIKj8L1PArXI7zherfCCh2Q2D0bokM8bxKDOgpDJYVFxhvWQdLkjMIKj8L1PArXI7wfBbZCCg98'
..'gz7k2nI7bxKDOgo9JYVF+I7XQcbkjMIKCyM1PlYjnjxwEoM6CiwlhUXowNVB1uSMwgqPwvU8CtcjvLgeusIKHqLDPB+Q2D1wEoM6CjslhUVDddRB4eSMwgqPwvU8CtcjvK5HgT8KFf51PHw6rD1wEoM6CjIlhUWq+9RB3eSMwgqPwvU8CtcjvBTuMMMKqdswPseMtDtv'
..'EoM6CgolhUUjBdRB5eSMwgqPwvU8CtcjvHE9xsIKSNNkPUHTZD0Ga6Y8Ch4jhUUAY9RBtN2MwgqPwvW8cf0zQwAAAAAKAACAPwAAgD/NzMw9CqWdET0uqmA9hU7xPAo1I4VFpa7WQZDVjMIKLyOFRQZk1EEf1YzCChgjhUUsE9JByd2MwgokI4VFoK3WQSTejMIKKCOF'
..'RTIU0kE01YzCIQVTb3VuZCEMQWNjZXNzRGVuaWVkIQdTb3VuZElkIRZyYnhhc3NldGlkOi8vMjAwODg4NTEwIQ1BY2Nlc3NHcmFudGVkIRZyYnhhc3NldGlkOi8vMjAwODg4NDY4IQlEb29yQ2xvc2UhFnJieGFzc2V0aWQ6Ly8yNTc4NDE2NDAhCERvb3JPcGVuIRZy'
..'Ynhhc3NldGlkOi8vMjUxODg1NDk1IQhNZXNoUGFydCEHQnV0dG9uMgfrAwQEAaoBqwEGERERAwAAAAAAAHFACo/C9TwK1yO8AAAAAApeT4VF/4jjQRVNkMIKvLxfP7WjrT8AoWA/IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8zMjEzMjIwMzU2IQhNZXNoU2l6ZQpK6KY+'
..'VrkAPx+Gpj4hCVRleHR1cmVJRCEXcmJ4YXNzZXRpZDovLzI0NTk5MzA2OTYhD1Byb3hpbWl0eVByb21wdCEMSG9sZER1cmF0aW9uAwAAAKCZmck/IQ9LZXlib2FyZEtleUNvZGUDAAAAAACAWUAhCk9iamVjdFRleHQhB0J1dHRvbjEEFAGsAa0BCl5PhUV6h+NBE6mK'
..'wgpS+DPDCtcjPAAANEMHZwAEGwGuAa8BBsrItgMAAAAAAACRQAoAAAAAAAC0QgAAAAAKkTSFRZt15EHcwIzCCt3HxT5WltlAg8COQCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAAAFlAIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQ1Q'
..'bGF5YmFja1NwZWVkAwAAAGBmZvI/IQ5XZWxkQ29uc3RyYWludCEFUGFydDAhBVBhcnQxIQVGcmFtZQSwAaUBpgEhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAABDEBsQGyASEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoAAAAA'
..'AAA0wwAAtMIKgzSFRQq1/0GujozCIQxSaWdodFN1cmZhY2UKAAA0wwAAAAAAALRCCn0/NT7jpY9AAACAPyEKVG9wU3VyZmFjZQQ3AaUBpgEKsTSFRXiTyEF6jIzCCsdLl0B9PzU+AACAPyEEV2VsZCECQzAEswG0AbUBIQJDMQS2AbcBuAEEPwG5AboBCltHhUXlgeNB'
..'FoyMwgoZBJY+th7dQAAAgD8EuwG8Ab0BBL4BvwHAAQTBAcIBwwEERQG5AboBCsEhhUVwbeNBEoyMwgoZBJY+3XrcQAAAgD8ExAG/AcABBMUBwgHDAQTGAbQBvQEExwHIAckBIQlXZWRnZVBhcnQETgHKAcsBCpqZD0IAALTCAAC0wgoKIoVFqA3/QVSNi8IKAAC0QmZm'
..'WMIAAAAACs3MTD7NzEw9/9GbPiELU3BlY2lhbE1lc2ghBVNjYWxlCgAAgD8BQM49AACAPyEITWVzaFR5cGUDAAAAAAAAAEAEWAHMAc0BCpqZD8IKV7ZCuJ6yQgoKIoVFyA3/QRSMjcIKcT23wuxRWEKksDLDCs3MTD7NzEw9aMybPgoAAIA/nDjOPQAAgD8EXgHOAc8B'
..'CgAAAAAAADTDmhkQQwoKIoVFtA3/QVSNjMIKAAA0wwAAAACamQ/CCt3Rmz7NzEw+xrV+PwRjAdAB0QEKCtcjPArXI7xSOPPCChRHhUW7Gf9BaI2NwgrNzEw+c8qaPs3MTD0KAACAPwAAgD+UxtI9BGgB0gHTAQoAAAAAAAA0w9djFMMKFEeFRagZ/0FojYzCCgAANMMA'
..'AAAASOH8QQpzypo+zcxMPhirfj8hBHNpZ24EbQHUAdUBCj5PhUXgXOFBI/aJwgpKLRo/sDwQP1mvqz0hF3JieGFzc2V0aWQ6Ly8zMjEzMjE4MTM0CnSXZD6t2lU+0Iz+PCEXcmJ4YXNzZXRpZDovLzMyMTMyMTMxMTAEcwGqAasBCl5PhUUtX+FBJQCRwiEGRm9sZGVy'
..'IQlEb29yUGFydHMhBlN0cmlwZQfpAwR6AdYB1wEG///pCps9hUVnQvtB2sCMwgojWuQ+zcxMPjLdDEAE2AG0Ab0BBNkB2gHbAQfHAASBAdwB3QEGY19iCpE0hUU0D+ZB3MCMwgoZBBY/AAAAP4PAjkAhBExvY2sHGgAEhwHeAd0BBhsqNQohKYVFNA/mQUy+jMIKne8n'
..'P5qZmT4qXA8+BIoB3gHdAQorJoVFNA/mQUy+jMIKne8nP5qZmT43COw+BI0B3wHgAQqRNIVFffDMQby7jMIK+roGP111Qj/MQHxAB0ABBJIB4QHiAQbKy9EKkTSFRQLczEHewIzCCgAYFj9oTGY/YPeBQCEMVXNlUGFydENvbG9yClZKST/T/Ms9FCJ3QAqRNIVFaELP'
..'QdzAjMIKkTSFRc+ozUHcwIzCCpE0hUU1D8xB3MCMwgqRNIVFnHXKQdzAjMIKIhcWP2hMZj9w94FACpE0hUUC3MxB3MCMwgSeAeMB5AEKSOH8QQAAtEIfBbRCChRHhUWSGf9BaI2LwgofBbRCXI9pQgAAAAAKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwpeNYVFfiTk'
..'QSKzjsIKAACAPwAS6Kz//z8vCgAS6KwAAIA///8/LgoAAIA/0EuYru3/+zAK0EuYrgAAgD/t//svCl41hUXcVuRBIrOOwgpHd0w5K+oPOtT/f78KFRmwt/7/fz/d6Q86CgAAgD8AAAAA1AI3OQqRP8Sz/v9/Px9CCToKAACAvwAAAACIqDa5Cr3ew7P+/38/H0IJOgov'
..'3S8zCABOMNr/f78KqObxrgAAgD/Z/02wCl41hUV+JORBMrOOwgpg0ZK1AACAv9sXmbgKAACAv2CIkjUvBQI4CgAAgMMAACBBAACAQwoAAIC/AAAAAAAAAAAKAAAAAAAAAAAAAIA/Ci659sLh0Ag+rffMwwqZhUw5v/EPOv7/f78KAACAv2wzr7ewiEy5CgAAgD8Y2jcv'
..'7f/7MAomLqqvAACAP94/yrEKfT+1PeOlD8AAAAA/CgAAAAAAAAAAAACAvwoAAAAAAACAPwAAAAAKAFDjvT7wW0AAVQG/CsQGAjh3Gpm4CwCAPwoAAIC/cIOSNdgGAjgKsmP7wpzmTsDI98zDCpmFTDks8g86/v9/vwoAAIC/6DKvt6+ITLkK8NiSQBGUXECAUwG/ClD9'
..'8cLLQk7AyPfMwwrNzMw8tLPHviXZj74KAH4OPibPEcAAQjO+Cnp4TLmc6g+6CgCAPwrDGLC38v9/P1fqDzoKByEWP5xbT79bUmE4Cj8IELgJ5C041/9/PwoHIRa/nFtPP8uxYbgKn/laPNagHzzh9n8/CuFbTz+pIBY/33qBNwqpIBY/4FtPv9XWpbgKGzAGv0oDWr/9'
..'KDy5CksDWj8cMAa/SE74OApfA1o//S8GvwvbjLgK/i8Gv14DWr8qqDq4CgAAgL/6Mq+3h3xMuQo3GbC3/v9/P3zqDzoKNV0TM/Q/mTGe/3+/Ct7z068AAIA/0j+ZsQpwYsY+6kBiwAArFr4KAIDJPvoXzcCACYs/CgAAgL9gAAAuAACArQpgAAAuAACAP5j/CSwKN70I'
..'M/Q/8zGe/3+/CmwFB7AAAIA/rz/zsQo3vQgz9T/zMZ7/f78KNd0HM/U//TGe/3+/Cm2KCrAAAIA/qz/9sQo3zQcz9j/9MZ7/f78K7YkLsAAAgD+sP/uxCh0wBj9LA1o/piE+OQpvgRC4kAVJudf/fz83AQAAAgACAAMABAAFAAEAAQIAAgAGAAQABwABAAICAAIACAAE'
..'AAkACgADAQACAAsADABABEAMACQAJQAmABsAACQAJwAoABsAACQAKQAqABsAACQAJQArABsAACQAJwAsABsAACQAJwAtABsAACQAJQAuABsAACQAJQAvABsAACQAJwAwABsAACQAJwAxABsAACQAJQAyABsAACQAKQAzABsAACQANAA1ADYAQAJAAkACQAKBJAA3ADgA'
..'OQA6ADsAPABAAkADgSQAPQA+AD8AOgA7ADwAgSQAQABBAEIAOgA7ADwAASQAQwBEAEUAOgA7ADwAASQARgBHAEUAOgA7ADwAQAJAA4EkAEgASQBKADoAOwA8AIEkAEsATABNADoAOwA8AAEkAE4ATwBQADoAOwA8AAEkAFEAUgBQADoAOwA8AEACQAJAAoEkAFMAVABV'
..'AFYAOwA8AAEkAFcAWABVAFYAOwA8AEADQAJABIEkAFkAWgBbADoAOwA8AIEkAFwAXQBeADoAOwA8AIEkAF8AYABhADoAOwA8AEACgSQAYgBjAGQAVgA7ADwAASQAZQBmAGQAVgA7ADwAgSQAZwBoAGQAOgA7ADwAQANAAoEkAGkAagBrAFYAOwA8AEACQAIBJABsAG0A'
..'bgA6ADsAPAABJABvAHAAcQA6ADsAPAABJAByAHMAdAA6ADsAPABAAoEkAHUAdgB3AFYAOwA8AEACQAIBJAB4AHkAegA6ADsAPAABJAB7AHwAfQA6ADsAPAABJAB+AH8AgAA6ADsAPACBJACBAIIAgwBWADsAPABAAoEkAIQAhQCGAFYAOwA8AEACQAIBJACHAIgAiQA6'
..'ADsAPAABJACKAIsAjAA6ADsAPAABJACNAI4AjwA6ADsAPACBJACQAJEAkgA6ADsAPABAAkACgSQAkwCUAJUAOgA7ADwAQAJAAoEkAJYAlwCYAFYAOwA8AAEkAJkAmgCYAFYAOwA8AEADQAJABIEkAJsAnACdADoAOwA8AIEkAJ4AnwBeADoAOwA8AIEkAKAAoQCiADoA'
..'OwA8AEACgSQAowCkAKUAVgA7ADwAASQApgCnAKUAVgA7ADwAgSQAqACpAKUAOgA7ADwAQANAAoEkAKoAqwCsAFYAOwA8AEACQAIBJACtAK4ArwA6ADsAPAABJACwALEAsgA6ADsAPAABJACzALQAtQA6ADsAPABAAoEkALYAtwC4AFYAOwA8AEACQAIBJAC5ALoAuwA6'
..'ADsAPAABJAC8AL0AvgA6ADsAPAABJAC/AMAAwQA6ADsAPACBJADCAMMAxABWADsAPABAAoEkAMUAxgDHAFYAOwA8AEACQAIBJADIAMkAygA6ADsAPAABJADLAMwAjAA6ADsAPAABJADNAM4AzwA6ADsAPABAAkACgSQA0ADRAJUAOgA7ADwAQAJAA4EkANIA0wDUADoA'
..'OwA8AIEkANUA1gDXADoAOwA8AAEkANgA2QDaADoAOwA8AAEkANsA3ADaADoAOwA8AEACQAOBJADdAN4A3wA6ADsAPACBJADgAOEA4gA6ADsAPAABJADjAOQA5QA6ADsAPAABJADmAOcA6AA6ADsAPABABgEkAOkA6gDrADoA7AA8AAAkAO0A7gAbAAAkAO0A7wAbAAEk'
..'AOkA8ADrADoA7AA8AAEkAOkA8QDrADoA7AA8AAAkAO0A8gAbAAMMAAIADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAaABsAHAAdAB4AHwAgACEAIgAjAPMABQIAAgD0APUA9gDzAAUCAAIA9wD1APgA8wAFAgACAPkA9QD6APMABQIAAgD7APUA/AD9AAMNAAIA/gAO'
..'AA8AEAD/ABIAAAEWAAEBGAACARoAAwEcAAQBHgADASAABQEGAQcBCAEJAQoBCwEMAQoDAA0BDgEPARABEQEGAP0AAw0AAgASAQ4ADwAQAP8AEgATARYAAQEYAAIBGgDrABwAFAEeABUBIAAFAQYBBwEIAQkBCgELAQwBDAMADQEOAQ8BEAERAQYAJAADCgACAAYADgAP'
..'ABAAFgESABcBFgAYARgAGQEaABoBHAAbAR4AGgEgABwB8wAOAwACAPQAHQEeAfUA9gDzAA4DAAIA9wAdAR4B9QD4APMADgQAAgD5AB0BHgH1AB8BIAEhAfMADgUAAgD7ACIBIwEdAR4B9QAfASABIQEkAQ4AACQBDgAAJAEOAAAkAQ4AACQBDgAAJAEOAAABAAICAAIA'
..'JwEEACgBJAAZDQAOAA8AKQEqASsBLAESAC0BLgEqAS8BKgEYABkBGgAwARwAMQEyASoBHgAzASAANAE1ASwBJAAZCwAOAA8AKQEqASsBLAESADYBLgEqAS8BKgEYABkBHAA3ATIBKgEgADgBNQEqATkBGwIAOgE7ATwBPQEkABkLAA4ADwApASoBKwEsARIAPgEuASoB'
..'LwEqARgAGQEcAD8BMgEqASAAQAE1ASoBOQEdAgA6AUEBPAFCATkBHQIAOgE7ATwBQwEkABkLAA4ADwApASoBKwEsARIARAEuASoBLwEqARgAGQEcAEUBMgEqASAARgE1ASoBOQEgAgA6AUEBPAFHATkBIAIAOgE7ATwBSAE5ASACADoBSQE8AUoBSwEZDQAOAA8AKQEq'
..'ASsBKgESAEwBLgEqAS8BKgEYABkBGgBNARwATgEyASoBHgBPASAAUAE1ASoBUQEkAgBSAVMBVAFVAUsBGQ0ADgAPACkBKgErASoBEgBWAS4BKgEvASoBGAAZARoAVwEcAFgBMgEqAR4AWQEgAFoBNQEqAVEBJgIAUgFbAVQBVQEkABkJAA4ADwArASwBEgBcARgAGQEa'
..'AF0BHABeAR4AXwEgAGABNQEsAUsBGQ0ADgAPACkBKgErASoBEgBhAS4BKgEvASoBGAAZARoAYgEcAGMBMgEqAR4AYgEgAGQBNQEqAVEBKQIAUgFlAVQBVQEkABkJAA4ADwArASwBEgBmARgAGQEaAGcBHABoAR4AaQEgAGoBNQEsAf0AGQ0AAgBrAQ4ADwAQAP8AEgBs'
..'ARYAAQEYAAIBGgDrABwAbQEeABUBIABuAQYBbwEIAXABCgFxAf0AGQ0AAgBrAQ4ADwAQAP8AEgByARYAAQEYAAIBGgADARwAcwEeAAMBIABuAQYBbwEIAXABCgFxAXQBAQEAAgB1ASQALgkAAgB2ARAAdwESAHgBFgB5ARgAGQEaABoBHAB6AR4AGgEgAHsBOQEvAgA6'
..'AXwBPAF9ASQALggAEAB+ARIAfwEWAIABGAAZARoAGgEcAIEBHgAaASAAggEkAC4JAAIAgwEQAIQBEgCFARYAhgEYABkBGgAaARwAhwEeABoBIACIASQALggAEACEARIAiQEWAIYBGAAZARoAGgEcAIoBHgAaASAAiwEkAC4IABAAhAESAIwBFgCGARgAGQEaABoBHACN'
..'AR4AGgEgAI4BDABABYAkAJUBlgEaAYAkAJUBlwEaAYAkAJUBmAEaAYAkAJUBmQEaAQAkAJoBmwEaAS4JABAAjwESAJABFgCRARgAGQEaABoBHACSAR4AGgEgAJMBlAEPAEsBLg0ADgAPACkBKgErASoBEgCcAS4BKgEvASoBGAAZARoAnQEcAJ4BMgEqAR4AnwEgAKAB'
..'NQEqAVEBNgIAUgGhAVQBVQEWEyUBDhMmAS8UJQEOFCYBNRUlAQ4VJgEyFiUBDhYmATMXJQEOFyYBNBglAQ4YJgExHCYBGx4lARoeJgEdHyYBHSElARohJgEgIiYBICMlAQUjJgEgMCYBLw==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
