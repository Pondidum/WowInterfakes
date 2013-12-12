local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

builder.applyFrame = function(frame) 

	frame.SetBackdrop = function(self, backdrop)
		self.__storage.backdrop = backdrop
	end

	frame.RegisterEvent = function(self, event)
		eventRegistry.register(self, event)
	end

	frame.CreateTexture = function(self, name, layer, inherits, sublevel)
		return builder.createTexture(self, name, layer, inherits, sublevel)
	end

	frame.IgnoreDepth = function(self, enabled)
		self.__storage.ingoreDepth = enabled
	end
	
end
