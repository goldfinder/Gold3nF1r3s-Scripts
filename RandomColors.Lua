local f = owner
f.CharacterAdded:Connect(function()
	if f.Team ~= nil then
		local highlight = Instance.new("Highlight")
		highlight.Adornee=f.Character
		highlight.FillTransparency=0.8
		highlight.OutlineTransparency=0
		highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent=f.Character
		highlight.OutlineColor=f.TeamColor.Color
		highlight.FillColor=f.TeamColor.Color
	else
		local highlight = Instance.new("Highlight")
		highlight.Adornee=f.Character
		highlight.FillTransparency=0.8
		highlight.OutlineTransparency=0
		highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent=f.Character
		while true do
			local r,g,b = math.random(0,255),math.random(0,255),math.random(0,255)
			highlight.OutlineColor=Color3.fromRGB(r,g,b)
			highlight.FillColor=Color3.fromRGB(r,g,b)
			wait(.5)
			highlight.OutlineColor=Color3.fromRGB(255,255,255)
			highlight.FillColor=Color3.fromRGB(255,255,255)
			wait(.5)
		end
	end
end)
