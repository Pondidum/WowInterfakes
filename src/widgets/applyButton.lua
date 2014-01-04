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

		target.Enable = function(self)
			self.__storage.isEnabled = true
		end

		target.Disable = function(self)
			self.__storage.isEnabled = false
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
			return self.__storage.textFontString
		end

		target.GetHighlightTexture = function(self)
			return self.__storage.highlightTexture
		end

	end,

	initInstance = function(target)
		target:Enable()

		target.__storage.textFontString = builder.createFontString(target)
		target.__storage.highlightTexture = builder.createTexture(target)

	end,
})