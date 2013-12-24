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

	texture.SetTexCoord = function(self, leftOrULx, rightOrULy, topOrLLx, bottomOrLLy, URx, URy, LRx, LRy)

		if URx == nil or URy == nil or LRx == nil or LRy then

			self.__storage.texCoord = {
				left = leftOrULx,
				right = rightOrULy,
				top = topOrLLx,
				bottom = bottomOrLLy,
			}

		else

			self.__storage.texCoord = {
				ULx = ULx,
				ULy = ULy,
				LLx = LLx,
				LLy = LLy,
				URx = URx,
				URy = URy,
				LRx = LRx,
				LRy = LRy,
			}

		end

	end

end
