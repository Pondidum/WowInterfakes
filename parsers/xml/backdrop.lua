local ns = ...

local parser = ns.parsers.xml

local tag = {
	processChildren = false,

	build = function(file, element, target)

		local bgFile = element.attributes.bgFile
		local edgeFile = element.attributes.edgeFile
		local tile = element.attributes.tile
		
		local edgeSize = parser.newValueReader(element.elements.EdgeSize)
		local tileSize = parser.newValueReader(element.elements.TileSize)

		local insets = parser.newInsetReader(element.elements.BackgroundInsets)

		local backdrop = {}

		if  bgFile then
			backdrop.bgFile = bgFile
		end

		if edgeFile then
			backdrop.edgeFile = edgeFile
		end

		backdrop.tile = (tile == "true")		--maybe

		if edgeSize then
			backdrop.edgeSize = edgeSize.value
		end

		if tileSize then
			backdrop.tileSize = tileSize.value
		end

		if insets then
			backdrop.insets = insets.value
		end

		target:SetBackdrop(backdrop)

	end
}

parser.addTag("Backdrop", tag)
