local ns = ...
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "LayeredRegion",
	extends = { "VisibleRegion" },
	build = function(target)

		target.GetDrawLayer = function(self)
			return self.__storage.layer, self.__storage.subLayer
		end

		target.SetDrawLayer = function(self, layer, subLayer)
			self.__storage.layer = layer
			self.__storage.subLayer = subLayer
		end

		target.SetVertexColor = function(self, red, green, blue, alpha)

			self.__storage.vertexColor = {
				red = red,
				green = green,
				blue = blue,
				alpha = alpha,
			}

		end

	end,
})
