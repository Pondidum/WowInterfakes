local ns = ...
local log = ns.log:new("builder")

local templateManager = ns.templateManager
local frameRegistry = ns.frameRegistry

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

	local fontMeta = {}

	builder.applyUIObject(fontMeta)
	builder.applyParentedObject(fontMeta)
	builder.applyRegion(fontMeta)
	builder.applyVisibleRegion(fontMeta)
	builder.applyLayeredRegion(fontMeta)
	builder.applyFontInstance(fontMeta)
	builder.applyFontString(fontMeta)

	builder.metas.font = { __index = fontMeta }

	local animationGroupMeta = {}

	builder.applyUIObject(animationGroupMeta)
	builder.applyParentedObject(animationGroupMeta)
	builder.applyScriptObject(animationGroupMeta)
	builder.applyAnimationGroup(animationGroupMeta)

	builder.metas.animationGroup = animationGroupMeta
	
end


builder.createFrame = function(frameType, name, parent, template)
	
	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = buildName(parent, name)

	log.debug(string.format("Creating %s called %s (%s), parented to %s, with templates %s", 
							frameType, 
							realName or "nil", 
							name or "nil", 
							tostring(parent or "nil"), 
							template or "nil"))

	local frame = { __storage = {} }
	setmetatable(frame, builder.metas.frame)

	frameRegistry.register(realName, frame)

	frame.__storage.name = realName 	--no publicly accessable SetName method()
	frame:SetParent(parent)

	if template and template ~= "" then
		templateManager.apply(template, frame)
	end


	return frame

end

builder.createTexture = function(parent, name, layer, inherits, sublevel)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = buildName(parent, name)

	log.debug(string.format("Creating %s called %s (%s), parented to %s, with templates %s", 
							"Texture", 
							realName or "nil", 
							name or "nil", 
							tostring(parent or "nil"), 
							template or "nil"))

	local texture = { __storage = {} }
	setmetatable(texture, builder.metas.texture)

	frameRegistry.register(realName, texture)

	texture.__storage.name = name 	--no publicly accessable SetName method()
	texture:SetParent(parent)
	texture:SetDrawLayer(layer, sublevel)

	if inherits and inherits ~= "" then
		-- dunno yet, maybe just templateManager
	end

	return texture

end

builder.createFontString = function(parent, name, layer, inherits)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = buildName(parent, name)

	local font = { __storage = {} }

	setmetatable(font, builder.metas.font)

	frameRegistry.register(realName, font)

	font.__storage.name = name

	return font

end

builder.createAnimationGroup = function(parent, name, inherits)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = buildName(parent, name)

	local group = { __storage = {} }

	setmetatable(group, builder.metas.animationGroup)

	frameRegistry.register(realName, group)

	group.__storage.name = name

	return group

end


ns.builder = builder
