local ns = ...
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "UIObject",
	extends = {},
	build = function(target)

		target.GetName = function(self)
			return self.__storage.name
		end

		target.GetObjectType = function(self)
			return self.__storage.type
		end

	end,
})
