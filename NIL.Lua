-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 10932 characters

local ScriptFunctions = {
function(script,require)
function onTouch(part) 
local human = part.Parent:findFirstChild("Humanoid") 
if human ~= nil then 
part.Parent:findFirstChild("Head").Transparency = 0
part.Parent:findFirstChild("Torso").Transparency = 0
part.Parent:findFirstChild("Left Arm").Transparency = 0
part.Parent:findFirstChild("Right Arm").Transparency = 0
part.Parent:findFirstChild("Left Leg").Transparency = 0
part.Parent:findFirstChild("Right Leg").Transparency = 0
end 
end 
script.Parent.Touched:connect(onTouch) 

--COLORS

--1 = white
--208 = Light stone grey
--194 = Medium stone grey
--199 = Dark stone grey
--26 = Black
--21 = Bright red
--24 = Bright yellow
--226 = Cool yellow
--23 = Bright blue
--107 = Bright bluish green
--102 = Medium blue
--11 = Pastel blue
--45 = Light blue
--135 = Sand blue
--106 = Bright orange
--105 = Br. yellowish orange
--141 = Earth green
--28 = Dark green
--37 = Bright green
--119 = Br. yellowish green
--29 = Medium green
--151 = Sand green
--38 = Dark orange
--192 = Reddish brown
--104 = Bright violet
--9 = Light reddish violet
--101 = Medium red
--5 = Brick Yellow
--153 = Sand red
--217 = Brown
--18 = Nougat
--125 = Light orange


end,
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Chest") == nil then
		local g = script.Parent.Parent.Chest:clone()
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
				Y.Part0 = hit.Parent.Torso
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end
end

script.Parent.Touched:connect(onTouched)

end,
function(script,require)
local debounce = false 

function onTouch(part) 

local human = part.Parent:findFirstChild("Humanoid") 
if (human ~= nil) and debounce == false then 

debounce = true 

human.WalkSpeed = 16-- or whatever number 

wait(2) 
debounce = false 
end 
end 


script.Parent.Touched:connect(onTouch) 

end,
function(script,require)
local debounce = false
function getPlayer(humanoid) 
local players = game.Players:children() 
for i = 1, #players do 
if players[i].Character.Humanoid == humanoid then return players[i] end 
end 
return nil 
end 

function onTouch(part) 

local human = part.Parent:findFirstChild("Humanoid") 
if (human ~= nil) and debounce == false then

debounce = true

local player = getPlayer(human) 

if (player == nil) then return end 

script.Parent.Parent:findFirstChild("FlashGUI"):clone().Parent = player.PlayerGui

wait(5)
debounce = false
end
end


script.Parent.Touched:connect(onTouch) 

--Made by Jays520, J Productions
end,
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
script.Parent.Adornee = script.Parent.Parent
script:remove()
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


local Objects = Decode('AEB4ASEFTW9kZWwhBE5hbWUhC1Zlc3Qgdy8gR3VuIQpXb3JsZFBpdm90BDYBNwE4ASEFQ2hlc3QEOQE6ATsBIQRQYXJ0IQVQb3VjaCEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yBwYEIQZDRnJhbWUEGwA8AT0BIQpDYW5Db2xs'
..'aWRlAiEFQ29sb3IG/8yZIQhNYXRlcmlhbAMAAAAAAACRQCELT3JpZW50YXRpb24KAAAAAABAM0MAAAAAIQhQb3NpdGlvbgoYCmFC4E9gQJxjisMhCFJvdGF0aW9uCgAANMMAAEA/AAA0wyEEU2l6ZQoAAAA/AACAPs3MTD4hClRvcFN1cmZhY2UhCUJsb2NrTWVzaCEG'
..'T2Zmc2V0CgAAAAAAAAAAzcxMPwQmADwBPQEDAAAAAAAAcUAKxAxhQsBkVkAwfYrDCpqZmT+amZk/zcxMPgoAAAAAAAAAAM3MTL0hBVNjYWxlCgAAgD8AAIA/AACgQAQsADwBPQEKYAphQiAxY0AsZorDCgAAAD/NzEw+zcxMPgQvADwBPQEKdCZjQiCDW0BQfIrDCgAA'
..'gD6amZk/zcxMPgpmZoY/XI+CPwAAgD8hCk1hbnVhbFdlbGQhGVBhcnQtdG8tSGVhZCBTdHJvbmcgSm9pbnQhAkMwBD4BPwFAASECQzEEQQFCAUMBIQVQYXJ0MCEFUGFydDEhCU1hZyBQb3VjaAQ8ADwBPQEKWAtfQoBQKECwborDCs3MzD7NzEw/zcxMPiEEUHJvcAfr'
..'AwRDAEQBRQEGERERCgAAAACkcD2/XI9OQQpEzl5CgGR2QF7RisMKzcxMPs3MTD7NzEw+IQtTcGVjaWFsTWVzaArNzMw+zczMPs3MzD4hBk1lc2hJZCEoaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD04ODc0MjcwNyEITWVzaFR5cGUDAAAAAAAAFEAETAA8'
..'AT0BCrwLX0IgHTVAiHKKwwrNzMw+zszMPs3MTD4ETwA8AT0BCozzXkIgg1tAEn6KwwoAAIA/AACAP5qZqUAERgFCAUMBBFMAPAE9AQrEDGFCIGUmQDB9isMKMzOzP83MTD7NzEw+CgAAgD/NzEw/zcy8QARXADwBPQEKxAxhQoCDK0AwfYrDCpiZ2T/NzIw/zcxMPgoA'
..'AIA/AACAP5qZuUAEWwA8AT0BCsQMYUIgmBlAMH2KwwRdADwBPQEKxAxhQmAdJUAwfYrDCrgeBUDNzEw/zcxMPgRgADwBPQEKTAthQoBQKEDebYrDBGIAPAE9AQrEDGFCADIzQDB9isMEZAA8AT0BCjwLY0KAUChABm2KwwRmADwBPQEKxAxhQiBkZkAwfYrDCpqZmT/N'
..'zEw+zcxMPgRpADwBPQEKxAxhQgCYWUAwfYrDBGsAPAE9AQqYC2FCIB01QLRxisMKzczMPs3MzD7NzEw+IQRGbGFnBHAARwFIAQoAALTCAABAvwAAAAAKFBVhQiAxY0CQzIrDCgAAtMIAAAAAAABAvwrNzMw+zcxMPs3MTD4KAAAAPwAAgD8AAAA/AwAAAAAAABhAIQhN'
..'YWcgUHVjaAR4AEkBSgEKAAAAAABAM0NmZkZACnxwY0LA+F5ADmCKwwoAADTDAABAP2bmMMMKzcxMPs3MzD7NzEw+BHwASQFKAQpAdmNCAF1lQJhiisMEfgA8AT0BCrQmY0Igg1tAUHyKwwRLAUIBQwEEgQA8AT0BCsQMYULACCdAMH2Kwwq4HgVAzcxMPs3MTD4KrkeB'
..'P83MTD/2KKxABIYATAFNAQoAAAAAAICyQlyP0sAKYMRlQsB4MkDoo4rDBIgAPAE9AQrEDGFCwNUzQDB9isMEigA8AT0BCsQMYUIgPBpAMH2KwwSMADwBPQEKgAphQsAIJ0B0Z4rDCpqZCUDNzEw/zcxMPgoAAIA/ZmaGPwAAAEAEkABMAU0BClilZUKgwSVADKGKwwSS'
..'ADwBPQEKxAxhQoDLTEAwfYrDBJQAPAE9AQrEDGFC4LZOQDB9isMKmpm5P5qZmT/NzEw+IQZNaWRkbGUEmQBOAT0BCgAAAAAAAEC/AAAAAArEDGFCwP4/QDB9isMEmQA8AT0BBJwASQFKAQpoj2JCgLtfQG5gisMEngBJAUoBCgyVYkJAH2ZA+mKKwwSgADwBPQEKqAtj'
..'QiAdNUDgcIrDBKIAOgE7AQoUEmFCIK1AQCZ6isMKAAAAQAAAAEAAAIA/IQxUcmFuc3BhcmVuY3kDAAAAAAAA8D8hBUJvYXJkBKoATwFQAQMAAAAAAACAQAoAAAAAXI9CvwAAAAAKGGxfQoDJX0DIz4rDCgIAoD+amZk+zcxMPiEKU3VyZmFjZUd1aSEERmFjZSEKQ2Fu'
..'dmFzU2l6ZQsAAIBDAAAAQyEOTGlnaHRJbmZsdWVuY2UhCkltYWdlTGFiZWwhEEJhY2tncm91bmRDb2xvcjMG////DAAAAABkAAAAAABkACEFSW1hZ2UhFXJieGFzc2V0aWQ6Ly83Mzg4ODA2MiEESGVhZAS5ADoBOwEKFBJhQuBQkEAmeorDCgAAAEAAAIA/AACAPwMA'
..'AAAA8Gn4QAoAAKA/AACgPwAAoD8hBFNuYXAEUQFSAVMBBFQBVQFWAQcaAATDAE4BPQEGGyo1CpgTYUKAAQA/ML2KwwoAAIBAAACAPwAAAEAhBlNjcmlwdCEFVG9yc28hEFdhbGtTcGVlZCBTY3JpcHQhA0dVSSESSGVhZCBUZXJyYWluIEpvaW50BFcBPwFYASEFU3Rh'
..'bmQEWQFOAT0BBM8APAFaAQoAALRCAEAzQwAAAAAKkNldQuAwc0CCforDCgAAtEIAAAAAAEAzwwrMzMw+AACAP8zMzD4hDEN5bGluZGVyTWVzaARbAT8BWAEEXAFCAUMBBNYAPAFaAQqQ2V1CQMwMQIJ+isMKzMzMPwAAAEAAAIA/BF0BPwFAAQReAV8BYAEKAAAAQMzM'
..'zD8AAIA/IRtQYXJ0LXRvLU1pZGRsZSBTdHJvbmcgSm9pbnQEYQFiAUABBGMBZAFlAQTfAE4BPQEKxAxhQgAAgD8wfYrDIRJQYXJ0IFRlcnJhaW4gSm9pbnQEZgE/AVgBBGcBXwFgAQTkADwBWgEK6D9kQkDMDEDWe4rDBOYAPAFaAQroP2RC4DBzQNZ7isMEaAFCAUMB'
..'IQ9MZWdkcm9wIEhvbHN0ZXIEaQFqAWsBIQRMZWcxBO0AbAFtAQoAAAAASGG1wgAAAAAKXNdqQoB+nT92dorDCgAANMO4nrLCAAA0wwoAAIA/AAAAQAAAgD8hBExlZzIEbgFvAXABBPQAcQFyAQoAAAAAw/VovwAAAAAKeDBiQkCnmT9GgIrDBPcAbwFwAQoAAAAAXA+y'
..'QgAAAAAKCC9iQkDrsT/GgIrDCrkehT/NzEw+uB6FPyEBQiELQmFja1N1cmZhY2UDAAAAAAAAAEAEAAFzAXQBIQxGcm9udFN1cmZhY2UhC0xlZnRTdXJmYWNlChSuF0HsUXi/AAC0Qgp4rGRCALbLPzaVisMhDFJpZ2h0U3VyZmFjZQoUrhdBj8J1v+xRtEIKZ2aGP83M'
..'TD7NzEw+BAUBcwF0AQpEHGVCgJ21P+CQisMKMzMzP7gehT6vR+E+CgrXIz3NzMw9AAAAAAQKAXUBdgEKMzMCQuxReL8AALRCCiwUZUIA3bY/WnmKwwpxPQJChetRvz0KtUIKmpkZP3E9ij7NzEw+BA4BbwFwAQoIL2JCgHDdP8aAisMhAUcHxwAEFAF3AXgBBmNfYgoA'
..'gI/CrgczQwAAtMIKEKNkQsDD/D8yUorDCgCA2MKamZk+9iiyQgqQwnU+zcxMPs3MTD4KAACAPzMzMz/NzEw/BBkBdwF4AQqwpmRCAPL0P+ZpisMKzswMP83MTD7NzEw+IQZCdXR0b24EHgFqAWsBCgAAAAAAALTCAAAAAAqAeWNCAIRXPkYqisMKAACAQM3MzD4AAIBA'
..'IQRMZWdzIQxCaWxsYm9hcmRHdWkhCUZsYWdMYWJlbAwAAABAAAAAAABAAAAhClNpemVPZmZzZXQLAAAAAAAAAEAhCVRleHRMYWJlbCEFTGFiZWwhFkJhY2tncm91bmRUcmFuc3BhcmVuY3khD0JvcmRlclNpemVQaXhlbAwAAIA/AAAAAIA/AAAhBEZvbnQhBFRleHQh'
..'EkU0IEFuZCBIaWdoZXIgT25seSEKVGV4dENvbG9yMwZVAH8hCFRleHRTaXplAwAAAAAAACxAIRBUZXh0U3Ryb2tlQ29sb3IzBqr/ACEWVGV4dFN0cm9rZVRyYW5zcGFyZW5jeSEIRGlzYWJsZWQK8PFiQuBQIEBmNYrDCgAAgLAAAAAAAQCAPwoAANCnAACAPwAAAAAK'
..'9P5gQmCnYEDQiYrDCmr6fz8LWQC0fBtWPAplU/szAACAP8RHTjQKavp/vxfSgzN8G1a8CvMSgzMAAIA/WvXnMgoAAAC+mpkZP83MzD0KAACAvwAAAAAAAAAACgAAAAAAAAAAAACAPwoABCU/YBf2vgD8/L0KAACAP5CneTPnI9ewCmUc17BvfDC0AACAvwqYgXk/289k'
..'Pk8zTzwK/8pkvveGeT8q6jy7CgCDz75wF/a+APz8vQph+n8/Y+SDswjQVjwKC9BWPPttYDhh+n+/Cpqaf79XbF09XstVvAqCZ109LaB/P/8xOToKgAwlP2AX9r4A/Py9CrmyVDxnoeq98Ep+vwrHPcQ6flB+P0qc6r0Kavp/PxfSg7N8G1Y8ClD6fz+O4YOzogNYPAqi'
..'qIUzAACAP4XzhbMKAAAAAAAAAL8AAAAACgAAgD8AAACAAAAAAAoAAAAAAAAAgAAAgD8KAAAAAIDSfz8AAAAACgAAgD9diiKkAAAApQoAAAClAACAJwAAgD8Kz790QoqSB7//GXZBCgAAAAAAAIA/AAAAAArADGFCwP7/Pyx9isMKfxtWPKC3IzNq+n+/CszMTD4AAAC/'
..'zMxMvgoAr4C/cLoCvwD08z4KzMxMvwAAgD8AAAA/CoAoTr+wuAK/APTzPgoAAIC/kKd5s+cj1zAKZRzXMG98MDQAAIA/CgAAgD/MzEy/AAAAPwoAAIA/AAAAAAAAAAAKAIw3Pz7ffz9AiQY/Crf/fz+ZrZEbiHM9uwqIcz07esdQm7f/fz8Kz790QkzJg7//GW5BCoAo'
..'Tr/0WYG/APTzPgqAORg/aLoCvwD08z4KgCtkQsBqjz9GKorDCgEAALEAANAYAgCAPwoBAFCoAACAPwAA0BgKcIRGvNj3I7M0+38/ClLmgDMAAIA/qRonMwro3GJCQKeZP2aAisMKM4eKPKS/ibOl9n+/Cl0ECbIAAIA/1w6Kswqq938/iw6Es3W7gjwK4CWDMwAAgD8a'
..'/OcyCuQtNbthgHw/i7AoPgqk9n+/+km5N2+KirwK+FgUvIDHVz86uwk/Cqj2f79k7T04dm2KvAqbJoM8HmCgviYVc78KsfZ/v1/0gTd0JIq8hAEAAAIAAgADAAQABQABAAECAAIABgAEAAcACAACDQACAAkACgALAAwADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAa'
..'ABsAHAAdAB4AHwAgAA0AIQADAQAiACMACAACDAAKAAsADAANAA4ADwAQACQAEgATABQAFQAWACUAGAAZABoAJgAcAB0AHgAnACAADQAhAAUCACIAKAApACoACAACDQACAAkACgALAAwADQAOAA8AEAArABIAEwAUABUAFgAXABgAGQAaACwAHAAdAB4ALQAgAA0AIQAH'
..'AQAiACMACAACDAAKAAsADAANAA4ADwAQAC4AEgATABQAFQAWABcAGAAZABoALwAcAB0AHgAwACAADQAhAAkBACkAMQAyAAkDAAIAMwA0ADUANgA3AAgAAg0AAgA6AAoACwAMAA0ADgAPABAAOwASABMAFAAVABYAFwAYABkAGgA8ABwAHQAeAD0AIAANACEADAEAIgAj'
..'AAgAAgsAAgA+AAoACwAOAD8AEABAABIAEwAUAEEAFgAXABgAQgAaAEMAHABCAB4ARABFAA4DACkARgBHAEgASQBKAAgAAg0AAgA6AAoACwAMAA0ADgAPABAASwASABMAFAAVABYAFwAYABkAGgBMABwAHQAeAE0AIAANACEAEAEAIgAjAAgAAgwACgALAAwADQAOAA8A'
..'EABOABIAEwAUABUAFgAXABgAGQAaAE8AHAAdAB4AMAAgAA0AIQASAQApAFAAMgASAwACADMANAA1ADYAUQAIAAIMAAoACwAMAA0ADgAPABAATgASABMAFAAVABYAFwAYABkAGgBPABwAHQAeADAAIAANACEAFQEAKQAxADIAFQMAAgAzADQANQA2AFEACAACDAAKAAsA'
..'DAANAA4ADwAQAFIAEgATABQAFQAWABcAGAAZABoAUwAcAB0AHgBUACAADQAhABgBACkAVQAIAAIMAAoACwAMAA0ADgAPABAAVgASABMAFAAVABYAJQAYABkAGgBXABwAHQAeAFgAIAANACEAGgEAKQBZAAgAAgwACgALAAwADQAOAA8AEABaABIAEwAUABUAFgAXABgA'
..'GQAaAFsAHAAdAB4AVAAgAA0AIQAcAQApAFUACAACDAAKAAsADAANAA4ADwAQAFwAEgATABQAFQAWACUAGAAZABoAXQAcAB0AHgBeACAADQAhAB4BACkAUAAIAAINAAIAOgAKAAsADAANAA4ADwAQAF8AEgATABQAFQAWABcAGAAZABoAYAAcAB0AHgA9ACAADQAhACAB'
..'ACIAIwAIAAIMAAoACwAMAA0ADgAPABAAYQASABMAFAAVABYAFwAYABkAGgBiABwAHQAeAFQAIAANACEAIgEAKQBVAAgAAg0AAgA6AAoACwAMAA0ADgAPABAAYwASABMAFAAVABYAFwAYABkAGgBkABwAHQAeAD0AIAANACEAJAEAIgAjAAgAAgwACgALAAwADQAOAA8A'
..'EABlABIAEwAUABUAFgAXABgAGQAaAGYAHAAdAB4AZwAgAA0AIQAmAQApAFUACAACDAAKAAsADAANAA4ADwAQAGgAEgATABQAFQAWABcAGAAZABoAaQAcAB0AHgBnACAADQAhACgBACkAVQAIAAINAAIAOgAKAAsADAANAA4ADwAQAGoAEgATABQAFQAWABcAGAAZABoA'
..'awAcAB0AHgBsACAADQAhACoBACIAIwAIAAINAAIAbQAKAAsADAANAA4ADwAQAG4AEgATABQAFQAWACUAGABvABoAcAAcAHEAHgByACAADQBFACwCACkAcwBJAHQACAACDQACAHUACgALAAwADQAOAA8AEAB2ABIAEwAUABUAFgAXABgAdwAaAHgAHAB5AB4AegAgAA0A'
..'IQAuAQAiACMACAACDQACAHUACgALAAwADQAOAA8AEAB7ABIAEwAUABUAFgAXABgAdwAaAHwAHAB5AB4ARAAgAA0AIQAwAQAiACMACAACDAAKAAsADAANAA4ADwAQAH0AEgATABQAFQAWABcAGAAZABoAfgAcAB0AHgAwACAADQAhADIBACkAUAAyADIDAAIAMwA0ADUA'
..'NgB/AAgAAgwACgALAAwADQAOAA8AEACAABIAEwAUABUAFgAXABgAGQAaAIEAHAAdAB4AggAgAA0AIQA1AQApAIMACAACDAAKAAsADAANAA4ADwAQAIQAEgATABQAFQAWABcAGACFABoAhgAcAIUAHgBNACAADQAhADcAAAgAAgwACgALAAwADQAOAA8AEACHABIAEwAU'
..'ABUAFgAXABgAGQAaAIgAHAAdAB4AggAgAA0AIQA5AQApAIMACAACDAAKAAsADAANAA4ADwAQAIkAEgATABQAFQAWABcAGAAZABoAigAcAB0AHgCCACAADQAhADsBACkAgwAIAAIMAAoACwAMAA0ADgAPABAAiwASABMAFAAVABYAJQAYABkAGgCMABwAHQAeAI0AIAAN'
..'ACEAPQEAKQCOAAgAAgwACgALAAwADQAOAA8AEACPABIAEwAUABUAFgAXABgAhQAaAJAAHACFAB4APQAgAA0AIQA/AAAIAAIMAAoACwAMAA0ADgAPABAAkQASABMAFAAVABYAFwAYABkAGgCSABwAHQAeAGcAIAANACEAQQEAKQBVAAgAAgwACgALAAwADQAOAA8AEACT'
..'ABIAEwAUABUAFgAlABgAGQAaAJQAHAAdAB4AlQAgAA0AIQBDAQApAFkACAACDQACAJYACgALAAwADQAOAA8AEACXABIAEwAUABUAFgAlABgAmAAaAJkAHACYAB4ARAAgAA0ACAACDAAKAAsADAANAA4ADwAQAJoAEgATABQAFQAWABcAGAAZABoAmQAcAB0AHgBUACAA'
..'DQAhAEYBACkAVQAIAAINAAIAdQAKAAsADAANAA4ADwAQAJsAEgATABQAFQAWABcAGAB3ABoAnAAcAHkAHgB6ACAADQAhAEgBACIAIwAIAAINAAIAdQAKAAsADAANAA4ADwAQAJ0AEgATABQAFQAWABcAGAB3ABoAngAcAHkAHgBEACAADQAhAEoBACIAIwAIAAINAAIA'
..'OgAKAAsADAANAA4ADwAQAJ8AEgATABQAFQAWABcAGAAZABoAoAAcAB0AHgBNACAADQAhAEwBACIAIwAIAAIKAAIAlgAKAAsADgAPABAAoQAUABUAGACYABoAogAcAJgAHgCjAKQApQAIAAIOAAIApgAKAAsADAANAA4ADwAQAKcAEgATABQAFQAWAKgAGACpABoAqgAc'
..'AKkAHgCrACAADQCkAKUArABPAwACAK0ArgCvALAApQCxAFADALIAswAeALQAtQC2AAgAAgwAAgC3AAoACwAOAA8AEAC4ABQAFQAWACUAGACYABoAuQAcAJgAHgC6ACAADQCkALsARQBSAQApALwAvQBSAgA0AL4ANgC/AAgAAQ4AAgC3AAoACwAMAA0ADgDAABAAwQAS'
..'ABMAFADCABYAFwAYAJgAGgDDABwAmAAeAMQAIAANAKQApQDFAFUAAMUAVQEAAgDGAMUAVQEAAgDHAMUAVQEAAgDIADIAVQIAAgDJADYAygAyAFUCAAIAyQA2AMoAMgBVAgACAMkANgDKAAEAAQIAAgDLAAQAzAAIAF0MAAoACwAMAA0ADgDAABAAzQASABMAFADCABYA'
..'FwAYAM4AGgDPABwA0AAeANEAIAANANIAXgAAMgBeAwACADMANADTADYA1AAIAF0MAAoACwAMAA0ADgDAABAA1QASABMAFADCABYAFwAYAM4AGgDWABwA0AAeANEAIAANANIAYQAACABdDAAKAAsADAANAA4AwAAQAJcAEgATABQAwgAWABcAGACYABoAmQAcAJgAHgDX'
..'ACAADQAyAGMDAAIAMwA0ANgANgDZAAgAXQwACgALAAwADQAOAMAAEACXABIAEwAUAMIAFgAXABgAmAAaAJkAHACYAB4A2gAgAA0AMgBlAwACANsANADcADYA3QAIAF0MAAoACwAMAA0ADgDAABAA3gASABMAFADCABYAFwAYAJgAGgDfABwAmAAeANcAIAANADIAZwIA'
..'AgDgADYA4QAyAGcDAAIA2wA0ANgANgDiAAgAXQwACgALAAwADQAOAMAAEADjABIAEwAUAMIAFgAXABgAzgAaAOQAHADQAB4A0QAgAA0A0gBqAAAIAF0MAAoACwAMAA0ADgDAABAA5QASABMAFADCABYAFwAYAM4AGgDmABwA0AAeANEAIAANANIAbAAAMgBsAwACADMA'
..'NADTADYA5wABAAECAAIA6AAEAOkAAQBvAgACAOoABADrAAgAcA0AAgCWAAoACwAMAA0ADgDAABAA6wASABMAFADCABgA7AAaAO0AHADuAB4A7wAgAA0ApAClAAEAbwIAAgDwAAQA8QAIAHINAAIAlgAKAAsADAANAA4AwAAQAPIAEgATABQAwgAYAPMAGgD0ABwA8wAe'
..'AO8AIAANAKQApQAIAHIJAAoACwAOAA8AEAD1ABQAFQAYAPYAGgD3ABwA9gAeAPgAIAANAAgAchAAAgD5AAoACwD6APsADAD7AA4APwAQAPwAEgATABQAQQD9APsA/gD7ABgA/wAaAAABAQH7ABwAAgEeAAMBIAD7ACEAdQAACAByDwAKAAsA+gD7AAwA+wAOAA8AEAAE'
..'ARIAEwAUABUA/QD7AP4A+wAYAP8AGgAFAQEB+wAcAAIBHgAGASAA+wAhAHcBACIABwEIAHIPAAoACwD6APsADAD7AA4ADwAQAAgBEgATABQAFQD9APsA/gD7ABgACQEaAAoBAQH7ABwACwEeAAwBIAD7ACEAeQEAIgAHAQgAcgkACgALAA4ADwAQAA0BFAAVABgA9gAa'
..'AA4BHAD2AB4A+AAgAA0ACAByEAACAA8BCgALAPoA+wAMAPsADgAQARAAEQESABMAFAASAf0A+wD+APsAGAATARoAFAEBAfsAHAAVAR4AFgEgAPsAIQB8AQApABcBCAByEAACAPkACgALAPoA+wAMAPsADgA/ABAAGAESABMAFABBAP0A+wD+APsAGAATARoAGQEBAfsA'
..'HAAVAR4AGgEgAPsAIQB+AAAIAG8MAAIAGwEKAAsADAANAA4APwAQABwBFABBABgAHQEaAB4BHAAdAR4AHwEgAA0ApAClAMUAgAEAAgAgASEBAQMAAgAiAR4AIwEkASUBJgGCCgACACcBKAGlACkBDQAeACoBKwH7ACwBLQEuAS8BMAExATIBMwE0AQ0AxQCCAQA1AQsA'
..'GAs4AAkLOQBSFDgAEhQ5AFIXOAAVFzkAUjQ4ADI0OQBSVDgAUlQ5AE5aOQBVWzkAVVw5AFVgOABeYDkAUmQ4AGNkOQBSZjgAZWY5AHNoOQBnaTgAZ2k5AE5uOABsbjkAUg==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
