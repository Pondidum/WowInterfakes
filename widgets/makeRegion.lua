local ns = ...
local builder = ns.builder

builder.applyRegion = function(region)
 
	region.GetWidth = function(self)
		return self.__storage.width
	end
 
	region.GetHeight = function(self)
		return self.__storage.height
	end
 
	region.GetSize = function(self)
		return self.__storage.width, self.__storage.height
	end
 
	region.SetWidth = function(self, value)
		self.__storage.width = value
	end
 
	region.SetHeight = function(self, value)
		self.__storage.height = value
	end
 
	region.SetSize = function(self, w, h)
		self.__storage.width = w
		self.__storage.height = h
	end
 
	region.ClearAllPoints = function(self, value) 
		self.__storage.points = {}
	end
 
	region.SetPoint = function(self, anchor, other, otherAnchor, x, y) 
		self.__storage.points = self.__storage.points or {}

		self.__storage.points[anchor] = { other, otherAnchor, x, y }
	end
 
	region.SetAllPoints = function(self, otherRegion)
 		self.__storage.points = self.__storage.points or {}
		
		self.__storage.region:SetPoint("TOPLEFT", otherRegion, "TOPLEFT", 0, 0)
		self.__storage.region:SetPoint("BOTTOMRIGHT", otherRegion, "BOTTOMRIGHT", 0, 0)
	end

	region.SetParent = function(self, target)
		self.__storage.parent = target
	end
 
end
