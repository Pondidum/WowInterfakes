local ns = ...
local builder = ns.builder 

local createFrame = function(type, name, parent, templates)
	
	local frame =  builder.createFrame(type, name, parent, templates)

	if frame.finalize then
		frame.finalize()
		frame.finalize = nil
	end

	return frame

end

ns.api.export("CreateFrame", createFrame)
