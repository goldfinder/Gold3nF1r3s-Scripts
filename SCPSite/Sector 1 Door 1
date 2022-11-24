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

		spawn(function()
			for i = 3,(Door2.Size.z / 0.15) do
				Door2.CFrame = Door2.CFrame + (Door2.CFrame.lookVector * 0.15)

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
		spawn(function()
			for i = 3,(Door2.Size.z / 0.15) do
				Door2.CFrame = Door2.CFrame - (Door2.CFrame.lookVector * 0.15)

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
..'aWNrQ29sb3IHwgAhBkNGcmFtZQQdAKgBqQEhCkNhbkNvbGxpZGUCIQVDb2xvcgajoqUhCE1hdGVyaWFsAwAAAAAAgIlAIQtPcmllbnRhdGlvbgoAAAAAHwW0wo/C9TwhCFBvc2l0aW9uCq0XhkURqpFAxpacwiEIUm90YXRpb24Kj8L1vAAAtMIAAAAAIQRTaXplCs3M'
..'TD20s0c/JdkPPyEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQRQYXJ0Cg9rpjwYa6Y8qdPxPgqSF4ZF/4GFQDCcnMIK+VfYPFX86DymdA09CmEYhkV5GYlAIZqcwgoPa6Y8JXFHPx9rpjwKhhmGRSOukUBFnJzCCpIXhkVO+5BASZycwgphGIZFQ3mYQEOanMIK/RaGRSQq'
..'iUAlmpzCCpIXhkVos4lAOZycwgqSF4ZF7kydQGWcnMIK/RaGRVNgmEBHmpzCCv0WhkVZepBANpqcwgqSF4ZFPfqYQFucnMIKohWGRTiukUBRnJzCCja9rjzdT0c/8LQFPwqEF4ZFMqyRQKKRnMIKAAAAAOH6s0KPwvW8CpfpYT3NJc89cBKDOgqyF4ZFT9OeQMuKnMIK'
..'j8L1POH6M0MAADTDAwAAAAAAABhACgAAgD8AAIA/AACAPwoAAAAAAAAAAAAAAAAKkMDNPAw4Cz5vEoM6CosXhkXZq5lAwYqcwgqPwvU84fozQ7jeLEMK9BICPlXbojxwEoM6CrYXhkVKc5dAvIqcwgqPwvU84fozQ+F6t8IKF5DYPROiQzxvEoM6CqMXhkUAz5hAv4qc'
..'wgqPwvU84fozQx8FtkIKDHyDPtvacjtvEoM6CqkXhkXGm55Ay4qcwgqZwM08CjgLPm8SgzoKyReGRTU5lkC5ipzCCo/C9Tzh+jNDrkeBvwryEgI+XtuiPHASgzoKrheGRe2AmEC+ipzCCo/C9Tzh+jNDrse8QgoRkNg9IKJDPG8SgzoKtxeGRRMfl0C7ipzCCo/C9Tzh'
..'+jNDUrilwgoKfIM+4NpyO28SgzoKfxeGRSa6kECuipzCCh8fUT3xlJM94YCEPwqfF4ZFEaiVQOOPnMIKAAC0wuH6M0MAAAAAAwAAAAAAABBACifyej0QCIU64YCEPwqfF4ZFFKiVQLGKnMIK3mqzPBIIBTvcpmg+CjkXhkVqipRAi4qcwgrh+rFCmpmzwpqZs8IKDaAs'
..'PRIIBTtTzvE9CvoXhkVPPYlAh4qcwgqaGYZC4fqzQuH6s0IK6J8sPRMIBTuBzvE9CqwXhkXojKBAjYqcwgpIYZbCPQq0wuH6s8IK/Wf6PSiDjT3DSkM/CqAXhkXp2pRAoJKcwgrh+rHCZma0QpqZs0IKPIT/PX78mDvBSkM/CqAXhkXr2pRAN4ucwgqqsh8+HIxHOyCc'
..'gz8KiBeGRW4ol0C9i5zCCphvXD86g409GNjdPQqcF4ZFqjWVQDuQnMIKCtdDQD0KtMIAALTCCk2cWDwoCAU7VfdePAqAF4ZF/0mkQIyKnMIK7NGfwlwPtMLh+rPCCjTk8TwoCAU7yqnHOwrXF4ZF46yeQIqKnMIKH4VLwT0KtMIAALTCCkXHXzsmCAU7tMw4Pgq3F4ZF'
..'37ahQIuKnMIKSGGYwlwPtMLh+rPCCg5o+j08g409xkpDPwrTF4ZFSVmOQDmQnMIKcb2lQoXrs0LD9bNCCuoUeDwoCAU7W65CPAo6F4ZFsA6SQIqKnMIKM7OvQoXrs8JI4bPCChBa3jwoCAU7gTXZOworF4ZFlBqXQIyKnMIK7FH4QcP1s0IAALRCCgbnfzsoCAU77Jkh'
..'PgojF4ZFoWqUQIuKnMIKXI+uQincs0Jm5rNCChJo+j0sg409vEpDPwqgF4ZFCNuUQLaNnMIK4fqxwnE9tEJxvbNCCiVq+j08g409H0lDPwqaF4ZFZeSOQFiQnMIK4fqxwincu0K4HqxCCuQWeDwpCAU7y6xCPAoQGIZFG+KKQJCKnMIKZmafwnG9tEJSOLNCCh9Z3jwp'
..'CAU7azbZOwrwF4ZFNNuFQHiKnMIKj8IcwtcjtMLs0bPCCgTpfzsoCAU7ppghPgoRGIZFSX+IQISKnMIK9iipwqRwtUIfhbJCCj2oOj5G7Jw/oDPjPAoTGIZFeUqeQMKMnMIKCtcjPOH6M0MAADTDCj6oOj5I7Jw/hjPjPAohF4ZFaEqeQNKMnMIKj8L1PHH9M0MAADTD'
..'Ch8fUT3hlJM95ICEPwqWF4ZF+qeVQOSPnMIKAAC0wnH9M0MAAAAACifyej0ACIU644CEPwqWF4ZF/qeVQLKKnMIK32qzPAUIBTvepmg+CjAXhkVTipRAi4qcwgrh+rFCPYqzwj2Ks8IKEaAsPQUIBTtTzvE9CvEXhkU6PYlAiIqcwgrqnyw9BQgFO4bO8T0KoxeGRdKM'
..'oECOipzCCkhhlsIfBbTCw/Wzwgr+Z/o9GIONPcVKQz8KlxeGRdPalEChkpzCCuH6scLDdbRCPYqzQgo+hP89bfyYO8VKQz8KlxeGRdXalEA4i5zCCq2yHz4GjEc7IpyDPwp/F4ZFWCiXQL6LnMIKmW9cPyyDjT0Z2N09CpMXhkWUNZVAPZCcwgoK10NAHwW0wgAAtMIK'
..'UpxYPBgIBTtY9148CncXhkXpSaRAjoqcwgrs0Z/CXA+0wsP1s8IKM+TxPBgIBTvSqcc7Cs4XhkXNrJ5AjIqcwgofhUvBHwW0wgAAtMIKR8dfOxgIBTu2zDg+Cq4XhkXJtqFAjYqcwgpIYZjCPQq0wuH6s8IKFWj6PSyDjT3ISkM/CsoXhkUzWY5AO5CcwgpxvaVCpPCz'
..'QsP1s0IK8RR4PBgIBTterkI8CjEXhkWZDpJAi4qcwgozs69CSOGzwincs8IKGFrePBgIBTuCNdk7CiIXhkV9GpdAjYqcwgrsUfhB4fqzQgAAtEIKDud/OxgIBTvsmSE+ChoXhkWKapRAjIqcwgpcj65CKdyzQkjhs0IKFGj6PR2DjT29SkM/CpcXhkXy2pRAt42cwgrh'
..'+rHCzUy0QhSus0IKJmr6PS+DjT0jSUM/CpEXhkVP5I5AWZCcwgrh+rHCheu7QlwPrEIK5BZ4PBwIBTvPrEI8CgcYhkUG4opAkYqcwgpmZp/Cj8K0QlI4s0IKI1nePBwIBTtqNtk7CucXhkUf24VAeIqcwgoI6X87GwgFO6aYIT4KCBiGRTR/iECFipzCCvYoqcLDdbVC'
..'H4WyQgqe6WE91SXPPXASgzoKhBeGRZPKn0DPipzCCpfAzTwQOAs+bxKDOgpwF4ZFlqyZQMKKnMIKj8L1PHH9M0O43ixDCvkSAj5b26I8cBKDOgqbF4ZFB3SXQL2KnMIKj8L1PHH9M0PherfCCh2Q2D0bokM8bxKDOgqIF4ZFvc+YQMCKnMIKj8L1PHH9M0MfBbZCCg98'
..'gz7k2nI7bxKDOgqOF4ZFg5yeQMyKnMIKCyM1PlYjnjxwEoM6Cp8XhkVDZJdAvIqcwgqPwvU8cf0zQ7geusIKHqLDPB+Q2D1wEoM6CpAXhkWsNZJAsYqcwgqPwvU8cf0zQ65HgT8KFf51PHw6rD1wEoM6CpkXhkVKT5RAtYqcwgqPwvU8cf0zQxTuMMMKqdswPseMtDtv'
..'EoM6CsEXhkUydZBArYqcwgqPwvU8cf0zQ3E9xsIKSNNkPUHTZD0Qa6Y8Cq0ZhkWm7JFA3pGcwgqPwvW8CtcjvAAAAAAKAACAPwAAgD/NzMw9Cq6dET0uqmA9hU7xPAqWGYZFORubQAKanMIKnBmGRbvwkUBzmpzCCrMZhkVVrYhAyZGcwgqnGYZFIxebQG6RnMIKoxmG'
..'RWuxiEBempzCIQVTb3VuZCEMQWNjZXNzRGVuaWVkIQdTb3VuZElkIRZyYnhhc3NldGlkOi8vMjAwODg4NTEwIQ1BY2Nlc3NHcmFudGVkIRZyYnhhc3NldGlkOi8vMjAwODg4NDY4IQlEb29yQ2xvc2UhFnJieGFzc2V0aWQ6Ly8yNTc4NDE2NDAhCERvb3JPcGVuIRZy'
..'Ynhhc3NldGlkOi8vMjUxODg1NDk1IQhNZXNoUGFydCEHQnV0dG9uMgfrAwQEAaoBqwEGERERAwAAAAAAAHFACo/C9Txx/TNDAAAAAApX8IVFoYTOQGYHm8IKUvgzQwrXIzwAADTDCry8Xz+1o60/AKFgPyEGTWVzaElkIRdyYnhhc3NldGlkOi8vMzIxMzIyMDM1NiEI'
..'TWVzaFNpemUKSuimPla5AD8fhqY+IQlUZXh0dXJlSUQhF3JieGFzc2V0aWQ6Ly8yNDU5OTMwNjk2IQ9Qcm94aW1pdHlQcm9tcHQhDEhvbGREdXJhdGlvbgMAAACgmZnJPyEPS2V5Ym9hcmRLZXlDb2RlAwAAAAAAgFlAIQpPYmplY3RUZXh0IQdCdXR0b24xBBUBrAGt'
..'AQpt7YVFin7OQKB5oMIHZwAEGwGuAa8BBsrItgMAAAAAAACRQAoAAAAAAAC0wgAAAAAKOgiGRRA30kC2rpzCCt3HxT5WltlAPMSOQCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAAAFlAIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQ1Q'
..'bGF5YmFja1NwZWVkAwAAAGBmZvI/IQ5XZWxkQ29uc3RyYWludCEFUGFydDAhBVBhcnQxIQVGcmFtZQSwAaUBpgEhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAABDEBsQGyASEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoAAAAA'
..'AAAAAAAAtMIKSAiGRWaaH0Hk4JzCIQxSaWdodFN1cmZhY2UKfT81PuOlj0AAAIA/IQpUb3BTdXJmYWNlBDcBpQGmAQoAAAAAAAA0wwAAAAAKGgiGRQhdRUAY45zCCgAANMMAAAAAAAA0wwrHS5dAfT81PgAAgD8hBFdlbGQhAkMwBLMBtAG1ASECQzEEtgG3AbgBBEAB'
..'uQG6AQpw9YVFN2jOQHzjnMIKGQSWPrYe3UAAAIA/BLsBvAG9AQS+Ab8BwAEEwQHCAcMBBEYBuQG6AQoKG4ZFZhbOQIDjnMIKGQSWPt163EAAAIA/BMQBvwHAAQTFAbQBvQEExgHHAcgBBMkBwgHDASEJV2VkZ2VQYXJ0BE8BygHLAQqamQ9CAAC0QgAAtMIKwRqGRaJL'
..'HkE+4p3CCgAAtEJmZlhCAAA0wwrNzEw+zcxMPf/Rmz4hC1NwZWNpYWxNZXNoIQVTY2FsZQoAAIA/AUDOPQAAgD8hCE1lc2hUeXBlAwAAAAAAAABABFkBzAHNAQqamQ/C9qixwrieskIKwRqGReJLHkF+45vCCo/CsMLsUVjCFK6nPwrNzEw+zcxMPWjMmz4KAACAP5w4'
..'zj0AAIA/BF8BzgHPAQoAAAAAAAAAAJoZEEMKwRqGRbpLHkE+4pzCCt3Rmz7NzEw+xrV+PwRjAdAB0QEKSOH8QQAAtMIfBbRCCrf1hUV2Yx5BKuKdwgrh+rNCXI9pwgAANMMKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwRpAdIB0wEKCtcjPHH9M0NSOPPCCrf1hUXI'
..'Yx5BKuKbwgpx/TNDCtcjPFyPaUIKzcxMPnPKmj7NzEw9CgAAgD8AAIA/lMbSPQRvAdQB1QEKAAAAAAAAAADXYxTDCrf1hUWiYx5BKuKcwgpzypo+zcxMPhirfj8hBHNpZ24EcwHWAasBCo3thUUl1MVAkCyhwgpKLRo/sDwQP1mvqz0hF3JieGFzc2V0aWQ6Ly8zMjEz'
..'MjE4MTM0CnSXZD6t2lU+0Iz+PCEXcmJ4YXNzZXRpZDovLzMyMTMyMTMxMTAEeQHXAa0BCjfwhUVX3cVAVlSawiEGRm9sZGVyIQlEb29yUGFydHMhBlN0cmlwZQfpAwSAAdgB2QEG///pCjD/hUUetRZBuK6cwgojWuQ+zcxMPjLdDEAE2gG0Ab0BBNsB3AHdAQfHAASH'
..'Ad4B3wEGY19iCjoIhkV2ndhAtq6cwgoZBBY/AAAAP4PAjkAHGgAEjAHgAd8BBhsqNQqqE4ZFdp3YQEaxnMIKPYozQ8P1s8JxPTPDCp3vJz+amZk+KlwPPgSQAeAB3wEKoBaGRXad2EBGsZzCCp3vJz+amZk+NwjsPgSTAeEB4gEKOgiGRS9FaEDWs5zCCvq6Bj9ddUI/'
..'zEB8QAdAAQSYAeMB5AEGysvRCjoIhkVYoWdAtK6cwgoAGBY/aExmP2D3gUAhDFVzZVBhcnRDb2xvcgpWSkk/0/zLPRQid0AKOgiGRYvUekC2rpzCCjoIhkW+B25Atq6cwgo6CIZF8TphQLaunMIKOgiGRSRuVEC2rpzCCiIXFj9oTGY/cPeBQAo6CIZFWKFnQLaunMIK'
..'bQeGRZzy0EBaoZzCCgAAgL8AEuis//8/rwoAEugsAACAP///P64KAACAv6COPK75/5uwCqCOPC4AAIA/+f+brwptB4ZFFLzRQFqhnMIKd3dMuS/qDzrk/38/CgUZsDf+/38/4ekPugoAAIC/AjOvN3V8TLkKLxmwN/7/fz9+6g+6CgAAgD8CM6+3dnxMOQovGbA3/v9/'
..'P33qD7oKL90yswMAfjDq/38/Cijity4AAIA/6P99MAptB4ZFnPLQQEqhnMIKSNKSNQAAgL/LF5k4CgAAgD94h5I19wUCuAoAAIDDAAAgQQAAgEMKAACAvwAAAAAAAAAACgAAAAAAAAAAAACAPwouufbC4dAIPq33zMMKmYVMOb/xDzr+/3+/CgAAgL9sM6+3sIhMuQoA'
..'AIC/WNxUL/n/m7AKBq2bLwAAgD/qP9AxCn0/tT3jpQ/AAAAAPwoAAAAAAAAAAAAAgL8KAAAAAAAAgD8AAAAACgBQ470+8FtAAFUBvwrEBgI4dxqZuAsAgD8KAACAv3CDkjXYBgI4CrJj+8Kc5k7AyPfMwwqZhUw5LPIPOv7/f78KAACAv+gyr7eviEy5CvDYkkARlFxA'
..'gFMBvwrNzMw8tLPHviXZj74KAH4OPibPEcAAQjO+Cnp4TLmc6g+6CgCAPwrDGLC38v9/P1fqDzoKUP3xwstCTsDI98zDCgchFr+cW0+/I1JhuAr/CBA42eMtOOf/f78KByEWP5xbTz+TsWE4Cp/5WrzWoB888fZ/vwrhW0+/qSAWP3d5gbcKqSAWv+BbT78F16U4Ch0w'
..'Br9LA1o/jiE+uQovghA4nAVJuef/f78KGzAGP0oDWr/lKDw5CksDWr8cMAa/FE74uApfA1q//S8Gv1fbjDgK/i8GP14DWr+qpzo4CgAAgD8CM6+3dXxMOQoAAIC/AjOvN3B8TLkKM10Zs/Y/pTG+/38/Cp3xti8AAIA/4T+lMQpwYsY+6kBiwAArFr4KAIDJPvoXzcCA'
..'CYs/CgAAgL9gAAAuAACArQpgAAAuAACAP5j/CSwKNb0Os/Q//zG+/38/CpgI8S8AAIA/yT//MQo1vQ6z9T//Mb7/fz8KM90Ns/qfBDK+/38/CpkS+C8AAIA/458EMgo1zQ2z+58EMr7/fz8KmRH6LwAAgD/knwMyNwEAAAIAAgADAAQABQABAAECAAIABgAEAAcAAQAC'
..'AgACAAgABAAJAAoAAwEAAgALAAwAQARADAAkACUAJgAbAAAkACcAKAAbAAAkACkAKgAbAAAkACUAKwAbAAAkACcALAAbAAAkACcALQAbAAAkACUALgAbAAAkACUALwAbAAAkACcAMAAbAAAkACcAMQAbAAAkACUAMgAbAAAkACkAMwAbAAAkADQANQA2AEACQAJAAkAC'
..'gSQANwA4ADkAOgA7ADwAQAJAA4EkAD0APgA/ADoAOwA8AIEkAEAAQQBCADoAOwA8AAEkAEMARABFADoAOwA8AAEkAEYARwBFADoAOwA8AEACQAOBJABIAEkASgA6ADsAPACBJABLAEwATQA6ADsAPAABJABOAE8AUAA6ADsAPAABJABRAFIAUAA6ADsAPABAAkACQAKB'
..'JABTAFQAVQBWADsAPAABJABXAFgAVQBWADsAPABAA0ACQASBJABZAFoAWwA6ADsAPACBJABcAF0AXgA6ADsAPACBJABfAGAAYQA6ADsAPABAAoEkAGIAYwBkAFYAOwA8AAEkAGUAZgBkAFYAOwA8AIEkAGcAaABkADoAOwA8AEADQAKBJABpAGoAawBWADsAPABAAkAC'
..'ASQAbABtAG4AOgA7ADwAASQAbwBwAHEAOgA7ADwAASQAcgBzAHQAOgA7ADwAQAKBJAB1AHYAdwBWADsAPABAAkACASQAeAB5AHoAOgA7ADwAASQAewB8AH0AOgA7ADwAASQAfgB/AIAAOgA7ADwAgSQAgQCCAIMAVgA7ADwAQAKBJACEAIUAhgBWADsAPABAAkACASQA'
..'hwCIAIkAOgA7ADwAASQAigCLAIwAOgA7ADwAASQAjQCOAI8AOgA7ADwAgSQAkACRAJIAOgA7ADwAQAJAAoEkAJMAlACVADoAOwA8AEACQAKBJACWAJcAmABWADsAPAABJACZAJoAmABWADsAPABAA0ACQASBJACbAJwAnQA6ADsAPACBJACeAJ8AXgA6ADsAPACBJACg'
..'AKEAogA6ADsAPABAAoEkAKMApAClAFYAOwA8AAEkAKYApwClAFYAOwA8AIEkAKgAqQClADoAOwA8AEADQAKBJACqAKsArABWADsAPABAAkACASQArQCuAK8AOgA7ADwAASQAsACxALIAOgA7ADwAASQAswC0ALUAOgA7ADwAQAKBJAC2ALcAuABWADsAPABAAkACASQA'
..'uQC6ALsAOgA7ADwAASQAvAC9AL4AOgA7ADwAASQAvwDAAMEAOgA7ADwAgSQAwgDDAMQAVgA7ADwAQAKBJADFAMYAxwBWADsAPABAAkACASQAyADJAMoAOgA7ADwAASQAywDMAIwAOgA7ADwAASQAzQDOAM8AOgA7ADwAQAJAAoEkANAA0QCVADoAOwA8AEACQAOBJADS'
..'ANMA1AA6ADsAPACBJADVANYA1wA6ADsAPAABJADYANkA2gA6ADsAPAABJADbANwA2gA6ADsAPABAAkADgSQA3QDeAN8AOgA7ADwAgSQA4ADhAOIAOgA7ADwAASQA4wDkAOUAOgA7ADwAASQA5gDnAOgAOgA7ADwAQAYBJADpAOoA6wA6AOwAPAAAJADtAO4AGwAAJADt'
..'AO8AGwABJADpAPAA6wA6AOwAPAABJADpAPEA6wA6AOwAPAAAJADtAPIAGwADDAACAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgAbABwAHQAeAB8AIAAhACIAIwDzAAUCAAIA9AD1APYA8wAFAgACAPcA9QD4APMABQIAAgD5APUA+gDzAAUCAAIA+wD1APwA/QAD'
..'DQACAP4ADgAPABAA/wASAAABFgABARgAAgEaAAMBHAAEAR4ABQEgAAYBBwEIAQkBCgELAQwBDQEKAwAOAQ8BEAERARIBBgD9AAMNAAIAEwEOAA8AEAD/ABIAFAEWAAEBGAACARoA6wAcABUBHgDrACAABgEHAQgBCQEKAQsBDAENAQwDAA4BDwEQAREBEgEGACQAAwoA'
..'AgAGAA4ADwAQABYBEgAXARYAGAEYABkBGgAaARwAGwEeABoBIAAcAfMADgMAAgD0AB0BHgH1APYA8wAOAwACAPcAHQEeAfUA+ADzAA4EAAIA+QAdAR4B9QAfASABIQHzAA4FAAIA+wAiASMBHQEeAfUAHwEgASEBJAEOAAAkAQ4AACQBDgAAJAEOAAAkAQ4AACQBDgAA'
..'AQACAgACACcBBAAoASQAGQ0ADgAPACkBKgErASwBEgAtAS4BKgEvASoBGAAZARoAMAEcADEBMgEqAR4AMAEgADMBNAEsASQAGQ0ADgAPACkBKgErASwBEgA1AS4BKgEvASoBGAAZARoANgEcADcBMgEqAR4AOAEgADkBNAEqAToBGwIAOwE8AT0BPgEkABkNAA4ADwAp'
..'ASoBKwEsARIAPwEuASoBLwEqARgAGQEaADYBHABAATIBKgEeADgBIABBATQBKgE6AR0CADsBQgE9AUMBOgEdAgA7ATwBPQFEASQAGQ0ADgAPACkBKgErASwBEgBFAS4BKgEvASoBGAAZARoANgEcAEYBMgEqAR4AOAEgAEcBNAEqAToBIAIAOwFCAT0BSAE6ASACADsB'
..'SQE9AUoBOgEgAgA7ATwBPQFLAUwBGQ0ADgAPACkBKgErASoBEgBNAS4BKgEvASoBGAAZARoATgEcAE8BMgEqAR4AUAEgAFEBNAEqAVIBJAIAUwFUAVUBVgFMARkNAA4ADwApASoBKwEqARIAVwEuASoBLwEqARgAGQEaAFgBHABZATIBKgEeAFoBIABbATQBKgFSASYC'
..'AFMBXAFVAVYBJAAZCQAOAA8AKwEsARIAXQEYABkBGgBeARwAXwEeAF4BIABgATQBLAFMARkNAA4ADwApASoBKwEqARIAYQEuASoBLwEqARgAGQEaAGIBHABjATIBKgEeAGQBIABlATQBKgFSASkCAFMBZgFVAVYBTAEZDQAOAA8AKQEqASsBKgESAGcBLgEqAS8BKgEY'
..'ABkBGgBoARwAaQEyASoBHgBqASAAawE0ASoBUgErAgBTAWwBVQFWASQAGQkADgAPACsBLAESAG0BGAAZARoAbgEcAG8BHgBuASAAcAE0ASwB/QAZDQACAHEBDgAPABAA/wASAHIBFgABARgAAgEaAOsAHABzAR4A6wAgAHQBBwF1AQkBdgELAXcB/QAZDQACAHEBDgAP'
..'ABAA/wASAHgBFgABARgAAgEaAAMBHAB5AR4ABQEgAHQBBwF1AQkBdgELAXcBegEBAQACAHsBJAAwCQACAHwBEAB9ARIAfgEWAH8BGAAZARoAGgEcAIABHgAaASAAgQE6ATECADsBggE9AYMBJAAwCAAQAIQBEgCFARYAhgEYABkBGgAaARwAhwEeABoBIACIASQAMAgA'
..'EACJARIAigEWAIsBGAAZARoAGgEcAIwBHgCNASAAjgEkADAIABAAiQESAI8BFgCLARgAGQEaABoBHACQAR4AGgEgAJEBJAAwCAAQAIkBEgCSARYAiwEYABkBGgAaARwAkwEeABoBIACUAQwAQAWAJACbAZwBGgGAJACbAZ0BGgGAJACbAZ4BGgGAJACbAZ8BGgEAJACg'
..'AaEBGgEwCQAQAJUBEgCWARYAlwEYABkBGgAaARwAmAEeABoBIACZAZoBDwAWEyUBDhMmATEUJQEOFCYBNxUlAQ4VJgE0FiUBDhYmATUXJQEOFyYBNhglAQ4YJgEzHCYBGx4lARoeJgEdHyYBHSElARohJgEgIiUBBSImASAjJgEgMiYBMQ==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
