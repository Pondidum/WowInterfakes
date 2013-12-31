local ns = ...
local log = ns.log:new("builder")

local templateManager = ns.templateManager
local frameRegistry = ns.frameRegistry
local metaStore = ns.widgetMetaBuilder

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

	local meta = metaStore.get(string.lower(frameType)) or metaStore.get("frame")
	local frame = { __storage = {} }
	setmetatable(frame, meta)

	frameRegistry.register(realName, frame)

	frame.__storage.name = realName 	--no publicly accessable SetName method()
	frame.__storage.type = frameType
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

	log.debug(string.format("Creating Texture called %s (%s), parented to %s, with templates %s",
							realName or "nil",
							name or "nil",
							tostring(parent or "nil"),
							template or "nil"))

	local texture = { __storage = {} }
	setmetatable(texture, metaStore.get("texture"))

	frameRegistry.register(realName, texture)

	texture.__storage.name = name 	--no publicly accessable SetName method()
	texture.__storage.type = "texture"
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

	log.debug(string.format("Creating FontString called %s (%s), parented to %s, with templates %s",
							realName or "nil",
							name or "nil",
							tostring(parent or "nil"),
							template or "nil"))

	local font = { __storage = {} }

	setmetatable(font, metaStore.get("font"))

	frameRegistry.register(realName, font)

	font.__storage.name = name
	font.__storage.type = "fontstring"

	return font

end

builder.createAnimationGroup = function(parent, name, inherits)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = buildName(parent, name)

	log.debug(string.format("Creating AnimationGroup called %s (%s), parented to %s, with templates %s",
							realName or "nil",
							name or "nil",
							tostring(parent or "nil"),
							template or "nil"))

	local group = { __storage = {} }

	setmetatable(group, metaStore.get("animationGroup"))

	frameRegistry.register(realName, group)

	group.__storage.name = name
	group.__storage.type = "animationgroup"

	return group

end

ns.builder = builder
