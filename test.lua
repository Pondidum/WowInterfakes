--require "wowinterfakes"

--Api.debug.enabled = true

--local loader = Api.AddonLoader.new()

--loader.loadBlizzard()

--loader.addonBase = "D:\\dev\\tools\\lua\\5.1\\lua\\wowinterfakes\\wow-ui-source"
--loader.addons = {"Dark.Core", "Dark.Nameplates", "Dark.Unitframes", "Dark.Raids", "Dark.Warface"}
--loader.load()

require "luaxml"

--local x = xml.eval("<ui><frame name=\"test\"><frames /></frame></ui>")
local x = xml.load("D:\\dev\\tools\\lua\\5.1\\lua\\wowinterfakes\\wow-ui-source\\framexml\\ItemButtonTemplate.xml")

local TAB = "    "

local printTag = {
	start = function(tag)
		print("Start", tag:tag())
	end,
	finish = function(tag)
		print("Finish", tag:tag())
	end
}

local handlers = setmetatable({}, { __index = function(t, k) 
	return printTag
end })

handlers.Scripts = setmetatable({ skipChildren = true}, { __index = printTag })

handlers.Button = {
	start = function(tag)
		print('do')
	end,
	action = function(tag, parent)
		print(string.format('local f = CreateFrame("%s", "%s", %s)', tag:tag(), tag.name, parent.name))
	end,
	finish = function(tag)
		print('end         --' .. tag:tag())
	end
}

handlers.Anchors = {}

handlers.Anchor = {
	skipChildren = true,
	action = function(tag)

		local point = tag.point
		local x, y = 0, 0 

		local offsetTag = tag:find("Offset")

		if offsetTag then
			
			local absTag = offsetTag:find("AbsDimension")

			if absTag then
				x = absTag.x
				y = absTag.y
			end

		end

		print(string.format('f:SetPoint("%s", %s, %s)', point, x, y))

	end
}

handlers.Size = {
	skipChildren = true,
	action = function(tag)

		local absTag = tag:find("AbsDimension")

		if absTag then
			x = absTag.x
			y = absTag.y
		end

		print(string.format('f:SetSize(%s, %s)', x, y))

	end	
}

handlers.Layers = {}
handlers.Layer = {}

handlers.Texture = {
	action = function(tag, parent)

		local name = tag.name or ""
		local prefix = "local t"

		if tag.parentKey then
			prefix = "f." .. tag.parentKey
		end

		print(prefix .. string.format(' = f:CreateTexture("%s")', parent.level))

	end
}

local recurse 

recurse = function(tag, parent)

	if not tag.tag then 
		print("No :tag() found ", tag)
		return
	end

	local handler = handlers[tag:tag()]

	if handler.start then
		handler.start(tag, parent)
	end

	if handler.action then
		handler.action(tag, parent)
	end

	if not handler.skipChildren then
		for i, v in ipairs(tag) do
			recurse(v, tag)
		end
	end

	if handler.finish then
		handler.finish(tag, parent)
	end

end

recurse(x, { name = "UIParent" })

--[[
local createFrame = function(tag, indent, type)

	local name = (tag.name or ""):gsub("$parent", "")
	local parent = tag.parent or "UIParent"
	local inherits = tag.inherits or ""

	append(indent .. "do ")
	append(indent .. TAB .. "local %s = CreateFrame(\"Frame\", \"%s\", %s, \"%s\")", name, name, parent, inherits)

	for i, v in ipairs(tag) do
		handlers[v:tag()](v, indent ..TAB, name)
	end

	append(indent .. "end")

end

handlers.Frame = function(tag, indent, name)
	createFrame(tag, indent, name, "Frame")
end

handlers.Button = function(tag, indent)
	createFrame(tag, indent, "Button")
end

handlers.Size = function(tag, indent)
	
	for i, v in ipairs(tag) do
		handlers[v:tag()](v, indent)
	end
	
end

handlers.AbsDimension = function(tag, indent)
	append(indent .. "f:SetSize(%s, %s)", tag.x, tag.y)
end

handlers.Frames = function(tag, indent)
	
	for i,v in ipairs(tag) do
		handlers[v:tag()](v, indent)
	end

end

setmetatable(handlers, { __index = function(t, k) 
	return function(t, indent) 
		append(indent .. "Unknown: %s", k)
	end
end})

for i, v in ipairs(x) do
	handlers[v:tag()](v, "")
end

for i,v in ipairs(builder) do
	print(v)
end
]]