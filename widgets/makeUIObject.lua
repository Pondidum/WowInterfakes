local ns = ...
local builder = ns.builder

builder.applyUIObject = function(region)
 
	region.GetName = function(self)
		return self.__storage.name
	end

end
