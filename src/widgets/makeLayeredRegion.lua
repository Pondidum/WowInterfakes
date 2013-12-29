local ns = ...
local builder = ns.builder

builder.applyLayeredRegion = function(region) 
	
	region.GetDrawLayer = function(self)
		return self.__storage.layer, self.__storage.subLayer
	end

	region.SetDrawLayer = function(self, layer, subLayer)
		self.__storage.layer = layer
		self.__storage.subLayer = subLayer
	end

	region.SetVertexColor = function(self, red, green, blue, alpha)
		
		self.__storage.vertexColor = { 
			red = red, 
			green = green, 
			blue = blue, 
			alpha = alpha, 
		}

	end

end
