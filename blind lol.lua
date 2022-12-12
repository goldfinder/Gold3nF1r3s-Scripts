-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 7820 characters
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


local Objects = Decode('AEAeASEFTW9kZWwhBE5hbWUhB1R5cGUgMjAhCldvcmxkUGl2b3QEDwEQAREBIQRQYXJ0IQdSZWxlYXNlIQhBbmNob3JlZCIhCkJyaWNrQ29sb3IHbAEhBkNGcmFtZQQXABIBEwEhCkNhbkNvbGxpZGUCIQVDb2xvcgZLS0shCE1hdGVyaWFsAwAAAAAAAHFAIQtPcmll'
..'bnRhdGlvbgoAAAAAAAA0QwAAtEIhCFBvc2l0aW9uCtCLkz5jLWNAAMnyPyEIUm90YXRpb24KAAA0wwAAAAAAALTCIQRTaXplCkH+kD7W1M897VRsPiELU3BlY2lhbE1lc2ghBVNjYWxlCjkI9Dw4CPQ8Nwj0PCEGTWVzaElkIRdyYnhhc3NldGlkOi8vNzQ5MDAyMDIx'
..'NCEITWVzaFR5cGUDAAAAAAAAFEAhA01hZweUAAQoABQBEwEGUFBQCsP1s0IAAAAAAAC0wgpQjNO9YSJwQACU8z8KAAC0QgAAAAAAALTCCukmMT64HpU/JzEIPwr2YdVAWczVQJ9t0EAhF3JieGFzc2V0aWQ6Ly8xMzY0NjQxNTczIQRNYWcyB1oBBDEAFAETAQbTvpYK'
..'MHR8vmjSaECA3PM/IQtSZWZsZWN0YW5jZQMAAACgmZm5PwpmOSg+XI/CPj4qvT0KlJLbQO0F1UAzj9BAIRdyYnhhc3NldGlkOi8vMTM2NDY0MjUxOCEOV2VsZENvbnN0cmFpbnQhBVBhcnQwIQVQYXJ0MSEHQnVsbGV0cwQ8ABIBEwEK7Fa3PuxTbUAIavM/CtD/vj6M'
..'xGg+rqoLPgo3CPQ8OAj0PDgI9DwhF3JieGFzc2V0aWQ6Ly83NDkwMTczMDY0IQdBaW1QYXJ0IQtCYWNrU3VyZmFjZQMAAAAAAAAkQCENQm90dG9tU3VyZmFjZQcaAARJABQBEwEGGyo1IQxGcm9udFN1cmZhY2UhC0xlZnRTdXJmYWNlCmy3cT9zUAJAAEnzPyEMUmln'
..'aHRTdXJmYWNlCs3MzD3NzMw9zczMPSEKVG9wU3VyZmFjZSEMVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQpBdHRhY2htZW50IQVOVkFpbQRTABUBFgEKAAAAgAAAAIAAADTCCs3MTD7NzEw+AAAAACELRmxhc2ggSGlkZXIHaQEEWAASARMBBjw8PArowQE/8A3FQAB98z8K'
..'dakDP0zwCT7KGRo+CjcI9Dw4CPQ8Nwj0PCEXcmJ4YXNzZXRpZDovLzc0OTAwMzQ0NzghCUhhbmRndWFyZAReABIBEwEKdhoRP7CumEAAlvc/CgvduT+mtMk+diGWPgo5CPQ8Nwj0PDcI9DwhF3JieGFzc2V0aWQ6Ly83NDg5OTc2MjQ0BGMAEgETAQpqVUc/MTakQAB9'
..'8z8K/c9APgNXxz3fc0E+CjcI9Dw5CPQ8OQj0PCEXcmJ4YXNzZXRpZDovLzc0OTAxNDY1OTQhBVNpZ2h0BGwAFwEYAQoAAAAAAAA0QwAANMMhC1Bpdm90T2Zmc2V0BBkBEAERAQpu318/qiymQAB/8z8KAAA0wwAAAAAAAAAACgnNXD4nxoo9OxodPiEXcmJ4YXNzZXRp'
..'ZDovLzc0OTAxNTEwNjEEcQASARMBCmpVRz/t3z9AAH3zPwqwz0A+A1fHPeBzQT4KNgj0PDkI9Dw4CPQ8IRdyYnhhc3NldGlkOi8vNzQ5MDE0Mzc2OAR4ABoBGwEKAAAAAAAANEMAAAAABBwBEAERAQro9l4/ce87QIBj8j8KAAA0wwAAAAAAADRDCgXNXD7srZ090mkv'
..'Pgo3CPQ8Nwj0PDkI9DwhF3JieGFzc2V0aWQ6Ly83NDkwMTQ5ODkwIQdDaGFtYmVyAwAAAAAAAAAAB/EDBIMAHQEeAQb//wAKAAAAAAAAAAAAALTCCnJ0BT8L3GxAoJbmPwrMzEw+zMxMPszMTD4hBUNhdGNoBIcAEgETAQrUXeE+589eQED9AEAKsIOQPR1cUT44CPQ9'
..'CjcI9Dw3CPQ8OAj0PCEXcmJ4YXNzZXRpZDovLzc0OTAwMjQ4MzIhB1RyaWdnZXIEjQASARMBCtzxBj7caVBAAH3zPwreGOQ9E0IyPm/lPz0KNgj0PDcI9Dw4CPQ8IRdyYnhhc3NldGlkOi8vNzQ5MDAyOTkyMSEGU3dpdGNoBJMAEgETAQrsXbw+7aZCQAB98z8KXkUo'
..'PjbMqD3y/oA+IRdyYnhhc3NldGlkOi8vNzQ5MDAyOTMzMyEFVXBwZXIEmAASARMBCnhnET/nBGJA6F/vPwo9Nsw/MknKPtVglT4hF3JieGFzc2V0aWQ6Ly83NDkwMDg5MTY3IQVMb3dlcgSdABIBEwEK4I+7PvftP0AAffM/Cvcq/j/11To/SRqfPgo4CPQ8OAj0PDkI'
..'9DwhF3JieGFzc2V0aWQ6Ly83NDg5OTk5ODcyIQRCb2x0BKMAEgETAQpySxc/cQd3QADQ/j8K9rx2P+8xkj45E64+CjcI9Dw3CPQ8Nwj0PCEXcmJ4YXNzZXRpZDovLzc0ODk5OTY2MzchBVNvdW5kIQtCb2x0Rm9yd2FyZCESUm9sbE9mZk1heERpc3RhbmNlAwAAAAAA'
..'AFlAIRJSb2xsT2ZmTWluRGlzdGFuY2UhB1NvdW5kSWQhFnJieGFzc2V0aWQ6Ly8zOTM2Nzg5MjYhBlZvbHVtZSEIQm9sdEJhY2shFnJieGFzc2V0aWQ6Ly8zOTM2Nzg5MTUhBkJhcnJlbASzABIBEwEKdqsLP7LnnEAAffM/Cgxe/z8N76Y+r0AKPgo4CPQ8OAj0PDgI'
..'9DwhF3JieGFzc2V0aWQ6Ly83NDkwMDMxMjQzIQVSYWlscwS5ABIBEwEK7MHsPujdk0AAffM/CnQQlj88A4E+XI6XPgo4CPQ8Nwj0PDkI9DwhF3JieGFzc2V0aWQ6Ly83NDg5OTczMzg2IQRSZXN0BMAAEgETAQYtLS0K7vIZP5EaF0AA+fI/CrjlPj/fR48+UC5iPgo4'
..'CPQ8OQj0PDgI9DwhF3JieGFzc2V0aWQ6Ly83NDkwMDA4NTY3IRlCQ00gR3VuZmlnaHRlciBNb2QgMyBHcmlwBMYAEgETAQqoQI2979I8QAB98z8KdTL8Pqs5PD8EM0s+IRdyYnhhc3NldGlkOi8vNzQ5MDAxNjg2NyEFU3RvY2sEywASARMBCtiahT73CgdAAH3zPwrI'
..'dmo/ZVk9P0SulD4KOAj0PDcI9Dw3CPQ8IRdyYnhhc3NldGlkOi8vNzQ5MDAwOTQwMiEER3JpcATRABQBEwEKtF8HPmXLVkAAivM/IQRGaXJlIRdyYnhhc3NldGlkOi8vOTA3NDcyODgzOSEJU2lnaHRNYXJrBNYAFAETAQrsMmg/gMylQCA39D8hCUJsb2NrTWVzaAoK'
..'1yM8CtcjPAAAekQhCVNtb2tlUGFydATbABQBEwEK7NcBPyipzkAAivM/IQlTcG90TGlnaHQhB0ZsYXNoRlghCkJyaWdodG5lc3MG/9clIQdFbmFibGVkIQVBbmdsZQMAAAAAAIBmQCEFUmFuZ2UhD1BhcnRpY2xlRW1pdHRlciEORmxhc2hGWFtGbGFzaF0oAgAAAAD/'
..'/34AAIA//1UAIRFFbWlzc2lvbkRpcmVjdGlvbiEITGlmZXRpbWURmpmZPZqZmT0hDUxpZ2h0RW1pc3Npb24hDExvY2tlZFRvUGFydCEEUmF0ZQMAAAAAAECPQCEIUm90U3BlZWQRAAAAAAAAtEMpAgAAAAAEPN0+BDzdPgAAgD8AAAAAAAAAACEFU3BlZWQRAAAgQQAA'
..'IEEhB1RleHR1cmUhKWh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MjU3NDMwODcwKQIAAAAAAABAPwAAAAAAAIA/AACAPwAAAAAhCE92ZXJIZWF0IQxBY2NlbGVyYXRpb24KAAAAAAAAQEAAAAAAKAIAAAAA+vr6AACAP/r6+hEAAIA/AADAPyEOTGlnaHRJ'
..'bmZsdWVuY2URAABIwwAASEMRAAAAAAAAyEIpAgAAAADNzEw+AAAAAAAAgD8AAAAAAAAAABEAAAA/AAAAQCELU3ByZWFkQW5nbGULAAAAQAAAAEAhLHJieGFzc2V0Oi8vdGV4dHVyZXMvcGFydGljbGVzL3Ntb2tlX21haW4uZGRzKQIAAAAApHB9PwAAAAAAAIA/pHB9'
..'PwAAAAAhE1ZlbG9jaXR5SW5oZXJpdGFuY2UhBVNtb2tlCgAAAAAAAABAAAAAABGamRk/mpkZPykCAAAAAM3MzD4AAAAAAACAPwAAgD8AAAAAEQAAoEAAAOBACwAAyEEAAMhBKQIAAAAAMzNzPwAAAAAAAIA/AACAPwAAAAAhCEZpcmVQYXJ0BA4BFAETAQp0WgM/2EvN'
..'QKD38z8KwHckPoqugkAgLvc/CgAAgD8AAAAAAAAAAAoAAAAAAACAPwAAAAAKAAAAAP//fz8AAAAACv//fz8AAAAAAAAAAAoAAAAALb07swAAgL8K9AQ1P/QENb8AAAAACvQENT/0BDU/AAAAAAr//38///9/swAAAAAK//9/s///f78AAACACpNmnb0AAAAAAAAAAAr/'
..'/3+///9/swAAAIAK//9/s///fz8AAAAACpAcuz0AAAAAAAAAAAr//7+z//9/v+2tCagK//9/P///v7MuvbszQAEAAAIAAgADAAQABQAGAAELAAIABwAIAAkACgALAAwADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAaABsAHAACAwAdAB4AHwAgACEAIgAGAAELAAIA'
..'IwAIAAkACgAkAAwAJQAOAA8AEAAmABIAEwAUACcAFgAoABgAKQAaACoAHAAEAwAdACsAHwAsACEAIgAGAAQMAAIALQAIAAkACgAuAAwALwAOAA8AEAAwABIAEwAUACcAFgAxADIAMwAYACkAGgA0ABwABgMAHQA1AB8ANgAhACIANwAEAAAGAAQLAAIAOgAIAAkACgAu'
..'AAwAOwAOAA8AEAAwABIAEwAUABUAFgA8ABgAGQAaAD0AHAAJAwAdAD4AHwA/ACEAIgA3AAQAAAYAARIAAgBAAAgACQBBAEIAQwBCAAoARAAMAEUADgAPABAARgBHAEIASABCABIAEwAUACcAFgBJAEoAQgAYACkAGgBLAEwAQgBNAE4ATwAMBAACAFAADABRABQAUgAW'
..'AFMABgABCwACAFQACAAJAAoAVQAMAFYADgAPABAAVwASABMAFAAVABYAWAAYABkAGgBZABwADgMAHQBaAB8AWwAhACIABgABCwACAFwACAAJAAoAVQAMAF0ADgAPABAAVwASABMAFAAVABYAXgAYABkAGgBfABwAEAMAHQBgAB8AYQAhACIABgABCgAIAAkACgBVAAwA'
..'YgAOAA8AEABXABIAEwAUABUAFgBjABgAGQAaAGQAHAASAwAdAGUAHwBmACEAIgAGAAEMAAIAZwAIAAkACgBVAAwAaAAOAA8AEABXABIAEwAUAGkAagBrABYAbAAYAG0AGgBuABwAFAMAHQA+AB8AbwAhACIABgABCgAIAAkACgBVAAwAcAAOAA8AEABXABIAEwAUABUA'
..'FgBxABgAGQAaAHIAHAAWAwAdAHMAHwB0ACEAIgAGAAEMAAIAZwAIAAkACgBVAAwAdQAOAA8AEABXABIAEwAUAHYAagB3ABYAeAAYAHkAGgB6ABwAGAMAHQB7AB8AfAAhACIABgABDgACAH0ACAAJAEMAfgAKAH8ADACAAA4ADwAQAIEAEgATABQAggAWAIMAGACCABoA'
..'hABMAH4ATQBOAAYAAQsAAgCFAAgACQAKAAsADACGAA4ADwAQABEAEgATABQAFQAWAIcAGAAZABoAiAAcABsDAB0AiQAfAIoAIQAiAAYAAQsAAgCLAAgACQAKAFUADACMAA4ADwAQAFcAEgATABQAFQAWAI0AGAAZABoAjgAcAB0DAB0AjwAfAJAAIQAiAAYAAQsAAgCR'
..'AAgACQAKAAsADACSAA4ADwAQABEAEgATABQAFQAWAJMAGAAZABoAlAAcAB8DAB0AWgAfAJUAIQAiAAYAAQsAAgCWAAgACQAKAFUADACXAA4ADwAQAFcAEgATABQAFQAWAJgAGAAZABoAmQAcACEDAB0AWgAfAJoAIQAiAAYAAQsAAgCbAAgACQAKAFUADACcAA4ADwAQ'
..'AFcAEgATABQAFQAWAJ0AGAAZABoAngAcACMDAB0AnwAfAKAAIQAiAAYAAQsAAgChAAgACQAKAAsADACiAA4ADwAQABEAEgATABQAFQAWAKMAGAAZABoApAAcACUDAB0ApQAfAKYAIQAiAKcAJQUAAgCoAKkAqgCrACIArACtAK4ATgCnACUFAAIArwCpAKoAqwAiAKwA'
..'sACuAE4ABgABCwACALEACAAJAAoAVQAMALIADgAPABAAVwASABMAFAAVABYAswAYABkAGgC0ABwAKQMAHQC1AB8AtgAhACIABgABCwACALcACAAJAAoAVQAMALgADgAPABAAVwASABMAFAAVABYAuQAYABkAGgC6ABwAKwMAHQC7AB8AvAAhACIABgABCwACAL0ACAAJ'
..'AAoARAAMAL4ADgAPABAAvwASABMAFAAVABYAwAAYABkAGgDBABwALQMAHQDCAB8AwwAhACIABgABCwACAMQACAAJAAoARAAMAMUADgAPABAAvwASABMAFAAVABYAxgAYABkAGgDHABwALwMAHQC1AB8AyAAhACIABgABCwACAMkACAAJAAoARAAMAMoADgAPABAAvwAS'
..'ABMAFAAVABYAywAYABkAGgDMABwAMQMAHQDNAB8AzgAhACIABgABDQACAM8ACAAJAEMAfgAKAEQADADQAA4ADwAQAEYAFAAnABYA0QAYACkAGgBLAEwAfgBNAE4ApwAzAgACANIArADTAAYAAQ4AAgDUAAgACQBDAH4ACgB/AAwA1QAOAA8AEACBABIAEwAUACcAFgDW'
..'ABgAKQAaAIQATAB+AE0ATgDXADUBAB0A2AAGAAENAAIA2QAIAAkAQwB+AAoARAAMANoADgAPABAARgAUACcAFgDbABgAKQAaAEsATAB+AE0ATgDcADcGAAIA3QDeACIAEADfAOAADwDhAOIA4wBCAOQANw4AAgDlABAA5gDnACIA4AAPAOgA6QDqAE4A6wAJAOwA7QDu'
..'AO8AGADvABoA8ADxAPIA8wD0AE0A9QDkADcQAAIA9gD3APgAEAD5AOcAIgDgAA8A6AD6APsATgDsAO0A7gD8ABgA/QAaAP4A8QD/AAABAQHzAAIBTQADAQQBMwDkADcPAAIABQH3AAYB5wAiAOAADwDoAAcB+wBOAOwA7QDuAPwAGADvABoACAHxAAkBAAEKAfMAAgFN'
..'AAsBBAEzAAYAAQ4AAgAMAQgACQBDAH4ACgB/AAwADQEOAA8AEACBABIAEwAUACcAFgAOARgAKQAaAIQATAB+AE0ATgDcADwGAAIA3QDeAH4AEADfAOAADwDhAOIA4wB+AOQAPA8AAgDlAPcABgHnACIA4AAPAOgABwH7AE4A7ADtAO4A/AAYAO8AGgAIAfEACQEAAQoB'
..'8wACAU0ACwEEATMA5AA8EAACAPYA9wD4ABAA+QDnACIA4AAPAOgA+gD7AE4A7ADtAO4A/AAYAP0AGgD+APEA/wAAAQEB8wACAU0AAwEEATMA5AA8DwACAAUB9wAGAecAIgDgAA8A6AAHAfsATgDsAO0A7gD8ABgA7wAaAAgB8QAJAQABCgHzAAIBTQALAQQBMwAECDgA'
..'BAg5AAYLOAAECzkACQ==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end
