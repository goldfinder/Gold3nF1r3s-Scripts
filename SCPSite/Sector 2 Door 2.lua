-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11580 characters

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


local Objects = Decode('AEDoASEFTW9kZWwhBE5hbWUhFExldmVsIERldmVsb3BlciBkb29yIQpXb3JsZFBpdm90BKYBpwGoASEERG9vcgSmAakBqgEhElNjcmlwdGVkQ29tcG9uZW50cwSrAawBrQEhBlNjcmlwdCEETWFpbiEOVW5pb25PcGVyYXRpb24hBURvb3IyIQhBbmNob3JlZCIhCkJy'
..'aWNrQ29sb3IHwgAhBkNGcmFtZQQdAKwBrQEhCkNhbkNvbGxpZGUCIQVDb2xvcgajoqUhCE1hdGVyaWFsAwAAAAAAgIlAIQtPcmllbnRhdGlvbgoAAAAA4fqzQo/C9TwhCFBvc2l0aW9uCh4lhUVbUtRBzNiMwiEIUm90YXRpb24Kj8L1PAAAtEIAAAAAIQRTaXplCs3M'
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
..'Ynhhc3NldGlkOi8vMjUxODg1NDk1IQhNZXNoUGFydCEHQnV0dG9uMgfrAwQEAa4BrwEGERERAwAAAAAAAHFACo/C9TwK1yO8AAAAAApeT4VF/4jjQRVNkMIKvLxfP7WjrT8AoWA/IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8zMjEzMjIwMzU2IQhNZXNoU2l6ZQpK6KY+'
..'VrkAPx+Gpj4hCVRleHR1cmVJRCEXcmJ4YXNzZXRpZDovLzI0NTk5MzA2OTYhD1Byb3hpbWl0eVByb21wdCEMSG9sZER1cmF0aW9uAwAAAKCZmck/IQ9LZXlib2FyZEtleUNvZGUDAAAAAACAWUAhCk9iamVjdFRleHQhB0J1dHRvbjEEFAGwAbEBCl5PhUV6h+NBE6mK'
..'wgpS+DPDCtcjPAAANEMHZwAEGwGyAbMBBsrItgMAAAAAAACRQAoAAAAAAAC0QgAAAAAKkTSFRZt15EHcwIzCCt3HxT5WltlAg8COQCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAAAFlAIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQ1Q'
..'bGF5YmFja1NwZWVkAwAAAGBmZvI/IQ5XZWxkQ29uc3RyYWludCEFUGFydDAhBVBhcnQxIQVGcmFtZQS0AakBqgEhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAABDEBtQG2ASEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoAAAAA'
..'AAA0wwAAtMIKgzSFRQq1/0GujozCIQxSaWdodFN1cmZhY2UKAAA0wwAAAAAAALRCCn0/NT7jpY9AAACAPyEKVG9wU3VyZmFjZQQ3AakBqgEKsTSFRXiTyEF6jIzCCsdLl0B9PzU+AACAPyEEV2VsZCECQzAEtwG4AbkBIQJDMQS6AbsBvAEEPwG9Ab4BCltHhUXlgeNB'
..'FoyMwgoZBJY+th7dQAAAgD8EvwHAAcEBBMIBwwHEAQTFAcYBxwEERQG9Ab4BCsEhhUVwbeNBEoyMwgoZBJY+3XrcQAAAgD8EyAHDAcQBBMkBxgHHAQTKAbgBwQEEywHMAc0BIQlXZWRnZVBhcnQETgHOAc8BCpqZD0IAALTCAAC0wgoKIoVFqA3/QVSNi8IKAAC0QmZm'
..'WMIAAAAACs3MTD7NzEw9/9GbPiELU3BlY2lhbE1lc2ghBVNjYWxlCgAAgD8BQM49AACAPyEITWVzaFR5cGUDAAAAAAAAAEAEWAHQAdEBCpqZD8IKV7ZCuJ6yQgoKIoVFyA3/QRSMjcIKcT23wuxRWEKksDLDCs3MTD7NzEw9aMybPgoAAIA/nDjOPQAAgD8EXgHSAdMB'
..'CgAAAAAAADTDmhkQQwoKIoVFtA3/QVSNjMIKAAA0wwAAAACamQ/CCt3Rmz7NzEw+xrV+PwRjAdQB1QEKCtcjPArXI7xSOPPCChRHhUW7Gf9BaI2NwgrNzEw+c8qaPs3MTD0KAACAPwAAgD+UxtI9BGgB1gHXAQoAAAAAAAA0w9djFMMKFEeFRagZ/0FojYzCCgAANMMA'
..'AAAASOH8QQpzypo+zcxMPhirfj8hBHNpZ24EbQHYAdkBCj5PhUXgXOFBI/aJwgpKLRo/sDwQP1mvqz0hF3JieGFzc2V0aWQ6Ly8zMjEzMjE4MTM0CnSXZD6t2lU+0Iz+PCEXcmJ4YXNzZXRpZDovLzMyMTMyMTMxMTAEcwGuAa8BCl5PhUUtX+FBJQCRwiEGRm9sZGVy'
..'IQlEb29yUGFydHMhBlN0cmlwZQfpAwR6AdoB2wEG///pCps9hUVnQvtB2sCMwgojWuQ+zcxMPjLdDEAE3AG4AcEBBN0B3gHfAQfHAASBAeAB4QEGY19iCpE0hUU0D+ZB3MCMwgoZBBY/AAAAP4PAjkAhBExvY2sH+QMEiAHiAeEBBv+qAAMAAAAAAAByQAohKYVFNA/m'
..'QUy+jMIKAAAAP8P1s0KuR2E/Cp3vJz+amZk+KlwPPgcaAASOAeIB4QEGGyo1CismhUU0D+ZBTL6Mwgqd7yc/mpmZPjcI7D4EkQHjAeQBCpE0hUV98MxBvLuMwgr6ugY/XXVCP8xAfEAHQAEElgHlAeYBBsrL0QqRNIVFAtzMQd7AjMIKABgWP2hMZj9g94FAIQxVc2VQ'
..'YXJ0Q29sb3IKVkpJP9P8yz0UIndACpE0hUVoQs9B3MCMwgqRNIVFz6jNQdzAjMIKkTSFRTUPzEHcwIzCCpE0hUWcdcpB3MCMwgoiFxY/aExmP3D3gUAKkTSFRQLczEHcwIzCBKIB5wHoAQpI4fxBAAC0Qh8FtEIKFEeFRZIZ/0FojYvCCh8FtEJcj2lCAAAAAArNzEw+'
..'zcxMPVLKmj4KAACAPwEg1T0AAIA/Cl41hUV+JORBIrOOwgoAAIA/ABLorP//Py8KABLorAAAgD///z8uCgAAgD/QS5iu7f/7MArQS5iuAACAP+3/+y8KXjWFRdxW5EEis47CCkd3TDkr6g861P9/vwoVGbC3/v9/P93pDzoKAACAPwAAAADUAjc5CpE/xLP+/38/H0IJ'
..'OgoAAIC/AAAAAIioNrkKvd7Ds/7/fz8fQgk6Ci/dLzMIAE4w2v9/vwqo5vGuAACAP9n/TbAKXjWFRX4k5EEys47CCmDRkrUAAIC/2xeZuAoAAIC/YIiSNS8FAjgKAACAwwAAIEEAAIBDCgAAgL8AAAAAAAAAAAoAAAAAAAAAAAAAgD8KLrn2wuHQCD6t98zDCpmFTDm/'
..'8Q86/v9/vwoAAIC/bDOvt7CITLkKAACAPxjaNy/t//swCiYuqq8AAIA/3j/KsQp9P7U946UPwAAAAD8KAAAAAAAAAAAAAIC/CgAAAAAAAIA/AAAAAAoAUOO9PvBbQABVAb8KxAYCOHcambgLAIA/CgAAgL9wg5I12AYCOAqyY/vCnOZOwMj3zMMKmYVMOSzyDzr+/3+/'
..'CgAAgL/oMq+3r4hMuQrw2JJAEZRcQIBTAb8KUP3xwstCTsDI98zDCs3MzDy0s8e+JdmPvgoAfg4+Js8RwABCM74KenhMuZzqD7oKAIA/CsMYsLfy/38/V+oPOgoHIRY/nFtPv1tSYTgKPwgQuAnkLTjX/38/CgchFr+cW08/y7FhuAqf+Vo81qAfPOH2fz8K4VtPP6kg'
..'Fj/feoE3CqkgFj/gW0+/1daluAobMAa/SgNav/0oPLkKSwNaPxwwBr9ITvg4Cl8DWj/9Lwa/C9uMuAr+Lwa/XgNavyqoOrgKAACAv/oyr7eHfEy5CjcZsLf+/38/fOoPOgo1XRMz9D+ZMZ7/f78K3vPTrwAAgD/SP5mxCnBixj7qQGLAACsWvgoAgMk++hfNwIAJiz8K'
..'AACAv2AAAC4AAICtCmAAAC4AAIA/mP8JLAo3vQgz9D/zMZ7/f78KbAUHsAAAgD+vP/OxCje9CDP1P/Mxnv9/vwo13Qcz9T/9MZ7/f78KbYoKsAAAgD+rP/2xCjfNBzP2P/0xnv9/vwrtiQuwAACAP6w/+7EKHTAGP0sDWj+mIT45Cm+BELiQBUm51/9/PzcBAAACAAIA'
..'AwAEAAUAAQABAgACAAYABAAHAAEAAgIAAgAIAAQACQAKAAMBAAIACwAMAEAEQAwAJAAlACYAGwAAJAAnACgAGwAAJAApACoAGwAAJAAlACsAGwAAJAAnACwAGwAAJAAnAC0AGwAAJAAlAC4AGwAAJAAlAC8AGwAAJAAnADAAGwAAJAAnADEAGwAAJAAlADIAGwAAJAAp'
..'ADMAGwAAJAA0ADUANgBAAkACQAJAAoEkADcAOAA5ADoAOwA8AEACQAOBJAA9AD4APwA6ADsAPACBJABAAEEAQgA6ADsAPAABJABDAEQARQA6ADsAPAABJABGAEcARQA6ADsAPABAAkADgSQASABJAEoAOgA7ADwAgSQASwBMAE0AOgA7ADwAASQATgBPAFAAOgA7ADwA'
..'ASQAUQBSAFAAOgA7ADwAQAJAAkACgSQAUwBUAFUAVgA7ADwAASQAVwBYAFUAVgA7ADwAQANAAkAEgSQAWQBaAFsAOgA7ADwAgSQAXABdAF4AOgA7ADwAgSQAXwBgAGEAOgA7ADwAQAKBJABiAGMAZABWADsAPAABJABlAGYAZABWADsAPACBJABnAGgAZAA6ADsAPABA'
..'A0ACgSQAaQBqAGsAVgA7ADwAQAJAAgEkAGwAbQBuADoAOwA8AAEkAG8AcABxADoAOwA8AAEkAHIAcwB0ADoAOwA8AEACgSQAdQB2AHcAVgA7ADwAQAJAAgEkAHgAeQB6ADoAOwA8AAEkAHsAfAB9ADoAOwA8AAEkAH4AfwCAADoAOwA8AIEkAIEAggCDAFYAOwA8AEAC'
..'gSQAhACFAIYAVgA7ADwAQAJAAgEkAIcAiACJADoAOwA8AAEkAIoAiwCMADoAOwA8AAEkAI0AjgCPADoAOwA8AIEkAJAAkQCSADoAOwA8AEACQAKBJACTAJQAlQA6ADsAPABAAkACgSQAlgCXAJgAVgA7ADwAASQAmQCaAJgAVgA7ADwAQANAAkAEgSQAmwCcAJ0AOgA7'
..'ADwAgSQAngCfAF4AOgA7ADwAgSQAoAChAKIAOgA7ADwAQAKBJACjAKQApQBWADsAPAABJACmAKcApQBWADsAPACBJACoAKkApQA6ADsAPABAA0ACgSQAqgCrAKwAVgA7ADwAQAJAAgEkAK0ArgCvADoAOwA8AAEkALAAsQCyADoAOwA8AAEkALMAtAC1ADoAOwA8AEAC'
..'gSQAtgC3ALgAVgA7ADwAQAJAAgEkALkAugC7ADoAOwA8AAEkALwAvQC+ADoAOwA8AAEkAL8AwADBADoAOwA8AIEkAMIAwwDEAFYAOwA8AEACgSQAxQDGAMcAVgA7ADwAQAJAAgEkAMgAyQDKADoAOwA8AAEkAMsAzACMADoAOwA8AAEkAM0AzgDPADoAOwA8AEACQAKB'
..'JADQANEAlQA6ADsAPABAAkADgSQA0gDTANQAOgA7ADwAgSQA1QDWANcAOgA7ADwAASQA2ADZANoAOgA7ADwAASQA2wDcANoAOgA7ADwAQAJAA4EkAN0A3gDfADoAOwA8AIEkAOAA4QDiADoAOwA8AAEkAOMA5ADlADoAOwA8AAEkAOYA5wDoADoAOwA8AEAGASQA6QDq'
..'AOsAOgDsADwAACQA7QDuABsAACQA7QDvABsAASQA6QDwAOsAOgDsADwAASQA6QDxAOsAOgDsADwAACQA7QDyABsAAwwAAgANAA4ADwAQABEAEgATABQAFQAWABcAGAAZABoAGwAcAB0AHgAfACAAIQAiACMA8wAFAgACAPQA9QD2APMABQIAAgD3APUA+ADzAAUCAAIA'
..'+QD1APoA8wAFAgACAPsA9QD8AP0AAw0AAgD+AA4ADwAQAP8AEgAAARYAAQEYAAIBGgADARwABAEeAAMBIAAFAQYBBwEIAQkBCgELAQwBCgMADQEOAQ8BEAERAQYA/QADDQACABIBDgAPABAA/wASABMBFgABARgAAgEaAOsAHAAUAR4AFQEgAAUBBgEHAQgBCQEKAQsB'
..'DAEMAwANAQ4BDwEQAREBBgAkAAMKAAIABgAOAA8AEAAWARIAFwEWABgBGAAZARoAGgEcABsBHgAaASAAHAHzAA4DAAIA9AAdAR4B9QD2APMADgMAAgD3AB0BHgH1APgA8wAOBAACAPkAHQEeAfUAHwEgASEB8wAOBQACAPsAIgEjAR0BHgH1AB8BIAEhASQBDgAAJAEO'
..'AAAkAQ4AACQBDgAAJAEOAAAkAQ4AAAEAAgIAAgAnAQQAKAEkABkNAA4ADwApASoBKwEsARIALQEuASoBLwEqARgAGQEaADABHAAxATIBKgEeADMBIAA0ATUBLAEkABkLAA4ADwApASoBKwEsARIANgEuASoBLwEqARgAGQEcADcBMgEqASAAOAE1ASoBOQEbAgA6ATsB'
..'PAE9ASQAGQsADgAPACkBKgErASwBEgA+AS4BKgEvASoBGAAZARwAPwEyASoBIABAATUBKgE5AR0CADoBQQE8AUIBOQEdAgA6ATsBPAFDASQAGQsADgAPACkBKgErASwBEgBEAS4BKgEvASoBGAAZARwARQEyASoBIABGATUBKgE5ASACADoBQQE8AUcBOQEgAgA6ATsB'
..'PAFIATkBIAIAOgFJATwBSgFLARkNAA4ADwApASoBKwEqARIATAEuASoBLwEqARgAGQEaAE0BHABOATIBKgEeAE8BIABQATUBKgFRASQCAFIBUwFUAVUBSwEZDQAOAA8AKQEqASsBKgESAFYBLgEqAS8BKgEYABkBGgBXARwAWAEyASoBHgBZASAAWgE1ASoBUQEmAgBS'
..'AVsBVAFVASQAGQkADgAPACsBLAESAFwBGAAZARoAXQEcAF4BHgBfASAAYAE1ASwBSwEZDQAOAA8AKQEqASsBKgESAGEBLgEqAS8BKgEYABkBGgBiARwAYwEyASoBHgBiASAAZAE1ASoBUQEpAgBSAWUBVAFVASQAGQkADgAPACsBLAESAGYBGAAZARoAZwEcAGgBHgBp'
..'ASAAagE1ASwB/QAZDQACAGsBDgAPABAA/wASAGwBFgABARgAAgEaAOsAHABtAR4AFQEgAG4BBgFvAQgBcAEKAXEB/QAZDQACAGsBDgAPABAA/wASAHIBFgABARgAAgEaAAMBHABzAR4AAwEgAG4BBgFvAQgBcAEKAXEBdAEBAQACAHUBJAAuCQACAHYBEAB3ARIAeAEW'
..'AHkBGAAZARoAGgEcAHoBHgAaASAAewE5AS8CADoBfAE8AX0BJAAuCAAQAH4BEgB/ARYAgAEYABkBGgAaARwAgQEeABoBIACCASQALgkAAgCDARAAhAESAIUBFgCGARgAhwEaABoBHACIAR4AiQEgAIoBJAAuCAAQAIsBEgCMARYAjQEYABkBGgAaARwAjgEeABoBIACP'
..'ASQALggAEACLARIAkAEWAI0BGAAZARoAGgEcAJEBHgAaASAAkgEMAEAFgCQAmQGaARoBgCQAmQGbARoBgCQAmQGcARoBgCQAmQGdARoBACQAngGfARoBLgkAEACTARIAlAEWAJUBGAAZARoAGgEcAJYBHgAaASAAlwGYAQ8ASwEuDQAOAA8AKQEqASsBKgESAKABLgEq'
..'AS8BKgEYABkBGgChARwAogEyASoBHgCjASAApAE1ASoBUQE2AgBSAaUBVAFVARYTJQEOEyYBLxQlAQ4UJgE1FSUBDhUmATIWJQEOFiYBMxclAQ4XJgE0GCUBDhgmATEcJgEbHiUBGh4mAR0fJgEdISUBGiEmASAiJgEgIyUBBSMmASAwJgEv')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
