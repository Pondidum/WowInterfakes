local ns = ...
local builder = ns.builder

builder.applyRegion = function(region)
	
	local width, height = 0, 0
	local points = {}
 
	region.GetWidth = function(self)
		return width
	end
 
	region.GetHeight = function(self)
		return height
	end
 
	region.GetSize = function(self)
		return width, height
	end
 
	region.SetWidth = function(self, value)
		width = value
	end
 
	region.SetHeight = function(self, value)
		height = value
	end
 
	region.SetSize = function(self, w, h)
		width = w
		height = h
	end
 
	region.ClearAllPoints = function(self, value) 
		points = {}
	end
 
	region.SetPoint = function(self, anchor, other, otherAnchor, x, y) 
		points[anchor] = { other, otherAnchor, x, y }
	end
 
	region.SetAllPoints = function(self, otherRegion)
 
		region:SetPoint("TOPLEFT", otherRegion, "TOPLEFT", 0, 0)
		region:SetPoint("BOTTOMRIGHT", otherRegion, "BOTTOMRIGHT", 0, 0)
 
	end
 
end
