-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11512 characters

local ScriptFunctions = {
function(script,require)
--Made by xImmortalChaos for Site-40.

local Door = script.Parent.Door
local Door2 = script.Parent.Door2
local Button1 = script.Parent.Button1
local Button2 = script.Parent.Button2
local Open = false

local OpenSound = Door.DoorOpen
local CloseSound = Door.DoorClose

local Debounce = false
function Triggered(Player)
	if Player.Character == nil then return end
	if Player.Character:FindFirstChild("User Setup") == nil then return end
	if Player.Character:FindFirstChild("AccessLevel").Value < 7 then 
		Door.AccessDenied:Play()
		return end
	if not Debounce then
		Debounce = true
		if Open then
			Open = false
			CloseSound:Play()
			--Door.Transparency = 0
			for i,v in pairs(Door:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 0
				end
			end
			spawn(function()
				for i = 3,(Door.Size.z / 0.15)  do
					Door.CFrame = Door.CFrame + (Door.CFrame.lookVector * 0.15)

					wait()
				end
			end)

			spawn(function()
				for i = 3,(Door2.Size.z / 0.15) do
					Door2.CFrame = Door2.CFrame + (Door2.CFrame.lookVector * 0.15)

					wait()
				end
			end)
		else
			Open = true
			OpenSound:Play()
			spawn(function()
				for i = 3,(Door.Size.z / 0.15) do
					Door.CFrame = Door.CFrame - (Door.CFrame.lookVector * 0.15)

					wait()
				end
			end)
			spawn(function()
				for i = 3,(Door2.Size.z / 0.15) do
					Door2.CFrame = Door2.CFrame - (Door2.CFrame.lookVector * 0.15)

					wait()
				end
			end)
			--Door.Transparency = 1
			for i,v in pairs(Door:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 1
				end
			end
		end
		wait(0.4)
		Debounce = false
	end
end
Button1.ProximityPrompt.Triggered:connect(Triggered)
Button2.ProximityPrompt.Triggered:connect(Triggered)

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


local Objects = Decode('AEDjASEFTW9kZWwhBE5hbWUhFExldmVsIERldmVsb3BlciBkb29yIQpXb3JsZFBpdm90BKEBogGjASEERG9vcgShAaQBpQEhElNjcmlwdGVkQ29tcG9uZW50cwSmAacBqAEhBlNjcmlwdCEETWFpbiEOVW5pb25PcGVyYXRpb24hBURvb3IyIQhBbmNob3JlZCIhCkJy'
..'aWNrQ29sb3IHwgAhBkNGcmFtZQQdAKcBqAEhCkNhbkNvbGxpZGUCIQVDb2xvcgajoqUhCE1hdGVyaWFsAwAAAAAAgIlAIQtPcmllbnRhdGlvbgoAAAAACtcjvI/C9TwhCFBvc2l0aW9uCsLkOUMsefo/EtI9wyEIUm90YXRpb24hBFNpemUKzcxMPbSzRz8l2Q8/IQxU'
..'cmFuc3BhcmVuY3kDAAAAAAAA8D8hBFBhcnQKFWumPBhrpjyp0/E+Cg3iOUPn2Mk/t849wwoCWNg8VfzoPKZ0DT0KFOM5Q8022D+W6D3DChVrpjwlcUc/H2umPAoC4jlDdon6P0ENPsMKAOI5QyK+9z+4zj3DCgPjOUP72gpAl+g9wwoS4zlDennYPx+8PcMKCOI5Q4qe'
..'2j+3zj3DCvLhOUNQghRAuM49wwoB4zlDGqkKQCC8PcMKCuM5Q0269T8gvD3DCvfhOUPv3AtAuM49wwr84TlDyIn6P7OQPcMKPL2uPN1PRz/wtAU/ClTnOUOvgfo/AM09wwoAAAAAcf0zQ4/C9bwKl+lhPc0lzz1wEoM6CsDqOUMRjxdArNI9wwqPwvU8PQq0wgAANMMD'
..'AAAAAAAAGEAKAACAPwAAgD8AAIA/CgAAAAAAAAAAAAAAAAqQwM08DDgLPm8SgzoKxeo5QyVADUDBzT3DCo/C9Tw9CrTCuN4sQwr0EgI+VduiPHASgzoKyOo5QwfPCEAk0z3DCo/C9Tw9CrTC4Xq3wgoXkNg9E6JDPG8SgzoKxuo5Q3OGC0DD0D3DCo/C9Tw9CrTCHwW2'
..'QgoMfIM+29pyO28SgzoKwOo5Q/4fF0CV0T3DCpnAzTwKOAs+bxKDOgrK6jlD3FoGQI3VPcMKj8L1PD0KtMKuR4G/CvISAj5e26I8cBKDOgrH6jlDTeoKQBfSPcMKj8L1PD0KtMKux7xCChGQ2D0hokM8bxKDOgrJ6jlDlyYIQEzTPcMKj8L1PD0KtMJSuKXCCgp8gz7g'
..'2nI7bxKDOgrP6jlDgLn2P0nMPcMKHx9RPfOUkz3hgIQ/CjToOUOUOAVAXdA9wwoAALTCPQq0wgAAAAADAAAAAAAAEEAKJ/J6PRMIhTrhgIQ/Cs3qOUObOAVAXdA9wwrdarM8FwgFO9ymaD4K4eo5Q0f9AkCowz3DCuH6sULNzEw+mpmzwgoNoCw9FwgFO1PO8T0K4+o5'
..'QyTG2D++2z3DCpoZhkJx/TND4fqzQgronyw9FwgFO4HO8T0K4Oo5Q0MCG0AK0j3DCkhhlsIK16O84fqzwgr9Z/o9LIONPcNKQz8K1uY5Q0WeA0CH0D3DCuH6scLNzDPDmpmzQgo8hP89g/yYO8FKQz8Ki+o5Q0meA0CH0D3DCqqyHz4ijEc7IJyDPwpI6jlDUDkIQInN'
..'PcMKmG9cPz+DjT0Y2N09CgjoOUPHUwRAEtA9wwoK10NACtejvAAAtMIKTJxYPCwIBTtV9148Ct/qOUNxfCJAh8w9wwrs0Z/Cj8L1vOH6s8IKNOTxPCwIBTvIqcc7CuHqOUM5QhdAcdc9wwofhUvBCtejvAAAtMIKQ8dfOywIBTu0zDg+CuDqOUMwVh1AXNM9wwpIYZjC'
..'j8L1vOH6s8IKEWj6PT6DjT3GSkM/CgnoOUMLNu0/2dY9wwpxvaVCw/UzQ8P1s0IK7RR4PCwIBTtbrkI8CuDqOUOpC/w/vcM9wwozs69CCtcjPUjhs8IKEFrePCwIBTuCNdk7CuDqOUOdHQhA9cE9wwrsUfhB4fozQwAAtEIKCOd/OysIBTvsmSE+CuDqOUO1vQJA4MA9'
..'wwpcj65CFO4zQ2bms0IKEWj6PTCDjT28SkM/CkrpOUOEngNAkdA9wwrh+rHCSOEzw3G9s0IKKGr6PUCDjT0fSUM/CvnnOUN8Yu8/uc89wwrh+rHC7BEww7gerEIK5BZ4PC0IBTvMrEI8Ct3qOUNVWd8/b949wwpmZp/CSKEzw1I4s0IKH1nePC0IBTtqNtk7CurqOUO6'
..'Pcs/e9o9wwqPwhzCKVyPvezRs8IKB+l/Oy0IBTummCE+CuPqOUMNztU/md49wwr2KKnCrkczwx+FskIKO6g6PkbsnD+oM+M8CsXpOUNkfRZA3949wwoK1yM8PQq0wgAANMMKPqg6PkjsnD+LM+M8CrzpOUNEfRZAocA9wwqPwvU8HwW0wgAANMMKHx9RPeSUkz3kgIQ/'
..'CjPoOUNqOAVAOs89wwoAALTCHwW0wgAAAAAKJ/J6PQUIhTrjgIQ/CszqOUNxOAVAOs89wwrfarM8BwgFO96maD4K4eo5Qxv9AkCFwj3DCuH6sUIfhWs+PYqzwgoRoCw9BwgFO1PO8T0K4uo5Q9LF2D+c2j3DCuqfLD0HCAU7hs7xPQrf6jlDGgIbQOfQPcMKSGGWwgrX'
..'I7zD9bPCCv5n+j0bg409xUpDPwrV5jlDG54DQGTPPcMK4fqxwh/FM8M9irNCCj6E/z1w/Jg7xUpDPwqK6jlDH54DQGTPPcMKrbIfPguMRzsinIM/CkfqOUMlOQhAZsw9wwqZb1w/MIONPRrY3T0KB+g5Q51TBEDvzj3DCgrXQ0AK1yO8AAC0wgpSnFg8HAgFO1j3XjwK'
..'3uo5Q0h8IkBkyz3DCuzRn8KPwvW8w/Wzwgoz5PE8HAgFO9OpxzsK4Oo5QxFCF0BO1j3DCh+FS8EK1yO8AAC0wgpHx187HAgFO7bMOD4K3+o5QwhWHUA50j3DCkhhmMIK16O84fqzwgoUaPo9MIONPchKQz8KCOg5Q7o17T+21T3DCnG9pUJS+DNDw/WzQgrxFHg8HAgF'
..'O16uQjwK3+o5Q1ML/D+awj3DCjOzr0KPwnU9KdyzwgoYWt48HAgFO4I12TsK3+o5Q3IdCEDSwD3DCuxR+EFx/TNDAAC0QgoO5387HAgFO+yZIT4K3+o5Q4q9AkC9vz3DClyPrkIU7jNDSOGzQgoUaPo9IIONPb1KQz8KSek5Q1qeA0Buzz3DCuH6scKa2TPDFK6zQgon'
..'avo9M4ONPSNJQz8K+ec5QyZi7z+Xzj3DCuH6scI9CjDDXA+sQgrmFng8IQgFO8+sQjwK3Oo5QwRZ3z9N3T3DCmZmn8K4njPDUjizQgojWd48IQgFO2o22TsK6eo5Q2c9yz9Z2T3DCgrpfzsgCAU7ppghPgri6jlDu83VP3fdPcMK9iipwh9FM8MfhbJCCp7pYT3VJc89'
..'cBKDOgq96jlDm30ZQOXMPcMKl8DNPBA4Cz5vEoM6CsTqOUOfQQ1AY8o9wwqPwvU8HwW0wrjeLEMK+RICPlvbojxwEoM6CsfqOUOC0AhAxs89wwqPwvU8HwW0wuF6t8IKHZDYPRuiQzxvEoM6CsXqOUPuhwtAZc09wwqPwvU8HwW0wh8FtkIKD3yDPuTacjtvEoM6Cr/q'
..'OUN5IRdANs49wwoLIzU+ViOePHASgzoKxeo5Q/qwCEBT0D3DCo/C9TwfBbTCuB66wgodosM8H5DYPXASgzoKy+o5Q5yn/D9lzj3DCo/C9TwfBbTCrkeBPwoV/nU8fDqsPXASgzoKyeo5QwmHAkCSzz3DCo/C9TwfBbTCFO4wwwqp2zA+x4y0O28SgzoKzuo5Q7Kl9T+E'
..'1D3DCo/C9TwfBbTCcT3GwgpI02Q9QdNkPRVrpjwKNuc5Q4KD+z8QEj7DCo/C9bzh+rNCAAAAAAoAAIA/AACAP83MzD0Ksp0RPS6qYD2FTvE8CiTjOUPmHhBANA8+wwrs4jlD2JP7P/sPPsMKQOc5Qz+G1j/XEj7DCm7nOUO7FhBASBE+wwr24jlDmJbWP8MQPsMhBVNv'
..'dW5kIQxBY2Nlc3NEZW5pZWQhB1NvdW5kSWQhFnJieGFzc2V0aWQ6Ly8yMDA4ODg1MTAhDUFjY2Vzc0dyYW50ZWQhFnJieGFzc2V0aWQ6Ly8yMDA4ODg0NjghCURvb3JDbG9zZSEWcmJ4YXNzZXRpZDovLzI1Nzg0MTY0MCEIRG9vck9wZW4hFnJieGFzc2V0aWQ6Ly8y'
..'NTE4ODU0OTUhCE1lc2hQYXJ0IQdCdXR0b24yB+sDBAMBqQGqAQYREREDAAAAAAAAcUAKj8L1PB8FtMIAAAAACnykOkO28XZA/gk/wwqaGdtC7NGzwrge20IKvLxfP7WjrT8AoWA/IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8zMjEzMjIwMzU2IQhNZXNoU2l6ZQpK6KY+'
..'VrkAPx+Gpj4hCVRleHR1cmVJRCEXcmJ4YXNzZXRpZDovLzI0NTk5MzA2OTYhD1Byb3hpbWl0eVByb21wdCEMSG9sZER1cmF0aW9uAwAAAKCZmck/IQ9LZXlib2FyZEtleUNvZGUDAAAAAACAWUAhCk9iamVjdFRleHQhB0J1dHRvbjEEFAGrAawBCokKOUOI5XZAGIo4'
..'wwpm5ozC7NGzQkjhjEIHZwAEGgGtAa4BBsrItgMAAAAAAACRQArK2DlDlVZ+QKbjO8MK3cfFPlaW2UA8xI5AIRJSb2xsT2ZmTWF4RGlzdGFuY2UDAAAAAAAAWUAhF3JieGFzc2V0aWQ6Ly81MDk2OTg2MTQ1IQZWb2x1bWUDAAAAAAAACEAhDVBsYXliYWNrU3BlZWQD'
..'AAAAYGZm8j8hDldlbGRDb25zdHJhaW50IQVQYXJ0MCEFUGFydDEhBUZyYW1lBK8BpAGlASELQmFja1N1cmZhY2UDAAAAAAAAJEAhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAEMAGwAbEBIQxGcm9udFN1cmZhY2UhC0xlZnRTdXJmYWNlCgAAAAAAALRCAAC0wgqzvzlD'
..'BynsQGrlO8MhDFJpZ2h0U3VyZmFjZQofBeLCCtezQnsUuEEKfT81PuOlj0AAAIA/IQpUb3BTdXJmYWNlBDcBpAGlAQoAAAAAAAC0wgAAAAAKmb45Q+Ar+j6q3zvDCtejYMEK17PCw/UlQwrHS5dAfT81PgAAgD8hBFdlbGQhAkMwBLIBswG0ASECQzEEtQG2AbcBBEAB'
..'uAG5AQpnvjlD4rh2QGyKOcMKPYqmwgrXs8Jcj8LCChkElj62Ht1AAACAPwS6AbsBvAEEvQG+Ab8BBMABwQHCAQRHAbgBuQEKZb45Q0AVdkCcPT7DChkElj7detxAAACAPwTDAb4BvwEExAGzAbwBBMUBxgHHAQTIAcEBwgEhCVdlZGdlUGFydARQAckBygEKmpkPQgAA'
..'NEMAALTCCgY/OUN/i+lAkDQ+wwqaGRBDAAAAAAAAtEIKzcxMPs3MTD3/0Zs+IQtTcGVjaWFsTWVzaCEFU2NhbGUKAACAPwFAzj0AAIA/IQhNZXNoVHlwZQMAAAAAAAAAQARaAcsBzAEKmpkPwo/ClT+4nrJCCmY+OkP/i+lAjjQ+wwqamQ/CMzNzPwAAtEIKzcxMPs3M'
..'TD1ozJs+CgAAgD+cOM49AACAPwRgAc0BzgEKAAAAAAAAtEKaGRBDCga/OUOvi+lAkDQ+wwpSuOXCCtezQnsUysIK3dGbPs3MTD7GtX4/BGUBzwHQAQpI4fxBAAAAAB8FtEIKED85Qye76UBMkznDCs3MTD7NzEw9UsqaPgoAAIA/ASDVPQAAgD8EagHRAdIBCgrXIzwf'
..'BbTCUjjzwgoQPzpDy7vpQEqTOcMKrgcbQwrXs8IUrgVCCs3MTD5zypo+zcxMPQoAAIA/AACAP5TG0j0EcAHTAdQBCgAAAAAAALRC12MUwwoQvzlDf7vpQEyTOcMKUrjlwgrXs0K4HgbCCnPKmj7NzEw+GKt+PyEEc2lnbgR1AdUBqgEKEbE4Q76QZUAKjjjDCkotGj+w'
..'PBA/Wa+rPSEXcmJ4YXNzZXRpZDovLzMyMTMyMTgxMzQKdJdkPq3aVT7QjP48IRdyYnhhc3NldGlkOi8vMzIxMzIxMzExMAR7AdYBrAEKBP46QyKjZUAIBj/DIQZGb2xkZXIhCURvb3JQYXJ0cyEGU3RyaXBlBIAB1wHYAQrJ2DlDeF7aQF7COsMKI1rkPs3MTD4y3QxA'
..'BNkBswG8AQTaAdsB3AEHxwAEhwHdAd4BBmNfYgrK2DlDsJGFQKbjO8MKGQQWPwAAAD+DwI5ABxoABIwB3wHeAQYbKjUKgtc5Q7CRhUCdUT3DCp3vJz+amZk+KlwPPgSPAd8B3gEKgtc5Q7CRhUBzsD3DCp3vJz+amZk+NwjsPgSSAeAB4QEKOtY5Q0hbhD+m4zvDCvq6'
..'Bj9ddUI/zEB8QAdAAQSXAeIB4wEGysvRCsvYOUOaE4M/puM7wwoAGBY/aExmP2D3gUAhDFVzZVBhcnRDb2xvcgpWSkk/0/zLPRQid0AKytg5QwB6qT+m4zvDCsrYOUNm4I8/puM7wwrK2DlDmY1sP6bjO8MKytg5Q2daOT+m4zvDCiIXFj9oTGY/cPeBQArK2DlDmhOD'
..'P6bjO8MKgtc5Q6zNe0AKyjvDCv//P68AEuisAACAPwr//z+uAACAPwAS6KwK+v9XsCCKAq4AAIA/Cvr/V68AAIA/IIoCrgqC1zlDnGB9QAzKO8MK7P9/PzHqDzqPd0w5CuPpD7r+/38//RiwtwpRfEy5EjOvNwAAgD8KguoPuv7/fz8fGbC3ClJ8TDkSM6+3AACAvwqB'
..'6g+6/v9/Px8ZsLcK8v9/PwEAizAvXTQzCvj/ijAAAIA/6N+argqK1zlDrM17QAjKO8MKwxeZOAAAgL+80pK1ClsGArgEh5I1AACAvwoAAIDDAAAgQQAAgEMKAACAvwAAAAAAAAAACgAAAAAAAAAAAACAPwouufbC4dAIPq33zMMKmYVMOb/xDzr+/3+/CgAAgL9sM6+3'
..'sIhMuQr6/1eweF1jLwAAgD8K8D/TMQAAgD92bJSvCn0/tT3jpQ/AAAAAPwoAAAAAAAAAAAAAgL8KAAAAAAAAgD8AAAAACgBQ470+8FtAAFUBvwrEBgI4dxqZuAsAgD8KAACAv3CDkjXYBgI4CrJj+8Kc5k7AyPfMwwqZhUw5LPIPOv7/f78KAACAv+gyr7eviEy5CvDY'
..'kkARlFxAgFMBvwrNzMw8tLPHviXZj74KAH4OPibPEcAAQjO+Cnp4TLmc6g+6CgCAPwrDGLC38v9/P1fqDzoKUP3xwstCTsDI98zDCgdSYbicW0+/ByEWPwrv/3+/weMtOF8JELgKd7FhOJxbTz8HIRa/Cvn2f7/WoB88n/laPArDeIG3qSAWP+FbTz8KHdelOOBbT7+p'
..'IBY/CoIhPrlLA1o/HTAGPwrv/3+/ogVJuY+CELgK2Sg8OUoDWr8bMAa/CvpN+LgcMAa/SwNaPwp924w4/S8Gv18DWj8Kaqc6OF4DWr/+Lwa/ClF8TDkSM6+3AACAvwpMfEy5EjOvNwAAgD8K8v9/PwCAUTEubSwzCvV/UTEAAIA/730nrwpwYsY+6kBiwAArFr4KAIDJ'
..'PvoXzcCACYs/CgAAgL9gAAAuAACArQpgAAAuAACAP5j/CSwK8v9/P/+/wjEwzSEzCvW/wjEAAIA/89WNrwry/38/AMDCMTDNITMK8v9/PwDAzDEu7SAzCvW/zDEAAIA/89+Urwry/38/AcDMMTDdIDMK9b/KMQAAgD/y3pavNwEAAAIAAgADAAQABQABAAECAAIABgAE'
..'AAcAAQACAgACAAgABAAJAAoAAwEAAgALAAwAQARADAAjACQAJQAbAAAjACYAJwAbAAAjACgAKQAbAAAjACQAKgAbAAAjACYAKwAbAAAjACYALAAbAAAjACQALQAbAAAjACQALgAbAAAjACYALwAbAAAjACYAMAAbAAAjACQAMQAbAAAjACgAMgAbAAAjADMANAA1AEAC'
..'QAJAAkACgSMANgA3ADgAOQA6ADsAQAJAA4EjADwAPQA+ADkAOgA7AIEjAD8AQABBADkAOgA7AAEjAEIAQwBEADkAOgA7AAEjAEUARgBEADkAOgA7AEACQAOBIwBHAEgASQA5ADoAOwCBIwBKAEsATAA5ADoAOwABIwBNAE4ATwA5ADoAOwABIwBQAFEATwA5ADoAOwBA'
..'AkACQAKBIwBSAFMAVABVADoAOwABIwBWAFcAVABVADoAOwBAA0ACQASBIwBYAFkAWgA5ADoAOwCBIwBbAFwAXQA5ADoAOwCBIwBeAF8AYAA5ADoAOwBAAoEjAGEAYgBjAFUAOgA7AAEjAGQAZQBjAFUAOgA7AIEjAGYAZwBjADkAOgA7AEADQAKBIwBoAGkAagBVADoA'
..'OwBAAkACASMAawBsAG0AOQA6ADsAASMAbgBvAHAAOQA6ADsAASMAcQByAHMAOQA6ADsAQAKBIwB0AHUAdgBVADoAOwBAAkACASMAdwB4AHkAOQA6ADsAASMAegB7AHwAOQA6ADsAASMAfQB+AH8AOQA6ADsAgSMAgACBAIIAVQA6ADsAQAKBIwCDAIQAhQBVADoAOwBA'
..'AkACASMAhgCHAIgAOQA6ADsAASMAiQCKAIsAOQA6ADsAASMAjACNAI4AOQA6ADsAgSMAjwCQAJEAOQA6ADsAQAJAAoEjAJIAkwCUADkAOgA7AEACQAKBIwCVAJYAlwBVADoAOwABIwCYAJkAlwBVADoAOwBAA0ACQASBIwCaAJsAnAA5ADoAOwCBIwCdAJ4AXQA5ADoA'
..'OwCBIwCfAKAAoQA5ADoAOwBAAoEjAKIAowCkAFUAOgA7AAEjAKUApgCkAFUAOgA7AIEjAKcAqACkADkAOgA7AEADQAKBIwCpAKoAqwBVADoAOwBAAkACASMArACtAK4AOQA6ADsAASMArwCwALEAOQA6ADsAASMAsgCzALQAOQA6ADsAQAKBIwC1ALYAtwBVADoAOwBA'
..'AkACASMAuAC5ALoAOQA6ADsAASMAuwC8AL0AOQA6ADsAASMAvgC/AMAAOQA6ADsAgSMAwQDCAMMAVQA6ADsAQAKBIwDEAMUAxgBVADoAOwBAAkACASMAxwDIAMkAOQA6ADsAASMAygDLAIsAOQA6ADsAASMAzADNAM4AOQA6ADsAQAJAAoEjAM8A0ACUADkAOgA7AEAC'
..'QAOBIwDRANIA0wA5ADoAOwCBIwDUANUA1gA5ADoAOwABIwDXANgA2QA5ADoAOwABIwDaANsA2QA5ADoAOwBAAkADgSMA3ADdAN4AOQA6ADsAgSMA3wDgAOEAOQA6ADsAASMA4gDjAOQAOQA6ADsAASMA5QDmAOcAOQA6ADsAQAYBIwDoAOkA6gA5AOsAOwAAIwDsAO0A'
..'GwAAIwDsAO4AGwABIwDoAO8A6gA5AOsAOwABIwDoAPAA6gA5AOsAOwAAIwDsAPEAGwADDAACAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgAbABwAHQAeABsAHwAgACEAIgDyAAUCAAIA8wD0APUA8gAFAgACAPYA9AD3APIABQIAAgD4APQA+QDyAAUCAAIA+gD0'
..'APsA/AADDQACAP0ADgAPABAA/gASAP8AFgAAARgAAQEaAAIBHAADAR4ABAEfAAUBBgEHAQgBCQEKAQsBDAEKAwANAQ4BDwEQAREBBgD8AAMNAAIAEgEOAA8AEAD+ABIAEwEWAAABGAABARoA6gAcABQBHgAVAR8ABQEGAQcBCAEJAQoBCwEMAQwDAA0BDgEPARABEQEG'
..'ACMAAwgAAgAGAA4ADwAQABYBEgAXARYAGAEYABkBHAAaAR8AGwHyAA4DAAIA8wAcAR0B9AD1APIADgMAAgD2ABwBHQH0APcA8gAOBAACAPgAHAEdAfQAHgEfASAB8gAOBQACAPoAIQEiARwBHQH0AB4BHwEgASMBDgAAIwEOAAAjAQ4AACMBDgAAIwEOAAAjAQ4AAAEA'
..'AgIAAgAmAQQAJwEjABkNAA4ADwAoASkBKgErARIALAEtASkBLgEpARgAGQEaAC8BHAAwATEBKQEeADIBHwAzATQBKwEjABkNAA4ADwAoASkBKgErARIANQEtASkBLgEpARgAGQEaADYBHAA3ATEBKQEeADgBHwA5ATQBKQE6ARsCADsBPAE9AT4BIwAZDQAOAA8AKAEp'
..'ASoBKwESAD8BLQEpAS4BKQEYABkBGgA2ARwAQAExASkBHgBBAR8AQgE0ASkBOgEdAgA7AUMBPQFEAToBHQIAOwE8AT0BRQEjABkNAA4ADwAoASkBKgErARIARgEtASkBLgEpARgAGQEaADYBHABHATEBKQEeAEEBHwBIATQBKQE6ASACADsBQwE9AUkBOgEgAgA7AUoB'
..'PQFLAToBIAIAOwE8AT0BTAFNARkNAA4ADwAoASkBKgEpARIATgEtASkBLgEpARgAGQEaAE8BHABQATEBKQEeAFEBHwBSATQBKQFTASQCAFQBVQFWAVcBTQEZDQAOAA8AKAEpASoBKQESAFgBLQEpAS4BKQEYABkBGgBZARwAWgExASkBHgBbAR8AXAE0ASkBUwEmAgBU'
..'AV0BVgFXASMAGQkADgAPACoBKwESAF4BGAAZARoAXwEcAGABHgBhAR8AYgE0ASsBTQEZDQAOAA8AKAEpASoBKQESAGMBLQEpAS4BKQEYABkBGgBkARwAZQExASkBHgBkAR8AZgE0ASkBUwEpAgBUAWcBVgFXAU0BGQ0ADgAPACgBKQEqASkBEgBoAS0BKQEuASkBGAAZ'
..'ARoAaQEcAGoBMQEpAR4AawEfAGwBNAEpAVMBKwIAVAFtAVYBVwEjABkJAA4ADwAqASsBEgBuARgAGQEaAG8BHABwAR4AcQEfAHIBNAErAfwAGQ0AAgBzAQ4ADwAQAP4AEgB0ARYAAAEYAAEBGgDqABwAdQEeABUBHwB2AQYBdwEIAXgBCgF5AfwAGQ0AAgBzAQ4ADwAQ'
..'AP4AEgB6ARYAAAEYAAEBGgACARwAewEeAAQBHwB2AQYBdwEIAXgBCgF5AXwBAQEAAgB9ASMAMAcAAgB+ARAA/gASAH8BFgAAARgAGQEcAIABHwCBAToBMQIAOwGCAT0BgwEjADAGABAAhAESAIUBFgCGARgAGQEcAIcBHwCIASMAMAYAEACJARIAigEWAIsBGAAZARwA'
..'jAEfAI0BIwAwBgAQAIkBEgCOARYAiwEYABkBHACPAR8AkAEjADAGABAAiQESAJEBFgCLARgAGQEcAJIBHwCTAQwAQAWAIwCaAZsBOwCAIwCaAZwBOwCAIwCaAZ0BOwCAIwCaAZ4BOwAAIwCfAaABOwAwBwAQAJQBEgCVARYAlgEYABkBHACXAR8AmAGZAQ8AFhMkAQ4T'
..'JQExFCQBDhQlATcVJAEOFSUBNBYkAQ4WJQE1FyQBDhclATYYJAEOGCUBMxwlARseJAEaHiUBHR8lAR0hJAEaISUBICIkAQUiJQEgIyUBIDIlATE=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
