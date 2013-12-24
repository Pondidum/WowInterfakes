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
		self:SetPoint("TOPLEFT", otherRegion, "TOPLEFT", 0, 0)
		self:SetPoint("BOTTOMRIGHT", otherRegion, "BOTTOMRIGHT", 0, 0)
	end

	region.GetNumPoints = function(self)

		if self.__storage.points == nil then
			return 0
		end

		local count = 0

		for k,v in pairs(self.__storage.points) do
			count = count + 1
		end

		return count

	end

	region.SetParent = function(self, target)
		self.__storage.parent = target
	end

	region.CreateAnimationGroup = function(self, name, inherits)
		return builder.createAnimationGroup(self, name, inherits)
	end
 
end
