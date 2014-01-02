local ns = ...

ns.widgetMetaBuilder.addType({
	name = "Slider",
	extends = { "Frame" },
	build = function(target)

		target.SetMinMaxValues = function(self, minValue, maxValue)
			self.__storage.minValue = minValue
			self.__storage.minValue = maxValue
		end

		target.SetValue = function(self, value)
			self.__storage.value = value
		end

	end,
})
