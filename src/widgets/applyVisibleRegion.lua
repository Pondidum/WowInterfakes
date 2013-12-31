local ns = ...
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "VisibleRegion",
	extends = { "Region" },
	build = function(target)

		target.GetAlpha = function(self)
			return self.__storage.alpha
		end

		target.SetAlpha = function(self, value)
			self.__storage.alpha = value
		end

		target.Hide = function(self)
			self.__storage.visible = false
		end

		target.Show = function(self)
			self.__storage.visible = true
		end

		target.IsShown = function(self)
			return self.__storage.visible
		end

		target.IsVisible = function(self)
			return self.__storage.visible
		end

	end,
})
