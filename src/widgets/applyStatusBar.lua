local ns = ...

ns.builder.addType({
	name = "StatusBar",
	extends = { "Frame" },
	build = function(target)

		target.SetMinMaxValues = function(self, minValue, maxValue)
			self.__storage.minValue = minValue
			self.__storage.maxValue = maxValue
		end

		target.GetMinMaxValues = function(self)
			return self.__storage.minValue, self.__storage.maxValue
		end

		target.SetValue = function(self, value)
			self.__storage.value = value
		end

		target.GetValue = function(self)
			return self.__storage.value
		end

		target.SetStatusBarColor = function(self, red, green, blue, alpha)
			self.__storage.barColor = { r = red, g = green, b = blue, a = alpha }
		end

	end,

	initInstance = function(target)
		target:SetMinMaxValues(0, 1)
		target:SetValue(0)
	end,
})
