local ns = ...
local builder = ns.builder

builder.applyVisibleRegion = function(region)
 
	region.GetAlpha = function(self)
		return self.__storage.alpha
	end
	
	region.SetAlpha = function(self, value)
		self.__storage.alpha = value
	end	
 
	region.Hide = function(self)
		self.__storage.visible = false
	end
	
	region.Show = function(self)
		self.__storage.visible = true
	end
	
	region.IsShown = function(self)
		return self.__storage.visible
	end
	
	region.IsVisible = function(self)
		return self.__storage.visible
	end
	 
	return region
 
end
