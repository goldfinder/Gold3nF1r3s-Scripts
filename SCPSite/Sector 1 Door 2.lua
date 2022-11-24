-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11548 characters

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
	--if Player.Character:FindFirstChild("AccessLevel").Value < 0 then 
	--	Door.AccessDenied:Play()
	--	return end
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


local Objects = Decode('AEDkASEFTW9kZWwhBE5hbWUhFExldmVsIERldmVsb3BlciBkb29yIQpXb3JsZFBpdm90BKIBowGkASEERG9vcgSiAaUBpgEhElNjcmlwdGVkQ29tcG9uZW50cwSnAagBqQEhBlNjcmlwdCEETWFpbiEOVW5pb25PcGVyYXRpb24hBURvb3IyIQhBbmNob3JlZCIhCkJy'
..'aWNrQ29sb3IHwgAhBkNGcmFtZQQdAKgBqQEhCkNhbkNvbGxpZGUCIQVDb2xvcgajoqUhCE1hdGVyaWFsAwAAAAAAgIlAIQtPcmllbnRhdGlvbgoAAAAA4fqzQo/C9TwhCFBvc2l0aW9uCh4lhUURqpFAZjedwiEIUm90YXRpb24Kj8L1PAAAtEIAAAAAIQRTaXplCs3M'
..'TD20s0c/JdkPPyEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQRQYXJ0CgtrpjwYa6Y8qdPxPgo5JYVF/4GFQPwxncIK81fYPFX86DymdA09CmokhUV5GYlACzSdwgoLa6Y8JXFHPx9rpjwKRSOFRSOukUDnMZ3CCjklhUVO+5BA4zGdwgpqJIVFQ3mYQOkzncIKziWFRSQq'
..'iUAHNJ3CCjklhUVos4lA8zGdwgo5JYVF7kydQMcxncIKziWFRVNgmEDlM53CCs4lhUVZepBA9jOdwgo5JYVFPfqYQNExncIKKSeFRTiukUDbMZ3CCjG9rjzdT0c/8LQFPwpHJYVFMqyRQIo8ncIKAAAAAB8FtMKPwvW8CpfpYT3NJc89cBKDOgoZJYVFT9OeQGFDncIK'
..'j8L1PArXo7wAADTDAwAAAAAAABhACgAAgD8AAIA/AACAPwoAAAAAAAAAAAAAAAAKkMDNPAw4Cz5vEoM6CkAlhUXZq5lAa0OdwgqPwvU8CtejvLjeLEMK9BICPlXbojxwEoM6ChUlhUVKc5dAcEOdwgqPwvU8CtejvOF6t8IKF5DYPROiQzxvEoM6CiglhUUAz5hAbUOd'
..'wgqPwvU8CtejvB8FtkIKDHyDPtvacjtvEoM6CiIlhUXGm55AYUOdwgqZwM08CjgLPm8SgzoKAiWFRTU5lkBzQ53CCo/C9TwK16O8rkeBvwryEgI+XtuiPHASgzoKHSWFRe2AmEBuQ53CCo/C9TwK16O8rse8QgoRkNg9IKJDPG8SgzoKFCWFRRMfl0BxQ53CCo/C9TwK'
..'16O8UrilwgoKfIM+4NpyO28SgzoKTCWFRSa6kEB+Q53CCh8fUT3rlJM94YCEPwosJYVFEaiVQEk+ncIKAAC0wgrXo7wAAAAAAwAAAAAAABBACifyej0JCIU64YCEPwosJYVFFKiVQHtDncIK3mqzPA8IBTvcpmg+CpIlhUVqipRAoUOdwgrh+rFCZma0QpqZs8IKDaAs'
..'PQ8IBTtTzvE9CtEkhUVPPYlApUOdwgqaGYZCHwW0wuH6s0IK6J8sPQ8IBTuBzvE9Ch8lhUXojKBAn0OdwgpIYZbCw/WzQuH6s8IK/Wf6PSODjT3DSkM/CislhUXp2pRAjDudwgrh+rHCmpmzwpqZs0IKPIT/PXn8mDvBSkM/CislhUXr2pRA9UKdwgqqsh8+FoxHOyCc'
..'gz8KQyWFRW4ol0BvQp3CCphvXD81g409GNjdPQovJYVFqjWVQPE9ncIKCtdDQMP1s0IAALTCCk2cWDwhCAU7VfdePApLJYVF/0mkQKBDncIK7NGfwqTws0Lh+rPCCjTk8TwhCAU7yqnHOwr0JIVF46yeQKJDncIKH4VLwcP1s0IAALTCCkXHXzshCAU7tMw4PgoUJYVF'
..'37ahQKFDncIKSGGYwqTws0Lh+rPCCg5o+j02g409xkpDPwr4JIVFSVmOQPM9ncIKcb2lQnsUtMLD9bNCCuoUeDwhCAU7W65CPAqRJYVFsA6SQKJDncIKM7OvQnsUtEJI4bPCChBa3jwhCAU7gTXZOwqgJYVFlBqXQKBDncIK7FH4QT0KtMIAALRCCgbnfzshCAU77Jkh'
..'PgqoJYVFoWqUQKFDncIKXI+uQtcjtMJm5rNCChJo+j0mg409vEpDPworJYVFCNuUQHZAncIK4fqxwo/Cs8JxvbNCCiVq+j03g409H0lDPwoxJYVFZeSOQNQ9ncIK4fqxwtcjrMK4HqxCCuQWeDwkCAU7y6xCPAq7JIVFG+KKQJxDncIKZmafwo9Cs8JSOLNCCh9Z3jwk'
..'CAU7azbZOwrbJIVFNNuFQLRDncIKj8Icwincs0Ls0bPCCgTpfzskCAU7ppghPgq6JIVFSX+IQKhDncIK9iipwlyPssIfhbJCCj2oOj5G7Jw/mDPjPAq4JIVFeUqeQGpBncIKCtcjPArXo7wAADTDCj6oOj5I7Jw/fTPjPAqqJYVFaEqeQFpBncIKj8L1PArXI7wAADTD'
..'Ch8fUT3blJM95ICEPwo1JYVF+qeVQEg+ncIKAAC0wgrXI7wAAAAACifyej37B4U644CEPwo1JYVF/qeVQHpDncIK32qzPAAIBTvepmg+CpslhUVTipRAoUOdwgrh+rFCw3W0Qj2Ks8IKEaAsPQAIBTtTzvE9CtokhUU6PYlApEOdwgrqnyw9AAgFO4bO8T0KKCWFRdKM'
..'oECeQ53CCkhhlsLh+rNCw/Wzwgr+Z/o9FIONPcVKQz8KNCWFRdPalECLO53CCuH6scI9irPCPYqzQgo+hP89aPyYO8VKQz8KNCWFRdXalED0Qp3CCq2yHz7+i0c7IpyDPwpMJYVFWCiXQG5CncIKmW9cPyaDjT0Z2N09CjglhUWUNZVA7z2dwgoK10NA4fqzQgAAtMIK'
..'UpxYPBIIBTtY9148ClQlhUXpSaRAnkOdwgrs0Z/CpPCzQsP1s8IKM+TxPBIIBTvSqcc7Cv0khUXNrJ5AoEOdwgofhUvB4fqzQgAAtMIKR8dfOxMIBTu2zDg+Ch0lhUXJtqFAn0OdwgpIYZjCw/WzQuH6s8IKFWj6PSWDjT3ISkM/CgElhUUzWY5A8T2dwgpxvaVCXA+0'
..'wsP1s0IK8RR4PBEIBTterkI8CpolhUWZDpJAoUOdwgozs69CuB60Qincs8IKGFrePBEIBTuCNdk7CqklhUV9GpdAn0OdwgrsUfhBHwW0wgAAtEIKDud/OxEIBTvsmSE+CrElhUWKapRAoEOdwgpcj65C1yO0wkjhs0IKFGj6PRWDjT29SkM/CjQlhUXy2pRAdUCdwgrh'
..'+rHCM7OzwhSus0IKJmr6PSiDjT0jSUM/CjolhUVP5I5A0z2dwgrh+rHCexSswlwPrEIK5BZ4PBUIBTvPrEI8CsQkhUUG4opAm0OdwgpmZp/CcT2zwlI4s0IKI1nePBUIBTtqNtk7CuQkhUUf24VAtEOdwgoI6X87FAgFO6aYIT4KwySFRTR/iECnQ53CCvYoqcI9irLC'
..'H4WyQgqe6WE91SXPPXASgzoKRyWFRZPKn0BdQ53CCpfAzTwQOAs+bxKDOgpbJYVFlqyZQGpDncIKj8L1PArXI7y43ixDCvkSAj5b26I8cBKDOgowJYVFB3SXQG9DncIKj8L1PArXI7zherfCCh2Q2D0bokM8bxKDOgpDJYVFvc+YQGxDncIKj8L1PArXI7wfBbZCCg98'
..'gz7k2nI7bxKDOgo9JYVFg5yeQGBDncIKCyM1PlYjnjxwEoM6CiwlhUVDZJdAcEOdwgqPwvU8CtcjvLgeusIKHqLDPB+Q2D1wEoM6CjslhUWsNZJAe0OdwgqPwvU8CtcjvK5HgT8KFf51PHw6rD1wEoM6CjIlhUVKT5RAd0OdwgqPwvU8CtcjvBTuMMMKqdswPseMtDtv'
..'EoM6CgolhUUydZBAf0OdwgqPwvU8CtcjvHE9xsIKSNNkPUHTZD0La6Y8Ch4jhUWm7JFATjydwgqPwvW8cf0zQwAAAAAKAACAPwAAgD/NzMw9CqqdET0uqmA9hU7xPAo1I4VFORubQCo0ncIKLyOFRbvwkUC5M53CChgjhUVVrYhAYzydwgokI4VFIxebQL48ncIKKCOF'
..'RWuxiEDOM53CIQVTb3VuZCEMQWNjZXNzRGVuaWVkIQdTb3VuZElkIRZyYnhhc3NldGlkOi8vMjAwODg4NTEwIQ1BY2Nlc3NHcmFudGVkIRZyYnhhc3NldGlkOi8vMjAwODg4NDY4IQlEb29yQ2xvc2UhFnJieGFzc2V0aWQ6Ly8yNTc4NDE2NDAhCERvb3JPcGVuIRZy'
..'Ynhhc3NldGlkOi8vMjUxODg1NDk1IQhNZXNoUGFydCEHQnV0dG9uMgfrAwQEAaoBqwEGERERAwAAAAAAAHFACo/C9TwK1yO8AAAAAAp0TIVFoYTOQLCroMIKvLxfP7WjrT8AoWA/IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8zMjEzMjIwMzU2IQhNZXNoU2l6ZQpK6KY+'
..'VrkAPx+Gpj4hCVRleHR1cmVJRCEXcmJ4YXNzZXRpZDovLzI0NTk5MzA2OTYhD1Byb3hpbWl0eVByb21wdCEMSG9sZER1cmF0aW9uAwAAAKCZmck/IQ9LZXlib2FyZEtleUNvZGUDAAAAAACAWUAhCk9iamVjdFRleHQhB0J1dHRvbjEEFAGsAa0BCl5PhUWKfs5Adjmb'
..'wgpS+DPDCtcjPAAANEMHZwAEGwGuAa8BBsrItgMAAAAAAACRQAoAAAAAAAC0QgAAAAAKkTSFRRA30kB2H53CCt3HxT5WltlAg8COQCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAAAFlAIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQ1Q'
..'bGF5YmFja1NwZWVkAwAAAGBmZvI/IQ5XZWxkQ29uc3RyYWludCEFUGFydDAhBVBhcnQxIQVGcmFtZQSwAaUBpgEhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAABDEBsQGyASEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoAAAAA'
..'AAA0wwAAtMIKgzSFRWaaH0FI7ZzCIQxSaWdodFN1cmZhY2UKAAA0wwAAAAAAALRCCn0/NT7jpY9AAACAPyEKVG9wU3VyZmFjZQQ3AaUBpgEKsTSFRQhdRUAU65zCCsdLl0B9PzU+AACAPyEEV2VsZCECQzAEswG0AbUBIQJDMQS2AbcBuAEEPwG5AboBCltHhUU3aM5A'
..'sOqcwgoZBJY+th7dQAAAgD8EuwG8Ab0BBL4BvwHAAQTBAcIBwwEERQG5AboBCsEhhUVmFs5ArOqcwgoZBJY+3XrcQAAAgD8ExAG/AcABBMUBwgHDAQTGAbQBvQEExwHIAckBIQlXZWRnZVBhcnQETgHKAcsBCpqZD0IAALTCAAC0wgoKIoVFokseQe7rm8IKAAC0QmZm'
..'WMIAAAAACs3MTD7NzEw9/9GbPiELU3BlY2lhbE1lc2ghBVNjYWxlCgAAgD8BQM49AACAPyEITWVzaFR5cGUDAAAAAAAAAEAEWAHMAc0BCpqZD8IKV7ZCuJ6yQgoKIoVF4kseQa7qncIKcT23wuxRWEKksDLDCs3MTD7NzEw9aMybPgoAAIA/nDjOPQAAgD8EXgHOAc8B'
..'CgAAAAAAADTDmhkQQwoKIoVFukseQe7rnMIKAAA0wwAAAACamQ/CCt3Rmz7NzEw+xrV+PwRjAdAB0QEKSOH8QQAAtEIfBbRCChRHhUV2Yx5BAuybwgofBbRCXI9pQgAAAAAKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwRpAdIB0wEKCtcjPArXI7xSOPPCChRHhUXI'
..'Yx5BAuydwgrNzEw+c8qaPs3MTD0KAACAPwAAgD+UxtI9BG4B1AHVAQoAAAAAAAA0w9djFMMKFEeFRaJjHkEC7JzCCgAANMMAAAAASOH8QQpzypo+zcxMPhirfj8hBHNpZ24EcwHWAasBCj5PhUUl1MVAhoaawgpKLRo/sDwQP1mvqz0hF3JieGFzc2V0aWQ6Ly8zMjEz'
..'MjE4MTM0CnSXZD6t2lU+0Iz+PCEXcmJ4YXNzZXRpZDovLzMyMTMyMTMxMTAEeQHXAa0BCpRMhUVX3cVAwF6hwiEGRm9sZGVyIQlEb29yUGFydHMhBlN0cmlwZQfpAwSAAdgB2QEG///pCps9hUUgtRZBdB+dwgojWuQ+zcxMPjLdDEAE2gG0Ab0BBNsB3AHdAQfHAASH'
..'Ad4B3wEGY19iCpE0hUV2ndhAdh+dwgoZBBY/AAAAP4PAjkAHGgAEjAHgAd8BBhsqNQohKYVFdp3YQOYcncIKSOH6PsP1s0KamVk/Cp3vJz+amZk+KlwPPgSQAeAB3wEKKyaFRXad2EDmHJ3CCp3vJz+amZk+NwjsPgSTAeEB4gEKkTSFRS9FaEBWGp3CCvq6Bj9ddUI/'
..'zEB8QAdAAQSYAeMB5AEGysvRCpE0hUVYoWdAeB+dwgoAGBY/aExmP2D3gUAhDFVzZVBhcnRDb2xvcgpWSkk/0/zLPRQid0AKkTSFRYvUekB2H53CCpE0hUW+B25Adh+dwgqRNIVF8TphQHYfncIKkTSFRSRuVEB2H53CCiIXFj9oTGY/cPeBQAqRNIVFWKFnQHYfncIK'
..'XjWFRZzy0EC8EZ/CCgAAgD8AEuis//8/LwoAEuisAACAP///Py4KAACAPyCTdq70/8swCiCTdq4AAIA/9P/LLwpeNYVFFLzRQLwRn8IKX3dMOS3qDzrc/3+/Cg0ZsLf+/38/3+kPOgoAAIA/AjOvN3V8TDkKLxmwt/7/fz9+6g86CgAAgL8CM6+3dnxMuQovGbC3/v9/'
..'P33qDzoKL10xMwUAZjDi/3+/Cmjk1K4AAIA/4P9lsApeNYVFnPLQQMwRn8IK1NGStQAAgL/TF5m4CgAAgL/sh5I1kwUCOAoAAIDDAAAgQQAAgEMKAACAvwAAAAAAAAAACgAAAAAAAAAAAACAPwouufbC4dAIPq33zMMKmYVMOb/xDzr+/3+/CgAAgL9sM6+3sIhMuQoA'
..'AIA/OFtGL/T/yzAKlu2irwAAgD/kP82xCn0/tT3jpQ/AAAAAPwoAAAAAAAAAAAAAgL8KAAAAAAAAgD8AAAAACgBQ470+8FtAAFUBvwrEBgI4dxqZuAsAgD8KAACAv3CDkjXYBgI4CrJj+8Kc5k7AyPfMwwqZhUw5LPIPOv7/f78KAACAv+gyr7eviEy5CvDYkkARlFxA'
..'gFMBvwpQ/fHCy0JOwMj3zMMKzczMPLSzx74l2Y++CgB+Dj4mzxHAAEIzvgp6eEy5nOoPugoAgD8Kwxiwt/L/fz9X6g86CgchFj+cW0+/P1JhOAqfCBC48eMtON//fz8KByEWv5xbTz+vsWG4Cp/5WjzWoB886fZ/PwrhW08/qSAWPyt6gTcKqSAWP+BbT7/t1qW4Ch0w'
..'Bj9LA1o/miE+OQrPgRC4lgVJud//fz8KGzAGv0oDWr/xKDy5CksDWj8cMAa/Lk74OApfA1o//S8GvzHbjLgK/i8Gv14DWr/qpzq4CgAAgL8CM6+3dXxMuQoAAIA/AjOvN3B8TDkKNN0UM/M/nDGm/3+/Ck6zzK8AAIA/1j+csQpwYsY+6kBiwAArFr4KAIDJPvoXzcCA'
..'CYs/CgAAgL9gAAAuAACArQpgAAAuAACAP5j/CSwKNj0KM/M/9jGm/3+/CiRlA7AAAIA/tz/2sQo2PQoz9D/2Mab/f78KNF0JM/ofADKm/3+/CiXqBrAAAIA/2h8Asgo2TQkz+h8AMqb/f78KpekHsAAAgD+0P/6xNwEAAAIAAgADAAQABQABAAECAAIABgAEAAcAAQAC'
..'AgACAAgABAAJAAoAAwEAAgALAAwAQARADAAkACUAJgAbAAAkACcAKAAbAAAkACkAKgAbAAAkACUAKwAbAAAkACcALAAbAAAkACcALQAbAAAkACUALgAbAAAkACUALwAbAAAkACcAMAAbAAAkACcAMQAbAAAkACUAMgAbAAAkACkAMwAbAAAkADQANQA2AEACQAJAAkAC'
..'gSQANwA4ADkAOgA7ADwAQAJAA4EkAD0APgA/ADoAOwA8AIEkAEAAQQBCADoAOwA8AAEkAEMARABFADoAOwA8AAEkAEYARwBFADoAOwA8AEACQAOBJABIAEkASgA6ADsAPACBJABLAEwATQA6ADsAPAABJABOAE8AUAA6ADsAPAABJABRAFIAUAA6ADsAPABAAkACQAKB'
..'JABTAFQAVQBWADsAPAABJABXAFgAVQBWADsAPABAA0ACQASBJABZAFoAWwA6ADsAPACBJABcAF0AXgA6ADsAPACBJABfAGAAYQA6ADsAPABAAoEkAGIAYwBkAFYAOwA8AAEkAGUAZgBkAFYAOwA8AIEkAGcAaABkADoAOwA8AEADQAKBJABpAGoAawBWADsAPABAAkAC'
..'ASQAbABtAG4AOgA7ADwAASQAbwBwAHEAOgA7ADwAASQAcgBzAHQAOgA7ADwAQAKBJAB1AHYAdwBWADsAPABAAkACASQAeAB5AHoAOgA7ADwAASQAewB8AH0AOgA7ADwAASQAfgB/AIAAOgA7ADwAgSQAgQCCAIMAVgA7ADwAQAKBJACEAIUAhgBWADsAPABAAkACASQA'
..'hwCIAIkAOgA7ADwAASQAigCLAIwAOgA7ADwAASQAjQCOAI8AOgA7ADwAgSQAkACRAJIAOgA7ADwAQAJAAoEkAJMAlACVADoAOwA8AEACQAKBJACWAJcAmABWADsAPAABJACZAJoAmABWADsAPABAA0ACQASBJACbAJwAnQA6ADsAPACBJACeAJ8AXgA6ADsAPACBJACg'
..'AKEAogA6ADsAPABAAoEkAKMApAClAFYAOwA8AAEkAKYApwClAFYAOwA8AIEkAKgAqQClADoAOwA8AEADQAKBJACqAKsArABWADsAPABAAkACASQArQCuAK8AOgA7ADwAASQAsACxALIAOgA7ADwAASQAswC0ALUAOgA7ADwAQAKBJAC2ALcAuABWADsAPABAAkACASQA'
..'uQC6ALsAOgA7ADwAASQAvAC9AL4AOgA7ADwAASQAvwDAAMEAOgA7ADwAgSQAwgDDAMQAVgA7ADwAQAKBJADFAMYAxwBWADsAPABAAkACASQAyADJAMoAOgA7ADwAASQAywDMAIwAOgA7ADwAASQAzQDOAM8AOgA7ADwAQAJAAoEkANAA0QCVADoAOwA8AEACQAOBJADS'
..'ANMA1AA6ADsAPACBJADVANYA1wA6ADsAPAABJADYANkA2gA6ADsAPAABJADbANwA2gA6ADsAPABAAkADgSQA3QDeAN8AOgA7ADwAgSQA4ADhAOIAOgA7ADwAASQA4wDkAOUAOgA7ADwAASQA5gDnAOgAOgA7ADwAQAYBJADpAOoA6wA6AOwAPAAAJADtAO4AGwAAJADt'
..'AO8AGwABJADpAPAA6wA6AOwAPAABJADpAPEA6wA6AOwAPAAAJADtAPIAGwADDAACAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgAbABwAHQAeAB8AIAAhACIAIwDzAAUCAAIA9AD1APYA8wAFAgACAPcA9QD4APMABQIAAgD5APUA+gDzAAUCAAIA+wD1APwA/QAD'
..'DQACAP4ADgAPABAA/wASAAABFgABARgAAgEaAAMBHAAEAR4AAwEgAAUBBgEHAQgBCQEKAQsBDAEKAwANAQ4BDwEQAREBBgD9AAMNAAIAEgEOAA8AEAD/ABIAEwEWAAEBGAACARoA6wAcABQBHgAVASAABQEGAQcBCAEJAQoBCwEMAQwDAA0BDgEPARABEQEGACQAAwoA'
..'AgAGAA4ADwAQABYBEgAXARYAGAEYABkBGgAaARwAGwEeABoBIAAcAfMADgMAAgD0AB0BHgH1APYA8wAOAwACAPcAHQEeAfUA+ADzAA4EAAIA+QAdAR4B9QAfASABIQHzAA4FAAIA+wAiASMBHQEeAfUAHwEgASEBJAEOAAAkAQ4AACQBDgAAJAEOAAAkAQ4AACQBDgAA'
..'AQACAgACACcBBAAoASQAGQ0ADgAPACkBKgErASwBEgAtAS4BKgEvASoBGAAZARoAMAEcADEBMgEqAR4AMwEgADQBNQEsASQAGQsADgAPACkBKgErASwBEgA2AS4BKgEvASoBGAAZARwANwEyASoBIAA4ATUBKgE5ARsCADoBOwE8AT0BJAAZCwAOAA8AKQEqASsBLAES'
..'AD4BLgEqAS8BKgEYABkBHAA/ATIBKgEgAEABNQEqATkBHQIAOgFBATwBQgE5AR0CADoBOwE8AUMBJAAZCwAOAA8AKQEqASsBLAESAEQBLgEqAS8BKgEYABkBHABFATIBKgEgAEYBNQEqATkBIAIAOgFBATwBRwE5ASACADoBOwE8AUgBOQEgAgA6AUkBPAFKAUsBGQ0A'
..'DgAPACkBKgErASoBEgBMAS4BKgEvASoBGAAZARoATQEcAE4BMgEqAR4ATwEgAFABNQEqAVEBJAIAUgFTAVQBVQFLARkNAA4ADwApASoBKwEqARIAVgEuASoBLwEqARgAGQEaAFcBHABYATIBKgEeAFkBIABaATUBKgFRASYCAFIBWwFUAVUBJAAZCQAOAA8AKwEsARIA'
..'XAEYABkBGgBdARwAXgEeAF8BIABgATUBLAFLARkNAA4ADwApASoBKwEqARIAYQEuASoBLwEqARgAGQEaAGIBHABjATIBKgEeAGQBIABlATUBKgFRASkCAFIBZgFUAVUBSwEZDQAOAA8AKQEqASsBKgESAGcBLgEqAS8BKgEYABkBGgBoARwAaQEyASoBHgBoASAAagE1'
..'ASoBUQErAgBSAWsBVAFVASQAGQkADgAPACsBLAESAGwBGAAZARoAbQEcAG4BHgBvASAAcAE1ASwB/QAZDQACAHEBDgAPABAA/wASAHIBFgABARgAAgEaAOsAHABzAR4AFQEgAHQBBgF1AQgBdgEKAXcB/QAZDQACAHEBDgAPABAA/wASAHgBFgABARgAAgEaAAMBHAB5'
..'AR4AAwEgAHQBBgF1AQgBdgEKAXcBegEBAQACAHsBJAAwCQACAHwBEAB9ARIAfgEWAH8BGAAZARoAGgEcAIABHgAaASAAgQE5ATECADoBggE8AYMBJAAwCAAQAIQBEgCFARYAhgEYABkBGgAaARwAhwEeABoBIACIASQAMAgAEACJARIAigEWAIsBGAAZARoAGgEcAIwB'
..'HgCNASAAjgEkADAIABAAiQESAI8BFgCLARgAGQEaABoBHACQAR4AGgEgAJEBJAAwCAAQAIkBEgCSARYAiwEYABkBGgAaARwAkwEeABoBIACUAQwAQAWAJACbAZwBGgGAJACbAZ0BGgGAJACbAZ4BGgGAJACbAZ8BGgEAJACgAaEBGgEwCQAQAJUBEgCWARYAlwEYABkB'
..'GgAaARwAmAEeABoBIACZAZoBDwAWEyUBDhMmATEUJQEOFCYBNxUlAQ4VJgE0FiUBDhYmATUXJQEOFyYBNhglAQ4YJgEzHCYBGx4lARoeJgEdHyYBHSElARohJgEgIiYBICMlAQUjJgEgMiYBMQ==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
