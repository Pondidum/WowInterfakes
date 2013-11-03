local ns = ...

local parser = ns.parsers.xml

local tag = {
	processChildren = false,

	build = function(element)

		local decorator = function(target)

			local bgFile = element.bgFile
			local edgeFile = element.edgeFile
			local tile = element.tile
			
			local edgeSize = parser.newValueReader(element.EdgeSize)
			local tileSize = parser.newValueReader(element.TileSize)

			local insets = parser.newInsetReader(element.BackgroundInsets)

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

		return decorator

	end,
}

parser.addTag("Backdrop", tag)
