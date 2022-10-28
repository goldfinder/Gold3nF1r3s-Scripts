-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 60204 characters

local ScriptFunctions = {
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Arm1") == nil then
		local g = script.Parent.Parent.Arm1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Left Arm"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end

end

script.Parent.Touched:connect(onTouched)
end,
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Arm2") == nil then
		local g = script.Parent.Parent.Arm2:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Right Arm"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end

end

script.Parent.Touched:connect(onTouched)
end,
function(script,require)
function onTouched(hit) 
	local d = hit.Parent:GetChildren() 
	for i=1, #d do 
		if (d[i].className == "Accessory") then 
			d[i]:remove() 
		end 
	end
end 

script.Parent.Touched:connect(onTouched) 

-- AceTacticalEye :)
end,
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Helmet") == nil then
		local g = script.Parent.Parent.Helmet:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent.Head
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end
end

script.Parent.Touched:connect(onTouched)

end,
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg1") == nil then
		local g = script.Parent.Parent.Leg1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Left Leg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end

end

script.Parent.Touched:connect(onTouched)
end,
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg2") == nil then
		local g = script.Parent.Parent.Leg2:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Right Leg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or h[i].className == "UnionOperation" or h[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end

end

script.Parent.Touched:connect(onTouched)
end,
function(script,require)
function onTouched(hit)
	local h = hit.Parent:findFirstChild("Humanoid")
	if h~=nil then
		local s = hit.Parent:findFirstChild("Pants")
		if s~=nil and d~=nil then
			hit.Parent.Pants:remove()
			script.Parent.Pants:clone().Parent = hit.Parent
		elseif s~=nil then
			hit.Parent.Pants:remove()
			script.Parent.Pants:clone().Parent = hit.Parent
		elseif d~=nil then
			script.Parent.Pants:clone().Parent = hit.Parent
		elseif s==nil and d==nil then
			script.Parent.Pants:clone().Parent = hit.Parent
		end
	end
end

script.Parent.Touched:connect(onTouched)
	
end,
function(script,require)
function onTouched(hit)
	local h = hit.Parent:findFirstChild("Humanoid")
	if h~=nil then
		local s = hit.Parent:findFirstChild("Shirt")
		if s~=nil and d~=nil then
			hit.Parent.Shirt:remove()
			script.Parent.Shirt:clone().Parent = hit.Parent
		elseif s~=nil then
			hit.Parent.Shirt:remove()
			script.Parent.Shirt:clone().Parent = hit.Parent
		elseif d~=nil then
			script.Parent.Shirt:clone().Parent = hit.Parent
		elseif s==nil and d==nil then
			script.Parent.Shirt:clone().Parent = hit.Parent
		end
	end
end

script.Parent.Touched:connect(onTouched)
	
end,
function(script,require)
function onTouched(hit) 
	local d = hit.Parent:GetChildren() 
	for i=1, #d do 
		if (d[i].className == "ShirtGraphic") then 
			wait(1)
			d[i]:remove() 
		end 
	end
end 

script.Parent.Touched:connect(onTouched) 
end,
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Chest") == nil then
		local g = script.Parent.Parent.Chest:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent.Torso
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart"  then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end
end

script.Parent.Touched:connect(onTouched)

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


local Objects = Decode('AEBlCSEFTW9kZWwhBE5hbWUhE1ZMb3JkJ3MgUlJUOiBPbWVnYS4hCldvcmxkUGl2b3QE3gjfCOAIIQVNb3JwaCEETGVnMQThCOII4wghBFBhcnQhBk1pZGRsZSEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQZDRnJhbWUEFgDkCOUIIQpDYW5Db2xsaWRlAiELT3JpZW50YXRpb24KAAAAAM1Ms0IAAAAAIQhQb3NpdGlvbgqy/rNCnSG9P6LxhsMhCFJvdGF0aW9uIQRTaXplCgAAgD8AAABAAACAPyEKVG9wU3VyZmFjZSEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQhNZXNoUGFydCEcTWVzaGVzL3JhcHRvciBzdHVmZl9Dd'
..'WJlLjAwOQQiAOYI5wghCE1hdGVyaWFsAwAAAAAAgJRACur7s0I6dABAit6Gwwr9a4s/qY2jP5uArj8hBk1lc2hJZCEXcmJ4YXNzZXRpZDovLzM3NDM5MzU5MjkhCE1lc2hTaXplCvz32kLXcO9CAHYJQyEJVGV4dHVyZUlEIRdyYnhhc3NldGlkOi8vMzc5Nzk0MjM2NSEgTWVzaGVzL3JhcHRvciBzdHVmZl9DeWxpbmRlci4wMDQELADoCOkICujds0IVCM8/3vCGwwqc5Jk/IDt2P1vEij8hF3JieGFzc2V0aWQ6Ly8zNzQzOTMxNjQ5Cta060IMALxCeL/SQiEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0zODIxOTE3MTc1IQ'
..'RMZWcyBOoI4gjrCAQ1AOwI7QgKAAAAAI9CtEIAAAAACub5s0L9+70/bnGHwwqksDLDcb2zQqSwMkMEOADoCOkICsbds0KdG9A/hm+HwyEcTWVzaGVzL3JhcHRvciBzdHVmZl9DdWJlLjAwOAQ9AO4I7wghCE1hc3NsZXNzCgAAAACPwvU8cT2KPgrQ87NCaFAIQFCDh8MKBgKLP166qT+DwKo/IRdyYnhhc3NldGlkOi8vMzc0MzkzMzIzNQo19tZCtdUAQ4gBBUMhF3JieGFzc2V0aWQ6Ly82MzI0NzgzOTYwIQVEZWNhbCEIVmluZ2V0dGUhBEZhY2UDAAAAAAAACEAhB1RleHR1cmUhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ'
..'9NjIyMTU3ODUxOAMAAACgmZnhPyEFQ2hlc3QE8AjxCPIIIQpCcmlja0NvbG9yB+sDBFEA8wj0CCEFQ29sb3IGERERCgAAAAB7FLNCAAAAAAre9rNCGr9eQHQxh8MKAAAAQAAAAEAAAIA/IRlNZXNoZXMvS0lMTEJFUkJTSE9SVFNDQVJGBxoABFoA9Qj2CCEKQ2FzdFNoYWRvdwYwMDADAAAAAABAlEAKAAAAAAAAtEIAAAAACiLes0I3lYlAuDCHwwpuB9c/uVdePxmNyT8hF3JieGFzc2V0aWQ6Ly8xOTA4NjYzNjc0CgD86T8gd20/gMC6PyEWcmJ4YXNzZXRpZDovLzE0OTk2NzQ3MiENU3R1ZHNQZXJUaWxlVSENU3R1ZHNQZXJUaWxlVgMA'
..'AAAAAAAAQAMAAAAAAAAQQAeUAARnAPcI+AgGW1tbCgAAAAAAAAAAAAC0wgpknbVC/Z9pQEKWh8MKrFX/P9Y63z49Ctc+IRdyYnhhc3NldGlkOi8vNjIxNjU5NTAxOQrYYQtBeLbzPzgX6z8hF3JieGFzc2V0aWQ6Ly82NDMxOTY0MjM4IQVBcm1vcgRvAPkI+ggKAAAAAAAAvsIAAAAACvz2tUL0ioVAfG+HwwoAADRDAACqwgAANEMKP98yPqc9yz4EaAA/IRdyYnhhc3NldGlkOi8vMzg2ODE1MzYyMQpCW/xBQDyzQoKi6EIhF3JieGFzc2V0aWQ6Ly82MzI5NTA2NDEwIQZIYW5kbGUHxwAEegD7CPwIBmNfYgoAAKDCAAC+wgAAtMIKfIC1Q'
..'oE4aUAgdofDCo/CtcIpXB/BhesuQwo8e80+omKkPgJtAEAhC1NwZWNpYWxNZXNoIQVTY2FsZQo81o8+PNaPPj3Wjz4hKGh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MjE0MjYzMDMhCVRleHR1cmVJZCEpaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0yODExMjMzMTYhCE1lc2hUeXBlAwAAAAAAABRAIRhNZXNoZXMvYmFja3BhY2tfQ3ViZS4wMDkEhwD9CP4ICkbOtEKbLWxAKi6HwwqRY+Y/vpDtP7NNAkAhF3JieGFzc2V0aWQ6Ly80NTIyNTg2ODMxChMuNEPfyjlDBNBLQyEqaHR0cDovL3d3dy5yb2Jsb3guY2'
..'9tL2Fzc2V0Lz9pZD00NTQ5NDI5MDkzBI4A/wgACQoAAAAAAAAvwwAAAAAKUrm2Qu2KSUD0SofDCgAANMMAAKDAAAA0wwqvAlM+lS3JPnRekD4hF3JieGFzc2V0aWQ6Ly8zODY4MTQ4MjgwCoIb7EFgnzNCfeYAQiEXcmJ4YXNzZXRpZDovLzM4NjgxNzU4MTAElQD/CAAJCnDEtkKfkElAMkiHwwqvaYk+OgjpPs4poz4hF3JieGFzc2V0aWQ6Ly8zODY4MTUyMDAyCm4XF0JIEFBCUq4RQiEXcmJ4YXNzZXRpZDovLzYzMjQ2MTAwNjAhHE1lc2hlcy9yYXB0b3Igc3R1ZmZfQ3ViZS4wNTAEnwABCQIJIRhDdXN0b21QaHlzaWNhbFByb3BlcnR'
..'pZXMQCtcjPM3MTD4AAAA/AACAPwAAgD8KAAAAAArXI70AAAAACnAKtEL7bX5AtjGHwwobS5A/3gmVPxlNDEAhF3JieGFzc2V0aWQ6Ly8zNzQzOTQzOTMyCvvB9kJDHShD4OhdQyEJUmVhclBhdGNoIQtCYWNrU3VyZmFjZQMAAAAAAAAkQASqAAMJBAkGKioqIQxGcm9udFN1cmZhY2UhC0xlZnRTdXJmYWNlCvrbskIXt31A9hCHwyEMUmlnaHRTdXJmYWNlCsef9j6cnwY+50KEPQeVAASxAAMJBAkGGxsbAwAAAAAAAHFACs7VskIXt31A8hCHwwpT9+s+R7j4PT6rgT0hClN1cmZhY2VHdWkhBFNHVUkhCkNhbnZhc1NpemULAACWQwAAyEIh'
..'DkxpZ2h0SW5mbHVlbmNlIQdUZXh0Qm94IQpJZGVudGlmaWVyIRBCYWNrZ3JvdW5kQ29sb3IzBh4eHiEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeSEMQm9yZGVyQ29sb3IzBv///yEPQm9yZGVyU2l6ZVBpeGVsDAAAAAAAAJqZmT4AAAwAAIA/AAAzMzM/AAAhEVBsYWNlaG9sZGVyQ29sb3IzIQRUZXh0IQVPTUVHQSEKVGV4dENvbG9yMwZPT08hClRleHRTY2FsZWQhCFRleHRTaXplAwAAAAAAAE5AIQtUZXh0V3JhcHBlZAwAAIA/AADNzMw+AAAhE1JBUElEIFJFU1BPTlNFIFRFQU0GfgACAwAAAAAAAC5ABNEABQkGCQoAAAAAAAAqQwAAA'
..'AAKYL+2QmFuSkCQFIfDCgAANEMAACBBAAA0wwovnFQ+S7LtPl401j4E1gAHCQgJCgAAAAAAACrDAAAAAArcWbVCecENQJquh8MKAAA0wwAAIMEAADRDCiRdtz6DYYE/79NUPyEXcmJ4YXNzZXRpZDovLzM4NjgxNDc2OTcKtLATQnC2qUISlotCIRdyYnhhc3NldGlkOi8vNjMyNDc5ODA1MQTdAAkJCgkKdsCyQqkse0BgWYfDCiCM8T3sgpg+u5HvPiEcTWVzaGVzL3JhcHRvciBzdHVmZl9DdWJlLjA0MwTiAAsJDAkKAAAAAAAANMMAAAAACoY0tUK7WxJArjOHwwoAADTDAAAAAAAANEMKCLeOPhxTjz+vE5w/IRdyYnhhc3NldGlkOi8vMz'
..'c0MzkzMTQ5NQrW7RpCoLsKQzipF0ME6QANCQ4JCgAAAAAAADRDAAAAAApUtLZCo9FlQEouh8MKAAA0wwAAAAAAADTDCq/jbT4UNtc+dqxFPyEXcmJ4YXNzZXRpZDovLzQyNTEwNTUzNDMKTJWgQb4NZkJDrrVCIRdyYnhhc3NldGlkOi8vNjMyNDgzNjczOCEUTWVzaGVzL3Jlc3RfQ3ViZS4wMDgE8QAPCRAJCoasskKjpGVA4h6HwwpcRis+yobxPrCUTz4hF3JieGFzc2V0aWQ6Ly8zNzQ0MTU5NTIyCtKAp0E0NWxCgALLQSEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0zODE0MzA5MzQ0BPcADwkQCQqGrLJCn6RlQIgEh8M'
..'E+gARCRIJCgAAAAAAAL5CAAAAAAqku7VChUtcQOrohsMKAAA0QwAAqkIAADTDCsLmjT6sO2Q/FKPOPiEXcmJ4YXNzZXRpZDovLzM4NjgxNTEzOTAKaRrVQUAAm0IcKRtCIRdyYnhhc3NldGlkOi8vNjMyNDYwMTg1MgQBAQkJEwkKBmiyQs0TT0DQEYfDCmHhJD50NdA+NLsMPwQFARQJFQkKAAAAAAAAcMEAAAAACmKtskKxtVdAdIyHwwobhmQ+FJBdP5E8pT4hF3JieGFzc2V0aWQ6Ly8zODY4MTUwNzk5CrdssUEoBaxC7UkAQiEXcmJ4YXNzZXRpZDovLzYzMjQ1NjU3NTYhFXBvcnRhY2FycmVnYWRvcl9kdXBsbwQMAQkJEwkK7qGyQoGO'
..'VkCIRYfDChSuRz7Vp0Q/16NwPiEXcmJ4YXNzZXRpZDovLzM3NDQxNTc3ODMKNAnWQaAlm0LgtBNCIRdyYnhhc3NldGlkOi8vNjMyOTUxNDg5MgQSARQJFQkKZsSyQhWhVkC2hofDCuwfxD04WUI/p5q9PiEXcmJ4YXNzZXRpZDovLzM4NjgxNDkxOTYKJ0UYQSDklkIkNRNCIRZyYnhhc3NldGlkOi8vMTAyMzk2NDA1BBkBFgkXCQoK16O8rkfvQQrXIzwKHPSyQjcLUECMr4bDCo/C9byuR+9BCtejPAoiOak+OgjpPs4poz4hDE1lc2hlcy9iYXRvbgdpAQQhARgJGQkGPDw8CgAAXMIAALRCAAC0wgreAbRCo70NQJSrhsMKAAC0wgAADEIAA'
..'AAACqyVP0BupGg+QyZdPyEXcmJ4YXNzZXRpZDovLzQ2MDk3NzE2NzQK0w0xQm3/VkBlYExBIQpQaXN0b2wgbWFnBCgBGgkbCQqSzLJCi78rQKbYhsMKDi0yPsdL9z47308+IRdyYnhhc3NldGlkOi8vMzc0MzkzNDIwMwofG6ZBoH9mQmxrwUEhF3JieGFzc2V0aWQ6Ly82MzI0OTIyMTMwBC4BFgkXCQquBLNC+QRQQHiuhsMKfziEPpUtyT50XpA+BDIBHAkdCQoAALTCAAAgQQAAAAAKwqSyQnkeUUD02IbDCgAAtMIAAAAAAAAgQQqvoxo+eNG6Pva8GT8ENgEUCRUJCqaSskIVoVZACoqHwwQ4AREJEgkKfK61QpmedUAI7IbDCtdrST5+0M'
..'o/sPrAPiEXcmJ4YXNzZXRpZDovLzIyNjk5NTgwNjEKqOKPQJhgCELw9v1AIRdyYnhhc3NldGlkOi8vMjI2OTk1ODc0MwQ+AR4JHwkKihC0QulUTkC6mobDCnuuMD47o/M+6QYsPwRCASAJIQkKAAAAAAAAoEAAAAAACjrJskKPvytAUMOGwwREAQkJEwkK7qGyQoGOVkD6ZIfDIRxNZXNoZXMvcmFwdG9yIHN0dWZmX0N1YmUuMDI3BEcBIgkjCQqK8bNC7/cuQHwyh8MKkPeNP8HTnz6EsARAIRdyYnhhc3NldGlkOi8vMzc0MzkzODE0OAqHgN5CcH76QSz2T0METAEkCSUJClK0skK7WxJArDOHwyEEVmVzdARPAQkJEwkK5hC0QjfeakCQMYf'
..'DCiGwsj+TGOQ/JUkTQCEXcmJ4YXNzZXRpZDovLzM4NjgxNTAwOTEKQU4RQ3x5OkOCTGJDIRdyYnhhc3NldGlkOi8vNjMyNDQ3Mzc1NCEFR2l2ZXIEVgHfCOAICpaNskJmZlZAVCuHwwofhYNAZmbWQBpVbD8hBlNjcmlwdCEEQXJtMSEEQXJtMiEKSGF0UmVtb3ZlciEESGVhZCELUGFudHNTY3JpcHQhC1NoaXJ0U2NyaXB0IRBULVNoaXJ0IE1lbHRlciAxIQVUb3JzbyEFUGFudHMhDVBhbnRzVGVtcGxhdGUhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9Mjk5MjM2MDAzNCEFU2hpcnQhDVNoaXJ0VGVtcGxhdGUhKmh0dHA6'
..'Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9NjQ5MTUzNDI2OQQmCScJKAkEagEpCSoJCqRwfT9cD7VCAAAAAAok/rNCskZfQLhwhsMKKdzrQo/CsUJI4evCIQNQYWQEbgErCSwJCnoDtEJN4YBA1m+GwwryeZo/ZRGDP/6LnD8hF3JieGFzc2V0aWQ6Ly8zNzQzOTQwNjExCgMQ70LSiAFD9Or1QiEXcmJ4YXNzZXRpZDovLzY0MzI3MzA3ODYELQkuCS8JBHYBLgkvCQoAAAAArsezQgAAAAAKtga0QpZ2XkBg8YfDBHgBMAkxCQp8AbRCqb+AQM71h8MKAAA0QwAAAAAAADTDIQFFBDIJMwk0CSEITGVmdCBMZWcEgAE1CTYJAwAAAAAAAHJAC'
..'s3MTD0AALRCCtejPArO/bNCjY68P5zyhsMKw/WyQmbms0KF67LCIQlSaWdodCBBcm0EhQE3CTgJCkjhOr8AALRCCtejPAo+BbRCSl1eQJLyh8MKPYq0wj2KskJ7lLRCIQlSaWdodCBMZWcEigE5CToJCq5HYb5cD7RCCtcjPAoOAbRCRZS8P7Jyh8MK4frDwlyPs0IAAMRCBI4BMwk0CQoAAAAAHwW0QgrXozwK9gG0Qu5aXkCYMofDCgrXozwAALRCAAAAACEISHVtYW5vaWQhBkhlYWx0aCEJTWF4SGVhbHRoIQpCb2R5Q29sb3JzIQlIZWFkQ29sb3IHUQEhCkhlYWRDb2xvcjMG/5SUIQxMZWZ0QXJtQ29sb3IhDUxlZnRBcm1Db2xvcjMhDE'
..'xlZnRMZWdDb2xvciENTGVmdExlZ0NvbG9yMyENUmlnaHRBcm1Db2xvciEOUmlnaHRBcm1Db2xvcjMhDVJpZ2h0TGVnQ29sb3IhDlJpZ2h0TGVnQ29sb3IzIQpUb3Jzb0NvbG9yIQtUb3Jzb0NvbG9yMyEITGVmdCBBcm0EpQE7CTwJCkjhOj8AALRCCtejPAre/rNC5lheQIByhsMKuJ60Qj2KskJ7lLTCISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTI5OTIzNzM0MTQhBkhlbG1ldAQ9CT4JPwkErAFACUEJCgAAAAAAgLVCAAAAAAqG/LNCgnqeQGAvh8MKAAA0wwCAskIAADRDCs3MTD7NzEw+zcxMPgoAAMhAAADIQAAAyEA'
..'hCUJhbGFjbGF2YQSyAUIJQwkKrvyzQnZhnkC4L4fDCu7MnD8miZs/sBqdPyEXcmJ4YXNzZXRpZDovLzE2NTc0MzI1NjkK7sycP6wcmj/WzJw/IRdyYnhhc3NldGlkOi8vMzMyNzM2MDM0MyEOVW5pb25PcGVyYXRpb24hBFZMWDIHTAEEvgFECUUJBnUAAAMAAAAAAICYQApmZmBCAAD3QvaohMIKGDC1QqkcsEAi94bDCjOz3EKPwt1BChclQwp2r7o9F7u6PR3mvD4hDFVzZVBhcnRDb2xvcgofj9k9SkfcPVI7FT8KMxO1QiTbrEB++YbDChqP2T1LR9w9UzsVPwrfPLVCg2avQBsFh8MKmplIQh8FAENSuBjDChmP2T1LR9w9UjsVPwoYPrVC'
..'4/CsQEruhsMK7FFhQinc+EIUrglCCh2P2T1JR9w9UzsVPwrrZbVCkeKvQHf4hsMKPQpIQuxR/kJSOPNCChWP2T1ER9w9UzsVPwrhVLVCcymwQEUAh8MKPQpIQuxR/kJSOJlCChaP2T1ER9w9VDsVPworKbVC/3usQBLxhsMK7FFhQinc+EIK15RCChSP2T0xXT499Pa6PgrCLrVCbvavQNL1hsMK16NUQs3M+0KPQpdCIQJWTATZAUQJRQkGMjIyCqgwtUIpRrBAivaGwyELUmVmbGVjdGFuY2UDAAAAoJmZqT8KKTniPU1I4T2wL78+AwAAAAAAANA/Cn3RAz4/dwU+a9Y0PwrnBLVCHU6tQOr3hsMKbdEDPkx3BT5s1jQ/CmY3tUJxY7BA/QWHw'
..'wps0QM+TXcFPmzWND8K4Ti1QndorUBX6obDCn3RAz4+dwU+a9Y0PwojabVCxfmwQKv2hsMKcNEDPkJ3BT5p1jQ/CnxUtUKrT7FAIQCHwwpy0QM+QncFPmrWND8KhB+1QtLarEC17YbDCnHRAz6HrmY93I/iPgpLJrVC1xGxQHjzhsMKRjRWPq5oCj5rbsI9CoPttEJf+bVA2uyGwwTwAUQJRQkGLy8vCnhCtUJpsK5AtPmGwwoc+g4+0NgMPpFPKD8KlNEDPkt3BT5r1jQ/CgQFtUIEUK1A7feGwwp60QM+Y3cFPmzWND8Kgze1QlhlsEAABofDCnjRAz5ldwU+a9Y0Pwr+OLVCXmqtQFrqhsMKk9EDPkp3BT5s1jQ/CkBptUKs+7BArvaGwwp/0Q'
..'M+V3cFPmzWND8KmVS1QpJRsUAkAIfDCoHRAz5XdwU+bdY0PwqhH7VCudysQLjthsMKgNEDPquuZj3fj+I+CmgmtUK+E7FAe/OGwwphNFY+wmgKPnZOsD4Kci+1QtQzr0DG+IbDIQlXZWRnZVBhcnQKaNGDPF/RAz1n0QM9CrN9tUJVG6ZAcAKHwwo9Cg7C9qgPQ8N1KUMK8D+1PWfRAz1f0YM8CiOLtULjqqZA1QWHwwrXo1TCZmZYwkihJcMKAACAPwAAgD8AAIA/CgAAAAAAAAAAAAAAAAr6uUU9WNGDPPu5RT0Ko4m1QvylpkAtBofDCmjRgzwOukU9GrrFPAqygLVCufmlQCMDh8MKkpG1Qh+ap0AxCYfDCj0KDkIpXBHCw3UpwwqUkrVCPFK'
..'nQDcJh8MKfNEDPj93BT5n1jQ/CgUFtUL7T61A7feGwwpt0QM+SncFPmjWND8KhDe1Qk9lsEAABofDCmzRAz5LdwU+aNY0Pwr/OLVCVWqtQFrqhsMKe9EDPj13BT5p1jQ/CkFptUKj+7BArvaGwwpv0QM+QncFPmfWND8KmlS1QopRsUAkAIfDCnDRAz5CdwU+Z9Y0PwqiH7VCsdysQLjthsMKK7rFPIOu5j20xaQ9Cop8tULjfalAg/6Gwwpv0QM+hq5mPWOu5j0KIXG1Qp5YqUAgAYfDCrvRAz5cdwU+a9Y0PwouBrVCz/OsQI7zhsMKitEDPop3BT5t1jQ/Cno2tUKBdLBAvwaHwwq70QM+WncFPmzWND8K3Wu1QjQYsUCo9obDCofRAz6JdwU+'
..'bNY0PwocObVCiVmtQJHphsMK7FFhQinc+EJcjwpCCozRAz5jdwU+aNY0PwpUVrVCd3qxQMoAh8MKjtEDPmN3BT5q1jQ/CmQdtUI3uaxABu2Gwwq/SxQ+k9GDPQ+6RT0KdQi1Qu1ItECX7YbDCi4GtULO86xAjvOGwwp6NrVCgHSwQL8Gh8MK3Wu1QjMYsUCo9obDChw5tUKIWa1AkemGwwqL0QM+ZHcFPmvWND8KVFa1QnR6sUDKAIfDCo3RAz5kdwU+bdY0PwpkHbVCNLmsQAbthsMKvUsUPpPRgz1ormY9CnxltUIXtKpAbf6Gwwr3xSQ+ta7mPbnFpD0K5Xq1Qq14qUDa/obDCoPRAz5bdwU+adY0PwpTVrVCd3qxQMoAh8MKhNEDPlt3BT5r1'
..'jQ/CmMdtUI3uaxABu2Gwwpw0QM+i0sUPnRLFD4KTJy1QiNEpUCcB4fDCqVLFD6A0YM9ArpFPQrKhrVCuU6nQFUEh8MKsNEDPld3BT5s1jQ/Ci0GtULR86xAj/OGwwqG0QM+fncFPm/WND8KeTa1QoN0sEDABofDCrDRAz5VdwU+bdY0Pwrca7VCNRixQKn2hsMKgtEDPn13BT5t1jQ/Chs5tUKLWa1AkumGwwpf0YM84sUkPXzRAz0KvO+0QvemtkDR6YbDCj0KDsL2qA9DheueQgRSAkQJRQkDAAAAAAAAkUAK6Da1Qi7frkAy/IbDCs1W2z3Dh9k9pNEhPwqV0QM+SncFPmnWND8KLAa1QvnxrECO84bDCnjRAz5kdwU+bNY0Pwp4NrVCqXKwQL'
..'8Gh8MKlNEDPkh3BT5q1jQ/CttrtUJcFrFAqPaGwwp10QM+YncFPmrWND8KGjm1QrJXrUCR6YbDCnPRAz5EdwU+Z9Y0PwpSVrVCnnixQMkAh8MKdNEDPkR3BT5q1jQ/CmIdtUJet6xABe2GwwqiSxQ+c9GDPGSuZj0KwVa1Qj6CqkDLAYfDCpPRAz5JdwU+atY0PwosBrVC+PGsQI3zhsMKd9EDPmJ3BT5r1jQ/Cng2tUKocrBAvgaHwwqT0QM+R3cFPmrWND8K22u1QlsWsUCn9obDCnTRAz5gdwU+a9Y0PwoaObVCsVetQJDphsMKcNEDPkR3BT5o1jQ/ClJWtUKdeLFAyQCHwwpy0QM+RHcFPmvWND8KYh21Ql23rEAF7YbDCp9LFD5z0YM8D7p'
..'FPQq8+bRCBRe0QPTwhsMKk9EDPkl3BT5p1jQ/Ci0GtUL78axAjvOGwwp5NrVCq3KwQL8Gh8MK3Gu1Ql4WsUCo9obDCnTRAz5gdwU+atY0PwobObVCtFetQJHphsMKcdEDPkR3BT5n1jQ/ClJWtUKgeLFAygCHwwpz0QM+RHcFPmrWND8KYh21QmC3rEAG7YbDCqBLFD5z0YM8DLpFPQrFd7VC1hunQMUHh8MKY9EDPohLFD56SxQ+CkuctUJNQqVAmweHwwpw0QM+NXcFPmnWND8K3QS1QttNrUDr94bDCmTRAz4/dwU+atY0PwpcN7VCL2OwQP4Fh8MKY9EDPj93BT5q1jQ/Ctc4tUI1aK1AWOqGwwpv0QM+NHcFPmrWND8KGWm1QoP5sECs9obD'
..'CmXRAz42dwU+ZtY0PwpyVLVCaU+xQCMAh8MKZtEDPjZ3BT5n1jQ/CnoftUKQ2qxAt+2Gwwpm0QM+ZtGDPNiP4j4KvRi1QnXlsECS9obDCnDRAz41dwU+atY0PwrdBLVC202tQOz3hsMKZNEDPj93BT5r1jQ/Clw3tUIvY7BA/wWHwwpj0QM+P3cFPmvWND8K1zi1QjVorUBZ6obDCm7RAz40dwU+a9Y0PwoZabVCg/mwQK32hsMKZ9EDPjZ3BT5p1jQ/CnNUtUJoT7FAIwCHwwpo0QM+NncFPmvWND8Kex+1Qo/arEC37YbDCmfRAz5m0YM8tsWkPQrDZ7VC4sGoQN8Eh8MhGUNvbXRhY3Mgbm8gbm90IHRoZSBwZXJzb24EnQJGCUcJCgAAAAAAA'
..'LTCAAAAAArag7NCwZOiQIgxh8MKSLTfP6bqsj/et5c/IRdyYnhhc3NldGlkOi8vNjQ2MTI4OTMyNAqWDUZCzoIUQvLXDUIhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9NTM2MTYwNTY2MCEYTWVzaGVzL3VudGl0bGVkX0N1YmUuMDMwBKQCSAlJCQouAbRC1/+mQJQxh8MK2zHWP2ZL1j+jL8k/IRdyYnhhc3NldGlkOi8vMzc0NDIyMjYxOAoVciNDk4UjQ+iEGUMhCUhFTFNUQVJYTwSrAkoJSwkKKVznwOF6C8LheiPCCuZJtUJWIbtAvjCHwwrNzAzBcT0Kwh+FN8IKcaPYPgdyMz72S6o+CkSlCz6pXPs9T6WLPQrNmbVCCz'
..'C3QNs/h8MKKKULPs9c+z1XpYs9CokhtUIe5r9AMD2HwwquRwVC7FGMwcP1fcIKRKULPoNc+z1jpYs9Cr2mtUK+b7hAFD2Hwwq4HoVAmpkywmZmIsIKNqULPudc+z08pYs9CpUOtUKntsBAxzqHwwq4HmBCMzOtQUjhMMIKNqULPuNc+z0+pYs9ChgstUKt/sBAKDeHwwqaGYZCj8LbwSlcsMIKLqULPthc+z1MpYs9CtEwtUKrscBAvziHwwquR1tCCtftwVwPo8IKTKULPr9c+z08pYs9CreatULogLZAFz6HwwrsUdbB7FEzwtejAsIKMKULPtZc+z1MpYs9CiGdtUItBrlALSSHwwpSuEJB4boLw2ZmNEIKPKULPphc+z1gpYs9CjOhtUIP1Lh'
..'AFD6HwwoK10tBexQPwlK4P8IKRKULPsVc+z1ApYs9CqyVtUI63LZAX0CHwwoUrmvBPQrhwdejKMIKMKULPt9c+z1KpYs9CreLtUIqjLdATyCHwwrXo7jAcT0dw2ZmMEIKPKULPstc+z1FpYs9CrWNtUKPbLdAwEGHwwoK14vApHCLwXE9OsIKLqULPt9c+z1JpYs9Ci0btUKta8BATjyHwwpcj0hCexTGwAAAe8IKMaULPsNc+z1YpYs9CsKctUJf9rZAFSSHwwpcj5DBhev2wvYo3EEKTKULPqFc+z1NpYs9CmyetUJV3LZAtT2Hwwp7FJLBAABKwgrX88EKMKULPttc+z1KpYs9CtqPtUK63LdA7yCHwwrsUbg/PUoWw+xRL0IKLqULPuFc+z1I'
..'pYs9CkUVtULkSsBAFT2HwwquRzNC9ijMQM3MVcIKPKULPrVc+z1QpYs9CjeStUJ2ubdALEGHwwquRyFApHDFwY/COcIKMaULPs5c+z1SpYs9CmCZtUIumLZArCOHwwpI4dbBuJ4Aw4Xr60EKLqULPr9c+z1cpYs9Cp+htULBuLhAhiSHwwrNzMw/rkf+wq5HDEIKLqULPstc+z1WpYs9Cu6WtUJ3YbdA1yGHwwpmZirBCtcHwz0KD0IKTKULPndc+z1jpYs9ChqptUL2RLhApTuHwwpSuKbArkdowqRw58EKLqULPtVc+z1RpYs9CkaTtUJeCLdAUSGHwwofhZXBcf0Nw65HFUIKKKULPtZc+z1SpYs9ChcctUJ3vL9AET6HwwqkcONBH4XrwAAAa'
..'cIKNqULPuhc+z08pYs9CswUtUKc0sBAHDqHwwrXo3lCFK7PQPYoZcIKMaULPqtc+z1lpYs9CviltUIOabhAJiaHwwqkcJXA1yPpwjMz0UEKTKULPvdc+z0cpYs9Co0qtUKqE8FAdiuHwwr2KIdCSGEXwwCAtkIKSKULPgdd+z0ZpYs9CoEXtUK0rsBAXyaHwwrsUTtC7FErw1yPgUIKTKULPgpd+z0QpYs9CpEMtUJD1sBACyiHwwq4HmVCwzUdQ6RwM0IKTKULPg1d+z0TpYs9CuEStUIZ8MBArCiHwwo9Cn5CZiYtQ3sUa0IKPKULPgVd+z0lpYs9CrEYtUL0/79A6COHwwrNzOpB7NEtwzMzbUIKSKULPgZd+z0apYs9CpcRtUIhjsBAmSWHww'
..'ofhSdCAIAwQ8P1YEIKPKULPgNd+z0mpYs9CkUetUJoJ8BAwiSHwwpxPQhCpHAjwz2KgUIKJfpNPu9c+z0wpYs9Cio7tUJNzb9APSeHwwpI4RxCmtkRw/aolkIK0q9dPsJc+z1epYs9CnJAtUJmZr9AzTqHwwrsURtC7FELwuF6k8IKSKULPvVc+z0jpYs9CgottUJ19sBA9imHwwoAAE1CmlkVw6TwokIKSaULPv6AQz0GI48+CkiftUI5+bhA/jKHwwoK1yM8cf0zwzMzfkIKSaULPv2AQz0GI48+CgrXIzxx/TPDMzNWQgpJpQs+wKASPco2Uz4K2ze1Qvzmv0BQM4fDCgrXIzxx/TPDMzMaQgpIpQs+wKASPco2Uz4KCtcjPHH9M8NmZrxBCrd'
..'2CT9HA8A9QDJaPgr6cbVCKDu7QGsgh8MKPQoZQgAAfcLDdYjCCrd2CT9GA8A9QTJaPgr3frVCauy7QAwjh8MKSOEAQnsUQcL2KG7CCrd2CT9FA8A9QTJaPgozM7tB9igGwuF6UsIKt3YJP0MDwD1EMlo+CtGHtUJZW7xAYiaHwwrXo3BApHAhwc3MO8IKwnYJP1UDwD1VMlo+ClNxtUIsRrtAd0GHwwqF6wtCUjjmwsN1iUIKwnYJP1UDwD1SMlo+CiR/tUKh6LtA3j6HwwquR+lB9qgBw0jhc0IKwnYJP1gDwD1RMlo+CgAApkHsURDDhetaQgrCdgk/VwPAPU8yWj4KqYi1QpJLvECNO4fDChSuB0CFayjDrkdHQgrxSDc+TKWLPUfUpT4KYqi1'
..'Qvq4tkA0LofDCgrXI7wK1yM8w3XSwgrwSDc+TaWLPUfUpT4KS6S1QgRbtUA0LofDCgrXI7wK1yM8Ujjywgr0SDc+SqWLPUfUpT4Kwqi1QpPBuEA0LofDCgrXI7wK1yM8H4WVwgrxSDc+S6WLPUfUpT4KCtcjvArXIzw9CrLCCvZINz5KpYs9R9SlPgrynbVCekW6QDQuh8MKCtcjvArXIzw9CmLCCvRINz5OpYs9R9SlPgpUF7VCYP3AQDQuh8MKCtcjPHH9M8OF6wHBCvRINz5PpYs9R9SlPgoeAbVCxefAQDQuh8MKCtcjPHH9M8MAAMDBCvZINz5MpYs9R9SlPgqpN7VC5cLAQDQuh8MKCtcjPHH9M8PNzLJBCvVINz5MpYs9R9SlPgoK1yM8c'
..'f0zw6RwAUEK+Eg3Pkyliz1H1KU+CmFOtUJB579ANC6HwwoK1yM8cf0zw2ZmIkIKcjGqPkYDwD7xd9E9ConstEKmTcFAzSmHwwpcjzPCZmZ2wj0Kp8EKcTGqPkUDwD7yd9E9Ck3ttEKTP8FArjGHwwozM0LCAAC0wgrXIzwKcTGqPkYDwD7zd9E9CrDwtEL8AcFAhjuHwwrNzC3ChWv2wgAAwkEK3m7fPUNhdD0cLIE+Ci1RtUJtCLxAXDeHwwrhekHC7NGmwqRwncAK3W7fPUNhdD346oI+CjRRtUI7CLxA3imHwwrhekHCFC7Bws0ML8MKQ2F0PZ29SD6evUg+CucltUKgGL9AlzCHwwozM0LCAAC0wuH6s8IKmeziPUNhdD30pms+CslctUIyNr'
..'tAlzCHwwpDYXQ9lRt9PovjcD4KiXq1QiIbuUCXMIfDCmwxqj5AA8A+73fRPQpjoLVClZK0QK0xh8MKbTGqPkEDwD7xd9E9ClydtUKmybRAzyeHwwoAADnCKVzhwuF6hkEKbjGqPkEDwD7ud9E9CuSetUKarbRAsDeHwwo9CjbCw/V/wqRwmcEKdTGqPkYDwD7xd9E9Cp7htELdrMBA1CmHwwpyMao+RQPAPvJ30T0KYuK0QsqewEC1MYfDCnExqj5GA8A+9XfRPQrF5bRCM2HAQI07h8MK4G7fPUNhdD0cLIE+CkJGtUKkZ7tAYzeHwwrfbt89Q2F0Pfjqgj4KSUa1QnJnu0DlKYfDCkNhdD2evUg+n71IPgr8GrVC13e+QJ4wh8MKm+ziPUNhdD3'
..'0pms+Ct5RtUJplbpAnjCHwwpDYXQ9lht9PorjcD4Knm+1Qll6uECeMIfDCm8xqj5AA8A+73fRPQp4lbVCzPGzQLQxh8MKbjGqPkEDwD7yd9E9CnGStULdKLRA1ieHwwpwMao+QQPAPu530T0K+ZO1QtEMtEC3N4fDIQdIRUxTVEFSBIwDTAlNCQoAAIJCAAC0wgAANMMKnEK1QpiTukDSMIfDCgAAtEIAAMjBAAC0wgqMBo0+2kcCP0gPqz4Kd5nGPWIxwD33H4A8CnIrtUJqJcFAGi+HwwpTYbM8U2GzPFNhszwKeyi1Qgm4wECUMIfDCsWAozzFgKM8rBCPPQpnoLVCO+C0QBMxh8MKCtcjPAAANEMzM0JCCsWAIzwpQfU8xYAjPQodBrVCRuDA'
..'QJAwh8MKCtcjPAAANEOaGZ1CCsWAIzzGgCM9KEH1PAoRErVC/iTBQG0yh8MKCtcjvAAAAACaGZ3CChEStUIMJcFAly6HwwqtEI8992BMPcWAIz0KkSG1Qg3+wUCCMIfDCocItULcrMFAnjWHwwqHCLVCAq3BQGYrh8MKJ0H1PMiAIz3FgKM9CjgMtUJlFcFA1zGHwwopQXU9yICjPcWAIz0KsPy0QuEMwUB0K4fDCrD8tEK7DMFArDWHwwrFgCM8K0F1PShBdT0KNAK1Qvf0wECQMIfDCkhV5T0P6Vo+D10cPgoMpbVCRae1QFBDh8MKCqW1QsmntUBZH4fDCk42sT4P6Vo+6aK7PgrfWrVCeee6QMUyh8MKTFXlPQ/pWj4RXRw+Cj8NtULHZcBAX'
..'z6Hwwo+DbVCLGbAQAIjh8MKTW4FPW98UD3eyaY9CsF8tULzarxAYyaHwwpNbgU9bHxQPd7Jpj0KLp61QsMXukBjJofDCgrXIzwAADRDuB47QgpNbgU9bXxQPd7Jpj0KeVi1QiDZvkBkJofDCs0u+jz6Lvo95cmmPQq+erVCU3K8QDRCh8MKrkchQVxPIsOPwktCCsku+jz3Lvo95cmmPQoqnrVC+gO6QPhCh8MKj8JdQa6HJcOamUVCCs0u+jz5Lvo95cmmPQr5WLVCGua+QCpBh8MK0i76PPcu+j3jyaY9CgDGtUL2YLdA9DyHwwoAAFNCXE8dQ4/CHkIKzS76PPMu+j3myaY9Cp81tUKkTMFA0j+HwwoUrgNB1yMUw+xRWEIK1skmPiUcFj7yya'
..'Y9ClLBtULfybdADx6Hwwo9CgvCrgcww4+CAMMK08kmPiocFj7wyaY9ChErtUIYzsFA/iGHwwpI4SrBj8IPQ0jhCsMK1skmPhkcFj4AyqY9ChmotUJZ+rZAaiGHwwrsUSzCSOEnQ9ej7MIK5MkmPjMcFj7VyaY9ChgetULUTsNA9iSHwwr2KIpB7FH0Qj2KFcMK5MkmPiccFj7jyaY9CjYVtUKZJMFAOymHwwrXo5DAAIDbQjPzFsMK3ckmPiccFj7ryaY9CkEatUI+wsBATieHwwpcjzLBKVzwQnG9D8MK3MkmPiscFj7myaY9CkvOtUJAobdAISCHwwpcjyfCcb0Vwx/FC8MK2ckmPiocFj7ryaY9CmGftULzsrdANT+Hwwr2KBfCw/WeQQrX6kI'
..'K0skmPh8cFj78yaY9Ck2htULicLdAQiCHwwoK1wHCXA8gQ81M9MIK1skmPi4cFj7pyaY9CgnItUIeDrhAbx2HwwqameHB9ignw2YmBcMK2ckmPjQcFj7jyaY9CtK9tUKmy7hAykOHwwqkcL3BheuJwI8CAkMK0skmPi4cFj7tyaY9CkK+tUKduLhA1xuHwwoAAIrBFO4xw3uUA8MK3ckmPi4cFj7iyaY9Cv8htUIWV8JAFyOHwwpcj4I/cf0AQx+FEMMK48kmPikcFj7lyaY9CpvGtUKJd7dANj+HwwqPwl7CSOHAwSncBUMK3MkmPiIcFj7wyaY9Cg/HtUIJZrdAmSCHwwpcj0TCKZwfw8O1BMMK2ckmPjEcFj7myaY9Ckq3tUKVh7hADEOHwwrN'
..'zO7B7FGQQD0K/EIK3ckmPjEcFj7fyaY9CiMltUK6w8JALCKHwwpmZhJBmtkGQwAAEMMK0skmPikcFj7zyaY9CgO4tUI1bLhAiRyHwwoUrr3B9ugtQ8O1AMMK48kmPi8cFj7gyaY9CgvOtUKoq7dAsD+HwwoK10DCj8ILwoVrDkMK38kmPiMcFj7wyaY9CouktUIJVLdAxD6Hwwpcj1LC9iggQSnc4UIK38kmPiscFj7nyaY9CoG/tUIz8rdA7EGHwwoK1zPCUrgawRSu/0IK3MkmPhMcFj79yaY9CgyrtUIYx7ZAHCOHwwoK12bCPYozQzOz58IK38kmPjAcFj7hyaY9CprGtUIeLLhAiUKHwwpmZhnCheudwc2MBkMK08kmPi8cFj7qyaY9Cs0ut'
..'ULgMMJA8iCHwwpmZkbA7FEWQ4WrC8MK5MkmPjAcFj7ZyaY9CkUbtULK28JAvyWHwwqamQlBuB7qQhSuFsMK48kmPhscFj70yaY9CtSptUKI+LZAzDyHwwo9CoDCzcyMPwrX30IK3skmPjccFj7UyaY9Cm0UtUKmPMFANDeHwwoAAKDAuJ6LQqTwF0MK2MkmPj8cFj7VyaY9CpMetUJjlsJATj2HwwpxPeq/KVw7QqTwD0MK3skmPkAcFj7KyaY9Cu4ctUJhbMNAWDuHwwoAAIhBcT1nQmamFkMK3skmPkIcFj7PyaY9CjAatUIT+MJAljqHwwoK1wNBw/V6QnG9F0MK0ckmPj8cFj7ZyaY9CoQrtUInaMJANkCHwwq4HjXA9ijqQXG9DEMKxiG1Qj'
..'ACw0A9PofDCgAAyECPwiNCw7UPQwrRySY+PhwWPtzJpj0K2Ce1QqwDwkAxP4fDCtejKMGPwg5Ccf0LQwpPA3Y+NRwWPuTJpj0KxSq1QgPVv0AkPIfDCuF6rsE9CjhCChcJQwpsY4Q+IhwWPvjJpj0KxjC1QvZwv0C/JIfDCnsUrsGkMAVD9ugHwwrYySY+ORwWPtzJpj0KWxa1QqQIwUD8OIfDCnsUXsHhel9CpLAOQwrKySY+TIFpPVT1qj4KdZ+1QpiVt0CFLYfDCrgeBb89Che/j4ITQwrMySY+R4FpPVT1qj4KuB4Fvz0KF7+PgglDCtrJJj7oIC89iER8PgrOKLVCYyLAQMAth8MKuB4Fvz0KF78fBfVCCuzJJj7UIC89iER8Pgq4HgW/PQo'
..'Xvx8F10IKqy4kP49V5T3dTYI+CjB7tUKrLrtA7kOHwwpI4RvC7NHpQhQu0MIKqy4kP5ZV5T3ZTYI+CkNstULhT7pAzUCHwwp7FArCAAAFQz2K48IKqy4kP6NV5T3RTYI+Cs3M2MH2KBVDMzP0wgqrLiQ/xVXlPb1Ngj4Kv2K1Quq3uUDRPIfDCpqZEcHNjC5DwzUCwwq0LiQ/u1XlPdxNgj4Kz3i1QtpSu0B4HIfDCh+FK8LhenZCcT3OQgq0LiQ/zVXlPdJNgj4KJGu1QgFfukCSH4fDCoXrGcIpXDJCPYrkQgq0LiQ/4VXlPcdNgj4KcT32wbge30H2qPdCCrQuJD/vVeU9vk2CPgrDYrVCRrS5QIcjh8MK16M8wTMzM0CkMAVDCgLpWj77yaY9'
..'ug/GPgpSybVC5Zy2QBkzh8MKuB4FP/ZoM0NczypDCh7pWj7oyaY9ug/GPgrQ47VCkL62QAkzh8MKuB4FP/ZoM0Ok8BpDCuDoWj4XyqY9ug/GPgqhorVCSde2QDQzh8MKuB4FP/ZoM0PDtR7DCuvoWj4OyqY9ug/GPgq4HgU/9mgzQ1L4LMMK4uhaPhfKpj26D8Y+CjKHtUKG1bdAUDOHwwq4HgU/9mgzQ8N1DMMKOelaPtHJpj26D8Y+Cn0YtUIprMJA/TOHwwq4HgW/PQoXv/aol0IKP+laPszJpj26D8Y+CuQctUKCT8RACjSHwwq4HgW/PQoXv83Mb0IKDelaPvDJpj26D8Y+CsIYtUJgPsBA5zOHwwq4HgW/PQoXv5qZ1EIKJelaPt/Jpj26D'
..'8Y+CrgeBb89Che/exS4Qgry6Fo+CMqmPboPxj4KMya1QgBzvkDNM4fDCrgeBb89Che/uB75QgoRRss+2FXlPrgu+j0KJBi1QnLgxUBaOYfDCgrXLsJI4e3CFC4fwwoKRss+1lXlPr4u+j0Kshi1QnPVxUDxL4fDCsP1PcLNTLbC4TozwwoBRss+2FXlPswu+j0KWhy1QgmUxUApJIfDCilcK8JxPWnC1yMdQwpPbgU+z/CRPX5Hmj4K8G61QmTHvUClKIfDCgAAPcIzM8PCcX0uwwpPbgU+z/CRPThdnD4Kn2+1Qq29vUDCOIfDCuF6PcJIYanCKVx/wArP8JE9N8JvPiLCbz4KhDq1QsBbwUD+MIfDCsP1PcLNTLbCPYq1QgoIhAc+z/CRPUy6jD'
..'4Ka321QrPLvECoMIfDCs/wkT30Jpc+4dqPPgqvobVChVK6QHowh8MKBkbLPsxV5T65Lvo9CgLztULz8bZA1y6HwwoARss+zlXlPsMu+j0Ky++1QrArt0CmOofDCkjhNcK4nonCw3UkQwoNRss+zlXlPrMu+j0K5fC1QukVt0CtJ4fDCq5HMcIULunCXM8gwwoORss+2FXlPrcu+j0KcyW1QsGbxkBQOYfDCghGyz7WVeU+vS76PQoBJrVCwpDGQOcvh8MK/kXLPthV5T7KLvo9CqkptUJYT8ZAHySHwwpObgU+z/CRPX5Hmj4KP3y1QrOCvkCbKIfDCk5uBT7P8JE9N12cPgrufLVC/Hi+QLg4h8MKz/CRPTbCbz4hwm8+CtNHtUIPF8JA9DCHwwo'
..'GhAc+z/CRPUy6jD4Kuoq1QgKHvUCeMIfDCs/wkT3zJpc+4NqPPgr+rrVC1A27QHAwh8MKBEbLPsxV5T65Lvo9ClEAtkJCrbdAzS6Hwwr+Rcs+zlXlPsQu+j0KGv21Qv/mt0CcOofDCgpGyz7OVeU+sy76PQo0/rVCONG3QKMnh8MKyy76PPMu+j3oyaY9Cmt5tULuiLxA1B6HwwoK10NB7FG2wQoXAUMKzi76PPIu+j3nyaY9Ci5YtUJfAb9ALiCHwwrLLvo88C76PefJpj0KpJy1QicaukA/HYfDCs3MgEF7FJzB1+MBQwrLLvo89C76PenJpj0KQTW1QrNqwUDCIYfDCqRwjUBSuOjBhSsAQwrQLvo8+i76PeDJpj0KM8q1Ql5Dt0BNIofDCrge'
..'IUIAANRBzQwJQwrMLvo88S76Pd/Jpj0KEWq1Qrm8u0DGHofDClK4hsEzMz9B9mgDQwrJLvo88C76Pd7Jpj0K/Iy1QjVIuUDUHYfDCpqZUcH2KHRBFK4BQwrMLvo88C76Pd7Jpj0KpEa1QmkXvkD9H4fDCs0u+jztLvo938mmPQrusrVC7oK2QKQjh8MK7FGQQXE9VULX4w9DCs0u+jzqLvo938mmPQo4JLVCkInAQIMhh8MKKVz3waRwTUGF6wNDCtHJJj4eHBY+8MmmPQrkrbVC/MG2QJBCh8MKFK7nwFyPC8KkcCPCCs7JJj4lHBY+68mmPQo9HrVCeynBQGQ/h8MKcT0FQmZmjMHD9X3CCtHJJj4THBY+/cmmPQpXvbVC2D+4QD8/h8MKuB6FQ'
..'NejMsJmZiLCCuHJJj4uHBY+0MmmPQqaB7VCjSLCQII8h8MKuB5gQj0KrUFI4TDCCuHJJj4iHBY+3MmmPQrZKrVCnXjCQDA4h8MKmhmGQo/C28EKV7DCCtrJJj4iHBY+5cmmPQp9MLVCoRzCQBU6h8MKrkdbQoXr7cE9CqPCCtfJJj4lHBY+48mmPQr7rrVC0fC1QHRAh8MK7FHWwWZmM8KamQLCCtXJJj4mHBY+5smmPQrWsbVCrPO4QIEhh8MKSOFCQXG9C8NmZjRCCs3JJj4aHBY++smmPQq6trVCp7e4QHBAh8MKCtdLQbgeD8IUrj/CCtHJJj4mHBY+6MmmPQr2qLVC3l22QC5Dh8MKFK5rwbge4cGamSjCCtXJJj4vHBY+38mmPQoInbVCMz'
..'C3QOMch8MK7FG4wABAHcNmZjBCCs3JJj4oHBY+6cmmPQpyn7VCPgq3QNREh8MK9iiMwJqZi8FxPTrCCtrJJj4oHBY+3smmPQqlFrVC/8jBQFY+h8MKH4VIQmZmxsDD9XrCCuDJJj4jHBY+4MmmPQpksbVCRn22QGQhh8MKXI+QwcP19sL2KNxBCtfJJj4cHBY+7cmmPQpos7VCBF62QP8/h8MKexSSwT0KSsIK1/PBCtXJJj4rHBY+4cmmPQr6obVCa5C3QKIdh8MK7FG4P81MFsMpXC9CCtrJJj4sHBY+2smmPQqYD7VC1aHBQEM/h8MKrkczQgrXy0DNzFXCCs3JJj4iHBY+8MmmPQrUpLVCGWa3QCNEh8MK16MgQJqZxcGPwjnCCuDJJj4oHBY'
..'+3MmmPQparbVCxwy2QOcgh8MKSOHWwdejAMMAAOxBCtvJJj4dHBY+68mmPQo0t7VCM5e4QOwhh8MKzczMP81M/sKuRwxCCt3JJj4lHBY+48mmPQpuqrVCM/22QLceh8MKZmYqwZrZB8M9Cg9CCtfJJj4OHBY++smmPQopwLVCwgy4QIk9h8MKUrimwOxRaMIpXOfBCt3JJj4qHBY+3MmmPQoQprVCyJK2QBceh8MKH4WVwQAADsOuRxVCCs7JJj4pHBY+5smmPQq9F7VCuPfAQHFAh8MKpHDjQQrX68AAAGnCCuHJJj4qHBY+08mmPQoGD7VC9EPCQLc7h8MKmpl5Qilcz0C4HmXCCuDJJj4VHBY+78mmPQplvLVCATi4QNwjh8MKpHCVwBQu6cIz'
..'M9FBCtnJJj40HBY+z8mmPQr9KLVCwJHCQDgqh8MK9iiHQtdjF8MAgLZCCtTJJj48HBY+0MmmPQo9ErVCMBnCQCQkh8MK7FE7QntUK8Ncj4FCCtnJJj48HBY+xcmmPQosBbVCbEjCQCMmh8MKuB5lQqQwHUOkcDNCCtnJJj49HBY+ycmmPQq3DLVCSGfCQOMmh8MKexR+QkghLUM9CmtCCszJJj46HBY+1cmmPQqnE7VCfkjBQDIhh8MKSOHqQXvULcP2KG1CCtTJJj47HBY+0cmmPQorC7VCSfLBQDcjh8MKXI8nQnF9MEOF62BCCszJJj46HBY+18mmPQpRGrVCnHfBQDUih8MKcT0IQjNzI8M9ioFCCkgDdj4zHBY+3smmPQrUPLVC/QvBQCwlh'
..'8MKhescQincEcP2qJZCCmhjhD4dHBY+9MmmPQopQ7VC95DAQIk8h8MK7FEbQilcC8LhepPCCtTJJj42HBY+1cmmPQr2K7VC4W7CQG0oh8MKPQpNQilcFcOk8KJCCsrJJj5EgWk9TvWqPgo3tLVCbOK4QC8zh8MKCtcjPAAANEMzM35CCs7JJj4+gWk9TvWqPgoK1yM8AAA0QzMzVkIK2skmPuEgLz1+RHw+Cq84tULmKMFAlDOHwwoK1yM8AAA0QzMzGkIK68kmPs4gLz1+RHw+CgrXIzwAADRDZma8QQquLiQ/iFXlPddNgj4KFH61QsWUu0ABHYfDCj0KGUI9Cn3CpHCIwgquLiQ/jlXlPdVNgj4KmY21QnlovEAkIIfDCkjhAEK4HkHCuB5uwg'
..'quLiQ/m1XlPcxNgj4KMzO7QTMzBsKkcFLCCq4uJD++VeU9uE2CPgosmLVC9Oy8QCAkh8MKAABwQJqZIcHNzDvCCrYuJD+0VeU9102CPgpXfbVCvKG7QHlEh8MKhesLQnE95sLheolCCrYuJD/EVeU9zU2CPgrWjbVCymO8QF9Bh8MKrkfpQYWrAcNI4XNCCrYuJD/YVeU9wk2CPgoAAKZBe1QQw8P1WkIKti4kP+ZV5T26TYI+CjWZtUL92bxAaT2HwwrsUQhApHAow65HR0IK/OhaPvrJpj2xD8Y+ChS/tUI2MrZAeC2HwwoK1yO8AAAAAMN10sIKFulaPufJpj2xD8Y+CjG6tUI5kLRAdy2HwwoK1yO8AAAAAFI48sIK4OhaPhHKpj2xD8Y+Coa'
..'/tUL/n7hAeC2HwwoK1yO8AAAAAB+FlcIK6OhaPgnKpj2xD8Y+CgrXI7wAAAAAPQqywgrj6Fo+D8qmPbEPxj4KnLK1QkpvukB5LYfDCgrXI7wAAAAAAABiwgo16Vo+1MmmPbAPxj4K0hG1Qml1wkB6LYfDCgrXIzwAADRDexQCwQo66Vo+0cmmPbAPxj4KS/e0QphbwkB6LYfDCgrXIzwAADRDAADAwQoO6Vo+78mmPbAPxj4KcDi1QpQvwkB6LYfDCgrXIzwAADRDzcyyQQok6Vo+4MmmPbAPxj4KCtcjPAAANEOkcAFBCvXoWj4FyqY9sA/GPgqTU7VCQinBQHoth8MKCtcjPAAANENmZiJCCgNGyz7RVeU+uy76PQq03rRCStXCQDsoh8MKmpkz'
..'wqRwdsLD9abBCv1Fyz7OVeU+wi76PQqh37RCbsTCQKMxh8MKMzNCwj0KtMIK16M8CvhFyz7RVeU+yy76PQqv47RC0XrCQGY9h8MKzcwtwsN19sJ7FMJBCkduBT7L8JE9gkeaPgrtVrVCyom8QGo4h8MK4XpBwincpsK4Hp3ACkVuBT7L8JE9O12cPgryVrVCpIm8QE0oh8MKpHBBwlI4wcLNDC/DCsvwkT0pwm8+JsJvPgo8I7VCbzLAQFUwh8MKMzNCwj0KtMLD9bPCCv+DBz7L8JE9TrqMPgrJZLVCvo67QFQwh8MKy/CRPeomlz7j2o8+ClKItULsCrlAUzCHwwr6Rcs+yVXlPsAu+j0KiLW1Qs+gs0CfMYfDCvVFyz7LVeU+xy76PQrosbVCo'
..'uKzQNUlh8MKAAA5wmZm4cJcj4ZBCv9Fyz7LVeU+ui76PQrAs7VCDMGzQM04h8MKPQo2wh8FgMIpXJnBCgNGyz7RVeU+uS76PQqp0bRCQBXCQEMoh8MK/UXLPs5V5T7ALvo9CpbStEJkBMJAqzGHwwr4Rcs+0VXlPsou+j0KpNa0Qse6wUBuPYfDCkhuBT7L8JE9gUeaPgriSbVCwMm7QHI4h8MKRm4FPsvwkT07XZw+CudJtUKaybtAVSiHwwrL8JE9KsJvPiXCbz4KMRa1QmVyv0BdMIfDCr5XtUK0zrpAXDCHwwrL8JE96yaXPuLajz4KR3u1QuJKuEBbMIfDCvtFyz7JVeU+vi76PQp9qLVCxeCyQKcxh8MK9UXLPstV5T7GLvo9Ct2ktUKYIr'
..'NA3SWHwwoARss+y1XlPrgu+j0Ktaa1QgIBs0DVOIfDCsou+jzqLvo94smmPQruabVChLq7QCdCh8MKSOGgwVwPJEP2KElCCssu+jzrLvo94MmmPQoWRrVC8g6+QPpAh8MKyy76POku+j3fyaY9CvmMtUJaR7lAjkOHwwoK14HB4bogQ65HTUIKyy76POsu+j3hyaY9ClkjtULBfMBAlD+HwwozM93BAEArQ6RwPUIKyC76PPEu+j3dyaY9Ci21tUKsKbZARz6HwwoK18NBw7UJQ3sUBkIK8ETHPhDR4D4mQfU9CuG5tEIuSsBA3SiHwwrwRMc+DdHgPiZB9T0Kybq0Qqc5wEAWMofDCu9Exz4Q0eA+J0H1PQrDvrRCffG/QJ09h8MKbM0CPq0Qjz2'
..'EPZc+CrsvtUJsHrpAuziHwwpszQI+rRCPPbhImT4KwC+1QkYeukDuKIfDCq0Qjz0fCWs+HAlrPgoP/bRCnrS9QM4wh8MKoNgEPq0Qjz2m9Ik+ClI9tUJSKLlAzTCHwwqtEI89tCyUPncFjT4KJ2C1Qi6xtkDMMIfDCu9Exz4I0eA+I0H1PQp5jLVCXmKxQBIyh8MK8ETHPgnR4D4lQfU9CuuItULmorFAgyaHwwrvRMc+CdHgPiRB9T0KuYq1QviBsUAbOYfDChSZEz6R1gQ+K5mTPQqCoLVCBAu3QG5Ah8MKDZkTPpvWBD4nmZM9CmMhtUIOQMBAnz2HwwoUmRM+h9YEPjWZkz0KL661QvFcuEB/PYfDCh2ZEz6i1gQ+EZmTPQpbDbVCeRzBQBM7'
..'h8MKHZkTPqHWBD4UmZM9CowstUKiaMFAPzeHwwoWmRM+ntYEPhyZkz0KijG1QjsXwUDtOIfDChqZEz6Y1gQ+IJmTPQp6obVC6lG2QJE+h8MKFZkTPqLWBD4amZM9CgGktUIa/LhALSOHwwoRmRM+jtYEPjKZkz0KVKi1QvfGuECNPofDChSZEz6Z1gQ+IpmTPQomnLVCa7K2QPpAh8MKCtdrwbge4cGamSjCChWZEz6k1gQ+HJmTPQqYkbVClGy3QBYfh8MKEZkTPpvWBD4kmZM9CrqTtUL1SrdAb0KHwwr2KIzAH4WLwXE9OsIKFpkTPqDWBD4bmZM9CqsatUI4zcBAsDyHwwobmRM+m9YEPiCZkz0KnKO1QjzOtkATI4fDChqZEz6Q1gQ+KZmTP'
..'QplpbVCjbK2QCk+h8MKFZkTPqPWBD4bmZM9CviVtUK5wbdAwB+HwwoWmRM+odYEPhqZkz0KbRS1Qo+qwECDPYfDChGZEz6V1gQ+K5mTPQp+mLVCP5y3QNNBh8MKG5kTPp7WBD4dmZM9CgmgtUKvarZApSKHwwoYmRM+m9YEPiGZkz0Kwai1QkSquECLI4fDChiZEz6e1gQ+H5mTPQpznbVCcT+3QLUgh8MKcT0qwZrZB8M9Cg9CChqZEz6E1gQ+M5mTPQqusLVCvC+4QPs7h8MKGJkTPqDWBD4cmZM9CpaZtUJG4bZAKCCHwwoNmRM+ndYEPiSZkz0Koxu1QgUUwECNPofDCh2ZEz6j1gQ+EpmTPQrsE7VCCDrBQF86h8MKmpl5Qilcz0D2KGXCCh'
..'uZEz6T1gQ+J5mTPQpZrbVCBla4QEMlh8MKG5kTPrPWBD4AmZM9CucqtULkfsFA4yqHwwoXmRM+ttYEPgOZkz0KxBa1QjQUwUCCJYfDChuZEz6z1gQ+/piTPQo1C7VCAT7BQEcnh8MKG5kTPrjWBD7/mJM9CuERtUJPWcFA8CeHwwoRmRM+stYEPguZkz0KBRi1QoZbwEDnIofDCheZEz6y1gQ+B5mTPQqDELVCx/HAQLEkh8MKEZkTPrTWBD4JmZM9CusdtUI4hcBAzSOHwwr/tFk+sdYEPgyZkz0KdTy1QvolwEBsJofDCs9Paj6Y1gQ+K5mTPQoPQrVCF7m/QBk7h8MK7FEbQilcC8LDdZPCCheZEz601gQ+BJmTPQqILbVCCGDBQE0ph8MKApk'
..'TPlejTj29SZc+CkumtUJT7rhA1jKHwwoJmRM+TaNOPb1Jlz4KGZkTPmn6Gj33PV8+Cvo4tUILQcBALjOHwwormRM+VfoaPfc9Xz4KrkoRP3Tyyj1wn2Y+CmN2tUJAUbtANR+HwwquShE/c/LKPXGfZj4KHoS1QpgMvED7IYfDCq5KET978so9Z59mPgquShE/mvLKPUOfZj4Keo21QtSBvECDJYfDCrRKET+p8so9ZJ9mPgq7dbVCtFy7QCJCh8MKtEoRP7byyj1Sn2Y+ClWEtUJuCLxAYz+Hwwq0ShE/xPLKPUOfZj4KtEoRP8byyj1Bn2Y+CmSOtUIIcbxA4juHwwrkuEE+OJmTPc5Frz4K56+1QkyNtkDGLYfDCvy4QT4omZM9zkWvPgqVq7VC'
..'Zxu1QMUth8MK07hBPkeZkz3ORa8+Ck2wtUKKs7hAxi2HwwrVuEE+RJmTPc5Frz4K37hBPj6Zkz3ORa8+Ct+ktUKGTbpAxy2HwwovuUE+A5mTPctFrz4KlRa1QkxnwUDILYfDCi25QT4HmZM9y0WvPgob/7RCc1DBQMgth8MKEblBPhiZkz3LRa8+CsI4tUKAKcFAyC2HwwoluUE+CpmTPctFrz4K9rhBPi+Zkz3LRa8+CsVQtUJcQcBAyC2Hwwqf4rM+rPLKPpRl3T0KWum0QiO8wUAkKYfDCpbisz6q8so+nGXdPQos6rRCN63BQHcxh8MKjOKzPqzyyj6rZd09CsPttEIRbMFA3zuHwwotKOw9ECaBPTKHiD4KvVO1Qg4qvEB2N4fDCioo7D0QJ'
..'oE9hF+KPgrCU7VC7im8QDMph8MKECaBPRgsVD4MLFQ+Cv8ltULuZr9ATzCHwwrL2O89ECaBPVESeT4KAWC1QuZLu0BOMIfDChAmgT2/woU+QZt+Pgp0f7VCKBK5QE0wh8MKk+KzPqXyyj6ZZd09CnantUKHR7RAczGHwwqM4rM+pfLKPqNl3T0KQaS1QsmBtEAEJ4fDCpzisz6l8so+kmXdPQripbVCDWS0QMw3h8MKz920QjISwUArKYfDCqHetEJGA8FAfjGHwwo44rRCIMLAQOY7h8MKMki1Qh2Au0B9N4fDCjdItUL9f7tAOimHwwp0GrVC/by+QFYwh8MKdlS1QvWhukBVMIfDCulztUI3aLhAVDCHwwrrm7VClp2zQHoxh8MKtpi1QtjXs0'
..'ALJ4fDCleatUIcurNA0zeHwwqB2AQ/SdHgPaMQjz4KgFe1QooLvEDyLofDChSZEz6U1gQ+K5mTPQrRnrVCffi2QJBAh8MKDpkTPp3WBD4nmZM9CrIftUKHLcBAwT2HwwoUmRM+i9YEPjWZkz0Kfqy1QmpKuEChPYfDChyZEz6k1gQ+EZmTPQqqC7VC8gnBQDU7h8MKHJkTPqPWBD4VmZM9CtsqtUIbVsFAYTeHwwoWmRM+oNYEPh6Zkz0K2S+1QrQEwUAPOYfDChqZEz6b1gQ+H5mTPQrJn7VCYz+2QLM+h8MKFJkTPqTWBD4cmZM9ClCitUKT6bhATyOHwwoRmRM+kdYEPjKZkz0Ko6a1QnC0uECvPofDChSZEz6c1gQ+IpmTPQp1mrVC5J+2QBx'
..'Bh8MKFJkTPqXWBD4dmZM9CuePtUINWrdAOB+HwwoRmRM+n9YEPiOZkz0KCZK1Qm44t0CRQofDChaZEz6i1gQ+G5mTPQr6GLVCsbrAQNI8h8MKG5kTPp3WBD4gmZM9CuuhtUK1u7ZANSOHwwoamRM+lNYEPiiZkz0KtKO1QgagtkBLPofDChSZEz6l1gQ+HJmTPQpHlLVCMq+3QOIfh8MKFpkTPqPWBD4amZM9CrwStUIImMBApT2HwwoRmRM+mNYEPimZkz0KzZa1QriJt0D1QYfDChuZEz6h1gQ+HZmTPQpYnrVCKFi2QMcih8MKF5kTPpzWBD4jmZM9ChCntUK9l7hArSOHwwoYmRM+oNYEPiCZkz0Kwpu1Quost0DXIIfDChqZEz6H1gQ+M5mT'
..'PQr9rrVCNR24QB08h8MKGJkTPqLWBD4dmZM9CuWXtUK/zrZASiCHwwoOmRM+odYEPiSZkz0K8hm1Qn4BwECvPofDCjsStUKBJ8FAgTqHwwobmRM+lNYEPimZkz0KqKu1Qn9DuEBlJYfDChqZEz6y1gQ+ApmTPQo2KbVCXWzBQAUrh8MKF5kTPrbWBD4FmZM9ChMVtUKtAcFApCWHwwoamRM+tNYEPgCZkz0KhAm1QnorwUBpJ4fDChqZEz641gQ+AZmTPQowELVCyEbBQBIoh8MKEJkTPrPWBD4NmZM9ClQWtUL/SMBACSOHwwoXmRM+tNYEPgiZkz0K0g61QkDfwEDTJIfDChCZEz601gQ+DJmTPQo6HLVCsXLAQO8jh8MK/7RZPrDWBD4PmZM9C'
..'sQ6tUJzE8BAjiaHwwrQT2o+mtYEPiuZkz0KXkC1QpCmv0A7O4fDCheZEz601gQ+B5mTPQrXK7VCgU3BQG8ph8MKAZkTPlejTj28SZc+CpqktULM27hA+DKHwwoJmRM+TaNOPbxJlz4KGZkTPmn6Gj32PV8+Ckk3tUKELsBAUDOHwwormRM+VfoaPfY9Xz4KrkoRP3Tyyj1tn2Y+CrJ0tUK5PrtAVx+HwwquShE/dPLKPW6fZj4KbYK1QhH6u0AdIofDCq5KET988so9Y59mPgquShE/m/LKPUGfZj4KyYu1Qk1vvEClJYfDCrNKET+l8so9Z59mPgoKdLVCLUq7QERCh8MKs0oRP7Lyyj1Vn2Y+CqSCtULn9btAhT+HwwqzShE/wfLKPUafZj4Ks0'
..'oRP8Tyyj1Bn2Y+CrOMtUKBXrxABDyHwwrkuEE+OJmTPcxFrz4KNq61QsV6tkDoLYfDCvy4QT4omZM9zEWvPgrkqbVC4Ai1QOcth8MK07hBPkeZkz3MRa8+CpyutUIDobhA6C2HwwrVuEE+RJmTPcxFrz4K37hBPj6Zkz3MRa8+Ci6jtUL/OrpA6S2HwwrkFLVCxVTBQOoth8MKav20Quw9wUDqLYfDChE3tUL5FsFA6i2HwwoUT7VC1S7AQOoth8MKneKzPqzyyj6SZd09CqnntEKcqcFARimHwwqU4rM+qvLKPp1l3T0Ke+i0QrCawUCZMYfDConisz6s8so+q2XdPQoS7LRCilnBQAE8h8MKKijsPRAmgT0yh4g+CgxStUKHF7xAmDeHwwolKOw'
..'9ECaBPYRfij4KEVK1QmcXvEBVKYfDChAmgT0VLFQ+DCxUPgpOJLVCZ1S/QHEwh8MKx9jvPRAmgT1SEnk+ClBetUJfObtAcDCHwwoQJoE9vcKFPkGbfj4Kw321QqH/uEBvMIfDCpLisz6l8so+l2XdPQrFpbVCADW0QJUxh8MKi+KzPqXyyj6kZd09CpCitUJCb7RAJieHwwqa4rM+pfLKPo9l3T0KMaS1QoZRtEDuN4fDCp3isz6s8so+kGXdPQoe3LRCq//AQE0ph8MKlOKzPqryyj6ZZd09CvDctEK/8MBAoDGHwwqK4rM+rPLKPqtl3T0Kh+C0QpmvwEAIPIfDCoFGtUKWbbtAnzeHwwolKOw9ECaBPYNfij4Khka1QnZtu0BcKYfDChAmgT0V'
..'LFQ+CyxUPgrDGLVCdqq+QHgwh8MKx9jvPRAmgT1REnk+CsVStUJuj7pAdzCHwwoQJoE9vcKFPj+bfj4KOHK1QrBVuEB2MIfDCpLisz6l8so+mWXdPQo6mrVCD4uzQJwxh8MKBZe1QlHFs0AtJ4fDCqaYtUKVp7NA9TeHwwp7SgI/84AjPh00xD0KsEa1Qj9fu0C3PIfDCjMzk8CF6y/DXI9BQgqDSgI/84AjPg80xD0KwEe1QjVMu0B5JYfDCsP1OEAzczFDw/VBQiEXTWVzaGVzL0dvZ2dsZXNfQ3ViZS4wMDYE7AZOCU8JBiMkJAoAAAzCAAC0wgAAAAAK3K+zQu0uq0BYMofDCgAAtMIAAFzCAAC0wgrfuKU/OaIyPnMKfz8hF3JieGFzc2V0a'
..'WQ6Ly80NzUyNTkzMDQwCuJ7aUHArPs/dakzQQTyBlAJUQkKGHC1QklgqUCSAYfDClyPhMLheujBj4ISQwo+Nns9+galPTrGpD0DAAAAoJmZ2T8KD7rFPGWu5j22xaQ9CgmPtUKNxalAffqGwwpe0QM+Za5mPWau5j0KB4a1QiKoqUCN/IbDCrXFpD21xaQ9tcWkPQq1c7VCSmypQMAAh8MhGE1lc2hlcy91bnRpdGxlZF9DdWJlLjAwMgT/BlIJUwkKCtejPJqZuT8K16O8Cjb1skL+16xAGjGHwwreHCI/SBI1Ps0/xD8hF3JieGFzc2V0aWQ6Ly8zNzQ0MjIzMjg5CjluYkL4cYlBIqwVQyEHSG9sZGVycwQFB1QJVQkKUAGzQilJqUDYMYfDCs'
..'egzz+8l4M/75BSPyEXcmJ4YXNzZXRpZDovLzM5OTYwMzg5NzchKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9Mzk5OTMyNDM0NwQKB1QJVQkKhqmyQqW4mEA2MofDCtA8jT9lJDI/j8L1PiEXcmJ4YXNzZXRpZDovLzM5OTYwMzQ0NjAKXeCWP+DcLD9+FMU+IQVWaXNvcgQQB1QJVQkK0v2yQjG+pEDyMYfDCtVrqD+19Qg/zcwMPyEXcmJ4YXNzZXRpZDovLzM5OTYwMzk1NzQKQbySPzDhuj6OsbM+IQVXSElURSEGQ29sb3IzBgAAACEXcmJ4YXNzZXRpZDovLzY0MzMyMDM3MDUDAAAAYGZm7j8hF01lc2hlcy9Hb2dnbGVzX0N'
..'1YmUuMDA3BBsHTglPCQpshbJC4922QNAwh8MKByZ3PzpvyT6Q6JM+IRdyYnhhc3NldGlkOi8vNDc1MjU5MzExNAowGi5BOOaNQOxiUEAhF01lc2hlcy9Hb2dnbGVzX0N1YmUuMDA1BCEHTglPCQqOwrJC3RK1QFQyh8MK58SZP7XYuD5ZQlM+IRdyYnhhc3NldGlkOi8vNDc1MjU5Mjk5NQq6pFhByDaCQPrRFEAhF01lc2hlcy9Hb2dnbGVzX0N1YmUuMDA0BCcHTglPCQowjLJCcZi2QIQyh8MK4KCAP9u77j4bO64+IRdyYnhhc3NldGlkOi8vNDc1MjU5Mjg3MAoWOTVBsCyoQMR4dUAhAlZSBC4HVglXCQr2KEhC16NlQtejEEMKyCm1QkkL'
..'rkDkbofDCoVrg0I9CgNCpPC8QgqS0QM+SXcFPmnWND8Kljm1QknAsECoYofDCnnRAz5hdwU+a9Y0PwoWALVCIpCsQJhxh8MKMzNiQuF6aULXo11CCpLRAz5IdwU+atY0PwqYPLVCi/6tQBZ/h8MK16NhQuF6bUL2KObBCnbRAz5fdwU+a9Y0PwoFaLVC1AWxQP5th8MKZmZIQrgeYkL2qOfCCnHRAz5DdwU+aNY0PwrtFLVCxO6sQON6h8MK16NhQuF6bUI9ipPCCnLRAz5DdwU+atY0PwqlV7VCYh6xQPlmh8MKZmZIQrgeYkKaGZjCCp9LFD5z0YM8ZK5mPQraVbVCP2+qQI9mh8MKuB5VQmZmZ0IfBZbCCo/RAz5JdwU+adY0PwqVObVCSMCwQ'
..'Klih8MKedEDPl53BT5r1jQ/ChUAtUIhkKxAmXGHwwqP0QM+R3cFPmrWND8Klzy1Qor+rUAXf4fDCnXRAz5cdwU+atY0PwoEaLVC0wWxQP9th8MKcNEDPkJ3BT5q1jQ/CuwUtULB7qxA43qHwwpx0QM+QncFPmvWND8KpFe1Ql4esUD5ZofDCp1LFD5y0YM8ELpFPQrh9LRCuAe0QMt1h8MKljm1QkrAsECoYofDCnjRAz5hdwU+a9Y0PwoWALVCI5CsQJhxh8MKktEDPkd3BT5q1jQ/Cpg8tUKM/q1AFn+Hwwp10QM+X3cFPmrWND8KBWi1QtUFsUD+bYfDCnHRAz5DdwU+atY0PwrsFLVCxe6sQON6h8MKctEDPkN3BT5r1jQ/CqRXtUJjHrFA+W'
..'aHwwqgSxQ+c9GDPBG6RT0KQni1QnAHp0AmYYfDCmPRAz6ISxQ+f0sUPgq8nLVCMS+lQOFhh8MKuB5Vws1M9MIK12/BCm/RAz40dwU+aNY0PwqbKrVC0RSwQLxih8MKY9EDPj53BT5p1jQ/Cv4CtUITqKxAsXGHwwpTZbVCeeewQABuh8MKZmZIQrgeYkKaGejCCm3RAz4zdwU+atY0PwpCPLVCmQyuQEt+h8MKLBe1QscRrUA3eofDCqJVtUJY9bBAmWeHwwpn0QM+ZtGDPNiP4j4KNRW1QvHUsEC2cIfDCnHRAz43dwU+aNY0PwqbKrVC0BSwQL1ih8MKZtEDPkB3BT5o1jQ/Cv4CtUIRqKxAsnGHwwpm0QM+QHcFPmnWND8KU2W1QnjnsEABbof'
..'DCm/RAz42dwU+aNY0PwpCPLVCmAyuQEx+h8MKZtEDPjZ3BT5o1jQ/CisXtULGEa1AOHqHwwpo0QM+NncFPmnWND8KoVW1Qlf1sECaZ4fDCmjRAz5m0YM8tsWkPQqTZ7VCMq6oQMVjh8MEfQdWCVcJCkgntULBza9A5HKHwwp80QM+P3cFPmrWND8Ksyq1Qg8VsEDAYofDCm3RAz5LdwU+bNY0PwoWA7VCUKisQLVxh8MKbdEDPkt3BT5r1jQ/CmtltUK357BABG6Hwwp60QM+PncFPmvWND8KWjy1QtcMrkBPfofDCkIXtUIDEq1AO3qHwwq4VbVClvWwQJ1nh8MKcdEDPoauZj3ej+I+ChQitUIDA7FAAXSHwwpGNFY+rmgKPmxuwj0K5ea0Qgfc'
..'tUDveYfDBI0HVglXCQqoN7VCKQ6uQL5wh8MKk9EDPkt3BT5q1jQ/CrgqtULbErBA0mKHwwp50QM+YncFPmzWND8KGwO1QhumrEDHcYfDCnjRAz5kdwU+a9Y0PwpwZbVCg+WwQBZuh8MKktEDPkp3BT5s1jQ/Cl88tUKiCq5AYX6HwwqA0QM+VncFPmnWND8KRxe1Qs4PrUBNeofDCoHRAz5WdwU+adY0Pwq9VbVCYfOwQK9nh8MKgNEDPquuZj3cj+I+ChkitULOALFAE3SHwwpiNFY+w2gKPnlOsD4KhSu1QrkPr0A6b4fDCmnRgzxh0QM9ZtEDPQpKkrVC5IGnQCtgh8MKuB4NQrieDMN7FClDCvM/tT1l0QM9YdGDPAohi7VC0ZOmQHRjh8MK+'
..'blFPVrRgzz/uUU9CrWJtUK6jqZAF2OHwwpp0YM8ErpFPRm6xTwKT5O1Qgc6p0AqYIfDCvR8tUI1BaZAq2aHwwq4Hg3CH4UdQnsUKcMKG4C1QmrjpUAEZofDCnzRAz4+dwU+bNY0Pwq4KrVC0BKwQNJih8MKGwO1QhGmrEDHcYfDCmzRAz5MdwU+bdY0PwpwZbVCeOWwQBZuh8MKe9EDPj53BT5t1jQ/Cl88tUKYCq5AYX6Hwwpt0QM+QncFPm7WND8KSBe1QsYPrUBNeofDCm7RAz5CdwU+b9Y0Pwq+VbVCWPOwQK9nh8MKLLrFPH+u5j27xaQ9Cs96tUJLaalAfGqHwwpu0QM+iK5mPW2u5j0KBHC1QpJCqUC3Z4fDCrnRAz5adwU+aNY0PwqoOb'
..'VC7r+wQLdih8MKitEDPoh3BT5r1jQ/CigAtULFj6xAp3GHwwq50QM+WHcFPmrWND8Kqjy1Qi/+rUAlf4fDCoXRAz6IdwU+atY0PwoXaLVCeQWxQA1uh8MKidEDPmJ3BT5p1jQ/Cv8UtUJn7qxA8XqHwwqM0QM+YncFPmrWND8Kt1e1QgUesUAHZ4fDCrtLFD6S0YM9D7pFPQrgArVCRDm0QGt5h8MKudEDPlp3BT5q1jQ/Cqg5tULsv7BAt2KHwwqK0QM+iHcFPmzWND8KKAC1QsOPrECncYfDCrnRAz5XdwU+bNY0PwqqPLVCLf6tQCV/h8MKhdEDPoh3BT5r1jQ/ChdotUJ3BbFADW6HwwqJ0QM+Y3cFPmzWND8K/xS1QmburEDyeofDCozRAz5'
..'jdwU+bNY0Pwq3V7VCBB6xQAhnh8MKuksUPpLRgz1qrmY9CtdjtUKxoKpAMGqHwwr3xSQ+r67mPbrFpD0KWXm1QtNlqUAZaofDCoLRAz5ddwU+atY0Pwr/FLVCae6sQPF6h8MKhdEDPl13BT5q1jQ/CrdXtUIHHrFAB2eHwwpx0QM+jEsUPnRLFD4Kz5y1QtUupUDvYYfDCqRLFD6B0YM9ArpFPQqJhrVCCDqnQNlkh8MKsNEDPlZ3BT5r1jQ/Cqk5tULuv7BAtmKHwwqE0QM+f3cFPm3WND8KKQC1QsaPrECmcYfDCrDRAz5TdwU+bdY0PwqrPLVCL/6tQCR/h8MKgdEDPn53BT5r1jQ/ChhotUJ5BbFADG6Hwwpf0YM84sUkPXvRAz0KFOm0QqGU'
..'tkDUfIfDCrgeDUK4ngzD9iieQiEVTWVzaGVzL0dHTyBoZWFkZ2VhciAyBO4HWAlZCQYdHR0KKVwSwpoZDsMUrpfACliStUKKcLJA/F6HwwoAwAjDZmbswZrZH8MKDqkLPqTsfD5xHBA/IRdyYnhhc3NldGlkOi8vNDQ2ODc0OTM1Ngo4cCpAIEyHQPylPUEhBFZSWDIE9QdWCVcJCigntUKnqK9AQHKHwwocj9k9RkfcPVI7FT8KTzK1QsAjr0CUY4fDCheP2T1JR9w9UzsVPwqfEbVCPVCsQOxvh8MKFo/ZPUlH3D1UOxU/CsRitUKX0a9A4GyHwwoaj9k9RUfcPVM7FT8K4EC1QnR2rUBSeofDChOP2T1CR9w9VDsVPwpFIrVCd6esQPV2h8MKF'
..'Y/ZPUJH3D1UOxU/CtBVtUII3a9AmGeHwwoTj9k9MV0+PfX2uj4KMyu1Qh3or0DRcYfDBAUIWglbCQo4b7VCa0GpQGpnh8MKzUzfwilc88EKFw/DCgy6xTxlruY9tcWkPQp1jLVCKKqpQO1uh8MKX9EDPmWuZj1lruY9CvCDtUKVi6lAvWyHwwq2xaQ9tsWkPbbFpD0KnXK1QmhNqUBLaIfDIQdiYXRlcmlhBA8IXAldCQqOkLVCKD6lQHYxh8MKAPztPmtd/j4Pa50/IRdyYnhhc3NldGlkOi8vMzMyNzM1NTA0Nwp0DTpC1LNBQhim5kIhFnJieGFzc2V0aWQ6Ly8yODExMjMzMTYhBE1QTFMEGAheCV8JBh8fHwoAAHBCAAA0QwAAAAAKNKmzQn'
..'L1uUAMgYfDCgAA8EIAAAAAAAA0wwoDdvo+RClOPeGe0z0KCtc7Ph3ALD3SdPo9Cu9as0LP5rpARH6HwwodwKw8puLUPSRp4TwKZR+0QsPzuEDHg4fDCgAAcMIAAAAAAAC0wgpzaOE8c2jhPHNo4TwKZh+0QpYnuUAuhYfDCg50ej4ewKw9dV1IOwqxJ7RCpvK5QISKh8MK03R6Ph7ArD3YXEg7Ct4ftEKm8rlAhIqHwwoAAAAAAAC0QgAAcMIKDnR6Ph7ArD3TdPo9CukUtELhn7lAy4uHwwQrCGAJYQkKAAAgQgAANEMAAAAACsTIs0LylrhAnoKHwwoAAAxDAAAAAAAANEMKYzFrP+efQj4+Xok+CjVpSDvpbHo9zXL6PQqM5LJCwcW5QIh5h8M'
..'KN2lIO1pvej1gcPo9CozkskKem7tALoWHwwoAAKBCAAA0QwAAAAAKN2lIOxxyej2abfo9CozkskLOA71AzHmHwwoAAPDBAAA0wwAAAAAKYCXbPZpt+jyxZuE8ClHEs0IzurtA/H2Hwwrk1js9M9I7PRty+j0KWZWzQuT5ukDPfofDCttzejyAhJw9G3L6PQoBpbNC5Pm6QM9+h8MK2XP6O5ltejwccno8Cg6htEKHN7xAoYOHwwoOobRCFMu7QJuEh8MKDqG0QqFeu0CVhYfDCgAAcMIAAAAAAAAAAArac3o85h/bPRty+j0K4qi0QuT5ukDPfofDCtpzejxtms49G3L6PQowpLRC5Pm6QM9+h8MKmW36PBxyejzZc3o8Cu6vtEKAW7tA7n2HwwoA'
..'AAAAAAC0wgAAFkMKrlxIO0tbSDuZbfo8CrawtEL7rbpAfn+HwwoAAPBBAAAAAAAANMMKtrC0QlzZukAaf4fDCrawtEI5V7pAR4CHwwq2sLRCmoK6QOJ/h8MKtrC0Qr4Eu0C2fofDCtlzejyU1Ts9mW36PAoErLRCDe+6QOh+h8MK5Na7Ppxt+jyU1bs9CrUDtEK7hbVAeoWHwwrbc/o8nG16PBxyej0KUR60QmAZuUDegofDCpxtejzbc3o8lNU7PQoPKrRCJ+O4QFuDh8MKnG16PNtzejyV1Ts9CpQStEIn47hAW4OHwwoAAHDCAAAAAAAAtEIKotU7PZxtejzRc3o8CuEltEKHjrVAboeHwwpmZgrBheupwuF6bkIKdha0QjK0tUAXh4fDCgwHt'
..'ELc2bVAwIaHwwpRh5w9nG16PNtz+jwKUUK0Qt8ZtkCIh4fDCl8l2z2bbXo8cy4sPgo8xLNCgV+3QJiEh8MKXyXbPZttejzYI9s9CjzEs0I6xbZAP4iHwwpfJds9m236PBxyej0KPMSzQph3uUBohYfDCubWOz4z0rs9ZIecPQosE7RCrGa8QKOHh8MKuB5qQuyRIMOF64VBCuFz+j7nH9s9IXL6PQoQJrRCavK6QJl+h8MKAdU7PiHTuz0miJw9CtGvs0KlkLpAJ4mHwwquR83BzcyTwrierEIKXyXbPZxtejwccno9Cj3Es0KwGblA3YKHwwoa7m0+6B/bPYVElj0KfWC0QrU4vUByeIfDCkKehj6xV8g7RVvIOwoYDbRCeQC3QMaEh8MKcbW4Pr'
..'FXyDtFW8g7CkQFtEIxobRAQIqHwwrk1rs+nG36PHdEljwKtQO0QlH/s0AAiYfDCrUDtEIkDLdA9YGHwwrk1js9nG16PL9Gmz0Kik+0QrMXtkCNh4fDIQ9Db3JuZXJXZWRnZVBhcnQKUoecPYlKKjyhXEg8CgVHtEIBT7ZA94iHwwoAAAAAAAC0wgAAcEIKDXJ6PJxtejzVc/o8ClJCtEKO1LRAd4qHwwrk1js9nG16PNgj2z0K4lW0QuzEtkA/iIfDCuXWOz2cbXo8HHJ6PQriVbRCYBm5QN6Ch8MK5dY7PZxt+jwccno9CuFVtEJLd7lAaIWHwwrk1js9nG16PHMuLD4K41W0QjRft0CYhIfDCuTWOz2cbXo8HHJ6PArjVbRCh9S0QHeKh8MKYCX'
..'bPZxtejwccno8ClDEs0KH1LRAd4qHwwoBXUg+nFtIPQJu+j0KseCyQsW8vEBve4fDCgFdSD5wWEg9/nH6PQqx4LJCOGa7QB2Eh8MKAV1IPm5YSD39cfo9CrHgskI0/rlAX3qHwwphUa89YVGvPWFRrz0KStyyQmvuukCzfofDCsFFFj0CQhY9nFvIPQqY8bJCbe66QLN+h8MKm29wPJxIpT2cW8g9CmLBskJt7rpAs36HwwpnSiA8Ak2vPZxbyD0K4L6yQm3uukCzfofDCgFdSD0CTa89nFvIPQooz7JCbe66QLN+h8MK2XN6Phxyej2ChBw+CqEKs0IXNb1AknqHwwrac3o+JG56Pf+GHD4KoQqzQuiIu0BshYfDCtpzej4ibno9/YYcPgqhCrNC'
..'48a5QD55h8MKXyXbPV8l2z1fJds9CiAFs0In87pAp36Hwwrk1js9NdI7PRxy+j0KwR+zQivzukCnfofDCoNFljxums49HHL6PQp+47JCK/O6QKd+h8MKr1xIPOkf2z0ccvo9ClzgskIr87pAp36Hwwrac3o96R/bPRxy+j0KtfSyQivzukCnfofDCoZFFjyvV0g9r2bhPAosobRC2za8QO17h8MEsghiCWMJCoXr70EAAAAAAAA0wwoUArNCste6QLR+h8MDAAAAQDMzwz8K2XX6PTDPoz3D34A9CsddSD67XEg9c3T6PQoYB7NCArq8QEJ7h8MKx11IPhxdSD37c/o9ChgHs0JuY7tA8IOHwwofBaBCcf0zQwrXI7wKx11IPhxdSD38c/o9ChgHs'
..'0Jq+7lAMnqHwwoOUq89DlKvPQ5Srz0KsQKzQqHrukCGfofDCj0KcEIAADRDAAAAAApVRhY930UWPbtcyD0K/xezQqXrukCGfofDColwcDzcTKU9u1zIPQrJ57JCoeu6QIZ+h8MKBksgPIRRrz27XMg9CkflskKh67pAhn6HwwrHXUg9hFGvPbtcyD0Kj/WyQqPrukCGfofDB2EBBMsIZAllCQbKv6MKAAAMQgAAAADh+jPDCvzsskLTzLtAfHiHwwMAAACgmZm5PwMAAADAzMzsPwrHXUg+u1xIPXJ0+j0K/fGyQg6avUBldIfDCgDyskJOdbxAgn2HwwoAAJZCFO4zQ4/Cdb0KAPKyQjXYukBLdIfDCgAADELh+jNDCtejvAqZ7bJCrt+7QEd4h8'
..'MKAABcQlL4M0OPwvW8ClVGFj3eRRY9u1zIPQrnArNCyd+7QEd4h8MKiXBwPNtMpT27XMg9CrDSskKS37tAR3iHwwoGSyA8g1GvPbtcyD0KL9CyQo/fu0BHeIfDCsddSD2DUa89u1zIPQp24LJCot+7QEd4h8MKDt2zQiJnVkB0K4fDCkEtRIUAAMCsAACAvwpQyYIYAACAPwAAwCwKlt2zQmWZxj9e34bDCgAAgD/6fyuuvEJgswofgCsuAACAPzPrKjEKcgXKO93PArbC/n+/CuhvzbEAAIA/89ACtgoAAIA/EAPJKgAAwK4KoeSNKgEAgD+6BxgxCgAAgD8OA8kqAAAArwoOA8kqAQCAP7t/SjEKJtqzQgUVxz9sg4fDCh+AKy4AAIA/M+MqMQo'
..'F+BS7FWkHttb/f78K3hNauAAAgD8d9f61CkX/fz89h5k7ZjkQugphh5m7SP9/P/Jy+rcKtku0Qip8VkCcPYfDCgAAYJWDtsisAACAvwq6PwsqAACAP31JtywKEzECPEgBArbu/X+/ChYy5rEAAIA/EQMCtgoAAACx4v+/rAEAgL8KAACgLAAAgD/g/78sCgCQ7C0IAIC/R10zrwoIAIA/AKDsrYAAAC4KLn+yvc/eVrKcBn8/CjiTQrMAAIA/FcETMgrJJnu/idAxvoHIr70Ktn6yvbnYIjSeBn8/CgAAgD9QP6u0Jz9TMgpQP6s0AACAPzMnVTIKngZ/v0QHqjR2frI9CtoTqzQAAIA/WVkSMgr+/38/78upuLr7JjoKt9CpOAAAgD87Rmq3CpWp'
..'Lgg3ZSgvAACAvwofcoIYAACAPzddNC8Kbhx8v+/rPzQ2zzG+CqLsRzQAAIA/xrLksgpfHHy/TQYTsZfQMT4KAMm6sAAAgD9w054xCgAAgD8WAoCnAAAAJQonC6EjAACAPy4nVTIKAACAv8dXpa3H/x8xCgBYpa0AAIA/PidVMgoAAIC/UD+rNCc/U7IKUD+rNAAAgD8nJ1UyCgAAgD9nlZ83LTMCswpnlZ+3AACAP3W+ODcK8H6yvaUeLTOeBn+/CiLxkjQAAIA/cfKNMgoWAoCnAACAPwCAvywKDEd3P6FoTrADhIQ+CgDvHrAkAIA/f3DrsAoX6l0/PK4QOblD/74K8QSquQAAgD/ug5a5CsuzUT8h1hK/vOy1NApRxkW1+4TctQAAgL8KAACAP'
..'1Eiia8UH4EtCoAiiS8AAIA/LidVMgphHHw/wf5tLlzQMb4KXtAxvu/HqC9jHHy/ClABRLH5WqsvAACAvwqbv5I0AACAP91asC8KngZ/P753aDB4frK9CgCu864AAIA/GhoRMgoAAIA/APikLYz//68K9v+krQAAgD8uKVUyCgAAgD+rS3cuof+/sAoATHeuAACAPz4rVTIKNgS0QrLlX0CmcYbDCgAAgD+zG4q2HJ41NwpBJYo2AACAP7aE17gK3HkWvAK5TrY9/X+/CrPfjTws9n8/0QUquQoAAIA/wO2AsAAAIK8KwO2AsAAAgD8gALysCrYGtEJad15AYPGHwwofifs6b9wEtuL/f78KUteUsQAAgD913AS2CgAAgL+PJH6wAADoLwqPJH4wAA'
..'CAP/gfkC0KBgK0QqJ3HkCUMofDCsiRDbletZo5AACAvwrHzsA3AACAP/O0mjkKzT8GNyUAoTkAAIC/CrTXXzr6/38/DAGhOQrMO4a4ZAChOQAAgL8KfIxPvL36fz/paaE5CkgXDroyG4M5/v9/vwqApny7gv9/P2kzhDkKyzuGuE8vmjkAAIC/Ci9JUDyz+n8/576ZOQp+w7NCNuKnQEAvh8MKAACAPzjdVi0t/w8yChjdVq0AAIA/9SBhsQqSKFa8DujCNGf6f78KeHQUswAAgD/pK8M0CiItRIXy/7+sAQCAvwpFyYIYAACAP/D/vywKm/5av5LJAr920K09Cnc0ab7sSGU+wJdyvwrj5Tmzm3uztAAAgD8KqhlSNAAAgD/afLM0CgAAgD9DGVI'
..'01+U5swpGGVK0AACAP8l7s7QKJMQSPwQrJr/B//8+CrFbFz/4DUA/b4yXPgoEZkS1enEqtQAAgL8KyQNoP3Nh2L6c7tO0Cgt7IwUAALAsAACAPwrt1RI/+LNRP7orkCwKRJ86v/hpGL52Cyu/CgD99r5BrxS/At0nPwpm638/N+O3uW6izrwKQ6S7OQAAgD/cMY45CgZ7IwUAALAsAACAPwrsn/McAACAPwAAsCwKATSGvV5Gvj6bEm0/CuShVr+LFAa/23kaPgpwElG/XPWHvXLAEj8KKmqZPnzYTD80AQU/CtmDML+WWh6+fSM1PwrllwQ/0t0TP42GIT8KAACAP00JPjTV5TmzCk8JPrQAAIA/ynu0tAoAAIC/G4Zut3vvCbgK8EezN6n//z7x'
..'s12/CgAAgL/iIpu0uiC6Mgoho3y0ZBtEP9qNJL8KAACAv/zAq7d8oaO1CgfdmTe0tl2/GPb/vgoAAIC/D1SSuZasKLkK6DyoOV2xUb+X2RK/ywEAAAIAAgADAAQABQABAAECAAIABgAEAAUAAQACAgACAAcABAAIAAkAAwsAAgAKAAsADAANAA4ADwAQABEAEgATABQAFQAWABcAFAAYABkAGgAOABsAHAAdAAMKAAIAHgALAAwADwAfABEAEgAgACEAFQAiABgAIwAkACUAJgAnACgAKQAdAAMKAAIAKgALAAwADwArABEAEgAgACEAFQAsABgALQAkAC4AJgAvACgAMAABAAICAAIAMQAEADIACQAHCwACAAoACwAMAA0ADgAPADMAEQASABMAN'
..'AAVADUAFwA2ABgAGQAaAA4AGwAcAB0ABwoAAgAqAAsADAAPADcAEQASACAAIQAVADgAGAAtACQALgAmAC8AKAAwAB0ABw0AAgA5AAsADAAPADoAEQASADsADAAgACEAEwA8ABUAPQAXADwAGAA+ACQAPwAmAEAAKABBAEIACgQAAgBDAEQARQBGAEcAGwBIAAEAAgIAAgBJAAQASgAJAAwNAAIACgALAAwADQAOAEsATAAPAE0AEQASAE4ATwATAFAAFQBRABcAUAAYAFIAGgAOABsAHAAdAAwOAAIAUwALAAwASwBUAA8AVQARABIAVgASAE4AVwAgAFgAEwBZABUAWgAXAFkAGABbACQAXAAmAF0ARgAOBABEAEUARgBeAF8AHABgABwARgAOBA'
..'BEAGEARgBeAF8AHABgABwARgAOBABEAA4ARgBeAF8AHABgABwARgAOAwBGAF4AXwAcAGAAHABGAA4EAEQAHABGAF4AXwAcAGAAHABGAA4EAEQAYgBGAF4AXwAcAGAAHAAdAAwMAAsADABLAGMADwBkABEAEgBOAGUAIAAhABMAZgAVAGcAFwBmABgAaAAkAGkAJgBqAEYAFQIARABiAEYAawBGABUCAEQAYQBGAGsARgAVAgBEAA4ARgBrAEYAFQIARABFAEYAawBGABUCAEQAHABGAGsARgAVAQBGAGsAHQAMDQACAGwACwAMAA8AbQARABIAOwAMACAAIQATAG4AFQBvABcAcAAYAHEAJAByACYAcwAoAHQACQAMDQACAHUACwAMAA0ADgBLAHY'
..'ADwB3ABEAEgBOAHgAIAAhABMAeQAVAHoAFwB7ABgAfAAaAA4AfQAdBAB+AH8AJACAAIEAggCDAIQAHQAMCgACAIUACwAMAA8AhgARABIAIAAhABUAhwAYAIgAJACJACYAigAoAIsAHQAMDQACAGwACwAMAA8AjAARABIAOwAMACAAIQATAI0AFQCOABcAjwAYAJAAJACRACYAkgAoAJMAHQAMDQACAGwACwAMAA8AlAARABIAOwAMACAAIQATAI0AFQCVABcAjwAYAJYAJACXACYAmAAoAJkAHQAMDQACAJoACwAMAA8AmwARABIAnACdACAAIQATAJ4AFQCfABcAngAYAKAAJAChACYAogAoACkACQAMEgACAKMACwAMAKQApQANAKUASwBUAA8A'
..'pgARABIATgCnAKgApQCpAKUAOwAMACAAWAATAFkAFQCqAKsApQAXAFkAGACsABoApQAJAAwSAAIAowALAAwApAClAA0ApQBLAK0ADwCuABEAEgBOAK8AqAClAKkApQA7AAwAIACwABMAWQAVALEAqwClABcAWQAYALIAGgClALMAJAMAAgC0ALUAtgC3ABwAuAAlDQACALkAugC7ALwAHAC9AL4AvwAOABUAwAAYAMEAwgC+AMMAxADFAMYAxwAMAMgAyQDKAAwAuAAlCwACALkAugC7ALwAHAC9AL4AvwAOABgAywDCAL4AwwDMAMUAzQDIAM4AygAMAB0ADA0AAgBsAAsADAAPAM8AEQASADsADAAgACEAEwDQABUA0QAXANIAGADTACQAcgAmA'
..'HMAKAB0AB0ADA0AAgBsAAsADAAPANQAEQASADsADAAgACEAEwDVABUA1gAXANcAGADYACQA2QAmANoAKADbAB0ADAsAAgBsAAsADAAPANwAEQASADsADAAgACEAFQDdABgA3gAkAHIAJgBzACgAdAAdAAwMAAIA3wALAAwADwDgABEAEgAgACEAEwDhABUA4gAXAOMAGADkACQA5QAmAOYAKAApAB0ADA0AAgBsAAsADAAPAOcAEQASADsADAAgACEAEwDoABUA6QAXAOoAGADrACQA7AAmAO0AKADuAB0ADAoAAgDvAAsADAAPAPAAEQASACAAIQAVAPEAGADyACQA8wAmAPQAKAD1AB0ADAoAAgDvAAsADAAPAPYAEQASACAAIQAVAPcAGADyAC'
..'QA8wAmAPQAKAD1AB0ADA0AAgBsAAsADAAPAPgAEQASADsADAAgACEAEwD5ABUA+gAXAPsAGAD8ACQA/QAmAP4AKAD/AB0ADAsAAgBsAAsADAAPAAABEQASADsADAAgACEAFQABARgAAgEkAHIAJgBzACgAdAAdAAwNAAIAbAALAAwADwADAREAEgA7AAwAIAAhABMABAEVAAUBFwAEARgABgEkAAcBJgAIASgACQEdAAwKAAIACgELAAwADwALAREAEgAgACEAFQAMARgADQEkAA4BJgAPASgAEAEdAAwNAAIAbAALAAwADwARAREAEgA7AAwAIAAhABMABAEVABIBFwAEARgAEwEkABQBJgAVASgAFgEdAAwNAAIAbAALAAwADwAXAREAEgA7AAw'
..'AIAAhABMAGAEVABkBFwAaARgAGwEkAJcAJgCYACgAmQAdAAwOAAIAHAELAAwASwAdAQ8AHgERABIATgAfASAAWAATACABFQAhARcAIgEYACMBJAAkASYAJQEoABYBHQAMCwACACYBCwAMAA8AJwERABIAOwAMACAAIQAVACgBGAApASQAKgEmACsBKAAsAR0ADA0AAgBsAAsADAAPAC0BEQASADsADAAgACEAEwAYARUALgEXABoBGAAvASQAkQAmAJIAKACTAB0ADA0AAgBsAAsADAAPADABEQASADsADAAgACEAEwAxARUAMgEXADMBGAA0ASQA7AAmAO0AKADuAB0ADA0AAgBsAAsADAAPADUBEQASADsADAAgACEAEwAEARUANgEXAAQBGAAT'
..'ASQAFAEmABUBKAAWAR0ADA0AAgBsAAsADAAPADcBEQASADsADAAgACEAEwD5ABUAOAEXAPsAGAA5ASQAOgEmADsBKAA8AR0ADA0AAgBsAAsADAAPAD0BEQASADsADAAgACEAEwBZABUAPgEXAFkAGAA/ASQA7AAmAO0AKADuAB0ADA0AAgAmAQsADAAPAEABEQASADsADAAgACEAEwBBARUAQgEXAEEBGAApASQAKgEmACsBKAAsAR0ADAoAAgAKAQsADAAPAEMBEQASACAAIQAVAEQBGAANASQADgEmAA8BKAAQAR0ADAoAAgBFAQsADAAPAEYBEQASACAAIQAVAEcBGABIASQASQEmAEoBKAApAB0ADAoAAgDfAAsADAAPAEsBEQASACAAIQAVA'
..'EwBGADkACQA5QAmAOYAKAApAB0ADAsAAgBNAQsADAAPAE4BEQASADsADAAgACEAFQBPARgAUAEkAFEBJgBSASgAUwEJAAIJAAIAVAELAAwADwBVAREAEgATAFkAFQBWARcAWQAYAFcBGwAcAFgBQQEAAgBZAVgBQQEAAgBaAVgBQQEAAgBbAVgBQQEAAgBcAVgBQQEAAgAHAFgBQQEAAgAxAFgBQQEAAgBdAVgBQQEAAgBeAVgBQQEAAgBfAVgBQQEAAgBgAWEBQQIAAgBhAWIBYwFkAUECAAIAZAFlAWYBAQACAgACAFkBBABnAQkATgsAAgAKAAsADAANAA4ADwBoAREAEgATAGkBFQBqARcAawEYABkAGgAOABsAHAAdAE4JAAIAbAELAAwADw'
..'BtASAAIQAVAG4BGABvASQAcAEmAHEBKAByAQEAAgIAAgBaAQQAcwEJAFELAAIACgALAAwADQAOAA8AdAERABIAEwB1ARUAdgEXAHUBGAAZABoADgAbABwAHQBRCwACAGwBCwAMAA8AdwEgACEAEwDoABUAeAEXAHkBGABvASQAcAEmAHEBKAByAQEAAgIAAgB6AQQAewEJAFQMAAIAfAELAAwADQAOAEsATAAPAH0BEQASAE4ATwAgAH4BEwB/ARUAgAEXAIEBGAAZAAkAVAwAAgCCAQsADAANAGEASwBMAA8AgwERABIATgBPACAAfgETAIQBFQCFARcAhgEYABkACQBUDAACAIcBCwAMAA0ADgBLAEwADwCIAREAEgBOAE8AIAB+ARMAiQEVAIo'
..'BFwCLARgAGQAJAFQNAAIAYAELAAwASwBMAA8AjAERABIATgBPAKkAYQAgAH4BEwCNARUAjgGrAGEAFwCPARgAUgCQAVQCAJEBDgCSAQ4AkwFUDACUAZUBlgGXAZgBTACZAU8AmgFMAJsBTwCcAUwAnQFPAJ4BTACfAU8AoAFMAKEBTwAJAFQKAAIAogELAAwADQBhAA8AowERABIAIAB+ARMApAEVAKUBFwCmARgAGQBhAVQCAAIAYQFiAWMBZAFUAgACAGQBZQGnAQEAAgIAAgCoAQQAqQEJAF4MAAIACgALAAwADQAOAA8AqgERABIAIACwABMAqwEVAKwBFwCtARgArgEaAA4AGwAcAH0AXwEAfgCvAR0AXg0AAgCwAQsADAAPALEBEQASADsA'
..'DAAgACEAEwBZABUAsgEXAFkAGACzASQAtAEmALUBKAC2AbcBQALABAAJAMIBwwG9AQAJAMQBxQHGAQAJAMcByAHJAQAJAMoBywHMAUACwAIACQDNAc4BzwEACQDQAdEB0gEACQDTAdQB1QFeDAACALgBCwAMAEsAuQEPALoBEQASAE4AuwEgALwBEwC9ARUAvgEXAL8BGADAAcEBDAC3AUACQALABAAJAN4B3wG9AQAJAOAB4QHGAQAJAOIB4wHJAQAJAOQB5QHMAUACwAIACQDmAecBzwEACQDoAekB0gEACQDqAesB1QGACQDsAe0B1QFeDgACANYBCwAMAEsAVAAPANcBEQASAE4A2AEgAH4BEwC9ARUA2QHaAdsBFwC/ARgA3AEbAN0BwQEMA'
..'LcBQAJAAkACQALABAAJAPIB8wG9AQAJAPQB9QHGAQAJAPYB9wHJAQAJAPgB+QHMAUACwAIACQD6AfsBzwEACQD8Af0B0gEACQD+Af8B1QGACQAAAgEC1QFAAkAGAAICAwIEAgUCgQkABgIHAggCYgAJAgoCAAkACwIMAtUBAAICDQIOAgUCAAICAwIPAhACAAICDQIRAhACQALABAAJABICEwK9AQAJABQCFQLGAQAJABYCFwLJAQAJABgCGQLMAUACwAIACQAaAhsCzwEACQAcAh0C0gFAAoEJAB4CHwIIAmIACQIKAgAJACACIQLVAUACQANAAsAEAAkAIgIjAr0BAAkAJAIlAsYBAAkAJgInAswBAAkAKAIpAioCQALAAgAJACsCLALPAQAJAC'
..'0CLgLSAQAJAC8CMALVAUACwAQACQAiAjECvQEACQAkAjICxgEACQAmAjMCzAEACQAoAjQCKgJAAsACAAkANQI2As8BAAkANwI4AtIBQAIACQA5AjoC1QGBCQA7AjwCCAJiAAkCCgJAAkACwAIACQA9Aj4CzwEACQA/AkAC0gFAAoEJAEECQgIIAmIACQIKAgAJAEMCRALVAcAEAAkARQJGAr0BAAkARwJIAsYBAAkASQJKAswBAAkASwJMAioCAQkATQJOAk8CYgAJAgoCXgwAAgDWAQsADABLAFQADwDuAREAEgBOAO8BIAAhABMAvQEVAPABFwC/ARgA8QHBAQwARgBkAQBGAGsARgBkAgBEAEUARgBrAEYAZAIARAAcAEYAawBGAGQCAEQAYgB'
..'GAGsARgBkAgBEAGEARgBrAEYAZAIARAAOAEYAawC3AUACQANAAsAEAAkAVAJVAr0BAAkAVgJXAsYBAAkAWAJZAswBAAkAWgJbAioCQALAAgAJAFwCXQLPAQAJAF4CXwLSAQAJAGACYQLVAUACwAQACQBiAmMCvQEACQBkAmUCxgEACQBmAmcCzAEACQBoAmkCKgJAAsACAAkAagJrAs8BAAkAbAJtAtIBAAkAbgJvAtUBQALABAAJAHACcQK9AQAJAGQCcgLGAQAJAGYCcwLMAQAJAHQCdQIqAkACwAIACQB2AncCzwEACQB4AnkC0gFAAgAJAHoCewLVAYEJAHwCfQIIAmIACQIKAkACQALABAAJAH4CfwK9AQAJAIACgQLGAQAJAIICgwLJAQAJ'
..'AIQChQLMAUACwAIACQCGAocCzwEACQCIAokC0gEACQCKAosC1QFAAsAEAAkAjAKNAr0BAAkAjgKPAsYBAAkAkAKRAskBAAkAkgKTAswBQALAAgAJAJQClQLPAQAJAJYClwLSAQAJAJgCmQLVAV4MAAIA1gELAAwASwBUAA8AUAIRABIATgDvASAAUQITAL0BFQBSAhcAvwEYAFMCwQEMAB0AXgwAAgCaAgsADAAPAJsCEQASACAAIQATAJwCFQCdAhcAnAIYAJ4CJACfAiYAoAIoAKECHQBeCgACAKICCwAMAA8AowIRABIAIAAhABUApAIYAKUCJACmAiYApwIoAKECtwFAAsAkAAkArgKvAqoCAAkAsAKxArICAAkAswK0ArUCAAkAtgK3ArgCA'
..'AkAuQK6ArsCAAkAvAK9Ar4CAAkAvwLAAsECAAkAwgLDAsQCAAkAxQLGAscCAAkAyALJAsoCAAkAywLMAs0CAAkAzgLPAtACAAkA0QLSAtMCAAkA1ALVAtYCAAkA1wLYAtkCAAkA2gLbAtwCAAkA3QLeAt8CAAkA4ALhAuICAAkA4wLkAuUCAAkA5gLnAugCAAkA6QLqAusCAAkA7ALtAu4CAAkA7wLwAvECAAkA8gLzAvQCAAkA9QL2AvcCAAkA+AL5AvoCAAkA+wL8Av0CAAkA/gL/AgADAAkAAQMCAwMDAAkABAMFAwYDAAkABwMIAwkDAAkACgMLAwwDAAkADQMOAw8DAAkAEAMRAxIDAAkAEwMUAxUDAAkAFgMXAxgDQALAAgAJABkDGgMbAw'
..'AJABwDGgMdA0ACwAIACQAeAx8DIAMACQAhAx8DIgNAA8AEAAkAIwMkAyUDAAkAJgMnAygDAAkAKQMnAyoDAAkAKwMsAy0DwAQACQAuAy8DMAMACQAxAzIDMwMACQA0AzIDNQMACQA2AzcDOANAA8AFAAkAOQM6AzsDAAkAPAM9Az4DAAkAPwNAA0EDAAkAQgNAA0MDAAkARANFA0YDwAUACQBHA0gDSQMACQBKA0sDTAMACQBNA04DTwMACQBQA04DUQMACQBSA1MDVANAAkAHwAMACQBVA1YDVwMACQBYA1kDWgMACQBbA1wDXQMACQBeA18DYAMACQBhA2IDYwMBCQBkA2UDZgNiAAkCCgIACQBnA2gDWgMBCQBpA2oDZgNiAAkCCgLAAwAJAGs'
..'DbANaAwAJAG0DbgNvAwAJAHADcQNyA0AHwAMACQBzA3QDVwMACQB1A3YDWgMACQB3A3gDXQMACQB5A3oDYAMACQB7A3wDYwMBCQB9A34DZgNiAAkCCgIACQB/A4ADWgMBCQCBA4IDZgNiAAkCCgLAAwAJAIMDhANaAwAJAIUDhgNvAwAJAIcDiANyA14MAAIAqAILAAwASwBMAA8AqQIRABIATgBPACAAfgETAKoCFQCrAhcArAIYAK0CwQEMALcBQAJAAoAJAI8DkAOLAwEJAJEDkgOLA0UACQIKAkAEQAJAAgAJAJMDlAOVA0ADAAkAlgOXA5gDQAUAAgKZA5oDmwMAAgKZA5wDmAOACQCdA54DmAOACQCdA58DmAOACQCdA6ADmANAAoAJAKED'
..'ogOYA0ADgAkAowOkA5gDgAkAowOlA5gDAQkApgOnA5gDYgAJAgoCQALABQAJAKgDqQOVAwAJAKgDqgOVAwAJAKsDrAOVAwAJAK0DrgOVAwAJAKgDrwOVA0AEgAkAsAOxA5UDgAkAsgOzA7QDgAkAtQO2A5UDQALAC4AJALcDuAO5A4AJALoDuwO8A4AJAL0DvgO5A4AJAL8DwAPBA4AJAMIDwwPEA0ACwCQACQDFA8YDxwMACQDIA8kDygMACQDLA8wDzQMACQDOA88D0AMACQDRA9ID0wMACQDUA9UD1gMACQDXA9gD2QMACQDaA9sD3AMACQDdA94D3wMACQDgA+ED4gMACQDjA+QD5QMACQDmA+cD6AMACQDpA+oD6wMACQDsA+0D7gMACQDvA'
..'/AD8QMACQDyA/MD9AMACQD1A/YD9wMACQD4A/kD+gMACQD7A/wD/QMACQD+A/8DAAQACQABBAIEAwQACQAEBAUEBgQACQAHBAgECQQACQAKBAsEDAQACQANBA4EDwQACQAQBBEEEgQACQATBBQEFQQACQAWBBcEGAQACQAZBBoEGwQACQAcBB0EHgQACQAfBCAEIQQACQAWBCIEIwQACQAkBCUEJgQACQAnBCgEKQQACQAqBCsELAQACQAtBC4ELwRAAsACAAkAMAQxBDIEAAkAMwQxBDQEQALAAgAJADUENgQ3BAAJADgENgQ5BEADwAQACQA6BDsEPAQACQA9BD4EPwQACQBABD4EQQQACQBCBEMERATABAAJAEUERgRHBAAJAEgESQRKBAAJAE'
..'sESQRMBAAJAE0ETgRPBEADwAUACQBQBFEEUgQACQBTBFQEVQQACQBWBFcEWAQACQBZBFcEWgQACQBbBFwEXQTABQAJAF4EXwRgBAAJAGEEYgRjBAAJAGQEZQRmBAAJAGcEZQRoBAAJAGkEagRrBEACQAfAAwAJAGwEbQRuBAAJAG8EcARxBAAJAHIEcwR0BAAJAHUEdgR3BAAJAHgEeQR6BAEJAHsEfAR9BGIACQIKAgAJAH4EfwRxBAEJAIAEgQR9BGIACQIKAsADAAkAggSDBHEEAAkAhASFBIYEAAkAhwSIBIkEQAfAAwAJAIoEiwRuBAAJAIwEjQRxBAAJAI4EjwR0BAAJAJAEkQR3BAAJAJIEkwR6BAEJAJQElQR9BGIACQIKAgAJAJYElwR'
..'xBAEJAJgEmQR9BGIACQIKAsADAAkAmgSbBHEEAAkAnASdBIYEAAkAngSfBIkEgAkAoAShBKIEgAkAowSkBKIEgAkApQSmBKcEgAkAqASpBKoEgAkAqwSsBK0EQAuACQCuBK8EsASACQCxBLIEswSACQC0BLUEsASACQC2BLcEuASACQC5BLoEuwRAAsAkAAkAvAS9BL4EAAkAvwTABMEEAAkAwgTDBMQEAAkAxQTGBMcEAAkAyATJBMoEAAkAywTMBM0EAAkAzgTPBNAEAAkA0QTSBNMEAAkA1ATVBNYEAAkA1wTYBNkEAAkA2gTbBNwEAAkA3QTeBN8EAAkA4AThBOIEAAkA4wTkBOUEAAkA5gTnBOgEAAkA6QTqBOsEAAkA7ATtBO4EAAkA7wTw'
..'BPEEAAkA8gTzBPQEAAkA9QT2BPcEAAkA+AT5BPoEAAkA+wT8BP0EAAkA/gT/BAAFAAkAAQUCBQMFAAkABAUFBQYFAAkABwUIBQkFAAkACgULBQwFAAkADQUOBQ8FAAkAEAURBRIFAAkAEwUUBRUFAAkAFgUXBRgFAAkAGQUaBRsFAAkAHAUdBR4FAAkAHwUgBSEFAAkAIgUjBSQFAAkAJQUmBScFQALAAgAJACgFKQUqBQAJACsFKQUsBUACwAIACQAtBS4FLwUACQAwBS4FMQVAA8AEAAkAMgUzBTQFAAkANQU2BTcFAAkAOAU2BTkFAAkAOgU7BTwFwAQACQA9BT4FPwUACQBABUEFQgUACQBDBUEFRAUACQBFBUYFRwVAA8AFAAkASAVJBUoFA'
..'AkASwVMBU0FAAkATgVPBVAFAAkAUQVPBVIFAAkAUwVUBVUFwAUACQBWBVcFWAUACQBZBVoFWwUACQBcBV0FXgUACQBfBV0FYAUACQBhBWIFYwVAAkAHwAMACQBkBWUFZgUACQBnBWgFaQUACQBqBWsFbAUACQBtBW4FbwUACQBwBXEFcgUBCQBzBXQFdQViAAkCCgIACQB2BXcFaQUBCQB4BXkFdQViAAkCCgLAAwAJAHoFewVpBQAJAHwFfQV+BQAJAH8FgAWBBUAHwAMACQCCBYMFZgUACQCEBYUFaQUACQCGBYcFbAUACQCIBYkFbwUACQCKBYsFcgUBCQCMBY0FdQViAAkCCgIACQB2BY4FaQUBCQCPBZAFdQViAAkCCgLAAwAJAJEFkgVpBQ'
..'AJAJMFlAV+BQAJAJUFlgWBBYAJAJcFmAWZBYAJAJoFmwWZBYAJAJwFnQWeBYAJAJ8FoAWhBYAJAKIFowWkBUAHwAMACQClBaYFZgUACQCnBagFaQUACQCpBaoFbAUACQCrBawFbwUACQCtBa4FcgUBCQCvBbAFdQViAAkCCgIACQCxBbIFaQUBCQCzBbQFdQViAAkCCgLAAwAJALUFtgVpBQAJALcFuAV+BQAJALkFugWBBUACQALAJAAJALsFvAW+BAAJAL0FvgXBBAAJAL8FwAXEBAAJAMEFwgXHBAAJAMMFxAXKBAAJAMUFxgXNBAAJAMcFyAXQBAAJAMkFygXTBAAJAMsFzAXWBAAJAM0FzgXPBQAJANAF0QXcBAAJANIF0wXUBQAJANUF1gX'
..'iBAAJANcF2AXlBAAJANkF2gXoBAAJANsF3AXrBAAJAN0F3gXuBAAJAN8F4AXxBAAJAOEF4gX0BAAJAOMF5AX3BAAJAOUF5gXnBQAJAOgF6QX9BAAJAOoF6wUABQAJAOwF7QUDBQAJAO4F7wXwBQAJAPEF8gUJBQAJAPMF9AUMBQAJAPUF9gUPBQAJAPcF+AUSBQAJAPkF+gUVBQAJAPsF/AUYBQAJAP0F/gUbBQAJAP8FAAYeBQAJAAEGAgYhBQAJAAMGBAYFBgAJAAYGBwYnBUACwAIACQAIBgkGKgUACQAKBgkGLAVAAsACAAkACwYMBi8FAAkADQYMBjEFQAPABAAJAA4GDwY0BQAJABAGEQY3BQAJABIGEQY5BQAJABMGFAY8BcAEAAkAFQYW'
..'Bj8FAAkAFwYYBkIFAAkAGQYYBkQFAAkAGgYbBkcFQAPABQAJABwGHQZKBQAJAB4GHwZNBQAJACAGIQZQBQAJACIGIQZSBQAJACMGJAZVBcAFAAkAJQYmBlgFAAkAJwYoBlsFAAkAKQYqBl4FAAkAKwYqBmAFAAkALAYtBmMFQAJAB8ADAAkALgYvBmYFAAkAMAYxBmkFAAkAMgYzBmwFAAkANAY1Bm8FAAkANgY3BnIFAQkAOAY5BnUFYgAJAgoCAAkAOgY7BmkFAQkAPAY9BnUFYgAJAgoCwAMACQA+Bj8GaQUACQBABkEGfgUACQBCBkMGgQVAB8ADAAkALgZEBmYFAAkAMAZFBmkFAAkAMgZGBmwFAAkANAZHBm8FAAkANgZIBnIFAQkAOAZJB'
..'nUFYgAJAgoCAAkAOgZKBmkFAQkAPAZLBnUFYgAJAgoCwAMACQA+BkwGaQUACQBABk0GfgUACQBCBk4GgQWACQBPBlAGlQNAA0ACwCQACQBRBlIGvgQACQBTBlQGwQQACQBVBlYGxAQACQBXBlgGxwQACQBZBloGygQACQBbBlwGzQQACQBdBl4G0AQACQBfBmAG0wQACQBhBmIG1gQACQBjBmQGzwUACQBlBmYG3AQACQBnBmgG1AUACQBpBmoG4gQACQBrBmwG5QQACQBtBm4G6AQACQBvBnAG6wQACQBxBnIG7gQACQBzBnQG8QQACQB1BnYG9AQACQB3BngG9wQACQB5BnoG5wUACQB7BnwG/QQACQB9Bn4GAAUACQB/BoAGAwUACQBXBoEG8A'
..'UACQCCBoMGCQUACQCEBoUGDAUACQCGBocGDwUACQCIBokGEgUACQCKBosGFQUACQCMBo0GGAUACQCOBo8GGwUACQCQBpEGHgUACQCSBpMGIQUACQCUBpUGBQYACQCWBpcGJwVAAsACAAkAmAaZBioFAAkAmgaZBiwFQALAAgAJAJsGnAYvBQAJAJ0GnAYxBUADwAQACQCeBp8GNAUACQCgBqEGNwUACQCiBqEGOQUACQCjBqQGPAXABAAJAKUGpgY/BQAJAKcGqAZCBQAJAKkGqAZEBQAJAKoGqwZHBUADwAUACQCsBq0GSgUACQCuBq8GTQUACQCwBrEGUAUACQCyBrEGUgUACQCzBrQGVQXABQAJACUGtQZYBQAJACcGtgZbBQAJACkGtwZeBQA'
..'JACsGtwZgBQAJACwGuAZjBUACQAfAAwAJALkGugZmBQAJALsGvAZpBQAJAL0GvgZsBQAJAL8GwAZvBQAJAMEGwgZyBQEJAMMGxAZ1BWIACQIKAgAJAMUGxgZpBQEJAMcGyAZ1BWIACQIKAsADAAkAyQbKBmkFAAkAywbMBn4FAAkAzQbOBoEFQAfAAwAJAM8G0AZmBQAJANEG0gZpBQAJANMG1AZsBQAJAL8G1QZvBQAJANYG1wZyBQEJANgG2QZ1BWIACQIKAgAJANoG2wZpBQEJANwG3QZ1BWIACQIKAsADAAkA3gbfBmkFAAkAywbgBn4FAAkAzQbhBoEFgAkA4gbjBuQGgAkA5QbmBucGXgwAAgCJAwsADABLAFQADwCKAxEAEgBOAO8BIAAh'
..'ABMAiwMVAIwDFwCNAxgAjgPBAQwARgBvAgBEAGEARgBrAEYAbwIARABFAEYAawBGAG8CAEQADgBGAGsARgBvAQBGAGsARgBvAgBEAGIARgBrAEYAbwIARAAcAEYAawAdAF4NAAIA6AYLAAwASwBUAA8A6QYRABIATgDqBiAAIQATAOsGFQDsBhcA7QYYAO4GJADvBiYA8AZGAHYCAEQAHABGAGsARgB2AgBEAGEARgBrAEYAdgIARAAOAEYAawBGAHYCAEQARQBGAGsARgB2AQBGAGsARgB2AgBEAGIARgBrALcBQALAAoEJAPYG9wYIAmIACQIKAgAJAPgG+QbVAQEJAPoG+wbVAUUACQIKAl4NAAIA1gELAAwASwBMAA8A8QYRABIATgBPACAAs'
..'AATAAgCFQDyBhcA8wYYAPQGGwD1BsEBDAAdAF4OAAIA/AYLAAwASwBUAA8A/QYRABIATgCnACAAIQATAP4GFQD/BhcA/gYYAAAHJAABByYAAgcoAGsAHQBeDAACAAMHCwAMAA8ABAcRABIAIAAhABMAnAIVAAUHFwCcAhgABgckAAcHJgAGBygACAdGAH8BAEYAawBGAH8CAEQARQBGAGsARgB/AgBEABwARgBrAEYAfwIARABiAEYAawBGAH8CAEQAYQBGAGsARgB/AgBEAA4ARgBrAB0AXgwAAgBEAAsADAAPAAkHEQASACAAIQATAJwCFQAKBxcAnAIYAAsHJAAMByYADQcoAAgHRgCGAQBGAGsARgCGAgBEAEUARgBrAEYAhgIARAAcAEYAaw'
..'BGAIYCAEQAYgBGAGsARgCGAgBEAGEARgBrAEYAhgIARAAOAEYAawAdAF4NAAIADgcLAAwASwBMAA8ADwcRABIATgBPACAAvAETAJwCFQAQBxcAnAIYABEHJAASByYAEwdCAI0EAAIAQwBEAGEARgBHABsASABCAI0FAAIAFAdEAGEAFQcWB0YAFwcbABgHQgCNBAACAEMARABFAEYARwAbAEgAQgCNBQACABQHRABFABUHFgdGABcHGwAYB0IAjQQAAgBDAEQADgBGAEcAGwBIAEIAjQUAAgAUB0QADgAVBxYHRgAXBxsAGAdGAI0CAEQAYQBGAGsARgCNAgBEABwARgBrAEYAjQIARABiAEYAawBGAI0CAEQARQBGAGsARgCNAgBEAA4ARgBrAEY'
..'AjQEARgBrAB0AXg0AAgAZBwsADABLAEwADwAaBxEAEgBOAE8AIAC8ARMA6wYVABsHFwDtBhgAHAckAB0HJgAeB0YAmgIARABhAEYAawBGAJoCAEQAHABGAGsARgCaAgBEAGIARgBrAEYAmgIARABFAEYAawBGAJoCAEQADgBGAGsARgCaAQBGAGsAHQBeDgACAB8HCwAMAEsAVAAPACAHEQASAE4A6gYgACEAEwDrBhUAIQcXAO0GGAAiByQAIwcmACQHKABrAB0AXg4AAgAlBwsADABLAFQADwAmBxEAEgBOAOoGIAAhABMA6wYVACcHFwDtBhgAKAckACkHJgAqBygAawBGAKICAEQAHABGAGsARgCiAgBEAGEARgBrAEYAogIARAAOAEYAawBG'
..'AKICAEQARQBGAGsARgCiAQBGAGsARgCiAgBEAGIARgBrALcBQAJAA0ACwAQACQAwBzEHLQcACQAyBzMHNAcACQA1BzYHNwcACQA4BzkHOgdAAsACAAkAOwc8Bz0HAAkAPgc/B0AHAAkAQQdCB0MHQALABAAJAEQHRQctBwAJAEYHRwc0BwAJAEgHSQc3BwAJAEoHSwc6B0ACwAIACQBMB00HPQcACQBOB08HQAcACQBQB1EHQwdAAsAEAAkAMAdSBy0HAAkAUwdUBzQHAAkAVQdWBzcHAAkAVwdYBzoHQALAAgAJAFkHWgc9BwAJAFsHXAdAB0ACAAkAXQdeB0MHgQkAXwdgB2EHYgAJAgoCQAJAAsAEAAkAYgdjBy0HAAkAZAdlBzQHAAkAZAdmB'
..'2cHAAkAaAdpBzcHQALAAgAJAIgCagc9BwAJAJQCawdABwAJAGwHbQdDB0ACwAQACQBuB28HLQcACQBwB3EHNAcACQByB3MHZwcACQB0B3UHNwdAAsACAAkAdgd3Bz0HAAkAeAd5B0AHAAkAegd7B0MHXgwAAgArBwsADABLAFQADwAsBxEAEgBOAO8BIABRAhMALQcVAC4HFwAvBxgAUwLBAQwAtwFAAkACwAQACQB+B38HLQcACQCAB4EHNAcACQCCB4MHZwcACQCEB4UHNwdAAsACAAkAWQeGBz0HAAkAPgeHB0AHAAkAiAeJB0MHgAkAigeLB0MHXg4AAgArBwsADABLAFQADwB8BxEAEgBOANgBIAB+ARMALQcVAH0H2gHbARcALwcYANwBGw'
..'DdAcEBDAC3AUACQAJAAkACwAQACQCOB48HLQcACQCQB5EHNAcACQCSB5MHZwcACQCUB5UHNwdAAsACAAkAlgeXBz0HAAkAmAeZB0AHAAkAmgebB0MHgAkAnAedB0MHQAJABgACAp4HnwegB4EJAKEHogdhB2IACQIKAgAJAKMHpAdDBwACAqUHpgegBwACAp4HpweoBwACAqUHqQeoB0ACwAQACQCqB6sHLQcACQCAB6wHNAcACQCtB64HZwcACQCvB7AHNwdAAsACAAkAsQeyBz0HAAkAswe0B0AHQAKBCQC1B7YHYQdiAAkCCgIACQC3B7gHQwdAAkADQALABAAJALkHugctBwAJALsHvAc0BwAJAL0Hvgc3BwAJAL8HwAc6B0ACwAIACQDBB8I'
..'HPQcACQDDB8QHQAcACQDFB8YHQwdAAsAEAAkAxwfIBy0HAAkAyQfKBzQHAAkAywfMBzcHAAkAzQfOBzoHQALAAgAJAM8H0Ac9BwAJANEH0gdAB0ACAAkA0wfUB0MHgQkA1QfWB2EHYgAJAgoCQAJAAsACAAkA1wfYBz0HAAkA2QfaB0AHQAKBCQDbB9wHYQdiAAkCCgIACQDdB94HQwfABAAJAN8H4ActBwAJAOEH4gc0BwAJAOMH5Ac3BwAJAOUH5gc6BwEJAOcH6AfpB2IACQIKAl4MAAIAKwcLAAwASwBUAA8AjAcRABIATgDvASAAIQATAC0HFQCNBxcALwcYAPEBwQEMAEYAqwEARgBrAEYAqwIARABFAEYAawBGAKsCAEQAHABGAGsARgCr'
..'AgBEAGIARgBrAEYAqwIARABhAEYAawBGAKsCAEQADgBGAGsAHQBeDQACAOoHCwAMAEsArQAPAOsHEQASAE4A7AcgACEAEwDtBxUA7gcXAO8HGADwByQA8QcmAPIHRgCyAQBGAGsARgCyAgBEAEUARgBrAEYAsgIARAAcAEYAawBGALICAEQAYgBGAGsARgCyAgBEAGEARgBrAEYAsgIARAAOAEYAawC3AUACwAQACQD2B/cHLQcACQD4B/kHNAcACQD6B/sHZwcACQD8B/0HNwdAAsACAAkA/gf/Bz0HAAkAAAgBCEAHAAkAAggDCEMHXgwAAgDzBwsADABLALkBDwD0BxEAEgBOALsBIAC8ARMALQcVAPUHFwAvBxgAwAHBAQwAtwFAAsACgQkAB'
..'wgICGEHYgAJAgoCAAkACQgKCEMHAQkACwgMCEMHRQAJAgoCXg0AAgArBwsADABLAEwADwAECBEAEgBOAE8AIACwABMAYQcVAAUIFwAGCBgA9AYbAPUGwQEMAB0AXgoAAgANCAsADAAPAA4IEQASACAAIQAVAA8IGAAQCCQAEQgmABIIKAATCLcBQAIBCQAbCBwIFwhiAAkCCgJAAkADAQkAHQgeCB8IYgAJAgoCAQkAIAghCBcIRQAJAgoCwAIACQAiCCMIFwgACQAkCCUIJgiACQAnCCgIFwheDQACABQICwAMAEsArQAPABUIEQASAFYAEgBOABYIIAAhABMAFwgVABgIFwAZCBgAGgjBAQwARgC8AgBEAGEARgBrAEYAvAIARAAOAEYAawBGAL'
..'wCAEQARQBGAGsARgC8AgBEABwARgBrAEYAvAEARgBrAEYAvAIARABiAEYAawC3AUACQASACQAuCC8IKgiACQAwCDEIMgiACQAzCDQINQhAAkACQAIACQA2CDcIFwhAAwEJADgIOQgXCGIACQIKAgEJADoIOwgXCGIACQIKAkAEQAMAAgI8CD0IFwgACQA8CD4IFwgAAgI8CD8IQAgBCQBBCEIIFwhiAAkCCgIBCQBDCEQIFwhiAAkCCgJABwEJAEUIRghHCGIACQIKAgAJAEgISQhKCAAJAEgISwhKCAAJAEgITAhKCAAJAEgITQhKCAAJAEgITghKCAAJAE8IUAhKCEAUAAkAUQhSCBcIAAkAUwhUCBcIAAICVQhWCB8IAAICVwhYCFkIQAMBCQB'
..'aCFsIXAhiAAkCCgIBCQBaCF0IXAhiAAkCCgIBCQBaCF4IXAhiAAkCCgIAAgJfCGAIJghAAkADQAQACQBhCGIIFwgAAgJjCGQIQAgAAgJlCGYIQAhAAoEJAGcIaAhpCGIACQIKAgEJAGoIawgXCGIACQIKAoEJAGwIbQhuCGIACQIKAgAJAG8IcAgXCIEJAHEIcggXCGIACQIKAgAJAHMIdAgXCAAJAHUIdggXCAACAncIeAhACAACAncIeQgXCAAJAHoIewgXCAB8CH0Ifgh/CAB8CIAIgQh/CAACAoIIgwhACAAJAIQIhQgXCAACAoYIhwhACAAJAIgIiQgXCAACAooIiwhACAACAowIjQhACEACwAiACQCOCI8ISgiACQCQCJEIMgiACQCSCJMI'
..'KggBCQCUCJUIFwhFAAkCCgIBCQCWCJcIFwhiAAkCCgIBCQCYCJkIFwhiAAkCCgIBCQCaCJsIFwhiAAkCCgIBCQCcCJ0IFwhiAAkCCgJACIAJAJ4InwhKCIAJAKAIoQgyCIAJAKIIowgqCAEJAKQIpQgXCEUACQIKAgEJAKYIpwgXCGIACQIKAgEJAKgIqQgXCGIACQIKAgEJAKoIqwgXCGIACQIKAgEJAKwIrQgXCGIACQIKAgAJAK4IrwgXCF4NAAIAFAgLAAwASwCtAA8AKQgRABIAVgASAE4AFgggACEAEwAqCBUAKwgXACwIGAAtCMEBDABGAMMCAEQAYQBGAGsARgDDAgBEAA4ARgBrAEYAwwIARABFAEYAawBGAMMCAEQAHABGAGsARgDDA'
..'QBGAGsARgDDAgBEAGIARgBrALcBQAiACQC1CLYIsQiACQC3CLgIuQiACQC6CLsIKggBCQC8CL0IvghFAAkCCgIBCQC/CMAIvghiAAkCCgIBCQDBCMIIvghiAAkCCgIBCQDDCMQIvghiAAkCCgIBCQDFCMYIvghiAAkCCgJeDAACABQICwAMAA8AsAgRABIAVgASACAAfgETALEIFQCyCNoBswgXALEIGAC0CMEBDAC3AUAIgAkAzgjPCMoIgAkAtwjQCNEIgAkAtwjSCNMIAQkAvAjUCNUIRQAJAgoCAQkA1gjXCNUIYgAJAgoCAQkA2AjZCNUIYgAJAgoCAQkA2gjbCNUIYgAJAgoCAQkA3AjdCNUIYgAJAgoCXg4AAgAUCAsADABLAMcIDwDICB'
..'EAEgBWABIATgDJCCAAsAATAMoIFQDLCNoBzAgXAMoIGAC0CBsAzQgA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
