local ns = ...

local builder = {}

builder.init = function()
	
	local frameMeta = {}

	builder.applyRegion(frameMeta)
	builder.applyVisibleRegion(frameMeta)
	builder.applyFrame(frameMeta)

	builder.frameMeta = { __index = frameMeta }

end

builder.createFrame = function()
	
	local frame = { __storage = {} }

	setmetatable(frame, builder.frameMeta)

	return frame

end

ns.builder = builder