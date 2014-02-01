local ns = ...

ns.builder.addType({
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

		target.IsEnabled = function(self)
			return self.__storage.isEnabled
		end

		target.Enable = function(self)
			self.__storage.isEnabled = true
		end

		target.Disable = function(self)
			self.__storage.isEnabled = false
		end

	end,
})
