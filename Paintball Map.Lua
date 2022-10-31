-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 9704 characters
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


local Objects = Decode('AEBRASEGRm9sZGVyIQROYW1lIQNNQVAhBFBhcnQhA3BhZCENQm90dG9tU3VyZmFjZQMAAAAAAAAAACEKQnJpY2tDb2xvcgcVACEGQ0ZyYW1lBA8ARgFHASEFQ29sb3IGxCgcIQhQb3NpdGlvbgpG8GvCAAACQgBh00IhBFNpemUKAADAQAAAgD8AAMBAIQpUb3BTdXJm'
..'YWNlIQxCaWxsYm9hcmRHdWkhDlpJbmRleEJlaGF2aW9yAwAAAAAAAPA/IQZBY3RpdmUiIRdFeHRlbnRzT2Zmc2V0V29ybGRTcGFjZQoAAAAAAACgQAAAAAAMAABQQQAAAABAQAAAIQdUZXh0Qm94IRBCYWNrZ3JvdW5kQ29sb3IzBgAAACEWQmFja2dyb3VuZFRyYW5z'
..'cGFyZW5jeQMAAACgmZnpPwwAAIA/AAD6fqo+AAAhBEZvbnQDAAAAAAAAEEAhBFRleHQhDUNURiBQYWludGJhbGwhClRleHRDb2xvcjMG////IQpUZXh0U2NhbGVkIQhUZXh0U2l6ZQMAAAAAAAAsQCELVGV4dFdyYXBwZWQMAAAAAAAA+n6qPgAAIRVOT1QgQ09ERUQs'
..'IERPIE5PVCBCVUcGqgAADAAAAAAAAIPAKj8AACEYTWFwOiBHb2xkM25GMXIzJ3MgQ3VzdG9tBv//ACENQ2xpY2tEZXRlY3RvciEVTWF4QWN0aXZhdGlvbkRpc3RhbmNlAwAAAAAAAChAIQVNb2RlbCEKR2FtZVN0YXR1cyEKV29ybGRQaXZvdARIAUYBRwEhC1N0cmlu'
..'Z1ZhbHVlIQtIaW50TWVzc2FnZSEFVmFsdWUhFldhaXRpbmcgZm9yIHBsYXllcnMuLi4hBEJsdWUhCEFuY2hvcmVkBD8ARgFHAQo2RLFDAAByQiGMG0QKvLrGQgAAgD8pHClDB/IDBEgASQFHAQYAAP8hCE1hdGVyaWFsAwAAAAAAgIpAIQtPcmllbnRhdGlvbgoAAAAA'
..'AAC0wgAAAAAKJL6/Q7xdgkJWFQ1EIQhSb3RhdGlvbgpScDA/IFUPQR5RiEEETQBJAUcBAwAAAAAAAJFACv6rokMnsYtClFwIRAoKKNdAwHIFP8Clez8EUABGAUcBCqlnt0MoYIJCOxcLRApSlD8/IHoPQZOQhUEEUwBJAUcBCsqksEMnsYtCS34HRApSuF4/wHIFP1o7'
..'gkIEVgBJAUcBCtNkqkPqQXlCVhUNRApSOEE/exROQD9XT0IEWQBGAUcBChgkvkOx23NCfGUIRApSuF4/wHIFP764/0AEXABGAUcBCqlnt0Oy23NCqhYLRApSuF4/wHIFP9GghkEEXwBJAUcBCv6rokOy23NClFwIRARhAEYBRwEKb5OiQ7Lbc0IpDBxEClK4Xj/AcgU/'
..'PgOJQQRkAEYBRwEKqefDQ7xdgkJDNAtEClKIQD8gVQ9BEAeOQQRnAEYBRwEKimKdQ7Lbc0JxFgtEClK4Xj/AcgU/8a6GQQRqAEYBRwEKn9CcQ7Lbc0L2+BtEClK4Xj/AcgU/YncJQgRtAEYBRwEKGCS+Q7xdgkIwdwhECnE9Sj8TVQ9Be7/pQARxAEoBRwEKAAAAAAAA'
..'B0MAAAAACnzrnkO8XYJCxEIIRAoAADTDAAA0QgAANMMK4XpUPxxVD0GLsRBBBHUARgFHAQqpZ7dDJ7GLQqoWC0QEdwBJAUcBCqIHwkOx23NCdVoKRApSuF4/wHIFP1SF/EAEegBGAUcBCopinUO9XYJCXDILRApSnEA/GFUPQTCNjUEEfgBLAUcBCgAAAAAAADRCAAAA'
..'AApyH79DaLCLQsjcCUQKAABAP0JgBT90GsFABIEASQFHAQrdZKpDKdxzQlYVDUQKUrheP8ByBT8/V09CBIUATAFHAQMAAAAAAMCYQAqCIr9DUbiCQj/bCUQKcD0KP1K4DkE9UMJABIgASQFHAQrKpLBDsttzQkt+B0QEigBGAUcBCqnnw0Oy23NCQzQLRApSuF4/wHIF'
..'PxAHjkEEjQBGAUcBCqnnw0MnsYtCQzQLRASPAEYBRwEKj2KdQyexi0JDNAtEBJEASQFHAQpBQMBDsttzQkjIH0QKFK53QEJgBT8j23dBBJQASQFHAQrnC8JDvF2CQnVaCkQKcT1KPxhVD0HKYvpABJcASgFHAQp8655DsttzQsRCCEQKUrheP8ByBT+LsRBBBJoASQFH'
..'AQq8lKVDsttzQh/cKkQEnABJAUcBCkKuqEMnsYtC5RcJRApSuF4/wHIFPw+DNEIEnwBJAUcBCnGltkPnXYJCVhUNRApSOEE/N1QPQfBMNkAEogBJAUcBCsEMwkNosItCdVoKRApSuF4/wHIFP7AU/0AEpQBNAUcBCkJewkOy23NC+0IIRApSuF4/wHIFP+naEEEEqABJ'
..'AUcBCkFAwEOy23NCLSkYRAoUrndAwHIFP2rZd0EEqwBGAUcBCqnnw0Oy23NC9vgbRApSuF4/wHIFP8Pu4kEErgBJAUcBCqwlnkPnXYJCVhUNRASwAEkBRwEKk7i/Q7Lbc0JWFQ1EBLIASQFHAQq8lKVDsttzQi0pGEQKFK53QMByBT9lzQ1CBLcATgFPASEKQ2FuQ29s'
..'bGlkZQIKACDyQgAAAD9UCqtDCgAAgEAAAIA/AACAQCEMVHJhbnNwYXJlbmN5BLsASQFHAQrKpLBDvF2CQpd8B0QKUjREPyRVD0FaO4JCBL4ASQFHAQpCrqhDsttzQuUXCUQEwABJAUcBCryUpUOy23NCSMgfRATCAEsBRwEKch+/Q7Hbc0LI3AlEBMQARgFHAQoYJL5D'
..'aLCLQnxlCEQExgBGAUcBCr2xqEOy23NCKQwcRATIAEkBRwEK02SqQyexi0JWFQ1EBMoATQFHAQpCXsJDJ7GLQvtCCEQEzABKAUcBCnzrnkMnsYtCxEIIRATOAEYBRwEKimKdQyncc0JDNAtEBNAASQFHAQqTuL9DJ7GLQlYVDUQE0gBNAUcBCkJewkO8XYJC+0IIRAo+'
..'xEg/GFUPQQloD0EE1QBJAUcBCtNkqkPGpYlCVhUNRApSOEE/9gHZPz9XT0IhA1JlZATaAFABRwEKAAAAAAAANEMAAAAACi8zNMMAAHJCIYwbRAoAADTDAAAAAAAANMMKKdzMQgAAgD8pHClDIQxHYW1lIE9iamVjdHMhCEJsdWVGbGFnBxcABOMAUQFHAQYNaawKAAAA'
..'AAAAtEIAAAAACm8pqkPkYn5CIQwcRAoAAIA/AACgQAAAgD8hC1NwZWNpYWxNZXNoIQZPZmZzZXQKAACAvwAAAAAAAAAAIQZNZXNoSWQhJ2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTAzODQ5MiEJVGV4dHVyZUlkISdodHRwOi8vd3d3LnJvYmxveC5j'
..'b20vYXNzZXQvP2lkPTEwNDM5NzUhCE1lc2hUeXBlAwAAAAAAABRAIQ1CbHVlRmxhZ1N0YW5kBPAAUQFHAQp5KapDgSlyQikMHEQKAACgQAAAgD8AAKBAIQdSZWRGbGFnBPQAUQFHAQr8diTDAACBQiEMHEQhJ2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9'
..'MTA0Mzk3NyEMUmVkRmxhZ1N0YW5kBPgAUQFHAQr8diTDAAB2QiEMHEQhBlNwYXducyEJU3BlY3RhdG9yIQ5TcGVjdGF0b3JTcGF3bgT+AEYBRwEhCENhblRvdWNoCrIotkIMyx9DdL0aRAoAIIM6bxKDOm8SgzoEAQFGAUcBCsPbWUIMyx9DdL0aRCEFVGVhbXMhBFRl'
..'YW0hCVRlYW1Db2xvcgfsAwfHACEFTG9iYnkHGgAEDAFGAUcBIQpDYXN0U2hhZG93BhsqNQq/mZNCer8XQ9odHEQKAACeQgAAgD8AACBCBA8BRgFHAQq/mZNCer8uQ9odHEQDAAAAYGZm7j8EEgFGAUcBCr+Zk0J6PyND2j0XRAoAAJ5CAACwQQAAgD8EFQFGAUcBCnwz'
..'B0J6PyND2h0cRAoAAIA/AADAQQAAIEIhBEhpbnQEGQFGAUcBCr+Zk0J4PyBD2h0eRAoAAIBBAACAPwAAAEEhC0Fsd2F5c09uVG9wIQ5MaWdodEluZmx1ZW5jZSELTWF4RGlzdGFuY2UDAAAAAAAASUAMAABQQQAAAACAPwAADAAAgD8AAAAAgD8AAAMAAAAAAAAIQCEh'
..'VG8gZXhpdCB0aGUgbWluaWdhbWUgc2F5ICIvbGVhdmUiBCQBRgFHAQq+mZNCej8jQ9r9IEQEJgFGAUcBCr6Z40J6PyND2h0cRCEHVGVycmFpbgc2AQQsAUYBRwEGW5pMAwAAAAAAAJRACt9s0UP5/65CH8waRAoAAMBAAACAPwCAmUMELwHnAEcBCjPzpkIAAG5CIYwb'
..'RArWuiZEAACAPwCAlkMHJgAENAFGAUcBBqBfNQrfbNFDAAAuQh/MGkQKAADAQAAArkIAgJlDBDcB5wBHAQphm6pCAAAuQkBY6kMK46QnRAAArkIAAMBABDoBRgFHAQpPBahC+f+uQkBY6kMKXP8mRAAAgD8AAMBABD0BRgFHAQp7yaVC+f+uQiDsQUQKanApRAAAgD8A'
..'AMBABEABRgFHAQqrpaVCAAAuQiDsQUQKdWcpRAAArkIAAMBABEMBRgFHAQoU/HzD+f+uQh/MGkQERQFGAUcBChT8fMMAAC5CH8waRAoAAIA/AAAAAAAAwDMKAAAAAAAAgD8AAAAACkTwA8IAAABCAITFQQoAAMCzAAAAAAAAgD8K9AQ1vwAAAADzBDW/CvQENT8AAAAA'
..'8gQ1vwrzBDU/AAAAAPMENb8K8wQ1PwAAAAD0BDW/CgAAgD8AAICpAAAAAAoAAICpAACAPwAAAAAKAACAvwAAAAAAAMCzCgAAwDMAAAAAAACAv2UBAAABAAIAAwAEAAEIAAIABQAGAAcACAAJAAoACwAMAA0ADgAPABAAEQASAAcAEwACBAAUABUAFgAXABgAGQAQABoA'
..'GwADCQAcAB0AHgAfABAAIAAhACIAIwAkACUAJgAnABcAKAApACoAFwAbAAMKABwAHQAeABUADgArABAAIAAhACIAIwAsACUALQAnABcAKAApACoAFwAbAAMKABwAHQAeABUADgAuABAAIAAhACIAIwAvACUAMAAnABcAKAApACoAFwAxAAIBADIAMwA0AAECAAIANQA2'
..'ADcAOAAIAgACADkAOgA7AAEAAQEAAgA8AAQACgYAPQAXAAYABwAKAD4ADgA/ABAAQAASAAcABAAKCwA9ABcABgAHAAgAQQAKAEIADABDAEQARQBGAEcADgBIAEkARwAQAEoAEgAHAAQACgkAPQAXAAYABwAKAEsARABMAEYARwAOAE0ASQBHABAATgASAAcABAAKCQA9'
..'ABcABgAHAAgAQQAKAE8ADABDAEQARQAOAFAAEABRABIABwAEAAoJAD0AFwAGAAcACgBSAEQATABGAEcADgBTAEkARwAQAFQAEgAHAAQACgsAPQAXAAYABwAIAEEACgBVAAwAQwBEAEUARgBHAA4AVgBJAEcAEABXABIABwAEAAoHAD0AFwAGAAcACgBYAEQATAAOAFkA'
..'EABaABIABwAEAAoHAD0AFwAGAAcACgBbAEQATAAOAFwAEABdABIABwAEAAoJAD0AFwAGAAcACgBeAEQATABGAEcADgBfAEkARwAQAE4AEgAHAAQACgcAPQAXAAYABwAKAGAARABMAA4AYQAQAGIAEgAHAAQACgkAPQAXAAYABwAIAEEACgBjAAwAQwBEAEUADgBkABAA'
..'ZQASAAcABAAKBwA9ABcABgAHAAoAZgBEAEwADgBnABAAaAASAAcABAAKBwA9ABcABgAHAAoAaQBEAEwADgBqABAAawASAAcABAAKCQA9ABcABgAHAAgAQQAKAGwADABDAEQARQAOAG0AEABuABIABwAEAAoLAD0AFwAGAAcACABBAAoAbwAMAEMARABFAEYAcAAOAHEA'
..'SQByABAAcwASAAcABAAKBwA9ABcABgAHAAoAdABEAEwADgB1ABAAXQASAAcABAAKCQA9ABcABgAHAAoAdgBEAEwARgBHAA4AdwBJAEcAEAB4ABIABwAEAAoJAD0AFwAGAAcACABBAAoAeQAMAEMARABFAA4AegAQAHsAEgAHAAQACgkAPQAXAAYABwAKAHwARABMAEYA'
..'fQAOAH4ASQB9ABAAfwASAAcABAAKCQA9ABcABgAHAAoAgABEAEwARgBHAA4AgQBJAEcAEACCABIABwAEAAoLAD0AFwAGAAcACABBAAoAgwAMAEMARACEAEYAfQAOAIUASQB9ABAAhgASAAcABAAKCQA9ABcABgAHAAoAhwBEAEwARgBHAA4AiABJAEcAEABUABIABwAE'
..'AAoHAD0AFwAGAAcACgCJAEQATAAOAIoAEACLABIABwAEAAoHAD0AFwAGAAcACgCMAEQATAAOAI0AEACLABIABwAEAAoHAD0AFwAGAAcACgCOAEQATAAOAI8AEACLABIABwAEAAoJAD0AFwAGAAcACgCQAEQATABGAEcADgCRAEkARwAQAJIAEgAHAAQACgsAPQAXAAYA'
..'BwAIAEEACgCTAAwAQwBEAEUARgBHAA4AlABJAEcAEACVABIABwAEAAoJAD0AFwAGAAcACgCWAEQATABGAHAADgCXAEkAcgAQAJgAEgAHAAQACgkAPQAXAAYABwAKAJkARABMAEYARwAOAJoASQBHABAAYgASAAcABAAKCQA9ABcABgAHAAoAmwBEAEwARgBHAA4AnABJ'
..'AEcAEACdABIABwAEAAoLAD0AFwAGAAcACABBAAoAngAMAEMARABFAEYARwAOAJ8ASQBHABAAoAASAAcABAAKCQA9ABcABgAHAAoAoQBEAEwARgBHAA4AogBJAEcAEACjABIABwAEAAoJAD0AFwAGAAcACgCkAEQATABGAH0ADgClAEkAfQAQAKYAEgAHAAQACgkAPQAX'
..'AAYABwAKAKcARABMAEYARwAOAKgASQBHABAAqQASAAcABAAKBwA9ABcABgAHAAoAqgBEAEwADgCrABAArAASAAcABAAKCwA9ABcABgAHAAgAQQAKAK0ADABDAEQARQBGAEcADgCuAEkARwAQAKAAEgAHAAQACgkAPQAXAAYABwAKAK8ARABMAEYARwAOALAASQBHABAA'
..'YgASAAcABAAKCQA9ABcABgAHAAoAsQBEAEwARgBHAA4AsgBJAEcAEACzABIABwAEAAoIAD0AFwAGAAcACgC0ALUAtgAOALcAEAC4ABIABwC5ABUABAAKCwA9ABcABgAHAAgAQQAKALoADABDAEQARQBGAEcADgC7AEkARwAQALwAEgAHAAQACgkAPQAXAAYABwAKAL0A'
..'RABMAEYARwAOAL4ASQBHABAAnQASAAcABAAKCQA9ABcABgAHAAoAvwBEAEwARgBHAA4AwABJAEcAEACzABIABwAEAAoJAD0AFwAGAAcACgDBAEQATABGAH0ADgDCAEkAfQAQAH8AEgAHAAQACgcAPQAXAAYABwAKAMMARABMAA4AxAAQAFoAEgAHAAQACgcAPQAXAAYA'
..'BwAKAMUARABMAA4AxgAQAGIAEgAHAAQACgkAPQAXAAYABwAKAMcARABMAEYARwAOAMgASQBHABAAggASAAcABAAKCQA9ABcABgAHAAoAyQBEAEwARgB9AA4AygBJAH0AEACmABIABwAEAAoJAD0AFwAGAAcACgDLAEQATABGAHAADgDMAEkAcgAQAJgAEgAHAAQACgcA'
..'PQAXAAYABwAKAM0ARABMAA4AzgAQAIsAEgAHAAQACgkAPQAXAAYABwAKAM8ARABMAEYARwAOANAASQBHABAAYgASAAcABAAKCwA9ABcABgAHAAgAQQAKANEADABDAEQARQBGAH0ADgDSAEkAfQAQANMAEgAHAAQACgsAPQAXAAYABwAIAEEACgDUAAwAQwBEAEUARgBH'
..'AA4A1QBJAEcAEADWABIABwABAAEBAAIA1wAEAD8IAD0AFwAGAAcACgDYAEYA2QAOANoASQDbABAA3AASAAcAAQABAQACAN0ABABBCwACAN4APQAXAAYABwAIAN8ACgDgAAwA4QBGAOIADgDjAEkA4gAQAOQAEgAHAOUAQgQA5gDnAOgA6QDqAOsA7ADtAAQAQQsAAgDu'
..'AD0AFwAGAAcACADfAAoA7wAMAOEARgDiAA4A8ABJAOIAEADxABIABwAEAEELAAIA8gA9ABcABgAHAAgA3wAKAPMADADhAEYA4gAOAPQASQDiABAA5AASAAcA5QBFBADmAOcA6ADpAOoA9QDsAO0ABABBCwACAPYAPQAXAAYABwAIAAkACgD3AAwADQBGAOIADgD4AEkA'
..'4gAQAPEAEgAHAAEAQQEAAgD5AAEASAEAAgDXAAEASAEAAgA8AAEASAEAAgD6AAQASwoAAgD7AD0AFwAGAAcACgD8ALUAtgD9ALYADgD+ABAA/wASAAcAuQAVAAQASwoAAgD7AD0AFwAGAAcACgAAAbUAtgD9ALYADgABARAA/wASAAcAuQAVAAEAAQEAAgACAQMBTgIA'
..'AgDXAAQBBQEDAU4CAAIAPAAEAUEAAwFOAgACAPoABAEGAQEAAQEAAgAHAQQAUgoAPQAXAAYABwAIAAgBCgAJAQoBtgAMAAsBRACEAA4ADAEQAA0BEgAHAAQAUgoAPQAXAAYABwAIAAgBCgAOAQoBtgAMAAsBDgAPARAADQESAAcAuQAQAQQAUgoAPQAXAAYABwAIAAgB'
..'CgARAQoBtgAMAAsBDgASARAAEwESAAcAuQAQAQQAUgoAPQAXAAYABwAIAAgBCgAUAQoBtgAMAAsBDgAVARAAFgESAAcAuQAQAQQAUgsAAgAXAT0AFwAGAAcACgAYAbUAtgD9ALYACgG2AA4AGQEQABoBEgAHALkAFQATAFcGABQAFQAWABcAGwEXABwBFQAdAR4BEAAf'
..'ARsAWAkAHAAdAB4AHwAQACABIQAhASMAIgElACYAJwAXACgAKQAqABcABABSCgA9ABcABgAHAAgACAEKACMBCgG2AAwACwEOACQBEAATARIABwC5ABABBABSCgA9ABcABgAHAAgACAEKACUBCgG2AAwACwEOACYBEAAWARIABwC5ABABAQABAQACACcBBABcCQA9ABcA'
..'BgAHAAgAKAEKACkBDAAqAUQAKwEOACwBEAAtARIABwAEAFwLAD0AFwAGAAcACAAoAQoALgEMACoBRAArAUYA2QAOAC8BSQDbABAAMAESAAcABABcCQA9ABcABgAHAAgAMQEKADIBDAAzAUQAKwEOADQBEAA1ARIABwAEAFwLAD0AFwAGAAcACAAxAQoANgEMADMBRAAr'
..'AUYA2QAOADcBSQDbABAAOAESAAcABABcCQA9ABcABgAHAAgAKAEKADkBDAAqAUQAKwEOADoBEAA7ARIABwAEAFwJAD0AFwAGAAcACAAoAQoAPAEMACoBRAArAQ4APQEQAD4BEgAHAAQAXAkAPQAXAAYABwAIADEBCgA/AQwAMwFEACsBDgBAARAAQQESAAcABABcCQA9'
..'ABcABgAHAAgAKAEKAEIBDAAqAUQAKwEOAEMBEAAtARIABwAEAFwJAD0AFwAGAAcACAAxAQoARAEMADMBRAArAQ4ARQEQADUBEgAHAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end
