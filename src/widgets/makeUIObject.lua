local ns = ...
local builder = ns.builder

builder.applyUIObject = function(region)
 
	region.GetName = function(self)
		return self.__storage.name
	end

	region.GetObjectType = function(self)
		return self.__storage.type
	end

end
