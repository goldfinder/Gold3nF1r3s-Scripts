-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 1352 characters

local ScriptFunctions = {
function(script,require)
script.Parent.L0A.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = "Foundation Personnel"
	if plr.Character:FindFirstChild("Role") ~= nil then
		script.Parent.L0A.SurfaceGui.TextLabel.Text="Already have a role."
		wait(3)
		script.Parent.L0A.SurfaceGui.TextLabel.Text=TLT
	else
		script.Parent.L0A.SurfaceGui.TextLabel.Text="Added Role."
		local inst = Instance.new("StringValue")
		inst.Value = TLT
		inst.Name="Role"
		inst.Parent = plr.Character
		local inst = Instance.new("StringValue")
		inst.Value = ""
		inst.Name="Class"
		inst.Parent = plr.Character
		wait(3)
		script.Parent.L0A.SurfaceGui.TextLabel.Text=TLT
	end
end)

script.Parent.L1A.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = "Researcher"
	if plr.Character:FindFirstChild("Role") ~= nil then
		script.Parent.L1A.SurfaceGui.TextLabel.Text="Already have a role."
		wait(3)
		script.Parent.L1A.SurfaceGui.TextLabel.Text=TLT
	else
		script.Parent.L1A.SurfaceGui.TextLabel.Text="Added Role."
		local inst = Instance.new("StringValue")
		inst.Value = TLT
		inst.Name="Role"
		inst.Parent = plr.Character
		wait(3)
		script.Parent.L1A.SurfaceGui.TextLabel.Text=TLT
	end
end)

script.Parent.L2A.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = "Security"
	if plr.Character:FindFirstChild("Role") ~= nil then
		script.Parent.L2A.SurfaceGui.TextLabel.Text="Already have a role."
		wait(3)
		script.Parent.L2A.SurfaceGui.TextLabel.Text=TLT
	else
		script.Parent.L2A.SurfaceGui.TextLabel.Text="Added Role."
		local inst = Instance.new("StringValue")
		inst.Value = TLT
		inst.Name="Role"
		inst.Parent = plr.Character
		wait(3)
		script.Parent.L2A.SurfaceGui.TextLabel.Text=TLT
	end
end)

script.Parent.L3A.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = "MTF"
	if plr.Character:FindFirstChild("Role") ~= nil then
		script.Parent.L3A.SurfaceGui.TextLabel.Text="Already have a role."
		wait(3)
		script.Parent.L3A.SurfaceGui.TextLabel.Text=TLT
	else
		script.Parent.L3A.SurfaceGui.TextLabel.Text="Added Role."
		local inst = Instance.new("StringValue")
		inst.Value = TLT
		inst.Name="Role"
		inst.Parent = plr.Character
		wait(3)
		script.Parent.L3A.SurfaceGui.TextLabel.Text=TLT
	end
end)

script.Parent.L4A.ClickDetector.MouseClick:Connect(function(plr)
	if plr.Character:FindFirstChild("Role") ~= nil then
		script.Parent.L4A.SurfaceGui.TextLabel.Text="Already have a role."
		wait(3)
		script.Parent.L4A.SurfaceGui.TextLabel.Text="Rapid Response Team"
	else
		script.Parent.L4A.SurfaceGui.TextLabel.Text="Added Role."
		local inst = Instance.new("StringValue")
		inst.Value = "RAP. RES. Team"
		inst.Name="Role"
		inst.Parent = plr.Character
		wait(3)
		script.Parent.L4A.SurfaceGui.TextLabel.Text="Rapid Response Team"
	end
end)
--[[
script.Parent.L5A.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = "O5 Council"
	if plr.Character:FindFirstChild("Role") ~= nil then
		script.Parent.L5A.SurfaceGui.TextLabel.Text="Already have a role."
		wait(3)
		script.Parent.L5A.SurfaceGui.TextLabel.Text=TLT
	else
		script.Parent.L5A.SurfaceGui.TextLabel.Text="Added Role."
		local inst = Instance.new("StringValue")
		inst.Value = TLT
		inst.Name="Role"
		inst.Parent = plr.Character
		wait(3)
		script.Parent.L5A.SurfaceGui.TextLabel.Text=TLT
	end
end)

script.Parent.L6A.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = "The Administrator"
	local TLTS = "TA (LOCKED)"
	if plr.UserId == 21490931 then
		if plr.Character:FindFirstChild("Role") ~= nil then
			script.Parent.L6A.SurfaceGui.TextLabel.Text="Already have a role."
			wait(3)
			script.Parent.L6A.SurfaceGui.TextLabel.Text=TLTS
		else
			script.Parent.L6A.SurfaceGui.TextLabel.Text="Added Role."
			local inst = Instance.new("StringValue")
			inst.Value = TLT
			inst.Name="Role"
			inst.Parent = plr.Character
			wait(3)
			script.Parent.L6A.SurfaceGui.TextLabel.Text=TLTS
		end
	else
		script.Parent.L6A.SurfaceGui.TextLabel.Text="This role is locked."
		wait(3)
		script.Parent.L6A.SurfaceGui.TextLabel.Text=TLTS
	end
end)
--]]
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


