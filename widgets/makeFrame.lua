local ns = ...
local builder = ns.builder

builder.applyFrame = function(region) 

	region.SetBackdrop = function(self, backdrop)
		self.__storage.backdrop = backdrop
	end

end
