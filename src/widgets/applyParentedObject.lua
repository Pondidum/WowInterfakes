local ns = ...
local builder = ns.builder

ns.builder.addType({
	name = "ParentedObject",
	extends = { "UIObject" },
	build = function(target)
 
		target.GetParent = function(self)
			return self.__storage.parent
		end

	end,
})
