local ns = ...
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "Texture",
	extends = { "LayeredRegion" },
	build = function(target)

		target.SetTexture = function(self, textureOrRed, green, blue, alpha)

			if type(textureOrRed) == "string" then
				self.__storage.texture = texture
			else
				self.__storage.textureColor = { red = textureOrRed, green = green, blue = blue, alpha = alpha}
			end

		end

		target.SetTexCoord = function(self, leftOrULx, rightOrULy, topOrLLx, bottomOrLLy, URx, URy, LRx, LRy)

			if URx == nil or URy == nil or LRx == nil or LRy then

				local l = leftOrULx
				local r = rightOrULy
				local t = topOrLLx
				local b = bottomOrLLy

				self.__storage.texCoord = {
					ULx = l,
					ULy = t,
					LLx = l,
					LLy = b,
					URx = r,
					URy = t,
					LRx = r,
					LRy = b,
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

		target.GetTexCoord = function(self)

			local c = self.__storage.texCoord

			if c then
				return c.ULx, c.ULy, c.LLx, c.LLy, c.URx, c.URy, c.LRx, c.LRy
			end

		end

		target.SetRotation = function(self, radians)
			self.__storage.rotation = radians
		end

	end,

	initInstance = function(target)
		target:SetSize(0, 0)
	end,
})
