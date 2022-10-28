-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 48004 characters

local ScriptFunctions = {
function(script,require)
function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Top") == nil then
		local g = script.Parent.Helmet
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
			Y.Part0 = owner.Character.Head
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


local Objects = Decode('AEAcCCEFTW9kZWwhCldvcmxkUGl2b3QE/gf/BwAIIQROYW1lIQZIZWxtZXQEAQgCCAMIIQRQYXJ0IQZNaWRkbGUhCEFuY2hvcmVkIiENQm90dG9tU3VyZmFjZQMAAAAAAAAAACEKQnJpY2tDb2xvcgcGBCEGQ0ZyYW1lBBsABAgFCCEKQ2FuQ29sbGlkZQIhCkNhc3RTaGFkb3chBUNvbG9yBv/MmSEITWF0ZXJpYWwDAAAAAAAAkUAhC09yaWVudGF0aW9uCgAAAAAAALRCAAAAACEIUG9zaXRpb24Kb9FZwnSSNj/gFPbBIQhSb3Rh'
..'dGlvbiEEU2l6ZQoAAABAAACAPwAAgD8hClRvcFN1cmZhY2UhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyELU3BlY2lhbE1lc2ghBVNjYWxlCgAAoD8AAKA/AACgPyEMVmVjdG9yM1ZhbHVlIQxPcmlnaW5hbFNpemUhBVZhbHVlIQpCYWxhY2xhdmExB+sDBCwABAgFCAYREREKN9VZwuS/LT8kE/bBCs3MTD3NzEw9zcxMPSELVmVydGV4Q29sb3IKAACAPgAAgD4AAIA+IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8xNjU3NDMxMDg1IQlU'
..'ZXh0dXJlSWQhFnJieGFzc2V0aWQ6Ly8xMjczMDM4MzEhCE1lc2hUeXBlAwAAAAAAABRAIQhNZXNoUGFydAQ5AAYIBQgKAAAAAAAAtMIAAAAACh8mWsKUs40/4Bz2wQrN5sk/gB8/PsiysD4hF3JieGFzc2V0aWQ6Ly80MDY3NDQ0NTM0IQhNZXNoU2l6ZSEJVGV4dHVyZUlEISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTQwNjc4OTQzMzYhB2JhdGVyaWEEQgAHCAgICgrXozwAAAAAUrjuQAqUkVbCwMBsP2Is9sEK'
..'DATyPnr3+z5dA5Y/IRdyYnhhc3NldGlkOi8vMzMyNzM1NTA0Nwp0DTpC1LNBQhim5kIhF3JieGFzc2V0aWQ6Ly8yODI5NjA4NDI1IRBGQVNUIEVTUyBIRUFEU0VUBEkA/wcACAqHiVrCfCgmP2AP9sEKnlGVP/6tnD8CQ+Q/IRdyYnhhc3NldGlkOi8vMzE3NTI2MTUyMwpR799Czt/dQsjRKUMhF3JieGFzc2V0aWQ6Ly8zNzk3OTQyMzY1IRhNZXNoZXMvdW50aXRsZWRfQ3ViZS4wMDIHGgAEUwAJCAoIBioqKgoAAAAA4XoUv4/C'
..'9bwKYfBbwnxGhj+eDPbBCpcmFT9IEjU+TebDPyEXcmJ4YXNzZXRpZDovLzM3NDQyMjMyODkKOW5iQvhxiUEirBVDIRhNZXNoZXMvdW50aXRsZWRfQ3ViZS4wMzAEWQD/BwAICszIWcKQ9lo/Zh32wQrbMdY/ZkvWP6MvyT8hF3JieGFzc2V0aWQ6Ly8zNzQ0MjIyNjE4ChVyI0OThSND6IQZQyEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0zNzc4NzQ5MDQ2IQZHIExlbnMH7AMEZAALCAwIBv8AAAMAAAAAAAByQAqF'
..'67NCFK6zwoUrM0MKUAVcwviaZz9gJPbBCgAAtELNzEy94fq1wgpgA4Q/HRJ7PgGu0j4DAAAAQDMz0z8hF3JieGFzc2V0aWQ6Ly8zNzg1NjQ4MDc0ChzOHD5cHBU9wD56PSEHR29nZ2xlcweVAARuAAsIDAgGHBwcCtupW8Lo5Gw/3if2wQqT95A/XOjcPivV9z4hF3JieGFzc2V0aWQ6Ly8zNzg1NjQ3MTM5ChYxLD5qMoM9DTCTPQRzAAsIDAgKGLRbwvB4aj8eKfbBCtuvlz/MJec+D6kBPyEOVW5pb25PcGVyYXRpb24hDkdvZ2ds'
..'ZXMgTW9kdWxlBHoADQgOCAYdHh8KCtcjPUhhtUIK16M8CutNWcLQ4Gg/pDr2wQqPgjBDuJ6yQnF9MMMKbAGlP3mzXD4oV4E/IQxVc2VQYXJ0Q29sb3IKNCcoQDMnKD81J6g/Cn/1XcIy910/mTH3wQoK16O8XE8zwwrXIz0Kb7NcPmwBpT+8pB1ACpHcWcKB52g/Njf2wQoK16O8XE8zw4Xrs8IDAAAAAAAAEEAKAACAPwAAgD8AAIA/CgAAAAAAAAAAAAAAACEHR2FzbWFzawSMAA8IEAgGISEhAwAAAAAAgJhAChSuB8CambXCcT3y'
..'QArkmFzC8PjyPuQq9sEKClfdwsN1r8JxPc7CCn8YmD/c/0Y/oeYcPyEWcmJ4YXNzZXRpZDovLzg1NjAwOTg1NQqccJRBYDdCQS4hGUEhBmNhbWVyYQSUABEIEggKXI9HQilcM8OFazLDCh3sWcLAv7Q/3/LwwQopHAJDhevRvh+Fiz8KK/cfP6pxpz6dFYo+IRdyYnhhc3NldGlkOi8vNDI1OTg5OTIyMAqZUXVC0GQAQjbD00EhF3JieGFzc2V0aWQ6Ly80MjU5OTAyODc3BJwAEwgUCAofhTbCFK6/wrgelUAKNcpdwsC6nT8GW/bB'
..'IQtSZWZsZWN0YW5jZQMAAACgmZnhPwopXL/C7FEwwsP1usIKYcbAP90AUj9Ucy0/AwAAAEAzM+M/IRdyYnhhc3NldGlkOi8vNDA2NzQ0MzEwOQphxsA/bACJP1RzLT8EpwAVCBYIAwAAAAAAAHFACrgeQMKk8LnC9ig8QAqEF1zC4Cy1PzJR9sEKCle5wpqZJ8KaGbbCCoXv1T/wvqU+lHCJPyEXcmJ4YXNzZXRpZDovLzQwNjc0NDQxMDQKhe/VP/C+pT68zJg/IQdIRUxTVEFSBK8AFwgYCApmZpRCSOHBQpqZAUEK5xJZwjzh2j9o'
..'JvbBCoXrt0JI4XpBUjiywgqMBo0+2kcCP0gPqz4KdpnGPWExwD34H4A8CkC/WcL39+o/Jwb2wQpSYbM8UmGzPFJhszwKqbpZwi0/6T+7HvbBAwAAAAAAAAhACsOAozzFgKM8rRCPPQq8DVjCDt3YP+Aj9sEK9igMwEghM0O4Hv1ACsOAIzwoQfU8xoAjPQoQ8lnCYyHkPzQj9sEK9igMwEghM0PXoxdCIQlXZWRnZVBhcnQKw4AjPMWAIz0qQfU8ClDlWcIG9uY/8j72wQr2KAxAUrhev9ejF8IKx+VZwoTQ5j+vAfbBCqoQjz32YEw9'
..'xoAjPQq431nCKPvrPwUd9sEKd/5ZwhUk5z+9cvbBCrT/WcIQwOY/X8/1wQolQfU8xoAjPcaAoz0K++xZwlDN5T97NvbBCiVBdT3GgKM9xoAjPQqbBFrCue3iP67S9cEKXgNawr5R4z8LdvbBCsOAIzwpQXU9KkF1PQqu+VnCLL3jP6wj9sEKQVXlPRHpWj4RXRw+CrgUWMJtrdw/zUX3wQoUGVjCbE3bP94G9cEKSjaxPhHpWj7uors+CrX0WMJu5d8/n0H2wQpGVeU9EelaPhNdHD4KnNtZwsVe5D+X//bBCu3eWcLxUuM/JUr1wQpM'
..'bgU9bnxQPeDJpj0KX+JYwnqG6T/gdPXBCk1uBT1sfFA938mmPQowf1jC8ennP9py9cEK9igMwEghM0P2KMRACkxuBT1tfFA94MmmPQoVTFnC9P3qPy939cEKzC76PPcu+j3myaY9CrHiWMJWWuo/xDH3wQofhYdB7BEuw5qZGUEKyS76PPYu+j3nyaY9Ci56WMLsxeg/3jv3wQopXI1BFC4zwz0K50AKLUlZwiNB7D8JI/fBCtUu+jz0Lvo948mmPQp+B1jCLAfnPynZ9sEKj8LLQXG9AENcj0K/Cs4u+jzzLvo958mmPQoDsVnCJLvt'
..'P74P98EKzczEQUhhIcP2KHBBCtTJJj4hHBY+9MmmPQrWGljC9lLmP3Pr9MEKAADKwXuUGcNIoS7DCtLJJj4nHBY+8MmmPQokz1nC8mbsP78z9cEKcT0FwrieHEPs0S/DCtTJJj4VHBY+AsqmPQrHL1jC0ePfP7gl9cEKUrggwtdjG8PXoy3DCubJJj4xHBY+08mmPQrNAVrCiPbuPz9j9cEKH4WVwQCA8UJm5ijDCubJJj4mHBY+38mmPQqc4VnChR3nP3Or9cEKZmYswjOz5EKuhyXDCt7JJj4lHBY+6cmmPQou0lnCY7LmP2qM9cEK'
..'pHA3wmYmA0NSuCjDCtzJJj4oHBY+58mmPQqbA1jCgAjoP9YK9cEKrkeFwYUrBMNmJjHDCtnJJj4pHBY+6cmmPQp6SFjCDc3hP2gC98EKmpkWwmZmcsHskSlDCtHJJj4dHBY+/cmmPQriQ1jCuiTgP6IT9cEKmpkawhQuK8NSOCzDCtTJJj4qHBY+68mmPQpJFljCkTPoPybg9MEK16N0wSmcGMNS+C7DCtnJJj4zHBY+48mmPQqgMFjCl0HqP9lF98EKFK5PwTMzncHNjCtDCtHJJj4sHBY+7cmmPQoyM1jCnpHoPzvH9MEKrkddwc3M'
..'J8MAwC3DCt7JJj4sHBY+4cmmPQrs51nCapfsP/lF9cEKzcz4wT2KBkMK1yrDCuTJJj4mHBY+5MmmPQokCFjCH3vnPwf99sEKKVzZwWZmWMKFay5DCtzJJj4hHBY+8smmPQqyCVjCJyzmP6sT9cEKMzPVwVK4BMOk8DDDCtnJJj4uHBY+5cmmPQoTNVjCxVvoP0c798EKw/W2weF6kMHNDCtDCt7JJj4vHBY+38mmPQof7FnCmFruP0I29cEKFK6pwXE9CEOamSvDCtHJJj4lHBY+88mmPQpdNljCcazmP5rT9MEK9ii+wXH9KMMpXC3D'
..'CuTJJj4rHBY+38mmPQoNAVjCslPpP0sD98EKFK6JwaRwXMJczy5DCuDJJj4iHBY+78mmPQr3OFjC9n/hPwf79sEKFK4hws3MD8JSOCtDCuDJJj4qHBY+5smmPQqVHFjC0uHnP9Uo98EKXI/MwQrXGcKamSxDCtzJJj4SHBY+/smmPQrtJljC49PfP6lA9cEK4Xomwq7HBcMKVzDDCuDJJj4vHBY+4MmmPQp2FljCRr/pP1Yx98EKcT16wfYoH8LsES1DCtLJJj4sHBY+6cmmPQqm0VnCziPuPwMi9cEK16O6wfZoHUOkMDDDCubJJj4u'
..'HBY+2MmmPQqe/FnCrCvtP8Zw9cEKhevjwdcj7UIfBSjDCuTJJj4aHBY+88mmPQq6KVjCajPhP0Tb9sEKKVwowpqZUMJcTy1DCt3JJj44HBY+0smmPQoW41nCIM/nP9mK9sEKFK4lwh+FbkKuRyxDCtbJJj4/HBY+08mmPQoi71nCO8rtPz7p9sEKmpnhwXE9EUL2aDBDCt3JJj5AHBY+ycmmPQpLA1rCjPvvPxLJ9sEKUriEwYXrYELD9S1DCt3JJj5CHBY+zcmmPQoS/lnCESHuP+299sEKcT3UwZqZZUKuhy1DCs/JJj4/HBY+2smm'
..'PQpk11nCxXXvPwoW98EK9iiWwdejoEEfBTNDCtbJJj4/HBY+1cmmPQrz8lnCsJ/vPyj39sEKFK6RwZqZDkKFqzBDCuXUWcIDou0/xAb3wQr2KObBcT2iQaTwMkMKTAN2PjYcFj7iyaY9Ck+jWcKsX+c/SNj2wQp7FC/CrkelQcO1MkMKbGOEPiAcFj74yaY9CtuUWcJ2ROY/3WH1wQo9CkHCAAAbQwDALsMK1skmPjocFj7ZyaY9CrbbWcI8k+c/SKf2wQrXoyzC7FEWQvaoL0MKzMkmPkuBaT1Z9ao+ChNIWMK6yeA/yef1wQr2KAxA'
..'hevRv0jhK8MKz8kmPkaBaT1Z9ao+CvYoDECF69G/uB4yQwrcySY+6iAvPYxEfD4KUK5ZwkFr5z8l8vXBCvYoDECF69G/uB4jQwruySY+1yAvPYxEfD4K9igMQIXr0b+4HhRDCrAuJD+OVeU93E2CPgpwx1jCTajmP9tO98EK16OMwoXrHkPhuhrDCrAuJD+TVeU92k2CPgpMzFjCMnjhPxQg98EKPQpmwjOzKUPheiTDCrAuJD+hVeU90U2CPgoK1yjCXE8vQ1zPKMMKsC4kP8RV5T2+TYI+CtLOWMLQ990/g+L2wQp7FErBcf0yw66H'
..'K8MKuS4kP79V5T3cTYI+CrfSWMJoL+U/Ldj0wQoAgIbCUri+QPaoJUMKuS4kP89V5T3STYI+CjXTWMLqMOA/+Az1wQrXo1fCKVyPPtejKkMKuS4kP+NV5T3HTYI+CmZmGcL2KDzA4fosQwq5LiQ/8VXlPb9Ngj4KiNFYwvf03D9HTvXBCtejCMEpXM/ApHAuQwr/6Fo+/MmmPbwPxj4KqPNXwkPe5D8RPPbBCvYoDMApXDJDMzMCQwoa6Vo+6cmmPbwPxj4KO85XwlyT6T8NN/bBCvYoDMApXDJD9qjkQgrh6Fo+FcqmPbwPxj4KFDNY'
..'wqdE3z8hQ/bBCvYoDMApXDJDFK4gQwrq6Fo+DMqmPbwPxj4K9igMwClcMkP2aBJDCuPoWj4SyqY9vA/GPgphcVjC/NHdP5VH9sEK9igMwClcMkMU7jJDCjrpWj7VyaY9vA/GPgo++1nCh7PsPw1V9sEK9igMQIXr0b9I4ehCCj/pWj7SyaY9vA/GPgq5FlrCImPyPyZT9sEK9igMQIXr0b/XI8lCChPpWj7zyaY9vA/GPgowyFnCIGDlP5pW9sEK9igMQIXr0b+F6xJDCifpWj7jyaY9vA/GPgr2KAxAhevRv2amBEMK+OhaPgnKpj28'
..'D8Y+CmSOWcLyHeI/SVX2wQr2KAxAhevRv4UrJUMKEEbLPtVV5T6/Lvo9CvU9WsJikfY/76b2wQpSuObApHDewgDAM8MKC0bLPtNV5T7DLvo9Clg9WsLLKvY/cRD2wQoK19vAj8K2ws3MMUMKAUbLPtVV5T7RLvo9CuIzWsL8iPU/5lP1wQqPwq3AM7OHwnE9L0MKUG4FPs7wkT2DR5o+Cm4TWcIjfus/O5n1wQrXo+DAXI+/wntUMkMKT24FPs7wkT08XZw+Cq4PWcJUG+w/ypr2wQp7FNbAw/WtwnsULsAKzvCRPTjCbz4nwm8+Cpes'
..'WcJpI+4/7CH2wQoK19vAj8K2wpqZr0IKCIQHPs7wkT1Puow+CgLoWMK1LOs/ehj2wQrO8JE99CaXPuTajz4Kcn1YwmqR6T9aE/bBCgtGyz7JVeU+wS76PQrgu1fCIH/sP5jx9cEKBUbLPsxV5T7JLvo9CgvEV8I8HO0/iK72wQquR8HAFK6Xwj0KMEMKDkbLPsxV5T68Lvo9Ct/CV8KtTew/KX/1wQo9CufA7NHawlL4M8MKDkbLPtVV5T7ALvo9Cgk5WsJ28/o/dKP2wQoHRss+01XlPsUu+j0KbDhawt+M+j/2DPbBCgFGyz7VVeU+'
..'0C76PQr2LlrCEOv5P2tQ9cEKT24FPs7wkT2DR5o+CoIOWcI34O8/wJX1wQpMbgU+zvCRPT1dnD4KwgpZwmh98D9Pl/bBCs7wkT02wm8+KcJvPgqrp1nCfYXyP3Ee9sEKBoQHPs7wkT1Puow+ChbjWMLJju8//xT2wQrO8JE98iaXPuXajz4KhnhYwn7z7T/fD/bBCgZGyz7JVeU+wi76PQr0tlfCNOHwPx3u9cEKAEbLPsxV5T7KLvo9Ch+/V8JQfvE/Dav2wQoKRss+zFXlPrwu+j0K871XwsGv8D+ue/XBCsou+jzzLvo96cmmPQrH'
..'6ljCJwzpP1f89MEKFK7RQVK4JsHNzClDCs0u+jz0Lvo96MmmPQqNUFnCzS7rP7cT9cEKyi76PPEu+j3oyaY9CtCCWMI7V+c/6eD0wQqF69dBzcycwK5HLEMKyy76PPMu+j3oyaY9Cp63WcKp3+w/CC/1wQrsUcBBFK6pwcM1JUMK0i76PPsu+j3hyaY9CugBWMJ8VuY/mi71wQozM4lBCtcxQoXrL0MKyC76PPEu+j3hyaY9Cm/xWMKsIOQ/tf70wQqPwpHBSOFKwPYoLkMKyC76PPAu+j3iyaY9CmKJWMLxU+I/ie30wQpI4YzBSOH6'
..'P8O1K0MKyS76PPAu+j3hyaY9ChxYWcLOjOU/YhT1wQrNLvo87i76Pd/Jpj0KXBVYwrFS4D9rSPXBCoXrXcHhelJCAIApQwrKLvo87C76PePJpj0KJb9ZwrNs5z+yLvXBCuxR5sF7FFbBSCEzQwrPySY+HxwWPvDJpj0KcB5Ywp1v4T8dN/fBCnsUjkEUrgXCpHAFwQrOySY+JRwWPuzJpj0KqtFZwgJ+6T9iDPfBCtejFkLXozRBPQpTwQrPySY+FBwWPv3Jpj0KgyZYwrtY6D8B/vbBCuxRAkKF6w/CPQoXwQriySY+LhwWPs/Jpj0K'
..'oghawgOm6D9q4PbBCo/C90EK11VC16MAQAriySY+IhwWPtzJpj0KtdpZwtI87z/ClfbBCs3MX0KF61tCuB5FQAraySY+IhwWPuXJpj0KbspZwowj7z+5s/bBCuxRXkLsUQRCUrjOwArWySY+JxwWPuPJpj0K/wtYwv0N3z9DFvfBCpqZqUDhek7CrkfZwArVySY+JhwWPubJpj0KLEpYwrZ25z9UI/XBCqRwA0IK1xzDPQrXQArMySY+GxwWPvrJpj0KKTpYwku86D9xEffBChSuCkKkcKvBCtcfwQrPySY+KBwWPujJpj0Krx1YwrF4'
..'3z8vQvfBCh+F+0AUrv/B7FEAwQrVySY+MBwWPt/Jpj0KfUVYwpeN3j+w3vTBCgAAAEEzsx/DZma2QArMySY+KRwWPunJpj0K9TlYwkUH4D8LXffBCh+FH0GuR4nBrkcFwQraySY+KRwWPt3Jpj0KTepZwhob6j/W+/bBCpqZIkK4Hg1CheuZwArfySY+JBwWPt/Jpj0KgBdYwkjr3z+iJPXBCoXrcUEAAPnCFK5nQArWySY+HRwWPu3Jpj0KOw5YwiAN4T/EDffBChSuc0EpXFPCAADgwArVySY+KxwWPuHJpj0KvkVYwqSG4D936fTB'
..'CpqZj0H2qB7Dj8K9QAraySY+LBwWPtrJpj0KsvFZwp2H6D/mC/fBCqRw9UEAABFCFK6HwArMySY+IxwWPu/Jpj0KWzlYwm334T/PUPfBCkjhnkGamZXBFK4LwQrfySY+KxwWPtvJpj0KhRRYwhTp3T/5HfXBCuF6pECPQvrC16NgQArcySY+HhwWPurJpj0KcjpYwv5B5z+nKfXBCkjh+EHXownDuB6tQArcySY+JhwWPuLJpj0KzCxYwvYy4D8++vTBCilcgUGaGQvDcT2aQArWySY+DhwWPvnJpj0KRx5Ywnwi6D984vbBCs3M8EFS'
..'uFvCcT36wArcySY+KxwWPtzJpj0K1CpYwic03j9p8fTBCmZmxkCk8AvDuB6VQArOySY+KhwWPubJpj0KV9dZwqbi5z9ZHvfBCrge30GPwl1Bzcw8wQriySY+KxwWPtTJpj0KMQBawrY46j950vbBCgrXI0JSuFdChesRQArfySY+FxwWPu7Jpj0KlSpYwqMM5z9cSPXBClK48EEK1/bCrkeBQArZySY+NBwWPs/Jpj0KP+FZwnKy7j+dtvXBCvYoV0Ip3P5CCteLQArSySY+PBwWPtHJpj0KqPpZwlBV6T9WWfXBCs3MEUJ7lBVDMzMv'
..'QQrZySY+PBwWPsXJpj0KFBJawvjX5z/wevXBClK45kHXo/pCzcw8QArZySY+PRwWPsrJpj0KEQlawhN36T+mhfXBCuxRG0LD9ftCCtdTQArMySY+OxwWPtfJpj0K3OdZwnL65j8MK/XBCuxRvEEUbiND4XpgQQrSySY+PBwWPtLJpj0KUQJawtiv5z/ES/XBCsP11EHDdRNDpHAdQQrMySY+OhwWPtjJpj0KeOFZwu6o6D8ROvXBCgrXBEJcTyZDZmZ2QQpHA3Y+MhwWPt/Jpj0KA6RZwj0d7T/uZPXBCjMzPkL2KCxDj8KZQQpoY4Q+'
..'HhwWPvTJpj0Kl41ZwmiV7T8e2vbBCpqZUELsUbhAPQqJwQrSySY+NhwWPtfJpj0KHdpZwuSy7j+xmfXBCqRwTELsERpDpHBhQQrJySY+R4FpPVH1qj4KCkNYwjlT6D+5PfbBCvYoDMBIITNDrke3QQrMySY+QoFpPVH1qj4K9igMwEghM0Ncj05BCtrJJj7kIC89g0R8PgrsqlnC1lXtP65L9sEK9igMwEghM0OPwgXACuzJJj7RIC89g0R8Pgr2KAzASCEzQ1K4iMEKri4kP4pV5T3XTYI+CgrQWMLW1+Y/p9/0wQqF64tCpHC3wRSu'
..'mcEKri4kP5FV5T3UTYI+Cl/JWMIw/+s/gQ71wQpxPWNCzcxswXE9PsEKri4kP55V5T3MTYI+CmZmJULheijBcT0KwQquLiQ/v1XlPbpNgj4Kp8NYwqlw7z8OTPXBCo/COUHhesTAH4XTwAq3LiQ/tVXlPdlNgj4Kfc1Ywg9k6D+pVvfBCqRwgUKuhxrDheuvQQq3LiQ/xFXlPc5Ngj4KpsRYwlZB7T+4IffBCnsUT0JSuCLDFK5vQQq3LiQ/2VXlPcNNgj4KSOERQsO1J8MfhTdBCrcuJD/oVeU9uk2CPgqDvVjCd1rwPzLg9sEKZmbe'
..'QMN1LcPsURRBCv3oWj76yaY9tA/GPgot+1fCdbjhPwDk9cEK9igMQFK4Xr8ULoHCChTpWj7oyaY9tA/GPgqI4FfCWvnbP7Xm9cEK9igMQFK4Xr+F66DCCuLoWj4RyqY9tA/GPgooLVjCzijpP/Xg9cEK9igMQFK4Xr+kcAjCCunoWj4JyqY9tA/GPgr2KAxAUrhev+F6QcIK5OhaPg/Kpj20D8Y+CntmWML+i+w/n+D1wQr2KAxAUrhev4/CfcEKN+laPtXJpj20D8Y+Cq8BWsJvt+o/Nu71wQr2KAzASCEzQ3sUQ8IKPOlaPtLJpj20'
..'D8Y+CtAnWsIKGOY/M/L1wQr2KAzASCEzQ81MgcIKEulaPvLJpj20D8Y+Cm3BWcJnLPA/7Oj1wQr2KAzASCEzQ2ZmksEKJelaPuLJpj20D8Y+CvYoDMBIITNDcT0Cwgr36Fo+B8qmPbQPxj4K54JZwkN78T865vXBCvYoDMBIITNDCtcjvQoJRss+0FXlPrwu+j0KpFdawk5V4z9GofXBCnsU1sAAgI3CAACYwAoCRss+zVXlPsUu+j0KvVNawh+l4z+fN/bBCs3M/MC4HrXCpHANwAr7Rcs+0FXlPs8u+j0KLkZawlvi4z9l8/bBCnsU'
..'AsHDdeTC16OQPwpMbgU+y/CRPYNHmj4KFxxZwjJt5D9TmvbBClK49sDsUazCCtczwApLbgU+y/CRPTxdnD4K+x1ZwizP4z+vmPXBCs3MAMHD9b3CZmYyQwrL8JE9MMJvPifCbz4KwrdZwhLN5j8ZHPbBCs3M/MC4HrXChWu4wgoEhAc+y/CRPVC6jD4KlvNYwsdl4z86GPbBCsvwkT3vJpc+5NqPPgo+iVjCe43hPyIW9sEKAEbLPsVV5T7CLvo9CpnTV8Liidg/Aiv2wQr7Rcs+yVXlPsku+j0K399XwqhG2D/BbvXBCjMzA8EpXNTC'
..'CtcjvAoHRss+yVXlProu+j0KEthXwtnn2D/XnfbBCkjh2sCaGZHCrkeRwArGW1rC3u/eP52k9cEK31dawq8/3z/2OvbBClBKWsLrfN8/vPb2wQo5IFnCwgfgP6qd9sEKHSJZwrxp3z8GnPXBCuS7WcKiZ+I/cB/2wQq491jCVwDfP5Eb9sEKYI1Ywgso3T95GfbBCrvXV8JyJNQ/WS72wQoB5FfCOOHTPxhy9cEKNNxXwmmC1D8uofbBCsgu+jztLvo948mmPQo67VjC0G/lP0w098EKUrjcwa4HM8OF68lACsou+jzuLvo948mmPQpR'
..'VFnC4Z/mP9sj98EKyS76POsu+j3jyaY9CtKEWMJZw+M/qkj3wQqkcNfB12MvQ4XrDUEKyS76PO4u+j3kyaY9CtK7WcLtSOg/iQ/3wQqF6+HB4bonw65HgT8KzS76PPUu+j3dyaY9Cn0HWMI6p+A/VfL2wQpI4crAcX0DQylcx0AK8UTHPg7R4D4jQfU9Cl9aWsLbptU/BrT1wQrxRMc+DNHgPiFB9T0Ki1Zawhn11T9oR/bBCvFExz4O0eA+JUH1PQpBSVrCHzHWP3z/9sEKbc0CPq0Qjz2DPZc+CgolWcIzudY/K6j2wQptzQI+rRCP'
..'PbdImT4K5CZZwkwe1j+aq/XBCq0Qjz0iCWs+GQlrPgqkvVnCHQ3ZP20s9sEKodgEPq0Qjz2m9Ik+ClX9WML5ttU/oij2wQqtEI89tCyUPnUFjT4KFpVYwvnn0z+UJvbBCvBExz4D0eA+IUH1PQoF41fC0xHLPws79sEK8ETHPgXR4D4iQfU9Cg3vV8Lsz8o/f4L1wQpn51fC8G3LP52r9sEKFZkTPpTWBD4umZM9CvA4WMLdCuA/thb3wQoQmRM+nNYEPimZkz0KF7pZwvsr5z/m8PbBChWZEz6K1gQ+OZmTPQoWQFjCcCjmPyzk9sEK'
..'IZkTPqTWBD4SmZM9CrzqWcLZbOY//sn2wQohmRM+odYEPhSZkz0KGMJZwpVB7D/sh/bBChmZEz6g1gQ+HpmTPQqws1nCNivsP3Gi9sEKG5kTPpnWBD4imZM9Cp4oWMJk790/o/n2wQoXmRM+pdYEPhuZkz0KpF9Ywohg5T8dQPXBChKZEz6R1gQ+NZmTPQp5UVjCi4DmP2D19sEKFZkTPpvWBD4mmZM9CkU4WMLOTd4/gSD3wQoXmRM+ptYEPh6Zkz0KgFtYwuN93T9eA/XBChKZEz6d1gQ+KJmTPQpLUVjC+cveP0Y498EKGZkTPqHW'
..'BD4cmZM9CuTPWcIAt+c/QeL2wQoemRM+ndYEPiGZkz0KzTJYwlSz3j9EQfXBChuZEz6R1gQ+LJmTPQqZKljCt7PfPx7y9sEKuVtYwtM83z/oDPXBChmZEz6i1gQ+G5mTPQpw1lnC8FHmP3nw9sEKEpkTPpbWBD4umZM9CsNQWMILg+A/ci33wQoemRM+oNYEPh6Zkz0KKTBYwkrs3D9fO/XBChuZEz6d1gQ+I5mTPQq6UVjC4DHlP7VF9cEKG5kTPp/WBD4gmZM9CqZFWMLG8t4/wBv1wQobmRM+hdYEPjaZkz0KzDhYwnH45T/Sy/bB'
..'ChuZEz6i1gQ+HZmTPQrnQ1jCvC7dP+8T9cEKEJkTPp/WBD4mmZM9Ch2/WcLyv+U/zAD3wQohmRM+pNYEPhSZkz0KRONZwjbR5z+nvfbBCh6ZEz6V1gQ+KJmTPQqwQ1jCpgLlP+Jg9cEKHJkTPrXWBD4CmZM9CuHHWcIux+s/dcL1wQoXmRM+uNYEPgaZkz0KXt5ZwhAI5z/pb/XBChyZEz621gQ+AJmTPQoY81nClrblP6WN9cEKHJkTPrrWBD4BmZM9Ch7rWcLuJec/H5f1wQoRmRM+tNYEPg6Zkz0Ku81ZwpHy5D/yRvXBCheZEz61'
..'1gQ+CZmTPQol5VnCFpPlP+Zj9cEKEZkTPrfWBD4MmZM9ChTIWcKFb+Y/PFT1wQpI4QRCXE8mQ2ZmdkEKAbVZPrPWBD4OmZM9CrCRWcKcYOo/K3r1wQrTT2o+mdYEPi2Zkz0K2X1Zwt/K6j9rxPbBCheZEz621gQ+B5mTPQqRwVnClcfrP9yo9cEKAZkTPlmjTj2/SZc+CipZWMIYMOY/Lzr2wQoJmRM+TqNOPb9Jlz4KGpkTPmz6Gj37PV8+CqWXWcIYn+o/ikb2wQosmRM+WfoaPfs9Xz4KrkoRP3nyyj1xn2Y+CvHVWMJl4OQ/ZAT1'
..'wQquShE/dvLKPXKfZj4KC9BYwvFv6T/bLfXBCq5KET9+8so9ap9mPgquShE/m/LKPUifZj4K+8pYwvt77D9TZPXBCrZKET+u8so9Zp9mPgqv01jC8D7mP80y98EKtkoRP7vyyj1Wn2Y+Ct3LWMLxjOo/9AP3wQq4Hk9CUrgiwxSub0EKtkoRP8fyyj1Kn2Y+CozFWMLTSu0/+Mn2wQrmuEE+OJmTPdNFrz4KkxlYwuJX4D/J6vXBCv64QT4omZM900WvPgr+AVjCDELbPy7t9cEK1bhBPkiZkz3TRa8+Cs1FWMId7eY/GOj1wQrXuEE+'
..'RZmTPdNFrz4K37hBPj+Zkz3TRa8+Coh4WMKE7Ok/zOf1wQoxuUE+BZmTPdNFrz4Ka+RZwtdN6D/U8/XBCi65QT4ImZM900WvPgopBlrCmjbkP1v39cEKE7lBPhqZkz3TRa8+Co+rWcIUIu0/Ju/1wQoluUE+DZmTPdNFrz4K+LhBPjGZkz3TRa8+Cjp0WcJqSu4/w+z1wQqj4rM+r/LKPpRl3T0KfjBawjHF4T+9r/XBCprisz6t8so+nGXdPQoKLVrCzQviP8k09sEKj+KzPq/yyj6sZd09CgshWsL2QeI/9dr2wQozKOw9EiaBPTKH'
..'iD4KQBlZwt284j8ijPbBCi4o7D0SJoE9g1+KPgrsGlnCETHiPyOo9cEKEiaBPR8sVD4LLFQ+CgKjWcLO1uQ/bxz2wQrR2O89EiaBPVESeT4KaPVYwsjT4T8BGfbBChImgT3DwoU+P5t+PgpNl1jC1jHgPyYX9sEKl+KzPqbyyj6ZZd09Co72V8LDN9g/nyn2wQqQ4rM+qPLKPqNl3T0KagFYwkz81z8Hg/XBCqDisz6o8so+kmXdPQqD+lfC5orYPz6P9sEKpOKzPq/yyj6TZd09CiY0WsI/4d0/sbL1wQqb4rM+rfLKPpxl3T0KsjBa'
..'wtsn3j+9N/bBCpDisz6v8so+rWXdPQqzJFrCBF7eP+nd9sEKNSjsPRImgT0xh4g+CugcWcLr2N4/Fo/2wQoxKOw9EiaBPYNfij4KlB5Zwh9N3j8Xq/XBCqqmWcLc8uA/Yx/2wQrT2O89EiaBPVESeT4KEPlYwtbv3T/1G/bBCvWaWMLkTdw/Ghr2wQqZ4rM+pvLKPpll3T0KNvpXwtJT1D+TLPbBCpPisz6o8so+pGXdPQoSBVjCWxjUP/uF9cEKoeKzPqjyyj6SZd09Civ+V8L1ptQ/MpL2wQqC2AQ/TNHgPacQjz4KExJZwjyp4j+P'
..'A/bBChWZEz6U1gQ+LJmTPQr6OVjCho3fPzMZ98EKD5kTPp3WBD4pmZM9CiG7WcKkruY/ZPP2wQoVmRM+itYEPjeZkz0KIEFYwhmr5T+q5vbBCh6ZEz6k1gQ+EpmTPQrG61nCgu/lP3zM9sEKHpkTPqLWBD4UmZM9CiLDWcI+xOs/aor2wQoYmRM+oNYEPh6Zkz0KurRZwt+t6z/vpPbBChuZEz6Z1gQ+IZmTPQqoKVjCDXLdPyH89sEKFZkTPqTWBD4bmZM9Cq5gWMIx4+Q/m0L1wQoRmRM+kdYEPjSZkz0Kg1JYwjQD5j/d9/bBChWZ'
..'Ez6b1gQ+JJmTPQpPOVjCd9DdP/8i98EKFZkTPqXWBD4dmZM9CopcWMKMAN0/3AX1wQoRmRM+ndYEPiWZkz0KVVJYwqJO3j/EOvfBChiZEz6i1gQ+HJmTPQru0FnCqTnnP7/k9sEKG5kTPpzWBD4hmZM9CtczWML9Nd4/wkP1wQobmRM+kdYEPiuZkz0KoytYwmA23z+c9PbBCsNcWMJ8v94/Zg/1wQoYmRM+otYEPhuZkz0KetdZwpnU5T/38vbBChGZEz6W1gQ+LJmTPQrNUVjCtAXgP/Av98EKG5kTPqDWBD4emZM9CjMxWML0btw/'
..'3T31wQoZmRM+ndYEPiOZkz0KxFJYwom05D8zSPXBChmZEz6g1gQ+IZmTPQqwRljCbnXePz4e9cEKG5kTPobWBD40mZM9CtY5WMIae+U/UM72wQoZmRM+otYEPh2Zkz0K8URYwmWx3D9tFvXBCg+ZEz6g1gQ+JZmTPQonwFnCm0LlP0oD98EKHpkTPqTWBD4TmZM9Ck7kWcLfU+c/JcD2wQobmRM+ldYEPiiZkz0KukRYwk+F5D9gY/XBChyZEz6z1gQ+ApmTPQrryFnC10nrP/PE9cEKGJkTPrbWBD4FmZM9CmjfWcK5iuY/Z3L1wQoc'
..'mRM+tNYEPgCZkz0KIvRZwj855T8jkPXBChyZEz651gQ+AJmTPQoo7FnCl6jmP52Z9cEKEZkTPrPWBD4NmZM9CsXOWcI6deQ/cEn1wQoYmRM+tNYEPgiZkz0KL+ZZwr8V5T9kZvXBChGZEz621gQ+DJmTPQoeyVnCLvLlP7pW9cEKAbVZPrLWBD4OmZM9CrqSWcJF4+k/qXz1wQrST2o+mtYEPiuZkz0K435ZwohN6j/pxvbBChiZEz611gQ+BpmTPQqbwlnCPkrrP1ur9cEKNFpYwsGy5T+tPPbBCgmZEz5No049v0mXPgoamRM+bPoa'
..'Pfk9Xz4Kr5hZwsEh6j8ISfbBCiyZEz5Z+ho9+T1fPgquShE/efLKPXCfZj4K+9ZYwg5j5D/iBvXBCq5KET938so9cJ9mPgoV0VjCmvLoP1kw9cEKrkoRP37yyj1pn2Y+Cq5KET+c8so9SJ9mPgoFzFjCpP7rP9Fm9cEKtkoRP6zyyj1nn2Y+CrnUWMKZweU/SzX3wQq2ShE/ufLKPVafZj4K58xYwpoP6j9yBvfBCrZKET/G8so9SZ9mPgq2ShE/x/LKPUifZj4KlsZYwnzN7D92zPbBCue4QT44mZM90EWvPgqdGljCi9rfP0ft9cEK'
..'ALlBPieZkz3QRa8+CggDWMK1xNo/rO/1wQrUuEE+SJmTPdBFrz4K10ZYwsZv5j+W6vXBCta4QT5EmZM90EWvPgrfuEE+P5mTPdBFrz4KknlYwi5v6T9K6vXBCjC5QT4GmZM90EWvPgp15VnCgNDnP1L29cEKLrlBPgmZkz3QRa8+CjMHWsJDueM/2fn1wQoTuUE+G5mTPdBFrz4KmaxZwr2k7D+k8fXBCiW5QT4NmZM90EWvPgr4uEE+MZmTPdBFrz4KRHVZwhPN7T9B7/XBCp7isz6v8so+kmXdPQqIMVrC2kfhPzuy9cEKluKzPq3y'
..'yj6cZd09ChQuWsJ2juE/Rzf2wQqL4rM+r/LKPqpl3T0KFSJawp/E4T9z3fbBCi0o7D0SJoE9MYeIPgpKGlnChj/iP6CO9sEKKSjsPRImgT2CX4o+CvYbWcK6s+E/oar1wQoSJoE9GSxUPgssVD4KDKRZwnZZ5D/tHvbBCsvY7z0SJoE9URJ5Pgpy9ljCcVbhP38b9sEKEiaBPb/ChT4/m34+CleYWMJ/tN8/pBn2wQqU4rM+pvLKPpll3T0KmPdXwm261z8dLPbBCo3isz6o8so+o2XdPQp0AljC9n7XP4WF9cEKnOKzPqjyyj6RZd09'
..'Co37V8KQDdg/vJH2wQqh4rM+r/LKPpJl3T0KMDVawuhj3T8vtfXBCpfisz6t8so+nGXdPQq8MVrChKrdPzs69sEKi+KzPq/yyj6sZd09Cr0lWsKt4N0/Z+D2wQowKOw9EiaBPTGHiD4K8h1ZwpRb3j+UkfbBCioo7D0SJoE9g1+KPgqeH1nCyM/dP5Wt9cEKEiaBPRssVD4LLFQ+CrSnWcKEdeA/4SH2wQrM2O89EiaBPVESeT4KGvpYwn9y3T9zHvbBChImgT3AwoU+P5t+Pgr/m1jCjdDbP5gc9sEKleKzPqbyyj6ZZd09CkD7V8J7'
..'1tM/ES/2wQqO4rM+qPLKPqRl3T0KHAZYwgSb0z95iPXBCp3isz6o8so+kWXdPQo1/1fCninUP7CU9sEKeUoCP/KAIz4kNMQ9CuMbWcKOad4//eL2wQquR0HAj8Iuw/Yo9EAKgUoCP/KAIz4VNMQ9CoEbWcLXd90/YW/1wQrhetS/e1QvQ9ejAEEhCUhFTFNUQVJYTwQPBBkIGggK9iiOQdejBcKuRwXBCmETWcIMv90/1CP2wQoAAKhBPQr9wTMzQ0AKcaPYPgdyMz72S6o+CkSlCz6qXPs9T6WLPQoqRljCyGDfP6oO98EKKKULPs5c'
..'+z1YpYs9CpKyWcJQHeY/x+r2wQrXoxZCw/U0QUjhUsEKRKULPoRc+z1kpYs9Cu9MWMLwKeU/2N72wQopXAJCCtcPwkjhFsEKN6ULPudc+z09pYs9CpfgWcItaOU/9MX2wQoUrvdBhetVQq5HAUAKN6ULPuRc+z0+pYs9CiW6WcKv7Oo/dYf2wQqPwl9CAABcQo/CRUAKLqULPtlc+z1NpYs9CoSsWcKe1+o/jKD2wQrsUV5CZmYEQnsUzsAKTKULPsFc+z09pYs9Crg2WMJ0Yt0/KfP2wQqF66lApHBOwsP12MAKMaULPtdc+z1MpYs9'
..'CsJqWMJkbOQ/aFH1wQqkcANCCtccw1K41kAKPKULPplc+z1hpYs9CmJdWMI0feU/He/2wQoUrgpCKVyrwRSuH8EKRKULPsVc+z1BpYs9CohFWMK2u90/7xf3wQoK1/tAmpn/wfYoAMEKMaULPuBc+z1KpYs9CtJmWMKA9tw/8Rf1wQoAAABBM7Mfw3sUtkAKPKULPstc+z1GpYs9CjVdWMLzMt4/ai73wQoUrh9BMzOJwbgeBcEKLqULPuFc+z1JpYs9CjPHWcK1oOY/69z2wQpcjyJCMzMNQpqZmcAKMqULPsNc+z1ZpYs9ClJAWMKJ'
..'G94/hFL1wQp7FHJB4fr4wj0KZ0AKTKULPqRc+z1OpYs9Cpg4WMJlDt8/DOz2wQoK13NB7FFTwgAA4MAKMaULPt1c+z1KpYs9CglnWMJdnd4/9yD1wQqamY9B9qgew6RwvUAKZM1ZwtpO5T9e6vbBCqRw9UE9ChFCKVyHwAo8pQs+uFz7PVGliz0KtVxYwl3S3z8rJPfBCsP1nkEfhZXBH4ULwQoypQs+z1z7PVOliz0K0z1Ywgdt3D/xTPXBCs3MpEBxPfrCAABgQAovpQs+wFz7PVyliz0Kl11YwlVA5D+0VvXBCkjh+EHXownDzcys'
..'QAovpQs+zVz7PValiz0KJ1JYwm9X3j8EL/XBCilcgUEKFwvDheuZQApMpQs+eFz7PWOliz0KCUZYwo785D/Ox/bBCkjh8EEUrlvChev5wAovpQs+1Vz7PVGliz0KgFBYwsKr3D+fJ/XBClK4xkAU7gvDzcyUQAoopQs+11z7PVKliz0KU7dZwt/E5D/S+fbBCrge30GF611B16M8wQo3pQs+6Vz7PTyliz0KhtlZwmC55j9JuvbBCgrXI0KPwldCXI8SQAoypQs+rVz7PWWliz0KUFBYwr8T5D9scPXBCs3M8EHs0fbCw/WAQApMpQs+'
..'91z7PR2liz0Km79Zwrx46j+gzPXBCrgeV0Ip3P5CH4WLQApIpQs+CF37PRmliz0K3tRZwun65T+GfvXBCs3MEUJ7lBVDPQovQQpMpQs+CV37PRGliz0KeuhZwoS75D+nmvXBCtej5kH2qPpC9ig8QApMpQs+DV37PRSliz0K7+BZwh4X5j+eo/XBCq5HG0Lh+vtCCtdTQAo8pQs+BF37PSaliz0KH8VZwjwC5D/GV/XBCuxRvEEUbiND7FFgQQpIpQs+B137PRuliz0KR9tZwv2Z5D8pc/XBCkjh1EFSeBNDrkcdQQo8pQs+BV37PSel'
..'iz0Kxr9ZwrRq5T9ZZPXBCgrXBEJcTyZDcT12QQol+k0+8Vz7PTGliz0KVIxZwsMl6T9AiPXBCjMzPkJmJixDFK6ZQQrSr10+xVz7PV+liz0KlHlZwpeK6T+2wPbBCpqZUEKuR7lASOGIwQpIpQs+91z7PSSliz0KoblZwiN56j9qtPXBCmZmTELsERpDuB5hQQpLpQs+/4BDPQcjjz4KpmRYwucw5T8CPvbBCvYoDMDXIzNDMzO3QQpMpQs+AIFDPQcjjz4K9igMwNcjM0NmZk5BCkylCz6/oBI9yjZTPgr5kVnC+GDpP5tJ9sEK9igM'
..'wNcjM0NmZgbACvYoDMDXIzNDzcyIwQq4dgk/RwPAPT8yWj4KrdpYwnny4z/gGPXBCqTwi0IzM7fBH4WZwQq4dgk/RgPAPUEyWj4KG9VYwihD6D8bQPXBCq5HY0LsUWzBhes9wQq4dgk/RAPAPUEyWj4KZmYlQuxRKMGF6wnBCrh2CT9BA8A9RDJaPgpS0FjCOCXrP6Rz9cEKj8I5QfYoxMAzM9PACsN2CT9XA8A9UzJaPgqU2FjCXD7lPzMp98EKpHCBQj2KGsMUrq9BCi/RWMIEUek/3/z2wQq4Hk9C4boiwylcb0EKw3YJP1kDwD1R'
..'Mlo+CkjhEULDtSfDKVw3QQrDdgk/WgPAPVAyWj4KNctYwhfp6z8DxvbBCmZm3kAzcy3D9igUQQrySDc+T6WLPUjUpT4KdyhYwqOp3z/p8vXBCvYoDED2KFy/9iiBwgrxSDc+UKWLPUjUpT4KJhJYwhTa2j8v9fXBCvYoDED2KFy/Zuagwgr4SDc+TKWLPUjUpT4KUlJYwtHj5T9Z8PXBCvYoDED2KFy/ZmYIwgr1SDc+TaWLPUjUpT4K9igMQPYoXL+kcEHCCvtINz5LpYs9SNSlPgpSgljClrnoPw3w9cEK9igMQPYoXL+amX3BCvZI'
..'Nz5PpYs9SNSlPgqa2lnCOC/nP1b79cEK9igMwNcjM0O4HkPCCvRINz5RpYs9SNSlPgqF+lnCOFDjP6r+9cEK9igMwNcjM0PsUYHCCvlINz5LpYs9SNSlPgrPpFnCKcHrP+z29cEK9igMwNcjM0PhepLBCvdINz5MpYs9SNSlPgr2KAzA1yMzQ65HAsIKdnBZwtfZ7D+t9PXBCvYoDMDXIzNDzcxMvQpzMao+SQPAPvV30T0KjiJawj0A4T/muvXBCo/C1cDheo3CAACYwApwMao+SAPAPvd30T0KTB9awh5D4T/HOPbBCuF6/MC4HrXC'
..'pHANwApxMao+SQPAPvd30T0K9hNawn924T//1fbBCoXrAcGkcOTC16OQPwrfbt89Q2F0PR4sgT4KYBpZwjns4T9+i/bBCmZm9sDNTKzCCtczwArebt89Q2F0Pfvqgj4K8RtZwtpn4T/Js/XBCtejAMGk8L3CZmYyQwpDYXQ9nb1IPqK9SD4KtZxZwlvo4z/GIfbBCuF6/MC4HrXChWu4wgqZ7OI9Q2F0Pfimaz4KdPhYwtoP4T+UHvbBCkNhdD2VG30+kONwPgpqn1jC9ITfP9oc9sEKbTGqPkEDwD7zd9E9ClIHWMLS+dc/YS72wQpu'
..'Mao+QwPAPvR30T0KlhFYwm7B1z/BkPXBCj0KA8EKV9TCCtejvApvMao+QwPAPvJ30T0KEgtYwn9I2D+FjvbBClyP2sB7FJHCrkeRwApxMao+SQPAPvV30T0KAiZawvBR3T+xvfXBCm4xqj5IA8A+93fRPQrAIlrC0ZTdP5I79sEKahdawjLI3T/K2PbBCt5u3z1DYXQ9HiyBPgrUHVnC7D3eP0mO9sEKZR9Zwo253T+UtvXBCimgWcIOOuA/kST2wQqX7OI9Q2F0Pfimaz4K6PtYwo1h3T9fIfbBCt6iWMKn1ts/pR/2wQrGCljChUvU'
..'Pywx9sEKChVYwiET1D+Mk/XBCoYOWMIymtQ/UJH2wSEISEVMU1RBUlgE5QQbCBwICvYoDMDXIzNDzcz8QAprClnCpCvhP9og9sEDAAAAoJmZqT8KXM8xw/YoXD9IISzDCkPi/j4Kr9U98++MPgMAAAAAAADoPwodVeU9DOlaPvJcHD4KwxRYwkCr3D/rRffBChgZWMJSS9s//Qb1wQouNrE+DOlaPsiiuz4KvfRYwobi3z+zQfbBCiJV5T0M6Vo+9VwcPgqn21nCClvkP6H/9sEK895ZwkRP4z8vSvXBCjZuBT1qfFA9wMmmPQpm4ljC'
..'qoPpP/d09cEKNG4FPWd8UD3AyaY9CjZ/WMJ55+c/9nL1wQr2KAzA1yMzQ/YoxEAKNW4FPWl8UD3AyaY9Ch1MWcLH+uo/QXf1wQqdLvo86S76PcvJpj0KveJYwndX6j/bMffBCpqZh0HsES7DmpkZQQqdLvo86C76PczJpj0KO3pYwmjD6D/5O/fBCilcjUGFKzPDUrjmQAqdLvo86C76PcvJpj0KOklZwuo97D8bI/fBCqcu+jzmLvo9x8mmPQqJB1jCEgXnP0rZ9sEKnS76PN8u+j3PyaY9ChCxWcKQt+0/yw/3wQrNzMRBSGEhwwAA'
..'cEEKtMkmPhkcFj7VyaY9CtsaWMLfUOY/k+v0wQoAAMrB7JEZw9ejLsMKtckmPhwcFj7TyaY9CivPWcJVY+w/yzP1wQpxPQXCSKEcQ3vUL8MKtMkmPg0cFj7kyaY9CswvWMKl4d8/1yX1wQoUriDCSGEbw2amLcMKyckmPiYcFj63yaY9CtYBWsK88u4/SGP1wQqamZXBAIDxQmbmKMMKyckmPhMcFj7KyaY9CqThWcLTGec/fqv1wQqkcCzCUrjkQj2KJcMKwckmPhMcFj7TyaY9CjbSWcLAruY/doz1wQrhejfC9igDQ1K4KMMKvMkm'
..'Ph8cFj7JyaY9CqEDWMJ7Bug/9wr1wQquR4XB9igEw2YmMcMKu8kmPhUcFj7XyaY9CoVIWMK4yuE/hQL3wQqamRbCZmZywXuUKUMKsMkmPhMcFj7fyaY9CudDWMJ9IuA/wBP1wQqamRrChSsrw+E6LMMKtMkmPiAcFj7OyaY9Ck8WWMJ+Meg/RuD0wQq7ySY+JBwWPsjJpj0KrTBYwlM/6j/3RffBChSuT8G4Hp3BzYwrQwqwySY+IhwWPs/Jpj0KODNYwnOP6D9Zx/TBCsHJJj4dHBY+xsmmPQr051nCtpPsPwRG9cEKzcz4wc2MBkOa'
..'2SrDCsjJJj4aHBY+yMmmPQowCFjCAnnnPyf99sEKKVzZwSlcWMIUbi5DCrzJJj4XHBY+0smmPQq4CVjCHSrmP8sT9cEKuB7VwVK4BMOk8DDDCrvJJj4fHBY+zcmmPQogNVjCflnoP2Y798EKSOG2weF6kMFcDytDCsHJJj4jHBY+wMmmPQon7FnC4VbuP0w29cEKj8KpwQBACEOamSvDCrDJJj4dHBY+1cmmPQpiNljCQqrmP7nT9MEK9ii+weH6KMO4Xi3DCsjJJj4gHBY+wMmmPQoZAVjCm1HpP2sD98EKw8kmPg4cFj7ZyaY9CgI5'
..'WMKvfeE/JPv2wQoUriHCzcwPwuE6K0MKxMkmPhocFj7MyaY9CqIcWMKi3+c/9Cj3wQrheszBCtcZwpqZLEMKvMkmPgccFj7hyaY9CvImWMK+0d8/x0D1wQrheibCH8UFw5pZMMMKxMkmPiEcFj7DyaY9CoMWWMIbvek/djH3wQq1ySY+IhwWPszJpj0KrtFZwi8g7j8PIvXBCtejusGFax1DMzMwwwrJySY+HxwWPr7Jpj0Kp/xZwuQn7T/PcPXBCgAA5MHXI+1CrgcowwrIySY+CBwWPtvJpj0KxClYwjEx4T9i2/bBCuxRKMKamVDC'
..'XE8tQwq+ySY+HxwWPsXJpj0KIONZwmTL5z/jivbBCrfJJj4rHBY+w8mmPQov71nCcMbtP0jp9sEKmpnhwXE9EUKFazBDCr7JJj4uHBY+tMmmPQpYA1rCsPfvPxvJ9sEKUriEwYXrYEJS+C1DCr7JJj4sHBY+u8mmPQoe/lnCOx3uP/a99sEK7FHUwZqZZUI9ii1DCrDJJj4sHBY+xcmmPQpx11nCDXLvPxUW98EKcT2WwdejoEEfBTNDCrfJJj4sHBY+wcmmPQoB81nC4ZvvPzL39sEKj8KRwZqZDkIUrjBDCrDJJj4pHBY+ycmmPQrz'
..'1FnCTp7tP88G98EKcT3mwXE9okEz8zJDCh8Ddj4dHBY+1cmmPQpbo1nCJVznP1XY9sEKexQvwq5HpUFSuDJDClRjhD4RHBY+4MmmPQrilFnCC0HmP+th9cEKPQpBwo8CG0OPwi7DCrfJJj4hHBY+zcmmPQrA21nChY/nP1On9sEKFK4swuxRFkKFqy9DCqzJJj5AgWk9OPWqPgobSFjCcMfgP+Xn9cEK9igMQIXr0b+43ivDCq7JJj49gWk9OPWqPgr2KAxAhevRv0ghMkMKvMkmPuAgLz1dRHw+CliuWcK5Z+c/MfL1wQr2KAxAhevR'
..'v0ghI0MK0ckmPskgLz1dRHw+CvYoDECF69G/SCEUQwqPLiQ/bFXlPdRNgj4KfcdYwoOl5j/xTvfBCvaojMKk8B5DAMAawwqPLiQ/dlXlPcxNgj4KV8xYwmZ14T8pIPfBCj0KZsLDtSlDAIAkwwqPLiQ/jVXlPcBNgj4KCtcowuxRL0Ps0SjDCo8uJD+7VeU9pk2CPgrczljCBPXdP5ji9sEKexRKweH6MsM9iivDCpouJD+aVeU91k2CPgq70ljCqyzlP0TY9MEKAICGwmZmvkAUriVDCpouJD+wVeU9yE2CPgo501jCKy7gPw8N9cEK'
..'16NXwilcjz5mpipDCpouJD/NVeU9uU2CPgpmZhnC9ig8wHH9LEMKmi4kP+dV5T2pTYI+CozRWMI38tw/Xk71wQrXowjBPQrPwDNzLkMK8uhaPubJpj2YD8Y+CrHzV8I+3OQ/MTz2wQr2KAzAKVwyQ6QwAkMKEelaPs7Jpj2YD8Y+CkXOV8J4kek/Lzf2wQr2KAzAKVwyQ9ej5EIKw+haPgvKpj2YD8Y+ChszWMJqQt8/PkP2wQr2KAzAKVwyQ4WrIEMK0uhaPv7Jpj2YD8Y+CsDoWj4OyqY9mA/GPgpocVjCh8/dP7BH9sEK9igMwClc'
..'MkOF6zJDCijpWj7AyaY9mA/GPgpI+1nCt6/sPxZV9sEK9igMQIXr0b9m5uhCCjXpWj64yaY9mA/GPgrFFlrCOV/yPy9T9sEK8OhaPunJpj2YD8Y+CjnIWcJ9XOU/plb2wQoN6Vo+1MmmPZgPxj4K9igMQIXr0b/2qARDCtHoWj4DyqY9mA/GPgpsjlnCghriP1dV9sEK6UXLPs1V5T6SLvo9CgI+WsJUjfY/9ab2wQpSuObAhWvewgDAM8MK5EXLPsxV5T6XLvo9CmM9WsLDJvY/eBD2wQoK19vAcb22ws3MMUMK20XLPs1V5T6iLvo9'
..'CuozWsIEhfU/7VP1wQo3bgU+yvCRPWZHmj4KdhNZwiZ76z9QmfXBCtej4MA9ir/Ce1QyQwo2bgU+yvCRPSFdnD4KuA9ZwlEY7D/fmvbBCo/C1cCk8K3CexQuwArK8JE9CsJvPvzBbz4KoKxZwuAf7j/5IfbBCgrX28BxvbbCmpmvQgrugwc+yvCRPTa6jD4KC+hYwtop6z+QGPbBCsrwkT3XJpc+ytqPPgp6fVjC7Y7pP3UT9sEK5EXLPsVV5T6TLvo9Cui7V8JQfew/vfH1wQrfRcs+yFXlPpsu+j0KFsRXwl4a7T+srvbBCsP1wMD2'
..'qJfCPQowQwroRcs+yFXlPpAu+j0K5sJXwttL7D9Nf/XBClK45sDNzNrCUvgzwwroRcs+zVXlPpIu+j0KGDlawmzv+j96o/bBCnk4WsLbiPo//Qz2wQoAL1rCHOf5P3JQ9cEKjA5Zwj7d7z/VlfXBCs4KWcJpevA/ZJf2wQq2p1nC+IHyP34e9sEKIeNYwvKL7z8VFfbBCpB4WMIF8e0/+g/2wQr+tlfCaN/wP0Lu9cEKLL9XwnZ88T8xq/bBCulFyz7IVeU+kC76PQr8vVfC863wP9J79cEKnC76POQu+j3OyaY9Cs3qWMJVCek/bvz0'
..'wQoUrtFBXI8mwVzPKUMKnS76POMu+j3PyaY9CpNQWcKgK+s/yRP1wQqdLvo84y76Pc7Jpj0K1YJYwsZU5z8F4fTBCoXr10HhepzAPUosQwqdLvo85S76Pc3Jpj0KpbdZwiHc7D8WL/XBCuxRwEGamanBUjglQwqjLvo88y76PcLJpj0K7gFYwnVU5j+7LvXBCrgeiUFI4TFCFO4vQwqfLvo85i76PcfJpj0Kc/FYwtQd5D/L/vTBCqAu+jzjLvo9xcmmPQpmiVjCdlHiP6Tt9MEKny76POMu+j3HyaY9CiBYWcKbieU/dBT1wQqiLvo8'
..'4C76PcbJpj0KYBVYwplQ4D+MSPXBCoXrXcEfhVJCj4IpQwqkLvo81y76PcrJpj0KKr9ZwiRp5z+/LvXBCuxR5sF7FFbB1yMzQwq0ySY+GBwWPtXJpj0Kex5Ywmht4T8+N/fBCnsUjkHXowXCpHAFwQq1ySY+GhwWPtHJpj0KttFZwlJ66T9uDPfBCtejFkLNzDRBPQpTwQq0ySY+DRwWPuPJpj0KjyZYwoFW6D8i/vbBCilcAkJI4Q/CSOEWwQrIySY+JBwWPrbJpj0KrQhawiWi6D914PbBCo/C90FI4VVC16MAQArIySY+EhwWPsnJ'
..'pj0KwdpZwh457z/PlfbBCo/CX0LD9VtCuB5FQArBySY+EhwWPtLJpj0KespZwuUf7z/Gs/bBCuxRXkIpXARCZmbOwAq8ySY+HxwWPsjJpj0KCQxYwtoL3z9kFvfBCpqZqUDhek7Cw/XYwAq7ySY+FBwWPtbJpj0KMkpYwnF05z9zI/XBCrHJJj4SHBY+4MmmPQo1OljC/7noP5ER98EKtMkmPh8cFj7OyaY9CrkdWMJ8dt8/UEL3wQofhftAFK7/wfYoAMEKgUVYwlmL3j/P3vTBCrHJJj4iHBY+zsmmPQoAOljC9gTgPytd98EKH4Uf'
..'Qa5HicG4HgXBCsHJJj4dHBY+xcmmPQpZ6lnCVBfqP+H79sEKmpkiQvYoDUKamZnACsfJJj4YHBY+yMmmPQqEF1jCL+nfP8Mk9cEKexRyQQAA+cIUrmdACkUOWML7CuE/5Q33wQoUrnNB7FFTwgAA4MAKwkVYwmaE4D+X6fTBCsHJJj4iHBY+wMmmPQq+8VnC0YPoP/EL98EKpHD1QT0KEUIUrofACrHJJj4dHBY+1MmmPQpnOVjCH/XhP+5Q98EKx8kmPh8cFj7ByaY9CogUWML/5t0/Gx71wQrNzKRAj0L6wtejYEAKw8kmPg0cFj7Y'
..'yaY9Cng6WMLGP+c/xin1wQrDySY+GhwWPsvJpj0K0CxYws0w4D9e+vTBCilcgUEKFwvDcT2aQAq8ySY+BhwWPuDJpj0KUx5Ywkog6D+d4vbBCsPJJj4gHBY+w8mmPQrXKljCADLeP4nx9MEKY9dZwvDe5z9lHvfBCsjJJj4eHBY+vcmmPQo9AFrC3zTqP4TS9sEKCtcjQlK4V0JcjxJACsfJJj4HHBY+28mmPQqcKljCeArnP31I9cEKzczwQezR9sKuR4FACr7JJj4eHBY+xcmmPQpI4VnCwq7uP6q29cEKuMkmPikcFj7CyaY9Cq/6'
..'WcKOUek/Yln1wQq+ySY+LhwWPrPJpj0KGxJawiDU5z/6evXBClK45kH2qPpC9ig8QAq+ySY+KxwWPrvJpj0KGAlawkNz6T+whfXBCq5HG0LD9ftCCtdTQAqxySY+LBwWPsXJpj0K4udZwsL25j8YK/XBCrjJJj4sHBY+wMmmPQpXAlrCEKznP89L9cEKSOHUQVJ4E0OkcB1BCrHJJj4oHBY+ycmmPQp+4VnCRKXoPx069cEKIAN2Ph0cFj7VyaY9CgukWcLGGe0//mT1wQozMz5C9igsQxSumUEKU2OEPg8cFj7eyaY9CqONWcL1ke0/'
..'Ltr2wQqamVBCw/W4QMP1iMEKuMkmPiAcFj7MyaY9CibaWcI8r+4/vpn1wQpmZkxC7BEaQ65HYUEKrMkmPj6BaT0w9ao+ChNDWMLvUOg/1z32wQqvySY+OYFpPTD1qj4KvckmPt4gLz1URHw+CveqWcJOUu0/vEv2wQrSySY+yCAvPVREfD4KkC4kP2RV5T3STYI+Cg3QWMId1eY/vt/0wQqk8ItCrke3wZqZmcEKkC4kP3FV5T3KTYI+CmXJWMJ8/Os/mg71wQpxPWNC4XpswXsUPsEKkC4kP4lV5T28TYI+CmZmJULsUSjBexQKwQqQ'
..'LiQ/uFXlPaBNgj4KrcNYwvdt7z8nTPXBCpsuJD+RVeU91E2CPgqJzVjCQWHoP8JW98EKpHCBQj2KGsMK169BCpsuJD+oVeU9xk2CPgqzxFjCkj7tP9Eh98EKuB5PQlK4IsMfhW9BCpsuJD/GVeU9tk2CPgqbLiQ/4lXlPaVNgj4KkL1YwrtX8D9M4PbBCu/oWj7kyaY9jg/GPgo0+1fCbrbhPyLk9cEKEOlaPszJpj2OD8Y+Co3gV8Jq99s/1+b1wQr2KAxA9ihcv4XroMIKwOhaPgvKpj2OD8Y+CjAtWMKbJuk/FOH1wQrR6Fo+/Mmm'
..'PY4Pxj4K9igMQPYoXL/hekHCCr3oWj4MyqY9jg/GPgqEZljCmInsP7zg9cEKKulaPr/Jpj2QD8Y+CrYBWsKfs+o/QO71wQo26Vo+tsmmPZAPxj4K1idawhgU5j868vXBCvYoDMDXIzNDzUyBwgrx6Fo+6MmmPZAPxj4KdsFZws8o8D/56PXBCvYoDMDXIzNDZmaSwQoP6Vo+0smmPZAPxj4K0uhaPgPKpj2QD8Y+CvCCWcLid/E/Seb1wQriRcs+zVXlPo8u+j0KqVdawjZR4z9MofXBCnsU1sDheo3CAACYwArbRcs+zFXlPpUu+j0K'
..'w1NawgWh4z+kN/bBCtNFyz7NVeU+ny76PQo3RlrCRt7jP2vz9sEKMm4FPsjwkT1lR5o+CiAcWcImauQ/Z5r2wQowbgU+yPCRPR5dnD4KAB5ZwinM4z/EmPXBCsjwkT0Cwm8++MFvPgrJt1nCgsnmPyYc9sEK6oMHPsjwkT01uow+Cp3zWMLkYuM/UBj2wQrI8JE90yaXPsfajz4KRYlYwvaK4T89FvbBCtxFyz7FVeU+kC76PQqf01fC/IfYPyYr9sEK1kXLPshV5T6XLvo9CuLfV8K+RNg/5G71wQozMwPBClfUwgrXI7wK4kXLPshV'
..'5T6JLvo9ChnYV8Ls5dg/+p32wQpcj9rAmhmRwq5HkcAKyltawsLr3j+jpPXBCuRXWsKRO98/+zr2wQpYSlrC0njfP8L29sEKQSBZwrIE4D++nfbBCiEiWcK1Zt8/G5z1wQrqu1nCDmTiP30f9sEKvvdYwnD93j+nG/bBCmaNWMKCJd0/lBn2wQrA11fCiCLUP30u9sEKA+RXwkrf0z87cvXBCuJFyz7IVeU+iC76PQo63FfCeIDUP1Gh9sEKni76PN4u+j3IyaY9CkXtWMLnbOU/YjT3wQpSuNzBHwUzw4XryUAKoi76POEu+j3JyaY9'
..'ClxUWcKenOY/7CP3wQqhLvo83i76PcnJpj0K3YRYwsvA4z/FSPfBCqRw18FmZi9Dj8INQQqfLvo84i76PcnJpj0K3btZwlBF6D+WD/fBCgrX4cHhuifDrkeBPwqfLvo86i76PcHJpj0KhwdYwh6l4D928vbBCkjhysBxfQNDPQrHQApkzQI98GBMPbmAoz0KUeNYwk046T+gePXBCmbNAj3vYEw9uYCjPQoVgljCOqTnP6p29cEK8kpZwgao6j/fevXBChpB9TwvQfU9v4CjPQqm41jC7QfqP8Es98EKGUH1PC5B9T2/gKM9CjJ9WMLU'
..'e+g/rDb3wQobQfU8MEH1Pb2Aoz0KHkhZwsvk6z9MHvfBChxB9TwtQfU9vYCjPQrDDFjCSMbmP+/V9sEKGEH1PC1B9T2/gKM9CuitWcIBV+0/XQv3wQqygCM+DycTPsyAoz0KtB9Ywp4V5j/y8fTBCqyAIz4YJxM+yYCjPQpsy1nCegnsP7449cEKsoAjPgMnEz7YgKM9Cjs0WMLYxt8/ECv1wQq9gCM+HycTPrCAoz0KF/1ZwviL7j9MZ/XBCr2AIz4bJxM+toCjPQqH3VnCo9rmPxWu9cEKtoAjPhgnEz7AgKM9CmfOWcKsceY/qo/1'
..'wQq5gCM+FicTPsCAoz0K7whYwpzC5z+4EPXBCrOAIz4dJxM+v4CjPQp3TFjCTKbhP1v+9sEKr4AjPgwnEz7WgKM9CvFHWMJpBuA/VBn1wQqygCM+FycTPsSAoz0KPhtYwsXs5z/e5vTBCrOAIz4hJxM+vYCjPQoYNVjCQ/DpP3lA98EKr4AjPhknEz7FgKM9CpU3WMLgSOg/b870wQq2gCM+HScTPruAoz0Kt+NZwuc47D+bSvXBCruAIz4YJxM+wICjPQpnDVjC7zfnPxj59sEKuYAjPg0nEz7KgKM9CucOWMKg7+U/YBn1wQqzgCM+'
..'HycTPr2Aoz0KdDlYwgAU6D8dNvfBCraAIz4eJxM+uoCjPQrW51nCL/PtPzM79cEKr4AjPhInEz7MgKM9CrA6WMI+beY/kNr0wQq7gCM+GycTPryAoz0KdAZYwjkH6T89//bBCriAIz4VJxM+xYCjPQpCPVjCx1rhPx/39sEKuIAjPhonEz7AgKM9CnIhWMKKnOc/CCT3wQq5gCM+ACcTPtaAoz0KjitYwkG33z95RfXBCriAIz4dJxM+vICjPQpyG1jCm3DpP18s98EKrIAjPhsnEz7FgKM9CuLNWcKRve0/Wyf1wQq9gCM+HycTPrGA'
..'oz0KAvhZwivK7D+OdPXBCruAIz4NJxM+yoCjPQpSLljCyw/hP/3X9sEKuoAjPiwnEz6kgKM9CvzeWcK2iOc/FIn2wQq1gCM+MicTPqaAoz0KzupZwpll7T+d5fbBCrqAIz4yJxM+noCjPQqR/lnCy4vvPxLG9sEKuoAjPjMnEz6ggKM9CnL5WcKuuu0/Jrv2wQqtgCM+LycTPq6Aoz0KiNNZwsoI7z+IEffBCrWAIz4vJxM+qYCjPQqN7lnCyzHvP0Hz9sEKrYAjPjAnEz6tgKM9ChbRWcJBPu0/jwL3wQr2KObBcT2iQTPzMkMKoipx'
..'PionEz6ygKM9CnigWcKoG+c//9T2wQrBx4E+EycTPs6Aoz0KSZJZwh8G5j/2ZfXBCsHXWcIFTuc/9KT2wQqngCM+n+dkPSqXpz4KD0xYwh+o4D9N6fXBCquAIz6Y52Q9KpenPgq6gCM+o60rPUxMdz4KPqtZwgEn5z9l8/XBCsmAIz6TrSs9TEx3Pgqx8iA/+9DgPVV5fz4K8MhYwp9o5j9GSffBCrHyID/80OA9VHl/PgqxzVjCq1LhP2ob98EKsfIgPwPR4D1MeX8+CrHyID8b0eA9MHl/Pgoq0FjC8+PdPw/f9sEKuPIgPyfR4D1a'
..'eX8+CvXTWMIy9+Q/BN/0wQq48iA/M9HgPUl5fz4KcdRYwuIR4D/EEvXBCrjyID9C0eA9PHl/Pgq48iA/RtHgPTR5fz4KzNJYwj7m3D/KUvXBCvSYVj7VgKM93SjCPgpQ+VfCWqjkP+879sEKCJlWPseAoz3dKMI+CqDUV8LWRek/Bjf2wQrkmFY+5ICjPd0owj4KejdYwsYq3z/YQvbBCuWYVj7ggKM93SjCPgrqmFY+4ICjPd0owj4KjXRYwjK/3T8zR/bBCi+ZVj6vgKM93yjCPgqr9lnCXlTsP1ZU9sEKL5lWPrCAoz3fKMI+Cp0R'
..'WsIz5/E/eFL2wQoVmVY+w4CjPd8owj4KncRZwhUm5T/eVfbBCiSZVj62gKM93yjCPgr9mFY+1YCjPd8owj4K9ItZwoj04T+VVPbBCupExz4t0eA+CkH1PQoVOFrCOQD2P5ek9sEK5ETHPivR4D4PQfU9Cnk3WsKum/U/ERH2wQrcRMc+LdHgPhtB9T0KMC5awh799D89WPXBCmbNAj7BEI89dj2XPgpqE1nC4CXrP0Kc9cEKZM0CPsEQjz2sSJk+Cr8PWcLyv+s/vpj2wQrBEI89EglrPgYJaz4KkKlZwkW97T85IvbBCprYBD7BEI89'
..'mvSJPgra6FjCLdbqPwAZ9sEKwRCPPasslD5qBY0+CmOAWMJYQ+k//xP2wQrlRMc+JNHgPg1B9T0KocJXwvEi7D/x8vXBCt9Exz4n0eA+FUH1PQqlylfC57zsPyes9sEK6kTHPifR4D4FQfU9CnvJV8J28us/woL1wQpDM1rCNkz6Py6h9sEK5ETHPivR4D4RQfU9CqcyWsKr5/k/qA32wQrcRMc+LdHgPhxB9T0KXilawhtJ+T/UVPXBCpgOWcLdce8/2Zj1wQrtClnC7wvwP1WV9sEKvqRZwkIJ8j/QHvbBCgjkWMIqIu8/lxX2wQqR'
..'e1jCVY/tP5YQ9sEKz71Xwu5u8D+I7/XBCtPFV8LkCPE/vqj2wQqpxFfCcz7wP1l/9cEKFkH1PCxB9T3BgKM9Co3rWMJhwOg/eAL1wQobQfU8LUH1PcCAoz0KUk9ZwunX6j9dGfXBChlB9TwsQfU9wICjPQqhhVjCaxTnP5nn9MEKGUH1PCxB9T3BgKM9Cly0WcLkf+w/IDT1wQocQfU8MkH1Pb2Aoz0KRAdYwiYZ5j/HM/XBChpB9TwpQfU9uYCjPQoS8ljCsO3jP8kE9cEKHEH1PCZB9T25gKM9ChKMWMJjKuI/+fP0wQobQfU8JkH1'
..'PbmAoz0KulZZwk1S5T8FGvXBChhB9TwnQfU9uoCjPQpVGljCoTPgPxZN9cEKG0H1PCJB9T26gKM9Cry7WcJlKOc/yzP1wQqvgCM+CCcTPsiAoz0KQyNYwtdK4T8JMvfBCqmAIz4TJxM+xYCjPQrrzVnCJS/pPxII98EKr4AjPv8mEz7UgKM9Ci4rWMIWEeg/Dvr2wQq6gCM+GycTPqyAoz0KzQNawjpb6D/23PbBCrqAIz4XJxM+soCjPQrJ1lnC9tDuP8iT9sEKsoAjPhQnEz68gKM9CtTGWcI9uO4/KbH2wQq2gCM+EicTPryAoz0K'
..'LRFYwkz13j/VEffBCrCAIz4ZJxM+uoCjPQodTljCdjPnP7go9cEKrYAjPgUnEz7RgKM9CnE+WMKfcug/Gg33wQqvgCM+EScTPsCAoz0KhSJYwtRd3z/jPPfBCrCAIz4cJxM+uYCjPQqESVjCTnfeP27l9MEKrYAjPhMnEz7CgKM9Cj0+WMKA6d8/N1f3wQqygCM+GCcTPriAoz0KEuZZwhDJ6T/Y9/bBCreAIz4RJxM+vICjPQpvHFjCQM7fPwIq9cEKtoAjPgcnEz7GgKM9Cl8TWMJb6uA/gQn3wQqwgCM+GycTPrmAoz0KxElYwmdm'
..'4D8A8PTBCrKAIz4ZJxM+t4CjPQpR7VnCgD3oP5cH98EKrYAjPg4nEz7IgKM9Cqc9WMLiz+E/OEv3wQq3gCM+FycTPrmAoz0KghlYwjHW3T97I/XBCrSAIz4RJxM+wYCjPQqzPljC1f/mP+wu9cEKtIAjPhUnEz69gKM9ClAxWMJ1FOA/cgD1wQq2gCM++yYTPtKAoz0KGyNYwvHb5z8U3/bBCrSAIz4YJxM+uoCjPQphL1jCtx/eP8r39MEKqYAjPhYnEz7BgKM9CnzTWcLem+c/rhn3wQq6gCM+GicTPq+Aoz0Kh/tZwgXm6T9Mz/bB'
..'CreAIz4KJxM+xoCjPQomL1jClMvmPwdN9cEKtoAjPignEz6fgKM9Ci/dWcJSSe4/Cbn1wQqygCM+LScTPqCAoz0KFfZZwisH6T+XXfXBCraAIz4sJxM+moCjPQoLDVrCQZHnP4Z+9cEKtoAjPi8nEz6cgKM9CjYEWsI2KOk/Bon1wQqqgCM+KycTPqiAoz0Kp+NZwj+45j83MPXBCrKAIz4qJxM+pICjPQqX/VnC+mnnP0hQ9cEKqoAjPiwnEz6pgKM9CmTdWcJFXug/8D71wQqdKnE+JycTPqyAoz0KJqFZwlC87D/4aPXBCr/HgT4O'
..'JxM+y4CjPQovi1nCJTLtP8/W9sEKsoAjPisnEz6jgKM9CjDWWcLKSe4/r5z1wQqngCM+medkPSKXpz4KIkdYwp0L6D+NPfbBCquAIz6S52Q9IpenPgq7gCM+o60rPUJMdz4K76dZwr/z7D8rS/bBCsmAIz6TrSs9Qkx3Pgqv8iA/8tDgPVJ5fz4KVtFYwkWX5j9Z5vTBCq/yID/00OA9T3l/PgrPyljCpqTrP0gU9cEKr/IgP/3Q4D1EeX8+Cq/yID8a0eA9JXl/Pgo0xVjCxATvP59Q9cEKufIgPx7R4D1ZeX8+Ct7OWMKcG+g/71D3'
..'wQq58iA/LNHgPUd5fz4KNcZYwmXg7D8JHffBCrnyID890eA9NXl/Pgq58iA/RtHgPSh5fz4KNb9Ywu7p7z/O3PbBCvKYVj7TgKM92CjCPgquAFjCaZLhP5zl9cEKBplWPsSAoz3YKMI+Co3mV8Jg8Ns/ROj1wQrhmFY+5ICjPdgowj4KrjFYwhLd6D+e4vXBCuSYVj7egKM92CjCPgromFY+3oCjPdgowj4K4WlYwvsu7D9H4vXBCiyZVj6ugKM91SjCPgr6/FnCR2LqP4fv9cEKLJlWPq+Aoz3VKMI+CloiWsIR2uU/bvP1wQoQmVY+'
..'woCjPdUowj4K/b1ZwvC77z9b6vXBCiCZVj62gKM91SjCPgr7mFY+1ICjPdUowj4Ks4BZwmkE8T+55/XBCuJExz4q0eA+CkH1PQo8UVrCGyXjPxik9cEK20THPinR4D4RQfU9CmpNWsJXc+M/ejf2wQrVRMc+KtHgPhpB9T0KIkBawmOv4z+O7/bBCl/NAj6/EI89dD2XPgrpG1nCgTjkP0uY9sEKXc0CPr8Qjz2rSJk+CsEdWcKhneM/u5v1wQq/EI89BwlrPgUJaz4KgrRZwuaL5j+HHPbBCpPYBD6/EI89mvSJPgoz9FjCbzbjP8QY'
..'9sEKvxCPPaMslD5pBY0+CvOLWMLMZ+E/uxb2wQrYRMc+IdHgPg5B9T0K4NlXwkWS2D87K/bBCtRExz4k0eA+F0H1PQrm5VfCWlDYP65y9cEK30THPiTR4D4IQfU9CkTeV8Jb7tg/zJv2wQrkRMc+KtHgPgpB9T0KSFVawtPV3j9dp/XBCt5Exz4p0eA+EUH1PQp2UVrCDyTfP7869sEK10THPirR4D4aQfU9Ci5EWsIbYN8/0/L2wQpgzQI+vxCPPXQ9lz4K9R9Zwjnp3z+Qm/bBCl7NAj6/EI89q0iZPgrNIVnCWU7fPwCf9cEKvxCP'
..'PQkJaz4FCWs+Co64WcKePOI/zB/2wQqV2AQ+vxCPPZr0iT4KP/hYwifn3j8JHPbBCr8Qjz2lLJQ+aQWNPgr/j1jChBjdPwAa9sEK2kTHPiHR4D4OQfU9CuzdV8L9QtQ/gC72wQrWRMc+JNHgPhdB9T0K8ulXwhIB1D/zdfXBCuFExz4k0eA+CEH1PQpQ4lfCE5/UPxGf9sEKG0H1PCRB9T27gKM9CvntWMIqNuU/PC/3wQobQfU8JEH1PbqAoz0KCVNZwuVf5j8ZH/fBChtB9TwhQfU9u4CjPQqfh1jCfZLjPzhD98EKgLhZwjkA6D8q'
..'C/fBChlB9TwoQfU9uoCjPQrBDFjCfYbgP5zu9sEhBlNjcmlwdAqcxVrCWsd5P+AU9sEKAACAP/ichrCMAASzCvichjAAAIA/dQKSLQpgeFrCuPNaP+AU9sEKAACAP5h/NaEAAACoCph/NaEAAIA/AAAAogrJz3K2DmgftgAAgL8KOo1+tQAAgD//Zx+2CsnPcjYOaB82AACAPwqa1X0/m+kEPmGnPDgKnOkEvprVfT/ZdLU5CqP8fz9C2Qm6D98lPAoQ2wk6/v9/P8lf2DEKRZKNvPG5Uzc39n+/CjD2fz/PD2W6R5KNvAq0AkW8dU24'
..'OUP7f78KKUNBOvr/fz/uqrM5Ct/xErz4yAY+JsN9PwrDqh09lph9PxFXBr4KbPJ/P4lckbzceyM8CkwpnLz83SS/eMhDPwoFlTK92qxoPcJXfz8KD5E3P0NsMj9dzQi8CjmQX7ybrww9OtN/Pwr0gT4/XPkqP7qcUbwKKCJ1PNwnHT1nyH+/Cl9ydj+J+4k++d7KPApfrFk/s1YNvrMFAj8Kwmo5vQ83cT/p56k+CpuPfb8hqww+hmUevArYKww+VWJ9P12NIz0YAQAAAQACAAMAAQABAgAEAAUAAgAGAAcAAg8ABAAIAAkACgALAAwA'
..'DQAOAA8AEAARABIAEwASABQAFQAWABcAGAAZABoAGwAcABkAHQAeAB8ADAAgACEAIgADAQAjACQAJQAEAgAEACYAJwAkAAcAAg0ABAAoAAkACgALAAwADQApAA8AKgARABIAFAArABYAFwAYABkAGgAsABwAGQAdAC0AHwAMACIABgQALgAvADAAMQAyADMANAA1ADYAAgsACQAKAA8ANwARABIAFgAXABgAOAAaADkAHAA4AB0AOgAwADsAPAA6AD0APgA2AAIMAAQAPwAJAAoADwBAABEAEgAWABcAGABBABoAQgAcAEEAHQBDADAA'
..'RAA8AEUAPQBGADYAAgwABABHAAkACgANACkADwBIABEAEgAUACsAFgAXABoASQAdAEoAMABLADwATAA9AE0ANgACDQAEAE4ACQAKAA0ATwAPAFAAEQASABQAUQAWABcAGABSABoAUwAcAFIAHQBUADAAVQA8AFYANgACCgAEAFcACQAKAA8AWAARABIAFgAXABoAWQAdAFoAMABbADwAXAA9AF0ANgACDgAEAF4ACQAKAA0AXwAPAGAAEQASABQAYQAWAGIAGABjABoAZAAcAGUAHQBmACAAZwAwAGgAPABpADYAAg0ABABqAAkACgAN'
..'AGsADwBsABEAEgAUAG0AFgAXABgAYwAaAG4AHABlAB0AbwAwAHAAPABxADYAAg0ABABqAAkACgANAGsADwByABEAEgAUAG0AFgAXABgAYwAaAHMAHABlAB0AdAAwAHAAPABxAHUAQAKABwB+AH8AgAABBwCBAIIAgwCEAIUAhgACDAAEAHYACQAKAA0AawAPAHcAEQASABQAeAAWABcAGAB5ABoAegAcAHsAHQB8AH0ACgA2AAIMAAQAhwAJAAoADQBrAA8AiAAUAIkAFgCKABgAiwAaAIwAHACNAB0AjgAwAI8APACQADYAAgwABACR'
..'AAkACgAPAJIAEQASABYAFwAYAJMAGgCUABwAlQAdAJYAMACXADwAmAA9AJkANgACDgAJAAoADQBfAA8AmgARABIAFABhABYAYgAYAJsAGgCcAJ0AngAcAJ8AHQCgACAAoQAwAKIAPACjADYAAgsACQAKAA8ApAARABIAFgClABgApgAaAKcAHACoAB0AqQAwAKoAPACrAD0APgB1AEACQAKABwCyALMArgABBwC0ALUArgC2AIUAhgBABEACQAIABwC3ALgAuQBAAwAHALoAuwC8AEAFAL0AvgC/AMAAAL0AvgDBALwAgAcAwgDDALwA'
..'gAcAwgDEALwAgAcAwgDFALwAQAKABwDGAMcAvABAA4AHAMgAyQC8AIAHAMgAygC8AAEHAMsAzAC8AIQAhQCGAEACwAUABwDNAM4AuQAABwDNAM8AuQAABwDQANEAuQAABwDSANMAuQAABwDNANQAuQBABIAHANUA1gC5AIAHANcA2ADZAIAHANoA2wC5AEACwAuABwDcAN0A3gCABwDfAOAA4QCABwDcAOIA3gCABwDjAOQA5QCABwDmAOcA6ABAAsAkAAcA6QDqAOsAAAcA7ADtAO4AAAcA7wDwAPEAAAcA8gDzAPQAAAcA9QD2APcA'
..'AAcA+AD5APoAAAcA+wD8AP0AAAcA/gD/AAABAAcAAQECAQMBAAcABAEFAQYBAAcABwEIAQkBAAcACgELAQwBAAcADQEOAQ8BAAcAEAERARIBAAcAEwEUARUBAAcAFgEXARgBAAcAGQEaARsBAAcAHAEdAR4BAAcAHwEgASEBAAcAIgEjASQBAAcAJQEmAScBAAcAKAEpASoBAAcAKwEsAS0BAAcALgEvATABAAcAMQEyATMBAAcANAE1ATYBAAcANwE4ATkBAAcAOgE7ATwBAAcAPQE+AT8BAAcAQAFBAUIBAAcAQwFEAUUBAAcARgFH'
..'AUgBAAcAQwFJAUoBAAcASwFMAU0BAAcATgFPAVABAAcAUQFSAVMBQALAAgAHAFQBVQFWAQAHAFcBVQFYAUACwAIABwBZAVoBWwEABwBcAVoBXQFAA8AEAAcAXgFfAWABAAcAYQFiAWMBAAcAZAFiAWUBAAcAZgFnAWgBwAQABwBpAWoBawEABwBsAW0BbgEABwBvAW0BcAEABwBxAXIBcwFAA8AFAAcAdAF1AXYBAAcAdwF4AXkBAAcAegF7AXwBAAcAfQF7AX4BAAcAfwGAAYEBwAUABwCCAYMBhAEABwCFAYYBhwEABwCIAYkBigEA'
..'BwCLAYkBjAEABwCNAY4BjwFAAkAHwAMABwCQAZEBkgEABwCTAZQBlQEABwCWAZcBmAEABwCZAZoBmwEABwCcAZ0BngEBBwCfAaABoQGEAIUAhgAABwCiAaMBlQEBBwCkAaUBoQGEAIUAhgDAAwAHAKYBpwGVAQAHAKgBqQGqAQAHAKsBrAGtAUAHwAMABwCuAa8BkgEABwCwAbEBlQEABwCyAbMBmAEABwC0AbUBmwEABwC2AbcBngEBBwC4AbkBoQGEAIUAhgAABwC6AbsBlQEBBwC8Ab0BoQGEAIUAhgDAAwAHAL4BvwGVAQAHAMAB'
..'wQGqAQAHAMIBwwGtAYAHAMQBxQHGAYAHAMcByAHGAYAHAMkBygHLAYAHAMwBzQHOAYAHAM8B0AHRAUALgAcA0gHTAdQBgAcA1QHWAdcBgAcA2AHZAdQBgAcA2gHbAdwBgAcA3QHeAd8BQALAJAAHAOAB4QHiAQAHAOMB5AHlAQAHAOYB5wHoAQAHAOkB6gHrAQAHAOwB7QHuAQAHAO8B8AHxAQAHAPIB8wH0AQAHAPUB9gH3AQAHAPgB+QH6AQAHAPsB/AH9AQAHAP4B/wEAAgAHAAECAgIDAgAHAAQCBQIGAgAHAAcCCAIJAgAHAAoC'
..'CwIMAgAHAA0CDgIPAgAHABACEQISAgAHABMCFAIVAgAHABYCFwIYAgAHABkCGgIbAgAHABwCHQIeAgAHAB8CIAIhAgAHACICIwIkAgAHACUCJgInAgAHACgCKQIqAgAHACsCLAItAgAHAC4CLwIwAgAHADECMgIzAgAHADQCNQI2AgAHADcCOAI5AgAHADoCOwI8AgAHAD0CPgI/AgAHAEACQQJCAgAHAEMCRAJFAgAHAEYCRwJIAgAHAEkCSgJLAkACwAIABwBMAk0CTgIABwBPAk0CUAJAAsACAAcAUQJSAlMCAAcAVAJSAlUCQAPA'
..'BAAHAFYCVwJYAgAHAFkCWgJbAgAHAFwCWgJdAgAHAF4CXwJgAsAEAAcAYQJiAmMCAAcAZAJlAmYCAAcAZwJlAmgCAAcAaQJqAmsCQAPABQAHAGwCbQJuAgAHAG8CcAJxAgAHAHICcwJ0AgAHAHUCcwJ2AgAHAHcCeAJ5AsAFAAcAegJ7AnwCAAcAfQJ+An8CAAcAgAKBAoICAAcAgwKBAoQCAAcAhQKGAocCQAJAB8ADAAcAiAKJAooCAAcAiwKMAo0CAAcAjgKPApACAAcAkQKSApMCAAcAlAKVApYCAQcAlwKYApkChACFAIYAAAcA'
..'mgKbAo0CAQcAnAKdApkChACFAIYAwAMABwCeAp8CjQIABwCgAqECogIABwCjAqQCpQJAB8ADAAcAiAKmAooCAAcAiwKnAo0CAAcAjgKoApACAAcAkQKpApMCAAcAlAKqApYCAQcAlwKrApkChACFAIYAAAcAmgKsAo0CAQcAnAKtApkChACFAIYAwAMABwCeAq4CjQIABwCgAq8CogIABwCjArACpQKABwCxArICswKABwC0ArUCswKABwC2ArcCuAKABwC5AroCuwKABwC8Ar0CvgJAB8ADAAcAvwLAAooCAAcAwQLCAo0CAAcAwwLE'
..'ApACAAcAxQLGApMCAAcAxwLIApYCAQcAyQLKApkChACFAIYAAAcAywLMAo0CAQcAzQLOApkChACFAIYAwAMABwDPAtACjQIABwDRAtICogIABwDRAtMCpQJAAkACwCQABwDUAtUC4gEABwDWAtcC5QEABwDYAtkC6AEABwDaAtsC6wEABwDcAt0C7gEABwDeAt8C8QEABwDgAuEC9AEABwDiAuMC9wEABwDkAuUC+gEABwDmAucC/QEABwDoAukCAAIABwDqAusCAwIABwDsAu0CBgIABwDuAu8CCQIABwDwAvECDAIABwDiAvICDwIA'
..'BwDzAvQCEgIABwD1AvYCFQIABwD3AvgCGAIABwD5AvoCGwIABwD7AvwCHgIABwD9Av4CIQIABwD/AgADJAIABwABAwIDJwIABwADAwQDKgIABwAFAwYDLQIABwAHAwgDMAIABwAJAwoDMwIABwALAwwDNgIABwANAw4DOQIABwAPAxADPAIABwARAxIDPwIABwATAxQDFQMABwAWAxcDRQIABwAYAxkDSAIABwAaAxsDSwJAAsACAAcAHAMdA04CAAcAHgMdA1ACQALAAgAHAB8DIANTAgAHACEDIANVAkADwAQABwAiAyMDWAIABwAk'
..'AyUDWwIABwAmAyUDXQIABwAnAygDYALABAAHACkDKgNjAgAHACsDLAMtAwAHAC4DLANoAgAHAC4DLwNrAkADwAUABwAwAzEDbgIABwAyAzMDcQIABwA0AzUDdAIABwA2AzUDdgIABwA3AzgDeQLABQAHADkDOgN8AgAHADsDPAN/AgAHAD0DPgOCAgAHAD8DPgOEAgAHAEADQQOHAkACQAfAAwAHAEIDQwOKAgAHAEQDRQONAgAHAEYDRwOQAgAHAEgDSQOTAgAHAEoDSwOWAgEHAEwDTQOZAoQAhQCGAAAHAE4DTwONAgEHAFADUQOZ'
..'AoQAhQCGAMADAAcAUgNTA40CAAcAVANVA6ICAAcAVgNXA6UCQAfAAwAHAFgDWQOKAgAHAFoDWwONAgAHAFwDXQOQAgAHAF4DXwOTAgAHAGADYQOWAgEHAEwDYgOZAoQAhQCGAAAHAGMDZAONAgEHAFADZQOZAoQAhQCGAMADAAcAZgNnA40CAAcAaANpA6ICAAcAagNrA6UCgAcAbANtA7kAQANAAsAkAAcAbgNvA+IBAAcAcANxA+UBAAcAcgNzA+gBAAcAdAN1A+sBAAcAdgN3A+4BAAcAeAN5A/EBAAcAegN7A/QBAAcAfAN9A/cB'
..'AAcAfgN/A/oBAAcAgAOBA/0BAAcAggODAwACAAcAhAOFAwMCAAcAhgOHAwYCAAcAiAOJAwkCAAcAigOLAwwCAAcAggOMAw8CAAcAjQOOAxICAAcAjwOQAxUCAAcAkQOSAxgCAAcAkwOUAxsCAAcAlQOWAx4CAAcAlwOYAyECAAcAmQOaAyQCAAcAmwOcAycCAAcAnQOeAyoCAAcAnwOgAy0CAAcAoQOiAzACAAcAowOkAzMCAAcApQOmAzYCAAcApwOoAzkCAAcAqQOqAzwCAAcAqwOsAz8CAAcArQOuAxUDAAcArwOwA0UCAAcAsQOy'
..'A0gCAAcAswO0A0sCQALAAgAHABwDtQNOAgAHALYDtQNQAkACwAIABwC3A7gDUwIABwC5A7gDVQJAA8AEAAcAugO7A1gCAAcAvAO9A1sCAAcAvgO9A10CAAcAvwPAA2ACwAQABwDBA8IDYwIABwDDA8QDLQMABwDFA8QDaAIABwDGA8cDawJAA8AFAAcAyAPJA24CAAcAygPLA3ECAAcAzAPNA3QCAAcAzgPNA3YCAAcAzwPQA3kCwAUABwDRA9IDfAIABwDTA9QDfwIABwDVA9YDggIABwDXA9YDhAIABwDYA9kDhwJAAkAHwAMABwDa'
..'A9sDigIABwDcA90DjQIABwDeA98DkAIABwDgA+EDkwIABwDiA+MDlgIBBwDkA+UDmQKEAIUAhgAABwDmA+cDjQIBBwDoA+kDmQKEAIUAhgDAAwAHAOoD6wONAgAHAOwD7QOiAgAHAO4D7wOlAkAHwAMABwDwA/EDigIABwDyA/MDjQIABwD0A/UDkAIABwD2A/cDkwIABwD4A/kDlgIBBwD6A/sDmQKEAIUAhgAABwD8A/0DjQIBBwD+A/8DmQKEAIUAhgDAAwAHAAAEAQSNAgAHAAIEAwSiAgAHAAQEBQSlAoAHAAYEBwQIBIAHAAkE'
..'CgQLBAIMAAQArAAJAAoADQApAA8ArQARABIAFAArABYAYgAYAK4AGgCvABwAsAAdALEAfQAKAHUAQALAJAAHABIEEwQOBAAHABQEFQQWBAAHABcEGAQZBAAHABoEGwQcBAAHAB0EHgQfBAAHACAEIQQiBAAHACMEJAQlBAAHACYEJwQoBAAHACkEKgQrBAAHACwELQQuBAAHAC8EMAQxBAAHADIEMwQ0BAAHADUENgQ3BAAHADgEOQQ6BAAHADsEPAQ9BAAHAD4EPwRABAAHADUEQQRCBAAHAEMERARFBAAHAEYERwRIBAAHAEkESgRL'
..'BAAHAEwETQROBAAHAE8EUARRBAAHAFIEUwRUBAAHAFUEVgRXBAAHAFgEWQRaBAAHAFsEXARdBAAHAF4EXwRgBAAHAGEEYgRjBAAHAGQEZQRmBAAHAGcEaARpBAAHAGoEawRsBAAHAG0EbgRvBAAHAHAEcQRyBAAHAHMEdAR1BAAHAHYEdwR4BAAHAHkEegR7BEACwAIABwB8BH0EfgQABwB/BH0EgARAAsACAAcAgQSCBIMEAAcAgQSCBIQEQAPABAAHAIUEhgSHBAAHAIgEiQSKBAAHAIsEiQSMBAAHAI0EjgSPBMAEAAcAkASRBJIE'
..'AAcAkASTBJQEAAcAlQSTBJYEAAcAlwSYBJkEQAPABQAHAJoEmwScBAAHAJ0EngSfBAAHAKAEoQSiBAAHAKMEoQSkBAAHAKUEpgSnBMAFAAcAqASpBKoEAAcAqwSsBK0EAAcArgSvBLAEAAcAsQSvBLIEAAcApQSzBLQEQAJAB8ADAAcAtQS2BLcEAAcAuAS5BLoEAAcAuwS8BL0EAAcAvgS/BMAEAAcAwQTCBMMEAQcAxATFBMYEhACFAIYAAAcAxwTIBLoEAQcAyQTKBMYEhACFAIYAwAMABwDLBMwEugQABwDNBM4EzwQABwDQBNEE'
..'0gRAB8ADAAcA0wTUBLcEAAcA1QTWBLoEAAcAuwTXBL0EAAcA2ATZBMAEAAcAwQTaBMMEAQcAxATbBMYEhACFAIYAAAcA3ATdBLoEAQcAyQTeBMYEhACFAIYAwAMABwDLBN8EugQABwDNBOAEzwQABwDQBOEE0gQCDAAEAAwECQAKAA0AXwAPAA0EEQASABQAYQAWAGIAGAAOBBoADwQcABAEHQARBH0ACgB1AEACwALABQAHAOoE6wTkBAAHAOoE7ATkBAAHAO0E7gTkBAAHAO8E8ATkBAAHAOoE8QTkBEAEgAcA8gTzBOQEgAcA9AT1'
..'BPYEgAcA9wT4BOQEQALAC4AHAPkE+gT7BIAHAPwE/QT+BIAHAP8EAAX7BIAHAAEFAgXlAIAHAAMFBAUFBUACwCQABwAGBQcFCAUABwAJBQoFCwUABwAMBQ0FDgUABwAPBRAFEQUABwASBRMFFAUABwAVBRYFFwUABwAYBRkFGgUABwAbBRwFHQUABwAeBR8FIAUABwAhBSIFBgEABwAjBSQFJQUABwAmBScFDAEABwAoBSkFKgUABwArBSwFLQUABwAuBS8FMAUABwAxBTIFMwUABwA0BTUFNgUABwA3BTgFOQUABwA6BTsFIQEABwA8'
..'BT0FPgUABwA/BUAFQQUABwBCBUMFRAUABwBFBUYFLQEABwBHBUgFSQUABwBKBUsFTAUABwBNBU4FTwUABwBQBVEFOQEABwBSBVMFVAUABwBVBVYFVwUABwBYBVkFWgUABwBbBVwFXQUABwBeBV8FYAUABwBhBWIFYwUABwBkBWUFZgUABwBnBWgFaQUABwBqBWsFbAVAAsACAAcAbQVuBW8FAAcAcAVuBXEFQALAAgAHAHIFcwV0BQAHAHUFcwV2BUADwAQABwB3BXgFeQUABwB6BXsFfAUABwB9BXsFfgUABwB/BYAFgQXABAAHAIIF'
..'gwWEBQAHAIUFhgWHBQAHAIgFhgWJBQAHAIoFiwWMBUADwAUABwCNBY4FjwUABwCQBZEFkgUABwCTBZQFlQUABwCWBZQFfgEABwCXBZgFmQXABQAHAJoFmwWcBQAHAJ0FngWHAQAHAJ8FoAWKAQAHAKEFoAWiBQAHAKMFpAWPAUACQAfAAwAHAKUFpgWnBQAHAKgFqQWqBQAHAKsFrAWYAQAHAK0FrgWvBQAHALAFsQWyBQEHALMFtAW1BYQAhQCGAAAHALYFtwWqBQEHALgFuQW1BYQAhQCGAMADAAcAugW7BaoFAAcAvAW9Bb4FAAcA'
..'vwXABcEFQAfAAwAHAMIFwwWnBQAHAKgFxAWqBQAHAKsFxQWYAQAHAK0FxgWvBQAHALAFxwWyBQEHALMFyAW1BYQAhQCGAAAHALYFyQWqBQEHALgFygW1BYQAhQCGAMADAAcAugXLBaoFAAcAvAXMBb4FAAcAzQXOBcEFgAcAzwXQBdEFgAcA0gXTBdEFgAcA1AXVBdYFgAcA1wXYBdkFgAcA2gXbBdwFQAuABwDdBd4F1AGABwDfBeAF1wGABwDhBeIF1AGABwDjBeQF5QWABwDmBecF6AVAAsAkAAcA6QXqBesFAAcA7AXtBe4FAAcA'
..'7wXwBfEFAAcA8gXzBfQFAAcA9QX2BfcFAAcA+AX5BfoFAAcA+wX8Bf0FAAcA/gX/BfcBAAcAAAYBBisEAAcAAgYDBgQGAAcAIwUFBjEEAAcABgYHBggGAAcACQYKBgsGAAcADAYNBg4GAAcALgUPBhAGAAcAMQURBg8CAAcAEgYTBhQGAAcAFQYWBkUEAAcAFwYYBhkGAAcAGgYbBhsCAAcAHAYdBh4GAAcAHwYgBlEEAAcAIQYiBlQEAAcARwUjBlcEAAcAJAYlBiYGAAcAJwYoBikGAAcAKgYrBjACAAcALAYtBjMCAAcALgYvBjAG'
..'AAcAMQYyBjMGAAcANAY1BmwEAAcANgY3BjgGAAcAOQY6BkICAAcAOwY8Bj0GAAcAPgY/BkAGAAcAQQZCBkMGQALAAgAHAEQGRQZ+BAAHAEYGRQaABEACwAIABwBHBkgGgwQABwBJBkgGhARAA8AEAAcASgZLBkwGAAcATQZOBk8GAAcAUAZOBlEGAAcAUgZTBo8EwAQABwBUBlUGVgYABwBXBlgGWQYABwBaBlgGlgQABwBbBlwGmQRAA8AFAAcAXQZeBpwEAAcAXwZgBmEGAAcAYgZjBqIEAAcAZAZjBmUGAAcAZgZnBqcEwAUABwBo'
..'BmkGqgQABwBqBmsGbAYABwBtBm4GbwYABwBwBm4GsgQABwBxBnIGtARAAkAHwAMABwBzBnQGdQYABwB2BncGjQIABwB4BnkGvQQABwB6BnsGwAQABwB8Bn0GwwQBBwB+Bn8GmQKEAIUAhgAABwCABoEGjQIBBwCCBoMGmQKEAIUAhgDAAwAHAIQGhQaNAgAHAIYGhwaIBgAHAIkGigaLBkAHwAMABwBzBowGdQYABwB2Bo0GjQIABwB4Bo4GvQQABwB6Bo8GwAQABwB8BpAGwwQBBwB+BpEGmQKEAIUAhgAABwCABpIGjQIBBwCCBpMG'
..'mQKEAIUAhgDAAwAHAIQGlAaNAgAHAIYGlQaIBgAHAJYGlwaLBoAHAJgGmQaaBoAHAJsGnAaaBoAHAJ0GngafBoAHAKAGoQaiBoAHAKMGpAalBkAEgAcApganBuQEgAcAqAapBvYEgAcApgaqBuQEQALAC4AHAKsGrAb7BIAHAK0Grgb+BIAHAK8GsAb7BIAHALEGsgblAIAHALMGtAYFBUACwCQABwC1BrYGCAUABwC3BrgGCwUABwC5BroGDgUABwC7BrwGEQUABwC9Br4GFAUABwC/BsAGFwUABwDBBsIGGgUABwDDBsQGHQUABwDF'
..'BsYGIAUABwDHBsgGBgEABwDJBsoGJQUABwDLBswGDAEABwDNBs4GKgUABwDPBtAGLQUABwDRBtIGMAUABwDTBtQGMwUABwDVBtYGNgUABwDXBtgGOQUABwDZBtoGIQEABwDbBtwGPgUABwDdBt4GQQUABwDfBuAGRAUABwDhBuIGLQEABwDjBuQGSQUABwDlBuYGTAUABwDnBugGTwUABwDpBuoGOQEABwDrBuwGVAUABwDtBu4GVwUABwDvBvAGWgUABwDxBvIGXQUABwDzBvQGYAUABwD1BvYG9wYABwD4BvkGZgUABwD6BvsGaQUA'
..'BwDzBvwGbAVAAsACAAcA/Qb+Bm8FAAcA/wb+BnEFQALAAgAHAAAHAQd0BQAHAAIHAQd2BUADwAQABwADBwQHeQUABwAFBwYHfAUABwAHBwYHfgUABwAIBwkHgQXABAAHAAoHCweEBQAHAAwHDQeHBQAHAA4HDQeJBQAHAA8HEAeMBUADwAUABwARBxIHjwUABwATBxQHkgUABwAVBxYHlQUABwAXBxYHfgEABwAYBxkHmQXABQAHABoHGwecBQAHABwHHQeHAQAHAB4HHweKAQAHACAHHweiBQAHACEHIgePAUACQAfAAwAHACMHJAen'
..'BQAHACUHJgeqBQAHACcHKAeYAQAHACkHKgevBQAHACsHLAeyBQEHAC0HLge1BYQAhQCGAAAHAC8HMAeqBQEHADEHMge1BYQAhQCGAMADAAcAMwc0B6oFAAcANQc2B74FAAcANwc4B8EFQAfAAwAHACMHOQenBQAHADoHOweqBQAHADwHPQeYAQAHACkHPgevBQAHACsHPweyBQEHAC0HQAe1BYQAhQCGAAAHAC8HQQeqBQEHADEHQge1BYQAhQCGAMADAAcAMwdDB6oFAAcANQdEB74FAAcANwdFB8EFgAcARgdHB9EFgAcASAdJB9EF'
..'gAcASgdLB9YFgAcATAdNB9kFgAcATgdPB9wFQAuABwBQB1EH1AGABwBSB1MH1wGABwBUB1UH1AGABwBWB1cH5QWABwBYB1kH6AVAAsAkAAcAWgdbB+sFAAcAXAddB+4FAAcAXgdfB/EFAAcAYAdhB/QFAAcAYgdjB/cFAAcAZAdlB/oFAAcAZgdnB/0FAAcAaAdpB/cBAAcAagdrBysEAAcAbAdtBwQGAAcAbgdvBzEEAAcAcAdxBwgGAAcAcgdzBwsGAAcAdAd1Bw4GAAcAdgd3BxAGAAcAeAd5Bw8CAAcAegd7BxQGAAcAfAd9B0UE'
..'AAcAfgd/BxkGAAcAgAeBBxsCAAcAggeDBx4GAAcAhAeFB1EEAAcAhgeHB1QEAAcAiAeJB1cEAAcAigeLByYGAAcAjAeNBykGAAcAjgePBzACAAcAkAeRBzMCAAcAkgeTBzAGAAcAlAeVBzMGAAcAlgeXB2wEAAcAmAeZBzgGAAcAmgebB0ICAAcAnAedBz0GAAcAngefB0AGAAcAoAehB0MGQALAAgAHAKIHowd+BAAHAKQHoweABEACwAIABwClB6YHgwQABwCnB6YHhARAA8AEAAcAqAepB0wGAAcAqgerB08GAAcArAerB1EGAAcA'
..'rQeuB48EwAQABwCvB7AHVgYABwCxB7IHWQYABwCzB7IHlgQABwC0B7UHmQRAA8AFAAcAtge3B5wEAAcAuAe5B2EGAAcAuge7B6IEAAcAvAe7B2UGAAcAvQe+B6cEwAUABwC/B8AHqgQABwDBB8IHbAYABwDDB8QHbwYABwDFB8QHsgQABwDGB8cHtARAAkAHwAMABwDIB8kHdQYABwDKB8sHjQIABwDMB80HvQQABwDOB88HwAQABwDQB9EHwwQBBwDSB9MHmQKEAIUAhgAABwDUB9UHjQIBBwDWB9cHmQKEAIUAhgDAAwAHANgH2QeN'
..'AgAHANoH2weIBgAHANwH3QeLBkAHwAMABwDeB98HdQYABwDgB+EHjQIABwDiB+MHvQQABwDkB+UHwAQABwDmB+cHwwQBBwDoB+kHmQKEAIUAhgAABwDqB+sHjQIBBwDsB+0HmQKEAIUAhgDAAwAHAO4H7weNAgAHAPAH8QeIBgAHAPIH8weLBoAHAPQH9QeaBoAHAPYH9weaBoAHAPgH+QefBoAHAPQH+geiBoAHAPsH/AelBgINAAQA4gQJAAoADQApAA8A4wQRABIAFAArABYAigAYAOQEGgDlBJ0A5gQcAOcEHQDoBCAA6QT9BwEA'
..'AAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
