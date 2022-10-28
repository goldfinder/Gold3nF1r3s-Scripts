-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 7836 characters

local ScriptFunctions = {
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg1") == nil then
		local g = script.Parent.Parent.Leg1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" then
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
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end

	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg2") == nil then
		local g = script.Parent.Parent.Leg2:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" then
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
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end
end

script.Parent.Touched:connect(onTouched)
end,
function(script,require)
local g = script.Parent.Chest
g.Parent = owner.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "MeshPart" then
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
	Y.Part0 = owner.Character.Torso
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end

local h = g:GetChildren()
for i = 1, # h do
	h[i].Anchored = false
	h[i].CanCollide = false
end

local g = script.Parent["Legdrop Holster"].Leg2
g.Parent = owner.Character
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "MeshPart" then
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
	Y.Part0 = owner.Character["Right Leg"]
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
end

local h = g:GetChildren()
for i = 1, # h do
	h[i].Anchored = false
	h[i].CanCollide = false
end

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


local Objects = Decode('AEAEASEFTW9kZWwhBE5hbWUhC1Zlc3Qgdy8gR3VuIQpXb3JsZFBpdm90BOQA5QDmACEFQ2hlc3QE5wDoAOkAIQRQYXJ0IQVQb3VjaCEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yBwYEIQZDRnJhbWUEGwDqAOsAIQpDYW5Db2xs'
..'aWRlAiEFQ29sb3IG/8yZIQhNYXRlcmlhbAMAAAAAAACRQCELT3JpZW50YXRpb24KAAAAAABAM0MAAAAAIQhQb3NpdGlvbgoYCmFC4E9gQJxjisMhCFJvdGF0aW9uCgAANMMAAEA/AAA0wyEEU2l6ZQoAAAA/AACAPs3MTD4hClRvcFN1cmZhY2UhCUJsb2NrTWVzaCEG'
..'T2Zmc2V0CgAAAAAAAAAAzcxMPwQmAOoA6wADAAAAAAAAcUAKxAxhQsBkVkAwfYrDCpqZmT+amZk/zcxMPgoAAAAAAAAAAM3MTL0hBVNjYWxlCgAAgD8AAIA/AACgQAQsAOoA6wAKYAphQiAxY0AsZorDCgAAAD/NzEw+zcxMPgQvAOoA6wAKdCZjQiCDW0BQfIrDCgAA'
..'gD6amZk/zcxMPgpmZoY/XI+CPwAAgD8hCU1hZyBQb3VjaAQ0AOoA6wAKWAtfQoBQKECwborDCs3MzD7NzEw/zcxMPiEEUHJvcAfrAwQ7AOwA7QAGERERCgAAAACkcD2/XI9OQQpEzl5CgGR2QF7RisMKzcxMPs3MTD7NzEw+IQtTcGVjaWFsTWVzaArNzMw+zczMPs3M'
..'zD4hBk1lc2hJZCEoaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD04ODc0MjcwNyEITWVzaFR5cGUDAAAAAAAAFEAERADqAOsACrwLX0IgHTVAiHKKwwrNzMw+zszMPs3MTD4ERwDqAOsACozzXkIgg1tAEn6KwwoAAIA/AACAP5qZqUAESgDqAOsACsQMYUIg'
..'ZSZAMH2KwwozM7M/zcxMPs3MTD4KAACAP83MTD/NzLxABE4A6gDrAArEDGFCgIMrQDB9isMKmJnZP83MjD/NzEw+CgAAgD8AAIA/mpm5QARSAOoA6wAKxAxhQiCYGUAwfYrDBFQA6gDrAArEDGFCYB0lQDB9isMKuB4FQM3MTD/NzEw+BFcA6gDrAApMC2FCgFAoQN5t'
..'isMEWQDqAOsACsQMYUIAMjNAMH2KwwRbAOoA6wAKPAtjQoBQKEAGbYrDBF0A6gDrAArEDGFCIGRmQDB9isMKmpmZP83MTD7NzEw+BGAA6gDrAArEDGFCAJhZQDB9isMEYgDqAOsACpgLYUIgHTVAtHGKwwrNzMw+zczMPs3MTD4hBEZsYWcEZwDuAO8ACgAAtMIAAEC/'
..'AAAAAAoUFWFCIDFjQJDMisMKAAC0wgAAAAAAAEC/Cs3MzD7NzEw+zcxMPgoAAAA/AACAPwAAAD8DAAAAAAAAGEAhCE1hZyBQdWNoBG8A8ADxAAoAAAAAAEAzQ2ZmRkAKfHBjQsD4XkAOYIrDCgAANMMAAEA/ZuYwwwrNzEw+zczMPs3MTD4EcwDwAPEACkB2Y0IAXWVA'
..'mGKKwwR1AOoA6wAKtCZjQiCDW0BQfIrDBHcA6gDrAArEDGFCwAgnQDB9isMKuB4FQM3MTD7NzEw+Cq5HgT/NzEw/9iisQAR8APIA8wAKAAAAAACAskJcj9LACmDEZULAeDJA6KOKwwR+AOoA6wAKxAxhQsDVM0AwfYrDBIAA6gDrAArEDGFCIDwaQDB9isMEggDqAOsA'
..'CoAKYULACCdAdGeKwwqamQlAzcxMP83MTD4KAACAP2Zmhj8AAABABIYA8gDzAApYpWVCoMElQAyhisMEiADqAOsACsQMYUKAy0xAMH2KwwSKAOoA6wAKxAxhQuC2TkAwfYrDCpqZuT+amZk/zcxMPiEGTWlkZGxlBI8A9ADrAAoAAAAAAABAvwAAAAAKxAxhQsD+P0Aw'
..'fYrDBI8A6gDrAASSAPAA8QAKaI9iQoC7X0BuYIrDBJQA8ADxAAoMlWJCQB9mQPpiisMElgDqAOsACqgLY0IgHTVA4HCKwwSYAOgA6QAKFBJhQiCtQEAmeorDCgAAAEAAAABAAACAPyEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQVCb2FyZASgAPUA9gADAAAAAAAAgEAK'
..'AAAAAFyPQr8AAAAAChhsX0KAyV9AyM+KwwoCAKA/mpmZPs3MTD4hClN1cmZhY2VHdWkhBEZhY2UhCkNhbnZhc1NpemULAACAQwAAAEMhDkxpZ2h0SW5mbHVlbmNlIQpJbWFnZUxhYmVsIRBCYWNrZ3JvdW5kQ29sb3IzBv///wwAAAAAZAAAAAAAZAAhBUltYWdlIRVy'
..'Ynhhc3NldGlkOi8vNzM4ODgwNjIhD0xlZ2Ryb3AgSG9sc3RlcgT3APgA+QAhBExlZzIE+gD7APwABxoABLUA/QD+AAYbKjUKAAAAAMP1aL8AAAAACngwYkJAp5k/RoCKwwoAAIA/AAAAQAAAgD8EuQD7APwACgAAAABcD7JCAAAAAAoIL2JCQOuxP8aAisMKuR6FP83M'
..'TD64HoU/IQFCIQtCYWNrU3VyZmFjZQMAAAAAAAAAQATCAP8AAAEhDEZyb250U3VyZmFjZSELTGVmdFN1cmZhY2UKFK4XQexReL8AALRCCnisZEIAtss/NpWKwyEMUmlnaHRTdXJmYWNlChSuF0GPwnW/7FG0QgpnZoY/zcxMPs3MTD4ExwD/AAABCkQcZUKAnbU/4JCK'
..'wwozMzM/uB6FPq9H4T4KCtcjPc3MzD0AAAAABMwAAQECAQozMwJC7FF4vwAAtEIKLBRlQgDdtj9aeYrDCnE9AkKF61G/PQq1QgqamRk/cT2KPs3MTD4E0AD7APwACggvYkKAcN0/xoCKwyEBRwfHAATWAAMBBAEGY19iCgCAj8KuBzNDAAC0wgoQo2RCwMP8PzJSisMK'
..'AIDYwpqZmT72KLJCCpDCdT7NzEw+zcxMPgoAAIA/MzMzP83MTD8E2wADAQQBCrCmZEIA8vQ/5mmKwwrOzAw/zcxMPs3MTD4hBkJ1dHRvbgTgAPgA+QAKAAAAAAAAtMIAAAAACoB5Y0IAhFc+RiqKwwoAAIBAzczMPgAAgEAhBlNjcmlwdCEETGVncwrw8WJC4FAgQGY1'
..'isMKAACAsAAAAAABAIA/CgAA0KcAAIA/AAAAAAr0/mBCYKdgQNCJisMKavp/PwtZALR8G1Y8CmVT+zMAAIA/xEdONApq+n+/F9KDM3wbVrwK8xKDMwAAgD9a9ecyCpiBeT/bz2Q+TzNPPAr/ymS+94Z5PyrqPLsKYfp/P2Pkg7MI0FY8CgvQVjz7bWA4Yfp/vwqamn+/'
..'V2xdPV7LVbwKgmddPS2gfz//MTk6CrmyVDxnoeq98Ep+vwrHPcQ6flB+P0qc6r0Kavp/PxfSg7N8G1Y8ClD6fz+O4YOzogNYPAqiqIUzAACAP4XzhbMKgCtkQsBqjz9GKorDCgEAALEAANAYAgCAPwoBAFCoAACAPwAA0BgK6NxiQkCnmT9mgIrDCjOHijykv4mzpfZ/'
..'vwpdBAmyAACAP9cOirMKqvd/P4sOhLN1u4I8CuAlgzMAAIA/GvznMgrkLTW7YYB8P4uwKD4KpPZ/v/pJuTdvioq8CvhYFLyAx1c/OrsJPwqo9n+/ZO09OHZtirwKmyaDPB5goL4mFXO/CrH2f79f9IE3dCSKvF8BAAACAAIAAwAEAAUAAQABAgACAAYABAAHAAgAAg0A'
..'AgAJAAoACwAMAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgAbABwAHQAeAB8AIAANACEAAwEAIgAjAAgAAgwACgALAAwADQAOAA8AEAAkABIAEwAUABUAFgAlABgAGQAaACYAHAAdAB4AJwAgAA0AIQAFAgAiACgAKQAqAAgAAg0AAgAJAAoACwAMAA0ADgAPABAA'
..'KwASABMAFAAVABYAFwAYABkAGgAsABwAHQAeAC0AIAANACEABwEAIgAjAAgAAgwACgALAAwADQAOAA8AEAAuABIAEwAUABUAFgAXABgAGQAaAC8AHAAdAB4AMAAgAA0AIQAJAQApADEACAACDQACADIACgALAAwADQAOAA8AEAAzABIAEwAUABUAFgAXABgAGQAaADQA'
..'HAAdAB4ANQAgAA0AIQALAQAiACMACAACCwACADYACgALAA4ANwAQADgAEgATABQAOQAWABcAGAA6ABoAOwAcADoAHgA8AD0ADQMAKQA+AD8AQABBAEIACAACDQACADIACgALAAwADQAOAA8AEABDABIAEwAUABUAFgAXABgAGQAaAEQAHAAdAB4ARQAgAA0AIQAPAQAi'
..'ACMACAACDAAKAAsADAANAA4ADwAQAEYAEgATABQAFQAWABcAGAAZABoARwAcAB0AHgAwACAADQAhABEBACkASAAIAAIMAAoACwAMAA0ADgAPABAARgASABMAFAAVABYAFwAYABkAGgBHABwAHQAeADAAIAANACEAEwEAKQAxAAgAAgwACgALAAwADQAOAA8AEABJABIA'
..'EwAUABUAFgAXABgAGQAaAEoAHAAdAB4ASwAgAA0AIQAVAQApAEwACAACDAAKAAsADAANAA4ADwAQAE0AEgATABQAFQAWACUAGAAZABoATgAcAB0AHgBPACAADQAhABcBACkAUAAIAAIMAAoACwAMAA0ADgAPABAAUQASABMAFAAVABYAFwAYABkAGgBSABwAHQAeAEsA'
..'IAANACEAGQEAKQBMAAgAAgwACgALAAwADQAOAA8AEABTABIAEwAUABUAFgAlABgAGQAaAFQAHAAdAB4AVQAgAA0AIQAbAQApAEgACAACDQACADIACgALAAwADQAOAA8AEABWABIAEwAUABUAFgAXABgAGQAaAFcAHAAdAB4ANQAgAA0AIQAdAQAiACMACAACDAAKAAsA'
..'DAANAA4ADwAQAFgAEgATABQAFQAWABcAGAAZABoAWQAcAB0AHgBLACAADQAhAB8BACkATAAIAAINAAIAMgAKAAsADAANAA4ADwAQAFoAEgATABQAFQAWABcAGAAZABoAWwAcAB0AHgA1ACAADQAhACEBACIAIwAIAAIMAAoACwAMAA0ADgAPABAAXAASABMAFAAVABYA'
..'FwAYABkAGgBdABwAHQAeAF4AIAANACEAIwEAKQBMAAgAAgwACgALAAwADQAOAA8AEABfABIAEwAUABUAFgAXABgAGQAaAGAAHAAdAB4AXgAgAA0AIQAlAQApAEwACAACDQACADIACgALAAwADQAOAA8AEABhABIAEwAUABUAFgAXABgAGQAaAGIAHAAdAB4AYwAgAA0A'
..'IQAnAQAiACMACAACDQACAGQACgALAAwADQAOAA8AEABlABIAEwAUABUAFgAlABgAZgAaAGcAHABoAB4AaQAgAA0APQApAgApAGoAQQBrAAgAAg0AAgBsAAoACwAMAA0ADgAPABAAbQASABMAFAAVABYAFwAYAG4AGgBvABwAcAAeAHEAIAANACEAKwEAIgAjAAgAAg0A'
..'AgBsAAoACwAMAA0ADgAPABAAcgASABMAFAAVABYAFwAYAG4AGgBzABwAcAAeADwAIAANACEALQEAIgAjAAgAAgwACgALAAwADQAOAA8AEAB0ABIAEwAUABUAFgAXABgAGQAaAHUAHAAdAB4AMAAgAA0AIQAvAQApAEgACAACDAAKAAsADAANAA4ADwAQAHYAEgATABQA'
..'FQAWABcAGAAZABoAdwAcAB0AHgB4ACAADQAhADEBACkAeQAIAAIMAAoACwAMAA0ADgAPABAAegASABMAFAAVABYAFwAYAHsAGgB8ABwAewAeAEUAIAANACEAMwAACAACDAAKAAsADAANAA4ADwAQAH0AEgATABQAFQAWABcAGAAZABoAfgAcAB0AHgB4ACAADQAhADUB'
..'ACkAeQAIAAIMAAoACwAMAA0ADgAPABAAfwASABMAFAAVABYAFwAYABkAGgCAABwAHQAeAHgAIAANACEANwEAKQB5AAgAAgwACgALAAwADQAOAA8AEACBABIAEwAUABUAFgAlABgAGQAaAIIAHAAdAB4AgwAgAA0AIQA5AQApAIQACAACDAAKAAsADAANAA4ADwAQAIUA'
..'EgATABQAFQAWABcAGAB7ABoAhgAcAHsAHgA1ACAADQAhADsAAAgAAgwACgALAAwADQAOAA8AEACHABIAEwAUABUAFgAXABgAGQAaAIgAHAAdAB4AXgAgAA0AIQA9AQApAEwACAACDAAKAAsADAANAA4ADwAQAIkAEgATABQAFQAWACUAGAAZABoAigAcAB0AHgCLACAA'
..'DQAhAD8BACkAUAAIAAINAAIAjAAKAAsADAANAA4ADwAQAI0AEgATABQAFQAWACUAGACOABoAjwAcAI4AHgA8ACAADQAIAAIMAAoACwAMAA0ADgAPABAAkAASABMAFAAVABYAFwAYABkAGgCPABwAHQAeAEsAIAANACEAQgEAKQBMAAgAAg0AAgBsAAoACwAMAA0ADgAP'
..'ABAAkQASABMAFAAVABYAFwAYAG4AGgCSABwAcAAeAHEAIAANACEARAEAIgAjAAgAAg0AAgBsAAoACwAMAA0ADgAPABAAkwASABMAFAAVABYAFwAYAG4AGgCUABwAcAAeADwAIAANACEARgEAIgAjAAgAAg0AAgAyAAoACwAMAA0ADgAPABAAlQASABMAFAAVABYAFwAY'
..'ABkAGgCWABwAHQAeAEUAIAANACEASAEAIgAjAAgAAgoAAgCMAAoACwAOAA8AEACXABQAFQAYAI4AGgCYABwAjgAeAJkAmgCbAAgAAg4AAgCcAAoACwAMAA0ADgAPABAAnQASABMAFAAVABYAngAYAJ8AGgCgABwAnwAeAKEAIAANAJoAmwCiAEsDAAIAowCkAKUApgCb'
..'AKcATAMAqACpAB4AqgCrAKwAAQABAgACAK0ABACuAAEATgIAAgCvAAQAsAAIAE8NAAIAjAAKAAsADAANAA4AsQAQALIAEgATABQAswAYALQAGgC1ABwAtAAeALYAIAANAJoAmwAIAE8JAAoACwAOAA8AEAC3ABQAFQAYALgAGgC5ABwAuAAeALoAIAANAAgATxAAAgC7'
..'AAoACwC8AL0ADAC9AA4ANwAQAL4AEgATABQAOQC/AL0AwAC9ABgAwQAaAMIAwwC9ABwAxAAeAMUAIAC9ACEAUgAACABPDwAKAAsAvAC9AAwAvQAOAA8AEADGABIAEwAUABUAvwC9AMAAvQAYAMEAGgDHAMMAvQAcAMQAHgDIACAAvQAhAFQBACIAyQAIAE8PAAoACwC8'
..'AL0ADAC9AA4ADwAQAMoAEgATABQAFQC/AL0AwAC9ABgAywAaAMwAwwC9ABwAzQAeAM4AIAC9ACEAVgEAIgDJAAgATwkACgALAA4ADwAQAM8AFAAVABgAuAAaANAAHAC4AB4AugAgAA0ACABPEAACANEACgALALwAvQAMAL0ADgDSABAA0wASABMAFADUAL8AvQDAAL0A'
..'GADVABoA1gDDAL0AHADXAB4A2AAgAL0AIQBZAQApANkACABPEAACALsACgALALwAvQAMAL0ADgA3ABAA2gASABMAFAA5AL8AvQDAAL0AGADVABoA2wDDAL0AHADXAB4A3AAgAL0AIQBbAAAIAE4MAAIA3QAKAAsADAANAA4ANwAQAN4AFAA5ABgA3wAaAOAAHADfAB4A'
..'4QAgAA0AmgCbAOIAXQEAAgDjAOIAAQAAAA==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
