-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 9972 characters

local ScriptFunctions = {
function(script,require)
script.Parent.TELE1.GUI.ClickDetector.MouseClick:Connect(function(plr)
	plr.Character:PivotTo(script.Parent.TELE2.WorldPivot+Vector3.new(0,3,0))
end)
script.Parent.TELE2.GUI.ClickDetector.MouseClick:Connect(function(plr)
	plr.Character:PivotTo(script.Parent.TELE1.WorldPivot+Vector3.new(0,3,0))
end)
end,
function(script,require)
script.Parent.TELE1.GUI.ClickDetector.MouseClick:Connect(function(plr)
	plr.Character:PivotTo(script.Parent.TELE2.WorldPivot+Vector3.new(0,3,0))
end)
script.Parent.TELE2.GUI.ClickDetector.MouseClick:Connect(function(plr)
	plr.Character:PivotTo(script.Parent.TELE1.WorldPivot+Vector3.new(0,3,0))
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


local Objects = Decode('AEA2ASEFTW9kZWwhCldvcmxkUGl2b3QEJwEoASkBIQROYW1lIQVURUxFMQQqASgBKQEhBFBhcnQhA1RQMSEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yB2oAIQZDRnJhbWUEGAAoASkBIQpDYW5Db2xsaWRlAiEFQ29sb3IG2oVB'
..'IQhNYXRlcmlhbAMAAAAAAMCYQCEIUG9zaXRpb24K1+M6QyPbeUB7FJtCIQRTaXplCgAAgD8AAIA/AACAPyEKVG9wU3VyZmFjZSEJREIgQnV0dG9uB0wBBCEAKAEpAQZ1AAADAAAAAAAAckAKwjU1QzdO/D/xIKVCCpnxgD7A0oE+CtejPCEKU3VyZmFjZUd1aSEOWklu'
..'ZGV4QmVoYXZpb3IDAAAAAAAA8D8hEENsaXBzRGVzY2VuZGFudHMhDkxpZ2h0SW5mbHVlbmNlIQ1QaXhlbHNQZXJTdHVkAwAAAAAAAHlAIQpTaXppbmdNb2RlIQVGcmFtZSEQQmFja2dyb3VuZENvbG9yMwb///8hFkJhY2tncm91bmRUcmFuc3BhcmVuY3kMAACAPwAA'
..'AACAPwAAIQlUZXh0TGFiZWwhBEZvbnQDAAAAAAAACEAhBFRleHQhBURlYnVnIQpUZXh0Q29sb3IzBgAAACEKVGV4dFNjYWxlZCEIVGV4dFNpemUDAAAAAAAALEAhC1RleHRXcmFwcGVkIQ1DbGlja0RldGVjdG9yIQNHVUkHNgEEQAAoASkBBluaTArCNTVDzK8cQPEg'
..'pUIhBERvd24H9AMERQAoASkBBiFUuQrCNTVDtHANQEYjpUIKmZmZPhSuRz8K16M8IQlTcG90TGlnaHQhCkJyaWdodG5lc3MDAAAAAAAA4D8GVf//IQdTaGFkb3dzIQVBbmdsZQMAAAAAAMBiQCEFUmFuZ2UDAAAAAAAAKEAH6wMEUwAoASkBBhEREQrNMjRDtHANQEYj'
..'pUIK56THPxSuRz8K16M8B8cABFkAKAEpAQZjX2IDAAAAAACAkEAK1+M6Q1Bejz17FJtCClyPekEpXA8+mZlJQSEOVW5pb25PcGVyYXRpb24EXQAoASkBCtjjOkNQXo89exSbQgqYwoFBKlwPPrBHUUEhDFVzZVBhcnRDb2xvcgq4Hn1B61E4Ph6FS0EK2OM6QxFUuD17'
..'FJtCCgAAAAAAAAAAAAAAAAqPwoFBKVwPPq5HUUEK1+M6Q09ejz17FJtCB+0DBGgAKAEpAQbu0gIK1+M6Q+DGdT17FJtCCs3MgEGPwvU9KFxPQQRsACgBKQEDAAAAAACAiUAK1+M6Q0DbIz17FJtCCnA9jkEK16M9wvVoQQRyACsBLAEDAAAAAAAAkUAhC09yaWVudGF0'
..'aW9uCgAAAAAAADRDAAAAAArXYzRDnBSuP249pkIhCFJvdGF0aW9uCgAANEMAAAAAAAA0QwoApBBAehQuQEBcjz8KrkcBQF77D0CZmZk/CtZjNENwWxg/cD2mQgrXoxBAehQuQCdcjz8K12M0Q5wUrj9vPaZCIQZTY3JpcHQhBVRFTEUyBC0BLgEpAQR/AC4BKQEKAAAA'
..'AAAAtEIAAAAACnrejUUj23lAsZngQgSBAC4BKQEKrAaORTdO/D/b9etCBIMALgEpAQqsBo5FzK8cQNv160IEhQAuASkBCrUGjkW0cA1A2/XrQgSHAC4BKQEKtQaORbRwDUDF++1CBIkALgEpAQp63o1FUF6PPbGZ4EIEiwAuASkBCnrejUVQXo89r5ngQgp63o1FEVS4'
..'Pa+Z4EIKet6NRU9ejz2xmeBCBI8ALgEpAQp63o1F4MZ1PbGZ4EIEkQAuASkBCnrejUVA2yM9sZngQgSUAC8BMAEKAAAAAAAAtMIAAAAACh4LjkWcFK4/sZntQgoeC45FcFsYP7OZ7UIElwAoASkBCkSIjUWkeQRBuN3vQgoAoAA/DCuEQQAAAEAEmgAoASkBCkSIjUWk'
..'eQRBz9LQQgScACgBKQEKwS+ORaR5BEHP0tBCBJ4AKAEpAQrBL45FpHkEQbjd70IEoAAoASkBCkfcjUVCroJB233gQgoANaxBhevRPpn3kUEEowAoASkBCtm6jUU1K4FBQEvgQgoASgRBgFvvPetRfEEEpgAoASkBCiH+jUU1K4FBQEvgQgSoACgBKQEKjNyNRahCgUFA'
..'S+BCCgCoh0GAdsA9JpmCQQSrADEBKQEKnh+ORRjMgUEAoNZCCgAAgEAAAIA/AAAAQCEFU2hhcGUDAAAAAAAAAEAEsAAxASkBCp4fjkUYzIFB5tvqQgSyADEBKQEKZpmNRRjMgUHm2+pCBLQAMQEpAQpmmY1FGMyBQQCg1kIEtgAoASkBChrVjUVANx08TC6gQgoAy1BC'
..'QCadPK7HuEIEuQAoASkBCrPXjUXddAI/rQogQgqP9ANCmXSCPxSuQ0EEvAAoASkBCqzXjUVvOoE/rQoeQgqP+wNCTDoBQBSuM0EEvwAoASkBCq3XjUVuOsE/rQocQgoP+wNCTDpBQBSuI0EHLgEExAAoASkBBltdaQq8U41F+n75P44FIkIKAACoPON6hEAM11NBCgrX'
..'ozzheoRACtcjQQq8U41F+H75P48FHEIhCVdlZGdlUGFydAoA16M8AABAQAAAQEAKvFONRV06IUBwgDZCCgAAAAAAADTDAAAAAAoK16M8hOuRPwrXU0EKvFONReD75T6PBSJCBNAAKAEpAQMAAAAAAABxQAqtZ41FHILCP+oUHEIKwMN+P/qBQkAAACRBBNMAKAEpAQqt'
..'R45FHILCP+oUHEIE1QAoASkBCq1HjkU4BAU/6hQgQgTXACgBKQEKrWeNRTgEBT/qFCBCBNkAKAEpAQqtZ41FkPf1vuoUJEIE2wAoASkBCq1HjkWQ9/W+6hQkQgTdACgBKQEKrWeNReR9vb/qFExCBN8AKAEpAQqtR45F5H29v+oUTEIE4QAoASkBCqjXjUVdOilA6pQD'
..'QgoAAPhBAACgPwAAAEAE5AAoASkBCqhSjkUunfRA6pQDQgoAAIA+AAA0QQAAAEAE5wAoASkBCqhcjUUunfRA6pQDQgTpACgBKQEKqH2ORTCd0EDqlANCCgAAKEEAAFhBAAAAQATsACgBKQEKqC+NRTCd0EDqlANCCgAAMEEAAFhBAAAAQATvACgBKQEK5VuORQACDb+P'
..'BR5CBPEAKAEpAQq8W45F+H75P44FIkIKAACsPOJ6hEAM11NBCrxbjkXg++U+jwUiQgq8W45F+H75P48FHEIKvFuORV06IUBwgDZCBDIBMwEpAQT4ADMBKQEKmteNRbpJ3EAAKajCBPoAMwEpAQpor41Ft2+eQCqFs8IE/AAzASkBCmivjUUPtK1AKoWzwgT+ADMBKQEK'
..'X6+NRYMUpkAqhbPCBAABMwEpAQpfr41FgxSmQBSLtcIEAgEzASkBCprXjUVEM0NAACmowgQEATMBKQEKmteNRUQzQ0D+KKjCCprXjUXyekRA/iiowgQHATMBKQEKmteNRW6PQkAAKajCBAkBMwEpAQqa141Fv0dBQAApqMIECwE0ATUBCvaqjUVQ4YpAACm1wgr2qo1F'
..'Ls9kQAIptcIENgEuASkBBA8BLgEpAQqE6Y1FQWAHQk5m6MIEEQEuASkBCrYRjkUCSv9BJArdwgQTAS4BKQEKthGORYyNAUIkCt3CBBUBLgEpAQq/EY5FmpkAQiQK3cIEFwEuASkBCr8RjkWamQBCOgTbwgQZAS4BKQEKhOmNRX0U8EFOZujCBBsBLgEpAQqE6Y1FfRTw'
..'QVBm6MIKhOmNRXM98EFQZujCBB4BLgEpAQqE6Y1FAgDwQU5m6MIEIAEuASkBCoTpjUUM1+9BTmbowgQiAS8BMAEKKBaORWhm+kFOZtvCCigWjkX6R/RBTGbbwgQlASgBKQEKo9SNRW46wT/Cb/fBCtLwAEJMOkFA96j7QgrlNRRFYG8MQEwuoEIKAACAPwAAAAAAAAAA'
..'CgAAAAAAAIA/AAAAAArX4zpDnBSuP3sUm0IKAACAvy69u7PtrQkoCi69u7MAAIA/Lr27swp63o1FnBSuP7GZ4EIKAAAAAAAAAAAAAIC/Cu2tCSguvbuzAACAPwouvbuzAACAPy69uzMKLr07swAAAAAAAIC/CprXjUVQ4YpAACmowgoAAAAAAAAAAAAAgD8K7a0JqC69'
..'u7MAAIC/Ci69uzMAAIA/Lr27swqE6Y1FaGb6QU5m6MJ1AQAAAQACAAMAAQABAgAEAAUAAgAGAAcAAgsABAAIAAkACgALAAwADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAaABsADAAHAAIKAAQAHAAJAAoACwAMAA0AHQAPAB4AEwAfABUAIAAXACEAGQAiABsADAAj'
..'AAQFACQAJQAmAAoAJwAlACgAKQAqACUAKwAFAwAsAC0ALgAlABkALwAwAAYJACwALQAuACUAGQAvADEAMgAzADQANQA2ADcACgA4ADkAOgAKADsABAAABwACCgAEADwACQAKAAsADAANAD0ADwA+ABMAPwAVACAAFwBAABkAIgAbAAwAIwAJBQAkACUAJgAKACcAJQAo'
..'ACkAKgAlACsACgMALAAtAC4AJQAZAC8AMAALCQAsAC0ALgAlABkALwAxADIAMwBBADUANgA3AAoAOAA5ADoACgA7AAkAAAcAAgkACQAKAAsADAANAEIADwBDABMARAAVACAAFwBFABkARgAbAAwARwAOBQBIAEkAEwBKAEsACgBMAE0ATgBPAAcAAgkACQAKAAsADAAN'
..'AFAADwBRABMAUgAVACAAFwBTABkAVAAbAAwABwACCQAJAAoACwAMAA0AVQAPAFYAEwBXABUAWAAXAFkAGQBaABsADABbAEACgAcAYABhAGIAAAcAYwBkAGIAAggACQAKAA0AVQAPAFwAEwBXABUAWAAXAF0AGQBeAF8ACgAHAAIJAAkACgALAAwADQBlAA8AZgATAGcA'
..'FQBYABcAaAAZAGkAGwAMAAcAAgcACQAKAAsADAAPAGoAFQBrABcAbAAZAG0AGwAMAFsAQAKABwB2AHcAYgAABwB4AHkAcQACCgAJAAoADQBVAA8AbgATAFcAFQBvAHAAcQAXAHIAcwB0ABkAdQBfAAoAegABAAABAAECAAQAewACAHwABwAXDQAEAAgACQAKAAsADAAN'
..'AA4ADwB9ABEAEgATABQAFQAWAHAAfgAXAH8AcwB+ABkAGgAbAAwABwAXDAAEABwACQAKAAsADAANAB0ADwCAABMAHwAVACAAcAB+ABcAgQBzAH4AGQAiABsADAAjABkFACQAJQAmAAoAJwAlACgAKQAqACUAKwAaAwAsAC0ALgAlABkALwAwABsJACwALQAuACUAGQAv'
..'ADEAMgAzADQANQA2ADcACgA4ADkAOgAKADsAGQAABwAXDAAEADwACQAKAAsADAANAD0ADwCCABMAPwAVACAAcAB+ABcAgwBzAH4AGQAiABsADAAjAB4FACQAJQAmAAoAJwAlACgAKQAqACUAKwAfAwAsAC0ALgAlABkALwAwACAJACwALQAuACUAGQAvADEAMgAzAEEA'
..'NQA2ADcACgA4ADkAOgAKADsAHgAABwAXCwAJAAoACwAMAA0AQgAPAIQAEwBEABUAIABwAH4AFwCFAHMAfgAZAEYAGwAMAEcAIwUASABJABMASgBLAAoATABNAE4ATwAHABcLAAkACgALAAwADQBQAA8AhgATAFIAFQAgAHAAfgAXAIcAcwB+ABkAVAAbAAwABwAXCwAJ'
..'AAoACwAMAA0AVQAPAIgAEwBXABUAWABwAH4AFwCJAHMAfgAZAFoAGwAMAFsAQAKABwBgAIwAfgAABwBjAI0AfgAXCgAJAAoADQBVAA8AigATAFcAFQBYAHAAfgAXAIsAcwB+ABkAXgBfAAoABwAXCwAJAAoACwAMAA0AZQAPAI4AEwBnABUAWABwAH4AFwCPAHMAfgAZ'
..'AGkAGwAMAAcAFwkACQAKAAsADAAPAJAAFQBrAHAAfgAXAJEAcwB+ABkAbQAbAAwAWwBAAoAHAHYAlQB+AAAHAHgAlACTABcKAAkACgANAFUADwCSABMAVwAVAG8AcACTABcAlABzAJMAGQB1AF8ACgAHAAAHAAkACgALAAwADwCWABUAawAXAJcAGQCYABsADAAHAAAH'
..'AAkACgALAAwADwCZABUAawAXAJoAGQCYABsADAAHAAAHAAkACgALAAwADwCbABUAawAXAJwAGQCYABsADAAHAAAHAAkACgALAAwADwCdABUAawAXAJ4AGQCYABsADAAHAAAHAAkACgALAAwADwCfABUAawAXAKAAGQChABsADAAHAAAJAAkACgALAAwADQBVAA8AogAT'
..'AFcAFQBYABcAowAZAKQAGwAMAAcAAAkACQAKAAsADAANAFUADwClABMAVwAVAFgAFwCmABkApAAbAAwABwAACQAJAAoACwAMAA0AVQAPAKcAEwBXABUAWAAXAKgAGQCpABsADAAHAAAKAAkACgALAAwADwCqABUAWABwAH4AFwCrAHMAfgAZAKwAGwAMAK0ArgAHAAAK'
..'AAkACgALAAwADwCvABUAWABwAH4AFwCwAHMAfgAZAKwAGwAMAK0ArgAHAAAKAAkACgALAAwADwCxABUAWABwAH4AFwCyAHMAfgAZAKwAGwAMAK0ArgAHAAAKAAkACgALAAwADwCzABUAWABwAH4AFwC0AHMAfgAZAKwAGwAMAK0ArgAHAAAJAAkACgALAAwADQBVAA8A'
..'tQATAFcAFQBrABcAtgAZALcAGwAMAAcAAAkACQAKAAsADAANAFUADwC4ABMAVwAVAGsAFwC5ABkAugAbAAwABwAACQAJAAoACwAMAA0AVQAPALsAEwBXABUAawAXALwAGQC9ABsADAAHAAAJAAkACgALAAwADQBVAA8AvgATAFcAFQBrABcAvwAZAMAAGwAMAFsAQAMA'
..'BwDGAMcAYgAAyADJAMoAywAABwDMAM0AYgAABwAJAAoADQDBAA8AwgATAMMAFQBYABcAxAAZAMUABwAACQAJAAoACwAMAA0AZQAPAM4AEwBnABUAzwAXANAAGQDRABsADAAHAAAJAAkACgALAAwADQBlAA8A0gATAGcAFQDPABcA0wAZANEAGwAMAAcAAAkACQAKAAsA'
..'DAANAGUADwDUABMAZwAVAM8AFwDVABkA0QAbAAwABwAACQAJAAoACwAMAA0AZQAPANYAEwBnABUAzwAXANcAGQDRABsADAAHAAAJAAkACgALAAwADQBlAA8A2AATAGcAFQDPABcA2QAZANEAGwAMAAcAAAkACQAKAAsADAANAGUADwDaABMAZwAVAM8AFwDbABkA0QAb'
..'AAwABwAACQAJAAoACwAMAA0AZQAPANwAEwBnABUAzwAXAN0AGQDRABsADAAHAAAJAAkACgALAAwADQBlAA8A3gATAGcAFQDPABcA3wAZANEAGwAMAAcAAAkACQAKAAsADAANAFUADwDgABMAVwAVAG8AFwDhABkA4gAbAAwABwAACQAJAAoACwAMAA0AVQAPAOMAEwBX'
..'ABUAbwAXAOQAGQDlABsADAAHAAAJAAkACgALAAwADQBVAA8A5gATAFcAFQBvABcA5wAZAOUAGwAMAAcAAAkACQAKAAsADAANAFUADwDoABMAVwAVAGsAFwDpABkA6gAbAAwABwAACQAJAAoACwAMAA0AVQAPAOsAEwBXABUAawAXAOwAGQDtABsADAAHAAAGAAkACgAL'
..'AAwADwDuABcA7wAZAMwAGwAMAFsAQAMABwDMAPMAYgAABwDGAPQAYgAAyADJAPUAywAACAAJAAoADQDBAA8A8AATAMMAFQBYABcA8QAZAPIAXwAKAAEAAAEAAgADAAEASwIABAAFAAIA9gAHAEwNAAQACAAJAAoACwAMAA0ADgAPAPcAEQASABMAFAAVABYAcACTABcA'
..'+ABzAJMAGQAaABsADAAHAEwMAAQAHAAJAAoACwAMAA0AHQAPAPkAEwAfABUAIABwAJMAFwD6AHMAkwAZACIAGwAMACMATgUAJAAlACYACgAnACUAKAApACoAJQArAE8DACwALQAuACUAGQAvADAAUAkALAAtAC4AJQAZAC8AMQAyADMANAA1ADYANwAKADgAOQA6AAoA'
..'OwBOAAAHAEwMAAQAPAAJAAoACwAMAA0APQAPAPsAEwA/ABUAIABwAJMAFwD8AHMAkwAZACIAGwAMACMAUwUAJAAlACYACgAnACUAKAApACoAJQArAFQDACwALQAuACUAGQAvADAAVQkALAAtAC4AJQAZAC8AMQAyADMAQQA1ADYANwAKADgAOQA6AAoAOwBTAAAHAEwL'
..'AAkACgALAAwADQBCAA8A/QATAEQAFQAgAHAAkwAXAP4AcwCTABkARgAbAAwARwBYBQBIAEkAEwBKAEsACgBMAE0ATgBPAAcATAsACQAKAAsADAANAFAADwD/ABMAUgAVACAAcACTABcAAAFzAJMAGQBUABsADAAHAEwLAAkACgALAAwADQBVAA8AAQETAFcAFQBYAHAA'
..'kwAXAAIBcwCTABkAWgAbAAwAWwBAAoAHAGAABQGTAAAHAGMAAgGTAEwKAAkACgANAFUADwADARMAVwAVAFgAcACTABcABAFzAJMAGQBeAF8ACgAHAEwLAAkACgALAAwADQBlAA8ABgETAGcAFQBYAHAAkwAXAAcBcwCTABkAaQAbAAwABwBMCQAJAAoACwAMAA8ACAEV'
..'AGsAcACTABcACQFzAJMAGQBtABsADABbAEACgAcAdgAMAZMAAAcAeAALAX4ATAoACQAKAA0AVQAPAAoBEwBXABUAbwBwAH4AFwALAXMAfgAZAHUAXwAKAHoASwAAAQBLAgAEAHsAAgANAQcAYQ0ABAAIAAkACgALAAwADQAOAA8ADgERABIAEwAUABUAFgBwAH4AFwAP'
..'AXMAfgAZABoAGwAMAAcAYQwABAAcAAkACgALAAwADQAdAA8AEAETAB8AFQAgAHAAfgAXABEBcwB+ABkAIgAbAAwAIwBjBQAkACUAJgAKACcAJQAoACkAKgAlACsAZAMALAAtAC4AJQAZAC8AMABlCQAsAC0ALgAlABkALwAxADIAMwA0ADUANgA3AAoAOAA5ADoACgA7'
..'AGMAAAcAYQwABAA8AAkACgALAAwADQA9AA8AEgETAD8AFQAgAHAAfgAXABMBcwB+ABkAIgAbAAwAIwBoBQAkACUAJgAKACcAJQAoACkAKgAlACsAaQMALAAtAC4AJQAZAC8AMABqCQAsAC0ALgAlABkALwAxADIAMwBBADUANgA3AAoAOAA5ADoACgA7AGgAAAcAYQsA'
..'CQAKAAsADAANAEIADwAUARMARAAVACAAcAB+ABcAFQFzAH4AGQBGABsADABHAG0FAEgASQATAEoASwAKAEwATQBOAE8ABwBhCwAJAAoACwAMAA0AUAAPABYBEwBSABUAIABwAH4AFwAXAXMAfgAZAFQAGwAMAAcAYQsACQAKAAsADAANAFUADwAYARMAVwAVAFgAcAB+'
..'ABcAGQFzAH4AGQBaABsADABbAEACgAcAYAAcAX4AAAcAYwAZAX4AYQoACQAKAA0AVQAPABoBEwBXABUAWABwAH4AFwAbAXMAfgAZAF4AXwAKAAcAYQsACQAKAAsADAANAGUADwAdARMAZwAVAFgAcAB+ABcAHgFzAH4AGQBpABsADAAHAGEJAAkACgALAAwADwAfARUA'
..'awBwAH4AFwAgAXMAfgAZAG0AGwAMAFsAQAKABwB2ACMBfgAABwB4ACIBkwBhCgAJAAoADQBVAA8AIQETAFcAFQBvAHAAkwAXACIBcwCTABkAdQBfAAoABwAACQAJAAoACwAMAA0AVQAPACQBEwBXABUAawAXACUBGQAmARsADAAA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
