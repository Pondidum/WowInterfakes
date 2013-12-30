local ns = ...
local builder = ns.builder

builder.applyFontInstance = function(font)

	font.GetFont = function(self)

		local data = self.__storage.font

		if not data then
			return nil
		end

		return data.name, data.height, data.flags

	end

	font.SetSpacing = function(self, spacing)
		self.__storage.spacing = spacing
	end

end
