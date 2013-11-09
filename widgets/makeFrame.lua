local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

builder.applyFrame = function(region) 

	region.SetBackdrop = function(self, backdrop)
		self.__storage.backdrop = backdrop
	end

	region.RegisterEvent = function(self, event)
		eventRegistry.register(self, event)
	end

end
