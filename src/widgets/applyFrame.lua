local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.widgetMetaBuilder.addType({
	name = "Frame",
	extends = { "ScriptObject", "VisibleRegion" },
	build = function(target)

		target.SetBackdrop = function(self, backdrop)
			self.__storage.backdrop = backdrop
		end

		target.SetBackdropBorderColor = function(self, red, green, blue, alpha)
			self.__storage.backdropBorderColor = { red = red, green = green, blue = blue, alpha = alpha }
		end

		target.SetBackdropColor = function(self, red, green, blue, alpha)
			self.__storage.backdropColor = { red = red, green = green, blue = blue, alpha = alpha }
		end

		target.RegisterEvent = function(self, event)
			eventRegistry.register(self, event)
		end

		target.IsEventRegistered = function(self, event)
			return eventRegistry.isRegistered(self, event)
		end

		target.CreateTexture = function(self, name, layer, inherits, sublevel)
			return builder.createTexture(self, name, layer, inherits, sublevel)
		end

		target.CreateFontString = function(self, name, layer, inherits)
			return builder.createFontString(self, name, layer, inherits)
		end

		target.RegisterForDrag = function(self, ...)
			self.__storage.drags = { ... }
		end

		target.IgnoreDepth = function(self, enabled)
			self.__storage.ingoreDepth = enabled
		end

		target.GetFrameLevel = function(self)
			return self.__storage.frameLevel or 1
		end

		target.SetFrameLevel = function(self, value)
			self.__storage.frameLevel = value
		end

		target.EnableMouse = function(self, value)
			self.__storage.enableMouse = value
		end

		target.SetAttribute = function(self, name, value)
			self.__storage.attributes = self.__storage.attributes or {}

			self.__storage.attributes[name] = value
		end

		target.GetAttribute = function(self, name)
			self.__storage.attributes = self.__storage.attributes or {}

			return self.__storage.attributes[name]
		end

		target.GetID = function(self)
			return self.__storage.id
		end

		target.SetID = function(self, id)
			self.__storage.id = id
		end

	end,
})
