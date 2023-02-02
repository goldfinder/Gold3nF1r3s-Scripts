while true do
	wait()
	local output = owner.PlayerGui.SB_OutputGUI.Main.Output.Entries:GetChildren()
	if #output >= 50 then
		for i=1,#output do
			output[i]:destroy()
		end
	end
end
