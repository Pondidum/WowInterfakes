local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.widgetMetaBuilder.addType({
	name = "Button",
	extends = { "Frame" },
	build = function(target)

		target.IsEnabled = function(self)
			return self.__storage.isEnabled
		end

		target.RegisterForClicks = function(self, ...)

			local allowed  = {}

			if ... ~= nil then

				for i,v in ipairs({...}) do
					allowed[v] = true
				end

			end

			self.__storage.clicks = allowed

		end

		target.GetFontString = function(self)

			--might need to put this in a constructor later
			self.__storage.textFontString = self.__storage.textFontString or builder.createFontString(self)

			return self.__storage.textFontString

		end

	end,
})
