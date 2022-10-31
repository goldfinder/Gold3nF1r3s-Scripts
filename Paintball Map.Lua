-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 9728 characters
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


local Objects = Decode('AEBSASEGRm9sZGVyIQROYW1lIQNNQVAhBFBhcnQhA3BhZCEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yBxUAIQZDRnJhbWUEEQBGAUcBIQVDb2xvcgbEKBwhCFBvc2l0aW9uCkbwa8IAAEBAAGHTQiEEU2l6ZQoAAMBAAACAPwAA'
..'wEAhClRvcFN1cmZhY2UhDEJpbGxib2FyZEd1aSEOWkluZGV4QmVoYXZpb3IDAAAAAAAA8D8hBkFjdGl2ZSEXRXh0ZW50c09mZnNldFdvcmxkU3BhY2UKAAAAAAAAoEAAAAAADAAAUEEAAAAAQEAAACEHVGV4dEJveCEQQmFja2dyb3VuZENvbG9yMwYAAAAhFkJhY2tn'
..'cm91bmRUcmFuc3BhcmVuY3kDAAAAoJmZ6T8MAACAPwAA+n6qPgAAIQRGb250AwAAAAAAABBAIQRUZXh0IQ1DVEYgUGFpbnRiYWxsIQpUZXh0Q29sb3IzBv///yEKVGV4dFNjYWxlZCEIVGV4dFNpemUDAAAAAAAALEAhC1RleHRXcmFwcGVkDAAAAAAAAPp+qj4AACEV'
..'Tk9UIENPREVELCBETyBOT1QgQlVHBqoAAAwAAAAAAACDwCo/AAAhGE1hcDogR29sZDNuRjFyMydzIEN1c3RvbQb//wAhDUNsaWNrRGV0ZWN0b3IhFU1heEFjdGl2YXRpb25EaXN0YW5jZQMAAAAAAAAoQCEFTW9kZWwhCkdhbWVTdGF0dXMhCldvcmxkUGl2b3QESAFJ'
..'AUcBIQtTdHJpbmdWYWx1ZSELSGludE1lc3NhZ2UhBVZhbHVlIRZXYWl0aW5nIGZvciBwbGF5ZXJzLi4uIQRCbHVlBD8ASQFHAQo2RLFDAAByQiGMG0QKvLrGQgAAgD8pHClDB/IDBEgASgFHAQYAAP8hCE1hdGVyaWFsAwAAAAAAgIpAIQtPcmllbnRhdGlvbgoAAAAA'
..'AAC0wgAAAAAKJL6/Q7xdgkJWFQ1EIQhSb3RhdGlvbgpScDA/IFUPQR5RiEEETQBKAUcBAwAAAAAAAJFACv6rokMnsYtClFwIRAoKKNdAwHIFP8Clez8EUABJAUcBCqlnt0MoYIJCOxcLRApSlD8/IHoPQZOQhUEEUwBKAUcBCsqksEMnsYtCS34HRApSuF4/wHIFP1o7'
..'gkIEVgBKAUcBCtNkqkPqQXlCVhUNRApSOEE/exROQD9XT0IEWQBJAUcBChgkvkOx23NCfGUIRApSuF4/wHIFP764/0AEXABJAUcBCqlnt0Oy23NCqhYLRApSuF4/wHIFP9GghkEEXwBKAUcBCv6rokOy23NClFwIRARhAEkBRwEKb5OiQ7Lbc0IpDBxEClK4Xj/AcgU/'
..'PgOJQQRkAEkBRwEKqefDQ7xdgkJDNAtEClKIQD8gVQ9BEAeOQQRnAEkBRwEKimKdQ7Lbc0JxFgtEClK4Xj/AcgU/8a6GQQRqAEkBRwEKn9CcQ7Lbc0L2+BtEClK4Xj/AcgU/YncJQgRtAEkBRwEKGCS+Q7xdgkIwdwhECnE9Sj8TVQ9Be7/pQARxAEsBRwEKAAAAAAAA'
..'B0MAAAAACnzrnkO8XYJCxEIIRAoAADTDAAA0QgAANMMK4XpUPxxVD0GLsRBBBHUASQFHAQqpZ7dDJ7GLQqoWC0QEdwBKAUcBCqIHwkOx23NCdVoKRApSuF4/wHIFP1SF/EAEegBJAUcBCopinUO9XYJCXDILRApSnEA/GFUPQTCNjUEEfgBMAUcBCgAAAAAAADRCAAAA'
..'AApyH79DaLCLQsjcCUQKAABAP0JgBT90GsFABIEASgFHAQrdZKpDKdxzQlYVDUQKUrheP8ByBT8/V09CBIUATQFHAQMAAAAAAMCYQAqCIr9DUbiCQj/bCUQKcD0KP1K4DkE9UMJABIgASgFHAQrKpLBDsttzQkt+B0QEigBJAUcBCqnnw0Oy23NCQzQLRApSuF4/wHIF'
..'PxAHjkEEjQBJAUcBCqnnw0MnsYtCQzQLRASPAEkBRwEKj2KdQyexi0JDNAtEBJEASgFHAQpBQMBDsttzQkjIH0QKFK53QEJgBT8j23dBBJQASgFHAQrnC8JDvF2CQnVaCkQKcT1KPxhVD0HKYvpABJcASwFHAQp8655DsttzQsRCCEQKUrheP8ByBT+LsRBBBJoASgFH'
..'AQq8lKVDsttzQh/cKkQEnABKAUcBCkKuqEMnsYtC5RcJRApSuF4/wHIFPw+DNEIEnwBKAUcBCnGltkPnXYJCVhUNRApSOEE/N1QPQfBMNkAEogBKAUcBCsEMwkNosItCdVoKRApSuF4/wHIFP7AU/0AEpQBOAUcBCkJewkOy23NC+0IIRApSuF4/wHIFP+naEEEEqABK'
..'AUcBCkFAwEOy23NCLSkYRAoUrndAwHIFP2rZd0EEqwBJAUcBCqnnw0Oy23NC9vgbRApSuF4/wHIFP8Pu4kEErgBKAUcBCqwlnkPnXYJCVhUNRASwAEoBRwEKk7i/Q7Lbc0JWFQ1EBLIASgFHAQq8lKVDsttzQi0pGEQKFK53QMByBT9lzQ1CBLcATwFQASEKQ2FuQ29s'
..'bGlkZQIKACDyQgAAAD9UCqtDCgAAgEAAAIA/AACAQCEMVHJhbnNwYXJlbmN5BLsASgFHAQrKpLBDvF2CQpd8B0QKUjREPyRVD0FaO4JCBL4ASgFHAQpCrqhDsttzQuUXCUQEwABKAUcBCryUpUOy23NCSMgfRATCAEwBRwEKch+/Q7Hbc0LI3AlEBMQASQFHAQoYJL5D'
..'aLCLQnxlCEQExgBJAUcBCr2xqEOy23NCKQwcRATIAEoBRwEK02SqQyexi0JWFQ1EBMoATgFHAQpCXsJDJ7GLQvtCCEQEzABLAUcBCnzrnkMnsYtCxEIIRATOAEkBRwEKimKdQyncc0JDNAtEBNAASgFHAQqTuL9DJ7GLQlYVDUQE0gBOAUcBCkJewkO8XYJC+0IIRAo+'
..'xEg/GFUPQQloD0EE1QBKAUcBCtNkqkPGpYlCVhUNRApSOEE/9gHZPz9XT0IhA1JlZATaAFEBRwEKAAAAAAAANEMAAAAACi8zNMMAAHJCIYwbRAoAADTDAAAAAAAANMMKKdzMQgAAgD8pHClDIQxHYW1lIE9iamVjdHMhCEJsdWVGbGFnBxcABOMAUgFHAQYNaawKAAAA'
..'AAAAtEIAAAAACm8pqkPkYn5CIQwcRAoAAIA/AACgQAAAgD8hC1NwZWNpYWxNZXNoIQZPZmZzZXQKAACAvwAAAAAAAAAAIQZNZXNoSWQhJ2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTAzODQ5MiEJVGV4dHVyZUlkISdodHRwOi8vd3d3LnJvYmxveC5j'
..'b20vYXNzZXQvP2lkPTEwNDM5NzUhCE1lc2hUeXBlAwAAAAAAABRAIQ1CbHVlRmxhZ1N0YW5kBPAAUgFHAQp5KapDgSlyQikMHEQKAACgQAAAgD8AAKBAIQdSZWRGbGFnBPQAUgFHAQr8diTDAACBQiEMHEQhJ2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9'
..'MTA0Mzk3NyEMUmVkRmxhZ1N0YW5kBPgAUgFHAQr8diTDAAB2QiEMHEQhBlNwYXducyEJU3BlY3RhdG9yIQ5TcGVjdGF0b3JTcGF3bgT+AEkBRwEhCENhblRvdWNoCrIotkIMyx9DdL0aRAoAIIM6bxKDOm8SgzoEAQFJAUcBCsPbWUIMyx9DdL0aRCEFVGVhbXMhBFRl'
..'YW0hCVRlYW1Db2xvcgfsAwfHACEFTG9iYnkHGgAEDAFJAUcBIQpDYXN0U2hhZG93BhsqNQq/mZNCer8XQ9odHEQKAACeQgAAgD8AACBCBA8BSQFHAQq/mZNCer8uQ9odHEQDAAAAYGZm7j8EEgFJAUcBCr+Zk0J6PyND2j0XRAoAAJ5CAACwQQAAgD8EFQFJAUcBCnwz'
..'B0J6PyND2h0cRAoAAIA/AADAQQAAIEIhBEhpbnQEGQFJAUcBCr+Zk0J4PyBD2h0eRAoAAIBBAACAPwAAAEEhC0Fsd2F5c09uVG9wIQ5MaWdodEluZmx1ZW5jZSELTWF4RGlzdGFuY2UDAAAAAAAASUAMAABQQQAAAACAPwAADAAAgD8AAAAAgD8AAAMAAAAAAAAIQCEh'
..'VG8gZXhpdCB0aGUgbWluaWdhbWUgc2F5ICIvbGVhdmUiBCQBSQFHAQq+mZNCej8jQ9r9IEQEJgFJAUcBCr6Z40J6PyND2h0cRCEHVGVycmFpbgc2AQQsAUkBRwEGW5pMAwAAAAAAAJRACt9s0UP5/65CH8waRAoAAMBAAACAPwCAmUMELwHnAEcBCjPzpkIAAG5CIYwb'
..'RArWuiZEAACAPwCAlkMHJgAENAFJAUcBBqBfNQrfbNFDAAAuQh/MGkQKAADAQAAArkIAgJlDBDcB5wBHAQphm6pCAAAuQkBY6kMK46QnRAAArkIAAMBABDoBSQFHAQpPBahC+f+uQkBY6kMKXP8mRAAAgD8AAMBABD0BSQFHAQp7yaVC+f+uQiDsQUQKanApRAAAgD8A'
..'AMBABEABSQFHAQqrpaVCAAAuQiDsQUQKdWcpRAAArkIAAMBABEMBSQFHAQoU/HzD+f+uQh/MGkQERQFJAUcBChT8fMMAAC5CH8waRAoAAIA/AAAAAAAAAAAKAAAAAAAAgD8AAAAACkTwA8IAAABCAITFQQoAAIA/AAAAAAAAwDMKAADAswAAAAAAAIA/CvQENb8AAAAA'
..'8wQ1vwr0BDU/AAAAAPIENb8K8wQ1PwAAAADzBDW/CvMENT8AAAAA9AQ1vwoAAIA/AACAqQAAAAAKAACAqQAAgD8AAAAACgAAgL8AAAAAAADAswoAAMAzAAAAAAAAgL9lAQAAAQACAAMABAABCQACAAUABgAHAAgACQAKAAsADAANAA4ADwAQABEAEgATABQACQAVAAIE'
..'ABYAFwAYAAcAGQAaABIAGwAcAAMJAB0AHgAfACAAEgAhACIAIwAkACUAJgAnACgABwApACoAKwAHABwAAwoAHQAeAB8AFwAQACwAEgAhACIAIwAkAC0AJgAuACgABwApACoAKwAHABwAAwoAHQAeAB8AFwAQAC8AEgAhACIAIwAkADAAJgAxACgABwApACoAKwAHADIA'
..'AgEAMwA0ADUAAQIAAgA2ADcAOAA5AAgCAAIAOgA7ADwAAQABAQACAD0ABAAKBgAGAAcACAAJAAwAPgAQAD8AEgBAABQACQAEAAoLAAYABwAIAAkACgBBAAwAQgAOAEMARABFAEYARwAQAEgASQBHABIASgAUAAkABAAKCQAGAAcACAAJAAwASwBEAEwARgBHABAATQBJ'
..'AEcAEgBOABQACQAEAAoJAAYABwAIAAkACgBBAAwATwAOAEMARABFABAAUAASAFEAFAAJAAQACgkABgAHAAgACQAMAFIARABMAEYARwAQAFMASQBHABIAVAAUAAkABAAKCwAGAAcACAAJAAoAQQAMAFUADgBDAEQARQBGAEcAEABWAEkARwASAFcAFAAJAAQACgcABgAH'
..'AAgACQAMAFgARABMABAAWQASAFoAFAAJAAQACgcABgAHAAgACQAMAFsARABMABAAXAASAF0AFAAJAAQACgkABgAHAAgACQAMAF4ARABMAEYARwAQAF8ASQBHABIATgAUAAkABAAKBwAGAAcACAAJAAwAYABEAEwAEABhABIAYgAUAAkABAAKCQAGAAcACAAJAAoAQQAM'
..'AGMADgBDAEQARQAQAGQAEgBlABQACQAEAAoHAAYABwAIAAkADABmAEQATAAQAGcAEgBoABQACQAEAAoHAAYABwAIAAkADABpAEQATAAQAGoAEgBrABQACQAEAAoJAAYABwAIAAkACgBBAAwAbAAOAEMARABFABAAbQASAG4AFAAJAAQACgsABgAHAAgACQAKAEEADABv'
..'AA4AQwBEAEUARgBwABAAcQBJAHIAEgBzABQACQAEAAoHAAYABwAIAAkADAB0AEQATAAQAHUAEgBdABQACQAEAAoJAAYABwAIAAkADAB2AEQATABGAEcAEAB3AEkARwASAHgAFAAJAAQACgkABgAHAAgACQAKAEEADAB5AA4AQwBEAEUAEAB6ABIAewAUAAkABAAKCQAG'
..'AAcACAAJAAwAfABEAEwARgB9ABAAfgBJAH0AEgB/ABQACQAEAAoJAAYABwAIAAkADACAAEQATABGAEcAEACBAEkARwASAIIAFAAJAAQACgsABgAHAAgACQAKAEEADACDAA4AQwBEAIQARgB9ABAAhQBJAH0AEgCGABQACQAEAAoJAAYABwAIAAkADACHAEQATABGAEcA'
..'EACIAEkARwASAFQAFAAJAAQACgcABgAHAAgACQAMAIkARABMABAAigASAIsAFAAJAAQACgcABgAHAAgACQAMAIwARABMABAAjQASAIsAFAAJAAQACgcABgAHAAgACQAMAI4ARABMABAAjwASAIsAFAAJAAQACgkABgAHAAgACQAMAJAARABMAEYARwAQAJEASQBHABIA'
..'kgAUAAkABAAKCwAGAAcACAAJAAoAQQAMAJMADgBDAEQARQBGAEcAEACUAEkARwASAJUAFAAJAAQACgkABgAHAAgACQAMAJYARABMAEYAcAAQAJcASQByABIAmAAUAAkABAAKCQAGAAcACAAJAAwAmQBEAEwARgBHABAAmgBJAEcAEgBiABQACQAEAAoJAAYABwAIAAkA'
..'DACbAEQATABGAEcAEACcAEkARwASAJ0AFAAJAAQACgsABgAHAAgACQAKAEEADACeAA4AQwBEAEUARgBHABAAnwBJAEcAEgCgABQACQAEAAoJAAYABwAIAAkADAChAEQATABGAEcAEACiAEkARwASAKMAFAAJAAQACgkABgAHAAgACQAMAKQARABMAEYAfQAQAKUASQB9'
..'ABIApgAUAAkABAAKCQAGAAcACAAJAAwApwBEAEwARgBHABAAqABJAEcAEgCpABQACQAEAAoHAAYABwAIAAkADACqAEQATAAQAKsAEgCsABQACQAEAAoLAAYABwAIAAkACgBBAAwArQAOAEMARABFAEYARwAQAK4ASQBHABIAoAAUAAkABAAKCQAGAAcACAAJAAwArwBE'
..'AEwARgBHABAAsABJAEcAEgBiABQACQAEAAoJAAYABwAIAAkADACxAEQATABGAEcAEACyAEkARwASALMAFAAJAAQACggABgAHAAgACQAMALQAtQC2ABAAtwASALgAFAAJALkAFwAEAAoLAAYABwAIAAkACgBBAAwAugAOAEMARABFAEYARwAQALsASQBHABIAvAAUAAkA'
..'BAAKCQAGAAcACAAJAAwAvQBEAEwARgBHABAAvgBJAEcAEgCdABQACQAEAAoJAAYABwAIAAkADAC/AEQATABGAEcAEADAAEkARwASALMAFAAJAAQACgkABgAHAAgACQAMAMEARABMAEYAfQAQAMIASQB9ABIAfwAUAAkABAAKBwAGAAcACAAJAAwAwwBEAEwAEADEABIA'
..'WgAUAAkABAAKBwAGAAcACAAJAAwAxQBEAEwAEADGABIAYgAUAAkABAAKCQAGAAcACAAJAAwAxwBEAEwARgBHABAAyABJAEcAEgCCABQACQAEAAoJAAYABwAIAAkADADJAEQATABGAH0AEADKAEkAfQASAKYAFAAJAAQACgkABgAHAAgACQAMAMsARABMAEYAcAAQAMwA'
..'SQByABIAmAAUAAkABAAKBwAGAAcACAAJAAwAzQBEAEwAEADOABIAiwAUAAkABAAKCQAGAAcACAAJAAwAzwBEAEwARgBHABAA0ABJAEcAEgBiABQACQAEAAoLAAYABwAIAAkACgBBAAwA0QAOAEMARABFAEYAfQAQANIASQB9ABIA0wAUAAkABAAKCwAGAAcACAAJAAoA'
..'QQAMANQADgBDAEQARQBGAEcAEADVAEkARwASANYAFAAJAAEAAQEAAgDXAAQAPwgABgAHAAgACQAMANgARgDZABAA2gBJANsAEgDcABQACQABAAEBAAIA3QAEAEELAAIA3gAGAAcACAAJAAoA3wAMAOAADgDhAEYA4gAQAOMASQDiABIA5AAUAAkA5QBCBADmAOcA6ADp'
..'AOoA6wDsAO0ABABBCwACAO4ABgAHAAgACQAKAN8ADADvAA4A4QBGAOIAEADwAEkA4gASAPEAFAAJAAQAQQsAAgDyAAYABwAIAAkACgDfAAwA8wAOAOEARgDiABAA9ABJAOIAEgDkABQACQDlAEUEAOYA5wDoAOkA6gD1AOwA7QAEAEELAAIA9gAGAAcACAAJAAoACwAM'
..'APcADgAPAEYA4gAQAPgASQDiABIA8QAUAAkAAQBBAQACAPkAAQBIAQACANcAAQBIAQACAD0AAQBIAQACAPoABABLCgACAPsABgAHAAgACQAMAPwAtQC2AP0AtgAQAP4AEgD/ABQACQC5ABcABABLCgACAPsABgAHAAgACQAMAAABtQC2AP0AtgAQAAEBEgD/ABQACQC5'
..'ABcAAQABAQACAAIBAwFOAgACANcABAEFAQMBTgIAAgA9AAQBQQADAU4CAAIA+gAEAQYBAQABAQACAAcBBABSCgAGAAcACAAJAAoACAEMAAkBCgG2AA4ACwFEAIQAEAAMARIADQEUAAkABABSCgAGAAcACAAJAAoACAEMAA4BCgG2AA4ACwEQAA8BEgANARQACQC5ABAB'
..'BABSCgAGAAcACAAJAAoACAEMABEBCgG2AA4ACwEQABIBEgATARQACQC5ABABBABSCgAGAAcACAAJAAoACAEMABQBCgG2AA4ACwEQABUBEgAWARQACQC5ABABBABSCwACABcBBgAHAAgACQAMABgBtQC2AP0AtgAKAbYAEAAZARIAGgEUAAkAuQAXABUAVwYAFgAXABgA'
..'BwAbAQcAHAEXAB0BHgESAB8BHABYCQAdAB4AHwAgABIAIAEiACEBJAAiASYAJwAoAAcAKQAqACsABwAEAFIKAAYABwAIAAkACgAIAQwAIwEKAbYADgALARAAJAESABMBFAAJALkAEAEEAFIKAAYABwAIAAkACgAIAQwAJQEKAbYADgALARAAJgESABYBFAAJALkAEAEB'
..'AAEBAAIAJwEEAFwJAAYABwAIAAkACgAoAQwAKQEOACoBRAArARAALAESAC0BFAAJAAQAXAsABgAHAAgACQAKACgBDAAuAQ4AKgFEACsBRgDZABAALwFJANsAEgAwARQACQAEAFwJAAYABwAIAAkACgAxAQwAMgEOADMBRAArARAANAESADUBFAAJAAQAXAsABgAHAAgA'
..'CQAKADEBDAA2AQ4AMwFEACsBRgDZABAANwFJANsAEgA4ARQACQAEAFwJAAYABwAIAAkACgAoAQwAOQEOACoBRAArARAAOgESADsBFAAJAAQAXAkABgAHAAgACQAKACgBDAA8AQ4AKgFEACsBEAA9ARIAPgEUAAkABABcCQAGAAcACAAJAAoAMQEMAD8BDgAzAUQAKwEQ'
..'AEABEgBBARQACQAEAFwJAAYABwAIAAkACgAoAQwAQgEOACoBRAArARAAQwESAC0BFAAJAAQAXAkABgAHAAgACQAKADEBDABEAQ4AMwFEACsBEABFARIANQEUAAkAAA==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end
