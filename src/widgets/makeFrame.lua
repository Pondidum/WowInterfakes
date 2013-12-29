local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

builder.applyFrame = function(frame) 

	frame.SetBackdrop = function(self, backdrop)
		self.__storage.backdrop = backdrop
	end

	frame.SetBackdropBorderColor = function(self, red, green, blue, alpha)
		self.__storage.backdropBorderColor = { red = red, green = green, blue = blue, alpha = alpha }
	end

	frame.SetBackdropColor = function(self, red, green, blue, alpha)
		self.__storage.backdropColor = { red = red, green = green, blue = blue, alpha = alpha }
	end

	frame.RegisterEvent = function(self, event)
		eventRegistry.register(self, event)
	end

	frame.CreateTexture = function(self, name, layer, inherits, sublevel)
		return builder.createTexture(self, name, layer, inherits, sublevel)
	end

	frame.CreateFontString = function(self, name, layer, inherits)
		return builder.createFontString(self, name, layer, inherits)
	end

	frame.IgnoreDepth = function(self, enabled)
		self.__storage.ingoreDepth = enabled
	end
	
	frame.GetFrameLevel = function(self)
		return self.__storage.frameLevel or 1
	end

	frame.SetFrameLevel = function(self, value)
		self.__storage.frameLevel = value
	end

end