local Objects = Decode('AABFIQVNb2RlbCEKV29ybGRQaXZvdARCQ0QhBFBhcnQhCEFuY2hvcmVkIiENQm90dG9tU3VyZmFjZQMAAAAAAAAAACEKQnJpY2tDb2xvcgfHACEGQ0ZyYW1lBBBDRCEFQ29sb3IGY19iIQhQb3NpdGlvbgqrCyrDdJyCQBhkEUIhBFNpemUKsMiKQOg4tUCAmVo/IQpU'
..'b3BTdXJmYWNlIQROYW1lIQNMNEEHNQEEGUNEBjSOQArLDCrDW1rHQJiuD0IKAACAQAAAgD8AFIM6IQpTdXJmYWNlR3VpIQ5aSW5kZXhCZWhhdmlvcgMAAAAAAADwPyEQQ2xpcHNEZXNjZW5kYW50cyEOTGlnaHRJbmZsdWVuY2UhDVBpeGVsc1BlclN0dWQDAAAAAAAA'
..'aUAhClNpemluZ01vZGUhCVRleHRMYWJlbCEQQmFja2dyb3VuZENvbG9yMwb///8hFkJhY2tncm91bmRUcmFuc3BhcmVuY3kMAACAPwAAAACAPwAAIQRGb250AwAAAAAAAAhAIQRUZXh0IRNSYXBpZCBSZXNwb25zZSBUZWFtIQpUZXh0Q29sb3IzIQhUZXh0U2l6ZQMA'
..'AAAAAABKQCELVGV4dFdyYXBwZWQhDUNsaWNrRGV0ZWN0b3IhA0wzQQQzQ0QKywwqwy3hpECYrg9CIQNNVEYhA0wyQQQ3Q0QKywwqwyzEgkCYrg9CIQhTZWN1cml0eSEDTDFBBDtFRArLDCrD8w9BQJiuD0IhClJlc2VhcmNoZXIhA0wwQQQ/Q0QKywwqw+4I+j+Yrg9C'
..'IRRGb3VuZGF0aW9uIFBlcnNvbm5lbCEGU2NyaXB0CqsLKsMp5KNAGFcRQgoAAIA/AAAAAEvKP7QKAAAAAAAAgD8AAAAACgAAgD8AAAAAk7lutBcBAAEAAgMEAQgABQYHCAkKCwwNDg8QERITCAQBCQAUFQUGBwgJFgsXDRgPGREaEwgbAwUAHB0eBh8dICEiHSMECAAk'
..'JSYdEScoKSorLCUtLi8GMAMAAAQBCQAUMQUGBwgJFgsyDRgPMxEaEwgbBwUAHB0eBh8dICEiHSMICAAkJSYdEScoKSo0LCUtLi8GMAcAAAQBCQAUNQUGBwgJFgs2DRgPNxEaEwgbCwUAHB0eBh8dICEiHSMMCAAkJSYdEScoKSo4LCUtLi8GMAsAAAQBCQAUOQUGBwgJ'
..'Fgs6DRgPOxEaEwgbDwUAHB0eBh8dICEiHSMQCAAkJSYdEScoKSo8LCUtLi8GMA8AAAQBCQAUPQUGBwgJFgs+DRgPPxEaEwgbEwUAHB0eBh8dICEiHSMUCAAkJSYdEScoKSpALCUtLi8GMBMAAEEBAAAA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()