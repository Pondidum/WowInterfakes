local ns = ...
local log = ns.log:new("apply.scrollFrame")
local builder = ns.builder

ns.builder.addType({
	name = "ScrollFrame",
	extends = { "Frame" },
	build = function(target)

		target.GetScrollChild = function(self)
			return self.__storage.scrollChild
		end

	end,
	initInstance = function(target)

		local bar = builder.createFrame("Slider", target:GetName() .. "ScrollBar", target)
		local down = builder.createFrame("Button", target:GetName() .. "ScrollBarScrollDownButton", target)
		local up = builder.createFrame("Button", target:GetName() .. "ScrollBarScrollUpButton", target)

	end,
})
