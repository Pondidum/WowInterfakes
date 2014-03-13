local ns = ...
local log = ns.log:new("builder")

local templateManager = ns.templateManager
local frameRegistry = ns.frameRegistry
local metaStore = ns.widgetBuilder.new()



local builder = {}

builder.addType = metaStore.addType
builder.init = metaStore.init
builder.listBuilders = metaStore.listBuilders

builder.buildName = function(parent, name)

	if not name then
		return nil
	end

	local parentName = ""

	if parent and parent.GetName then
		parentName = parent:GetName() or ""
	end

	return name:gsub("$parent", parentName)

end

builder.createFrame = function(frameType, name, parent, template)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = builder.buildName(parent, name)
	local parentName = "nil"

	if parent and parent.GetName then
		parentName = parent:GetName() or "nil"
	end

	log.debug(string.format("Creating %s called %s (%s), parented to %s, with templates %s",
							frameType,
							realName or "nil",
							name or "nil",
							parentName,
							template or "nil"))

	local meta = metaStore.get(frameType) or metaStore.get("frame")
	local frame = { __storage = {} }
	setmetatable(frame, meta)

	frameRegistry.register(realName, frame)

	frame.__storage.name = realName 	--no publicly accessable SetName method()
	frame.__storage.type = frameType
	frame:SetParent(parent)

	local init = metaStore.getInitialiser(frameType) or metaStore.getInitialiser("frame")
	init(frame)

	if template and template ~= "" then
		templateManager.apply(template, frame)
	end

	return frame

end

builder.createTexture = function(parent, name, layer, inherits, sublevel)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = builder.buildName(parent, name)
	local parentName = "nil"

	if parent and parent.GetName then
		parentName = parent:GetName() or "nil"
	end

	log.debug(string.format("Creating Texture called %s (%s), parented to %s, with templates %s",
							realName or "nil",
							name or "nil",
							parentName,
							template or "nil"))

	local texture = { __storage = {} }
	setmetatable(texture, metaStore.get("texture"))

	frameRegistry.register(realName, texture)

	texture.__storage.realName = name 	--no publicly accessable SetName method()
	texture.__storage.type = "texture"
	texture:SetParent(parent)
	texture:SetDrawLayer(layer, sublevel)

	local init = metaStore.getInitialiser("texture")
	init(texture)

	if inherits and inherits ~= "" then
		-- dunno yet, maybe just templateManager
	end

	return texture

end

builder.createFontString = function(parent, name, layer, inherits)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = builder.buildName(parent, name)
	local parentName = "nil"

	if parent and parent.GetName then
		parentName = parent:GetName() or "nil"
	end

	log.debug(string.format("Creating FontString called %s (%s), parented to %s, with templates %s",
							realName or "nil",
							name or "nil",
							parentName,
							template or "nil"))

	local font = { __storage = {} }

	setmetatable(font, metaStore.get("fontstring"))

	frameRegistry.register(realName, font)

	font.__storage.name = realName
	font.__storage.type = "fontstring"

	local init = metaStore.getInitialiser("FontString")
	init(font)

	return font

end

builder.createAnimationGroup = function(parent, name, inherits)

	if parent ~= nil and type(parent) == "string" then
		parent = frameRegistry.get(parent)
	end

	local realName = builder.buildName(parent, name)
	local parentName = "nil"

	if parent and parent.GetName then
		parentName = parent:GetName() or "nil"
	end

	log.debug(string.format("Creating AnimationGroup called %s (%s), parented to %s, with templates %s",
							realName or "nil",
							name or "nil",
							parentName,
							template or "nil"))

	local group = { __storage = {} }

	setmetatable(group, metaStore.get("animationGroup"))

	frameRegistry.register(realName, group)

	group.__storage.name = realName
	group.__storage.type = "animationgroup"

	local init = metaStore.getInitialiser("animationGroup")
	init(group)

	return group

end

ns.builder = builder
