local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

builder.applyButton = function(button)
	
	button.IsEnabled = function(self)
		return self.__storage.isEnabled
	end
	
end
