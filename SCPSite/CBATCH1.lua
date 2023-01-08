-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 2116 characters

local ScriptFunctions = {
function(script,require)

script.Parent.L0A.ClickDetector.MouseClick:Connect(function(plr)
	local HTTPS = game:GetService("HttpService")
	local TLT = 7
	local TLTS = "Beta Tester Access (ACCESS ONLY)"
	local string = HTTPS:GetAsync("https://raw.githubusercontent.com/goldfinder/SCP-Site-Logs-and-access/main/Beta%20Tester%20Access",true)
	local players = string:split("|")
	if plr.Character:FindFirstChild("AccessLevel") ~= nil then
		script.Parent.L0A.SurfaceGui.TextLabel.Text="Already have a access level."
		wait(3)
		script.Parent.L0A.SurfaceGui.TextLabel.Text=TLTS
	end
	for i=1,#players do
		if plr.UserId == tonumber(players[i]) then
			script.Parent.L0A.SurfaceGui.TextLabel.Text="Added Access."
			local inst = Instance.new("NumberValue")
			inst.Value = TLT
			inst.Name="AccessLevel"
			inst.Parent = plr.Character
			wait(3)
			script.Parent.L0A.SurfaceGui.TextLabel.Text=TLTS
		end
	end
	if plr.Character:FindFirstChild("AccessLevel") == nil then
		script.Parent.L0A.SurfaceGui.TextLabel.Text="This access level is locked."
		wait(3)
		script.Parent.L0A.SurfaceGui.TextLabel.Text=TLTS
	end
end)

script.Parent.L1A.ClickDetector.MouseClick:Connect(function(plr)
	if plr.Character:FindFirstChild("User Setup") ~= nil then 
		script.Parent.L1A.SurfaceGui.TextLabel.Text=plr.Name.." Already setup."
		wait(3)
		script.Parent.L1A.SurfaceGui.TextLabel.Text="Remove Access Level"
		return end
	if plr.Character:FindFirstChild("AccessLevel") == nil then
		script.Parent.L1A.SurfaceGui.TextLabel.Text="You don't have a access level."
		wait(3)
		script.Parent.L1A.SurfaceGui.TextLabel.Text="Remove Access Level"
	else
		script.Parent.L1A.SurfaceGui.TextLabel.Text="Removed Access Level."
		plr.Character:FindFirstChild("AccessLevel"):Destroy()
		wait(3)
		script.Parent.L1A.SurfaceGui.TextLabel.Text="Remove Access Level"
	end
end)

script.Parent.L2A.ClickDetector.MouseClick:Connect(function(plr)
	if plr.Character:FindFirstChild("User Setup") ~= nil then 
		script.Parent.L2A.SurfaceGui.TextLabel.Text=plr.Name.." Already setup."
		wait(3)
		script.Parent.L2A.SurfaceGui.TextLabel.Text="Remove Role"
		return end
	if plr.Character:FindFirstChild("Role") == nil then
		script.Parent.L2A.SurfaceGui.TextLabel.Text="You don't have a Role."
		wait(3)
		script.Parent.L2A.SurfaceGui.TextLabel.Text="Remove Role"
	else
		script.Parent.L2A.SurfaceGui.TextLabel.Text="Removed role."
		plr.Character:FindFirstChild("Role"):Destroy()
		wait(3)
		script.Parent.L2A.SurfaceGui.TextLabel.Text="Remove Role"
	end
end)

script.Parent.L3A.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = 8
	local TLTS = "Developer Access (LOCKED)"
	if plr.UserId == 21490931 then
		if plr.Character:FindFirstChild("AccessLevel") ~= nil then
			script.Parent.L3A.SurfaceGui.TextLabel.Text="Already have a access level."
			wait(3)
			script.Parent.L3A.SurfaceGui.TextLabel.Text=TLTS
		else
			script.Parent.L3A.SurfaceGui.TextLabel.Text="Added Access."
			local inst = Instance.new("NumberValue")
			inst.Value = TLT
			inst.Name="AccessLevel"
			inst.Parent = plr.Character
			wait(3)
			script.Parent.L3A.SurfaceGui.TextLabel.Text=TLTS
		end
	else
		script.Parent.L3A.SurfaceGui.TextLabel.Text="This access level is locked."
		wait(3)
		script.Parent.L3A.SurfaceGui.TextLabel.Text=TLTS
	end
end)

script.Parent.L3B.ClickDetector.MouseClick:Connect(function(plr)
	local TLT = "The Administrator"
	local TLTS = "TA (LOCKED)"
	if plr.UserId == 21490931 then
		if plr.Character:FindFirstChild("Role") ~= nil then
			script.Parent.L3B.SurfaceGui.TextLabel.Text="Already have a role."
			wait(3)
			script.Parent.L3B.SurfaceGui.TextLabel.Text=TLTS
		else
			script.Parent.L3B.SurfaceGui.TextLabel.Text="Added Role."
			local inst = Instance.new("StringValue")
			inst.Value = TLT
			inst.Name="Role"
			inst.Parent = plr.Character
			wait(3)
			script.Parent.L3B.SurfaceGui.TextLabel.Text=TLTS
		end
	else
		script.Parent.L3B.SurfaceGui.TextLabel.Text="This role is locked."
		wait(3)
		script.Parent.L3B.SurfaceGui.TextLabel.Text=TLTS
	end
end)

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


