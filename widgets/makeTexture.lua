local ns = ...
local builder = ns.builder

builder.applyTexture = function(texture) 
	
	texture.SetTexture = function(self, textureOrRed, green, blue, alpha)

		if type(textureOrRed) == "string" then
			self.__storage.texture = texture
		else
			self.__storage.textureColor = { red = textureOrRed, green = green, blue = blue, alpha = alpha}
		end

	end

end
