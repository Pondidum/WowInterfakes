local ns = ...
local log = ns.log:new("apply.scrollFrame")
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "ScrollFrame",
	extends = { "Frame" },
	build = function(target)

	end,
	initInstance = function(target)

		local bar = builder.createFrame("Slider", target:GetName() .. "ScrollBar", target)
		local down = builder.createFrame("Button", target:GetName() .. "ScrollBarScrollDownButton", target)
		local up = builder.createFrame("Button", target:GetName() .. "ScrollBarScrollUpButton", target)
	end,
})
