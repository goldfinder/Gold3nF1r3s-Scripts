prefix = "PLU>" --LOL
NUMLIST = {"0","1","2","3","4","5","6","7","8","9"}
local getdata = "https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/main/Player%20Security%20Action/Data"
local ExtraData="https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/main/Player%20Security%20Action/Extra"
function isempty(s)
	if string.len(s) == 1 or string.len(s) == 0 then return true
	else
		return false
	end
end
function yesno(s)
	if s == nil then return end
	if string.lower(s) == "true" then
		return "banned"
	else
		return "not banned"
	end
end
local str1
local str2
local plrlist
local tlist = {}
local getdata = "https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/main/Player%20Security%20Action/Data"
local ExtraData="https://raw.githubusercontent.com/goldfinder/Gold3nF1r3s-Scripts/main/Player%20Security%20Action/Extra"
local HttpService = game:GetService("HttpService")
owner.Chatted:Connect(function(msg)
	local MSplit = string.split(msg, " ")
	local first = string.lower(tostring(MSplit[1]))
	local x1 = first:find(string.lower(prefix))
	local MWP
	if x1 and x1==1 then
		tlist = {}
		local code = HttpService:GetAsync(getdata, true)
		str1 = code
		local code = HttpService:GetAsync(ExtraData, true)
		str2 = code
		plrlist = string.split(str1,"|")
		for i=1,#plrlist do
			local list = string.split(plrlist[i],"-")
			tlist[list[1]] = {}
			tlist[list[1]].Data   = list[2]
			tlist[list[1]].Strikes= list[3]
			tlist[list[1]].Banned = yesno(list[4])
		end
		MWP = string.sub(first, #prefix+1, #first)
		local str = string.split(MWP,"")
		if isempty(MWP) then
			MWP = tostring(owner.UserId)
			str = string.split(MWP,"")
		end
		local useable = true
		for i=1,#string do
			local tries = 0
			for z=1,#NUMLIST do
				if string[i]==NUMLIST[z] then
				else
					tries = tries+1
				end
			end
			if tries == 10 then
				useable=false
			end
		end
		if useable == true then
			if tlist[MWP] == nil then
				print(MWP.." Is not listed in PSA directory.")
			else
				if tlist[MWP] == "banned" then
					local BC = ""
					if tlist[MWP].Data == "BC1" then
						BC = "Exploiting is not authorized.  Unappealable."
					elseif tlist[MWP].Data == "BC2" then
						BC = "18+ Content/talk is not allowed. Appealable after 3 months"
					elseif tlist[MWP].Data == "BC3" then
						BC = "Account known of unlawful things.  Unappealable."
					elseif tlist[MWP].Data == "BC4" then
						BC = "Bypassing.  Appealable after 3 days of being banned."
					elseif tlist[MWP].Data == "BC5" then
						BC = "Account Suspended.  Confirm the account you are holding is within the correct owner's hand."
					else
						BC = tlist[MWP].Data
					end
					print(MWP.." Is "..tlist[MWP].Banned.." in PSA.")
					print(MWP.." Ban Reason: "..BC)
				else
					print(MWP.." Is "..tlist[MWP].Banned.." in PSA.")
					print(MWP.." Rank: "..BC)
				end
				
			end
		else
			print("Unuseable userid.")
		end
	end
end)
