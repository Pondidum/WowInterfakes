local ns = ...
local builder = ns.builder

builder.applyParentedObject = function(region)
 
	region.GetParent = function(self)
		return self.__storage.parent
	end

end
