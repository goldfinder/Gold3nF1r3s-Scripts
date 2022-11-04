-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 1080 characters

local ScriptFunctions = {
function(script,require)
--[[

Main Control

]]--
--Vars
local GameMaster = owner
local CC = nil
local eventrunning=false
local f = Instance.new("WeldConstraint")
--Events
f.Parent=script.Parent
f.Part1=script.Parent
f.Part0=game.Workspace.Terrain
script.Parent.BillboardGui.GMN.Text="GM: "..GameMaster.Name
script.Parent.BillboardGui.M.Text="Map: No Map Loaded"
script.Parent.BillboardGui.GS.Text="Game Status: Awaiting Map/Event"
print("Gold3nF1r3's Map Loader | Version:Indev-Beta")print("For commands, run 'gc:(command)'.  For Input, run '>(input)'")
print("Need help?  Run 'gc:Directory' then run '>help'")

--[[

Functions

]]--

function MapSet(data)
	local DSET
	local HttpService = game:GetService("HttpService")
	local code = HttpService:GetAsync("https://raw.githubusercontent.com/goldfinder/Maps.EventController/main/Main.Lua", true)
	DSET = loadstring(code)()(data.MapName)
	if DSET.LoadingMap == false then
		warn("Map not found.")
	end
end
function GameCommands(data)
	if string.lower(data.Command.Front) == string.lower("MS") then
		CC="MapSet"
		print("Maps are sensitive.  Run 'gc:maps' for maps.")
	end
	if string.lower(data.Command.Front) == string.lower("directory") then
		CC="directory"
		print("Directory enabled.  To exit, run '>end'.")
	end
end
function Input(data)
	local IS = false
	if CC==nil and IS==false then
		print("Current Command is not set.")
		IS=true
	end
	if IS==false and string.lower(data.Input)==string.lower("End") then
		print("Current Command cleared.")
		CC,IS=nil,true
	end
	if IS==false and CC=="MapSet" and string.lower(data.Input)~=string.lower("End") then
		print("Setting Map Settings...")
		local data2 = {}
		data2.MapName = tostring(data.Input)
		MapSet(data2)
		CC,IS=nil,true
	end
	if IS==false and CC=="help" and string.lower(data.Input)~=string.lower("End") then
		if string.lower(data.Input)==string.lower("help") then
			print("Command list:")
			print("ms(Map Set):  running MS will allow you to set the map.  Map is required to start a round of any gamemode")
			print("directory: Allows for viewing of maps, help, gamemodes, and more")
		end
		if string.lower(data.Input)==string.lower("ms") then
			print("MS:  Map set is the command to set a map.  This allows you to control the following:")
			print("Map, and gamemodes avaliable")
		end
		if string.lower(data.Input)==string.lower("directory") then
			print("Directory:  Directory is the main service to control the whole pad and games.  Allows you to view the following:")
			print("Maps - Allows you to see the current maps inside the directory.  Custom maps are not supported.")
			print("Gamemodes - Allows you to view the current avaliable gamemodes for the map currently loaded.  Custom gamemodes not supported.")
			print("Script developer information (Information): Allows access to view information about the creator.")
		end
		CC,IS=nil,true
	end
	if CC~=nil and CC=="directory" and string.lower(data.Input)~=string.lower("End") then
		local HttpService = game:GetService("HttpService")
		if string.lower(data.Input)==string.lower("Information") then
			print("Creator of ML: Gold3nF1r3")print("Creator of ML Paintball custom map: Gold3nF1r3")print("Original Author: SuperBlockUAlt")
			print("Creator's Discord: Lord_Zereph#1372 <@168394293067776001>")
			IS=true
		end
		if string.lower(data.Input)==string.lower("maps") and IS==false then
			local code = HttpService:GetAsync("https://raw.githubusercontent.com/goldfinder/Maps.EventController/main/DIR.Lua", true)
			local f = loadstring(code)()()
			IS=true
		end
		if string.lower(data.Input)==string.lower("gamemodes") and IS==false then
			local code = HttpService:GetAsync("https://raw.githubusercontent.com/goldfinder/Gamemode.EventHolder/main/DIR.Lua", true)
			local f = loadstring(code)()()
			IS=true
		end
		if string.lower(data.Input)==string.lower("help") and IS==false then
			print("If you would like a full list of commands, run '>help', else, run >(command) for a better understanding.")
			CC,IS="help",true
		end
		if IS==false then
			print("Directory Index not found.")
		end
	end
end

--[[

Chat Controller

]]--
--Vars
prefix1 = "GC:"
prefix2 = ">"
acceptedchars = {"a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9"}
local AFINPUT = false
--Events
GameMaster.Chatted:Connect(function(Message)
	local MSplit = string.split(Message, " ")
	local first = string.lower(tostring(MSplit[1]))
	local x1 = first:find(string.lower(prefix1))
	local x2 = first:find(string.lower(prefix2))
	local MWP
	if x1 and x1==1 then
		MWP = string.sub(first, #prefix1+1, #first)
		local data = {}
		data.Command={}
		data.Command.Front=MWP
		data.Command.Middle={}
		local currentid = 1
		for i=1,#MSplit-1 do
			local currentline = i+1
			if MSplit[currentline] ~= nil then
				data.Command.Middle[currentid]=tostring(MSplit[currentline])
			end
		end
		GameCommands(data)
	elseif x2 and x2==1 then
		MWP = string.sub(Message, #prefix2+1, #Message)
		local data = {}
		data.Input = MWP
		Input(data)
	end
end)


--[[
	if string.lower(Splits[1]) == string.lower("CPS")  then
		if string.len(Splits[2]) == 6 then
			local hex = Splits[2]:split("")
			local ishex = 0
			for cc=1,#hex do
				print("Testing "..hex[cc])
				for ch=1,#acceptedchars do
					if string.lower(tostring(hex[cc]))==acceptedchars[ch] then
						ishex=ishex+1
						print("Hex"..hex[cc])
					end
				end
			end
			if ishex == 6 then
				print("Hex Detected")
			end
		end
	end
]]
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


local Objects = Decode('AAA+IQRQYXJ0IQROYW1lIQNwYWQhCEFuY2hvcmVkIiENQm90dG9tU3VyZmFjZQMAAAAAAAAAACEKQnJpY2tDb2xvcgcVACEGQ0ZyYW1lBA89PiEFQ29sb3IGxCgcIQhQb3NpdGlvbgoAAMhCAABIQgAAyEIhBFNpemUKAADAQAAAgD8AAMBAIQpUb3BTdXJmYWNlIQxC'
..'aWxsYm9hcmRHdWkhDlpJbmRleEJlaGF2aW9yAwAAAAAAAPA/IQZBY3RpdmUhF0V4dGVudHNPZmZzZXRXb3JsZFNwYWNlCgAAAAAAAOBAAAAAAAwAAFBBAAAAAKBAAAAhB1RleHRCb3ghAUUhEEJhY2tncm91bmRDb2xvcjMGAAAAIRZCYWNrZ3JvdW5kVHJhbnNwYXJl'
..'bmN5AwAAAKCZmek/DAAAgD8AAM3MTD4AACEERm9udAMAAAAAAAAQQCEEVGV4dCELRXZlbnQ6IE5vbmUhClRleHRDb2xvcjMG////IQpUZXh0U2NhbGVkIQhUZXh0U2l6ZQMAAAAAAAAsQCELVGV4dFdyYXBwZWQhDENvZGUgV2FybmluZwwAAAAAAADNzEw+AAAhFU5P'
..'VCBDT0RFRCwgRE8gTk9UIEJVRwaqAAAhAU0MAAAAAAAAzczMPgAAIQRNYXA6Bv//ACEDR01ODAAAAAAAAJqZGT8AACEDR006IQJHUwwAAAAAAADNzEw/AAAhDEdhbWUgU3RhdHVzOiENQ2xpY2tEZXRlY3RvciEVTWF4QWN0aXZhdGlvbkRpc3RhbmNlAwAAAAAAAChA'
..'IQZTY3JpcHQKAACAPwAAAAAAAAAACgAAAAAAAIA/AAAAAAkBAAkAAgMEBQYHCAkKCwwNDg8QERIHEwEEABQVFgUXGBAZGgIKAAIbHB0eHxAgISIjJCUmJwUoKSoFGgILAAIrHB0eFQ4sECAhIiMtJS4nBSgpKgUaAgsAAi8cHR4VDjAQICEiIzElMicFKCkqBRoCCwAC'
..'MxwdHhUONBAgISIjNSUyJwUoKSoFGgILAAI2HB0eFQ43ECAhIiM4JTInBSgpKgU5AQEAOjs8AQAAAA==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
