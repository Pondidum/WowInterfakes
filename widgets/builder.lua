local ns = ...
local log = ns.log:new("builder")

local templateManager = ns.templateManager

local buildName = function(parent, name)
	
	if not name then 
		return nil
	end

	local parentName = ""

	if parent and parent.GetName then
		parentName = parent:GetName()
	end

	return name:gsub("$parent", parentName)
	
end


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
	
	local realName = buildName(parent, name)

	local frame = { __storage = {} }
	setmetatable(frame, builder.metas.frame)

	frame.__storage.name = realName 	--no publicly accessable SetName method()
	frame:SetParent(parent)

	if template and template ~= "" then
		templateManager.apply(template, frame)
	end

	if realName then
		_G[realName] = frame
	end

	log.debug(string.format("Creating %s called %s, parented to %s, with templates %s", type, name or "nil", parent or "nil", template or "nil"))

	return frame

end

builder.createTexture = function(prent, name, layer, inherits, sublevel)
	
	local texture = { __storage = {} }

	setmetatable(texture, builder.metas.texture)

	texture.__storage.name = name 	--no publicly accessable SetName method()
	texture:SetParent(parent)
	texture:SetDrawLayer(layer, sublevel)

	if inherits and inherits ~= "" then
		-- dunno yet, maybe just templateManager
	end

	return texture

end

ns.builder = builder
