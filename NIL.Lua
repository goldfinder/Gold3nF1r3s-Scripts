-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 5664 characters

local ScriptFunctions = {
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


local Objects = Decode('AAD+IQVNb2RlbCEETmFtZSELVmVzdCB3LyBHdW4hCldvcmxkUGl2b3QE3t/gIQVDaGVzdATh4uMhBFBhcnQhBVBvdWNoIQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhCkJyaWNrQ29sb3IHBgQhBkNGcmFtZQQb5OUhCkNhbkNvbGxpZGUCIQVDb2xv'
..'cgb/zJkhCE1hdGVyaWFsAwAAAAAAAJFAIQtPcmllbnRhdGlvbgoAAAAAAEAzQwAAAAAhCFBvc2l0aW9uChgKYULgT2BAnGOKwyEIUm90YXRpb24KAAA0wwAAQD8AADTDIQRTaXplCgAAAD8AAIA+zcxMPiEKVG9wU3VyZmFjZSEJQmxvY2tNZXNoIQZPZmZzZXQKAAAA'
..'AAAAAADNzEw/BCbk5QMAAAAAAABxQArEDGFCwGRWQDB9isMKmpmZP5qZmT/NzEw+CgAAAAAAAAAAzcxMvSEFU2NhbGUKAACAPwAAgD8AAKBABCzk5QpgCmFCIDFjQCxmisMKAAAAP83MTD7NzEw+BC/k5Qp0JmNCIINbQFB8isMKAACAPpqZmT/NzEw+CmZmhj9cj4I/'
..'AACAPyEJTWFnIFBvdWNoBDTk5QpYC19CgFAoQLBuisMKzczMPs3MTD/NzEw+IQRQcm9wB+sDBDvm5wYREREKAAAAAKRwPb9cj05BCkTOXkKAZHZAXtGKwwrNzEw+zcxMPs3MTD4hC1NwZWNpYWxNZXNoCs3MzD7NzMw+zczMPiEGTWVzaElkIShodHRwOi8vd3d3LnJv'
..'YmxveC5jb20vYXNzZXQvP2lkPTg4NzQyNzA3IQhNZXNoVHlwZQMAAAAAAAAUQARE5OUKvAtfQiAdNUCIcorDCs3MzD7OzMw+zcxMPgRH5OUKjPNeQiCDW0ASforDCgAAgD8AAIA/mpmpQARK5OUKxAxhQiBlJkAwfYrDCjMzsz/NzEw+zcxMPgoAAIA/zcxMP83MvEAE'
..'TuTlCsQMYUKAgytAMH2KwwqYmdk/zcyMP83MTD4KAACAPwAAgD+amblABFLk5QrEDGFCIJgZQDB9isMEVOTlCsQMYUJgHSVAMH2Kwwq4HgVAzcxMP83MTD4EV+TlCkwLYUKAUChA3m2KwwRZ5OUKxAxhQgAyM0AwfYrDBFvk5Qo8C2NCgFAoQAZtisMEXeTlCsQMYUIg'
..'ZGZAMH2KwwqamZk/zcxMPs3MTD4EYOTlCsQMYUIAmFlAMH2KwwRi5OUKmAthQiAdNUC0cYrDCs3MzD7NzMw+zcxMPiEERmxhZwRn6OkKAAC0wgAAQL8AAAAAChQVYUIgMWNAkMyKwwoAALTCAAAAAAAAQL8KzczMPs3MTD7NzEw+CgAAAD8AAIA/AAAAPwMAAAAAAAAY'
..'QCEITWFnIFB1Y2gEb+rrCgAAAAAAQDNDZmZGQAp8cGNCwPheQA5gisMKAAA0wwAAQD9m5jDDCs3MTD7NzMw+zcxMPgRz6usKQHZjQgBdZUCYYorDBHXk5Qq0JmNCIINbQFB8isMEd+TlCsQMYULACCdAMH2Kwwq4HgVAzcxMPs3MTD4KrkeBP83MTD/2KKxABHzs7QoA'
..'AAAAAICyQlyP0sAKYMRlQsB4MkDoo4rDBH7k5QrEDGFCwNUzQDB9isMEgOTlCsQMYUIgPBpAMH2KwwSC5OUKgAphQsAIJ0B0Z4rDCpqZCUDNzEw/zcxMPgoAAIA/ZmaGPwAAAEAEhuztClilZUKgwSVADKGKwwSI5OUKxAxhQoDLTEAwfYrDBIrk5QrEDGFC4LZOQDB9'
..'isMKmpm5P5qZmT/NzEw+IQZNaWRkbGUEj+7lCgAAAAAAAEC/AAAAAArEDGFCwP4/QDB9isMEj+TlBJLq6wpoj2JCgLtfQG5gisMElOrrCgyVYkJAH2ZA+mKKwwSW5OUKqAtjQiAdNUDgcIrDBJji4woUEmFCIK1AQCZ6isMKAAAAQAAAAEAAAIA/IQxUcmFuc3BhcmVu'
..'Y3kDAAAAAAAA8D8hBUJvYXJkBKDv8AMAAAAAAACAQAoAAAAAXI9CvwAAAAAKGGxfQoDJX0DIz4rDCgIAoD+amZk+zcxMPiEKU3VyZmFjZUd1aSEERmFjZSEKQ2FudmFzU2l6ZQsAAIBDAAAAQyEOTGlnaHRJbmZsdWVuY2UhCkltYWdlTGFiZWwhEEJhY2tncm91bmRD'
..'b2xvcjMG////DAAAAABkAAAAAABkACEFSW1hZ2UhFXJieGFzc2V0aWQ6Ly83Mzg4ODA2MiEPTGVnZHJvcCBIb2xzdGVyBPHy8yEETGVnMgT09fYHGgAEtff4BhsqNQoAAAAAw/VovwAAAAAKeDBiQkCnmT9GgIrDCgAAgD8AAABAAACAPwS59fYKAAAAAFwPskIAAAAA'
..'CggvYkJA67E/xoCKwwq5HoU/zcxMPrgehT8hAUIhC0JhY2tTdXJmYWNlAwAAAAAAAABABML5+iEMRnJvbnRTdXJmYWNlIQtMZWZ0U3VyZmFjZQoUrhdB7FF4vwAAtEIKeKxkQgC2yz82lYrDIQxSaWdodFN1cmZhY2UKFK4XQY/Cdb/sUbRCCmdmhj/NzEw+zcxMPgTH'
..'+foKRBxlQoCdtT/gkIrDCjMzMz+4HoU+r0fhPgoK1yM9zczMPQAAAAAEzPv8CjMzAkLsUXi/AAC0QgosFGVCAN22P1p5isMKcT0CQoXrUb89CrVCCpqZGT9xPYo+zcxMPgTQ9fYKCC9iQoBw3T/GgIrDIQFHB8cABNb9/gZjX2IKAICPwq4HM0MAALTCChCjZELAw/w/'
..'MlKKwwoAgNjCmpmZPvYoskIKkMJ1Ps3MTD7NzEw+CgAAgD8zMzM/zcxMPwTb/f4KsKZkQgDy9D/maYrDCs7MDD/NzEw+zcxMPiEGU2NyaXB0CvDxYkLgUCBAZjWKwwoAAICwAAAAAAEAgD8KAADQpwAAgD8AAAAACvT+YEJgp2BA0ImKwwpq+n8/C1kAtHwbVjwKZVP7'
..'MwAAgD/ER040Cmr6f78X0oMzfBtWvArzEoMzAACAP1r15zIKmIF5P9vPZD5PM088Cv/KZL73hnk/Kuo8uwph+n8/Y+SDswjQVjwKC9BWPPttYDhh+n+/Cpqaf79XbF09XstVvAqCZ109LaB/P/8xOToKubJUPGeh6r3wSn6/Csc9xDp+UH4/SpzqvQpq+n8/F9KDs3wb'
..'VjwKUPp/P47hg7OiA1g8CqKohTMAAIA/hfOFswqAK2RCwGqPP0YqisMKAQAAsQAA0BgCAIA/CgEAUKgAAIA/AADQGAro3GJCQKeZP2aAisMKM4eKPKS/ibOl9n+/Cl0ECbIAAIA/1w6Kswqq938/iw6Es3W7gjwK4CWDMwAAgD8a/OcyCuQtNbthgHw/i7AoPgqk9n+/'
..'+km5N2+KirwK+FgUvIDHVz86uwk/Cqj2f79k7T04dm2KvAqbJoM8HmCgviYVc78KsfZ/v1/0gTd0JIq8XQEAAgACAwQFAQECAAIGBAcIAg0AAgkKCwwNDg8QERITFBUWFxgZGhscHR4fIA0hAwEAIiMIAgwACgsMDQ4PECQSExQVFiUYGRomHB0eJyANIQUCACIoKSoI'
..'Ag0AAgkKCwwNDg8QKxITFBUWFxgZGiwcHR4tIA0hBwEAIiMIAgwACgsMDQ4PEC4SExQVFhcYGRovHB0eMCANIQkBACkxCAINAAIyCgsMDQ4PEDMSExQVFhcYGRo0HB0eNSANIQsBACIjCAILAAI2CgsONxA4EhMUORYXGDoaOxw6Hjw9DQMAKT4/QEFCCAINAAIyCgsM'
..'DQ4PEEMSExQVFhcYGRpEHB0eRSANIQ8BACIjCAIMAAoLDA0ODxBGEhMUFRYXGBkaRxwdHjAgDSERAQApSAgCDAAKCwwNDg8QRhITFBUWFxgZGkccHR4wIA0hEwEAKTEIAgwACgsMDQ4PEEkSExQVFhcYGRpKHB0eSyANIRUBAClMCAIMAAoLDA0ODxBNEhMUFRYlGBka'
..'ThwdHk8gDSEXAQApUAgCDAAKCwwNDg8QURITFBUWFxgZGlIcHR5LIA0hGQEAKUwIAgwACgsMDQ4PEFMSExQVFiUYGRpUHB0eVSANIRsBAClICAINAAIyCgsMDQ4PEFYSExQVFhcYGRpXHB0eNSANIR0BACIjCAIMAAoLDA0ODxBYEhMUFRYXGBkaWRwdHksgDSEfAQAp'
..'TAgCDQACMgoLDA0ODxBaEhMUFRYXGBkaWxwdHjUgDSEhAQAiIwgCDAAKCwwNDg8QXBITFBUWFxgZGl0cHR5eIA0hIwEAKUwIAgwACgsMDQ4PEF8SExQVFhcYGRpgHB0eXiANISUBAClMCAINAAIyCgsMDQ4PEGESExQVFhcYGRpiHB0eYyANIScBACIjCAINAAJkCgsM'
..'DQ4PEGUSExQVFiUYZhpnHGgeaSANPSkCAClqQWsIAg0AAmwKCwwNDg8QbRITFBUWFxhuGm8ccB5xIA0hKwEAIiMIAg0AAmwKCwwNDg8QchITFBUWFxhuGnMccB48IA0hLQEAIiMIAgwACgsMDQ4PEHQSExQVFhcYGRp1HB0eMCANIS8BAClICAIMAAoLDA0ODxB2EhMU'
..'FRYXGBkadxwdHnggDSExAQApeQgCDAAKCwwNDg8QehITFBUWFxh7Gnwcex5FIA0hMwAACAIMAAoLDA0ODxB9EhMUFRYXGBkafhwdHnggDSE1AQApeQgCDAAKCwwNDg8QfxITFBUWFxgZGoAcHR54IA0hNwEAKXkIAgwACgsMDQ4PEIESExQVFiUYGRqCHB0egyANITkB'
..'ACmECAIMAAoLDA0ODxCFEhMUFRYXGHsahhx7HjUgDSE7AAAIAgwACgsMDQ4PEIcSExQVFhcYGRqIHB0eXiANIT0BAClMCAIMAAoLDA0ODxCJEhMUFRYlGBkaihwdHosgDSE/AQApUAgCDQACjAoLDA0ODxCNEhMUFRYlGI4ajxyOHjwgDQgCDAAKCwwNDg8QkBITFBUW'
..'FxgZGo8cHR5LIA0hQgEAKUwIAg0AAmwKCwwNDg8QkRITFBUWFxhuGpIccB5xIA0hRAEAIiMIAg0AAmwKCwwNDg8QkxITFBUWFxhuGpQccB48IA0hRgEAIiMIAg0AAjIKCwwNDg8QlRITFBUWFxgZGpYcHR5FIA0hSAEAIiMIAgoAAowKCw4PEJcUFRiOGpgcjh6ZmpsI'
..'Ag4AApwKCwwNDg8QnRITFBUWnhifGqAcnx6hIA2am6JLAwACo6SlppunTAMAqKkeqqusAQECAAKtBK4BTgIAAq8EsAhPDQACjAoLDA0OsRCyEhMUsxi0GrUctB62IA2amwhPCQAKCw4PELcUFRi4GrkcuB66IA0ITxAAArsKC7y9DL0ONxC+EhMUOb+9wL0YwRrCw70c'
..'xB7FIL0hUgAACE8PAAoLvL0MvQ4PEMYSExQVv73AvRjBGsfDvRzEHsggvSFUAQAiyQhPDwAKC7y9DL0ODxDKEhMUFb+9wL0YyxrMw70czR7OIL0hVgEAIskITwkACgsODxDPFBUYuBrQHLgeuiANCE8QAALRCgu8vQy9DtIQ0xITFNS/vcC9GNUa1sO9HNce2CC9IVkB'
..'ACnZCE8QAAK7Cgu8vQy9DjcQ2hITFDm/vcC9GNUa28O9HNce3CC9IVsAAN0BAAAA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