local Objects = Decode('AABnIQVNb2RlbCEKV29ybGRQaXZvdARjZGUhBlNjcmlwdCEEUGFydCEETmFtZSEDTDNBIQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhCkJyaWNrQ29sb3IHnQAhBkNGcmFtZQQVZmUhBUNvbG9yBv//fyELT3JpZW50YXRpb24KAAAAAAAAtMIAAAAA'
..'IQhQb3NpdGlvbgqQZELD+ofUQP6ZFcAhCFJvdGF0aW9uCgAAAABxvbPCAAAAACEEU2l6ZQoAAChAAACAP0w3KT8hClRvcFN1cmZhY2UhClN1cmZhY2VHdWkhDlpJbmRleEJlaGF2aW9yAwAAAAAAAPA/IRBDbGlwc0Rlc2NlbmRhbnRzIQ5MaWdodEluZmx1ZW5jZSEN'
..'UGl4ZWxzUGVyU3R1ZAMAAAAAAABpQCEKU2l6aW5nTW9kZSEJVGV4dExhYmVsIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAIA/AAAAAIA/AAAhBEZvbnQDAAAAAAAACEAhBFRleHQhGURldmVsb3BlciBBY2Nlc3MgKExPQ0tF'
..'RCkhClRleHRDb2xvcjMGAAAAIQhUZXh0U2l6ZQMAAAAAAABKQCELVGV4dFdyYXBwZWQhDUNsaWNrRGV0ZWN0b3IhA0wwQQdrAAQ2ZmUGAI+cCs0ZQsNqxa5A/ZkVwAoAAChAAACAP1rjpT0hG0JldGEgVGVzdGVyIEFjY2VzcyAoTE9DS0VEKQfHAAQ+Z2UGY19iIQhN'
..'YXRlcmlhbAMAAAAAAICQQAr8gULDQmnBQP5RFcAKAAAAADOzs8IAAAAACmCRPUC8wxpAgJlaPyEDTDFBB0cBBEVnZQaqAAAKzRlCw1CoLUDMmZ3ACgAAAABSuLPCAAAAAAoAAIBAAACAP1rjpT0hE1JlbW92ZSBBY2Nlc3MgTGV2ZWwhA0wyQQRLZ2UKpRRCw1CodUDM'
..'mZ3ACgAAgEAAAIA/qu8nPSELUmVtb3ZlIFJvbGUhBFBBUlQEUGdlChQkQsNQqC1AzJmdwAoAAIhAAABgQN/O9z0EU2dlCvyBQsNCacFA/6juwCEDTDNCBFZmZQqxJkLD+ofUQP/M7sAKAAAoQAAAgD8TWDk+IQtUQSAoTE9DS0VEKQf5AwRcZmUG/6oACh0kQsNqxa5A'
..'/8zuwAoAAChAAACAPzLdJD4hGU81IENvdW5jaWwgQ2xhc3NpZmljYXRpb24H6wMEYWdlCqUUQsOgUMs/zJmdwCEPRXF1aXAgVGVhbSBHZWFyCrx+QsM+TgVB/6icwApmEZ80AAAAAAAAgD8KAAAAAAAAgD8AAAAACgeJtjQAAAAAAACAPwpnEZ80AAAAAAAAgD8hAQAB'
..'AAIDBAEAAAUBCwAGBwgJCgsMDQ4PEBESExQVFhcYGRoLGwMFABwdHgkfHSAhIh0jBAgAJCUmHRgnKCkqKywtLi8wCTEDAAAFAQsABjIICQoLDDMONBA1EhMUNhYXGDcaCxsHBQAcHR4JHx0gISIdIwgIACQlJh0YJygpKjgsJS4vMAkxBwAABQELAAgJCgsMOQ46EDs8'
..'PRITFD4WPxhAGgsFAQsABkEICQoLDEIOQxBEEhMURRZGGEcaCxsMBQAcHR4JHx0gISIdIw0IACQlJh0YJygpKkgsJS4vMAkxDAAABQELAAZJCAkKCwxCDkoQRBITFEsWRhhMGgsbEAUAHB0eCR8dICEiHSMRCAAkJSYdGCcoKSpNLCUuLzAJMRAAAAUBDAAGTggJCgsM'
..'OQ5PEDs8PRITFFAWRhhRGgsFAQsACAkKCww5DlIQOzw9EhMUUxY/GEAaCwUBCwAGVAgJCgsMDQ5VEBESExRWFhcYVxoLGxYFABwdHgkfHSAhIh0jFwgAJCUmHRgnKCkqWCwtLi8wCTEWAAAFAQsABjIICQoLDFkOWhBbEhMUXBYXGF0aCzEaAAAbGgUAHB0eCR8dICEi'
..'HSMcCAAkJSYdGCcoKSpeLCUuLzAJBQELAAZJCAkKCwxfDmAQLRITFGEWRhhMGgsbHgUAHB0eCR8dICEiHSMfCAAkJSYdGCcoKSpiLCUuLzAJMR4AAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
