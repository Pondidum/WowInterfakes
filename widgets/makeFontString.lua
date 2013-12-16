local ns = ...
local builder = ns.builder

builder.applyFontString = function(font) 
	
	font.SetText = function(self, text)
		self.__storage.text = text
	end

end
