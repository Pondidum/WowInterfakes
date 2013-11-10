local ns = ...

local templateManager = ns.templateManager
local builder = {}

builder.init = function()
		
	builder.metas = {}

	local frameMeta = {}

	builder.applyUIObject(frameMeta)
	builder.applyParentedObject(frameMeta)
	builder.applyRegion(frameMeta)
	builder.applyVisibleRegion(frameMeta)
	builder.applyScriptObject(frameMeta)
	builder.applyFrame(frameMeta)

	builder.metas.frame = { __index = frameMeta }


	local textureMeta = {}
	builder.applyUIObject(textureMeta)
	builder.applyParentedObject(textureMeta)
	builder.applyRegion(textureMeta)
	builder.applyVisibleRegion(textureMeta)
	builder.applyLayeredRegion(textureMeta)
	builder.applyTexture(textureMeta)

	builder.metas.texture = { __index = textureMeta }

end

builder.createFrame = function(type, name, parent, template)
	
	local frame = { __storage = {} }

	setmetatable(frame, builder.metas.frame)

	frame.__storage.name = name 	--no publicly accessable SetName method()
	frame:SetParent(parent)

	if template and template ~= "" then
		templateManager.apply(template, frame)
	end

	return frame

end

ns.builder = builder