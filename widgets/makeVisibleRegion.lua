local ns = ...
local builder = ns.builder

builder.applyVisibleRegion = function(region)
	
	local alpha, visible
 
	region.GetAlpha = function(self)
		return alpha
	end
	
	region.SetAlpha = function(self, value)
		alpha = value
	end
	
 
	region.Hide = function(self)
		visible = false
	end
	
	region.Show = function(self)
		visible = true
	end
	
	region.IsShown = function(self)
		return visible
	end
	
	region.IsVisible = function(self)
		return visible
	end
	 
	return region
 
end
