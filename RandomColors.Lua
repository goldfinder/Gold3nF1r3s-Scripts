local f = owner
f.CharacterAdded:Connect(function()
	local highlight = Instance.new("Highlight")
	highlight.Adornee=f.Character
	highlight.FillTransparency=1
	local r,g,b=math.random(0,255),math.random(0,255),math.random(0,255)
	highlight.OutlineColor=Color3.fromRGB(r,g,b)
	highlight.OutlineTransparency=0
	highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent=f.Character
end)
