local ns = ...

local templateManager = ns.templateManager
local builder = {}

builder.init = function()
	
	local frameMeta = {}

	builder.applyRegion(frameMeta)
	builder.applyVisibleRegion(frameMeta)
	builder.applyFrame(frameMeta)

	builder.frameMeta = { __index = frameMeta }

end

builder.createFrame = function(type, name, parent, template)
	
	local frame = { __storage = {} }

	setmetatable(frame, builder.frameMeta)

	frame:SetName(name)
	frame:SetParent(parent)
	
	if template and template ~= "" then
		templateManager.apply(template, frame)
	end

	return frame

end

ns.builder = builder