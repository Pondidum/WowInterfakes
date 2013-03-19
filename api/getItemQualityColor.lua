local getItemQualityColor = function()

	local redComponent, greenComponent, blueComponent, hexColor = .5, .5, .5, "ff999999"



	return redComponent, greenComponent, blueComponent, hexColor

end

Api.export("GetItemQualityColor", getItemQualityColor)