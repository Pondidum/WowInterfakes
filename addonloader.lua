--[[
local lineParsers = {}
local getLineParser = function(base, line)

	for i, p in ipairs(lineParsers) do

		if p.canParse(base, line) then
			return p.parse
		end

	end

	return nil

end


table.insert(lineParsers, {
	canParse = function(base, line)
		return string.sub(line, #line -2) == "lua"
	end,
	parse = function(base, line, name, ns)
		
		local content = loadfile(base.. "\\" .. line)

		if content then
			content(name, ns)
		end

	end,
})

table.insert(lineParsers, {
	canParse = function(base, line)
		return string.sub(line, #line-2) == "xml"
	end,
	parse = function(base, line, name, ns)

		local x = xml.load(base.. "\\" .. line)
		
		for i, tag in pairs(x) do
			if tag[0] == "Script" and tag.file then
				
				local content = loadfile(base .. "\\" .. io.path.getDirectory(line) .. tag.file)

				if content then
					content(name, ns)
				end
			end	
		end
	end,
})
]]

Api.AddonLoader = {
	
	new = function(base)

		local this = {}
		this.addons = {}

		local loadAddon = function(name)

			local tocPath = base..'\\'..name.."\\"..name..".toc"
			local parser = Api.parsers.get(tocPath)
			local ns = {}

			parser(tocPath, name, ns)

			--[[
			local file = io.open(tocPath, "r") 

			if file then

				debug("Loading","["..name.."]")
				local ns = {}

				for line in file:lines() do

					if line == nil then
						break
					end

					if line ~= '' and string.sub(line, 0, 2) ~= "##" then
					
						local basePath = base .. '\\' .. name
						local handler = getLineParser(basePath, line)

						if handler then
							handler(basePath, line, name, ns)
						else
							warn("Loading", "No parser found for: " .. line)
						end

					end
					
					-- local path = base..'\\'..name.."\\"..line
					-- local content = loadfile(path)

					-- if content then

					-- 	debug("Loading", path)						
					-- 	content(name, ns)

					-- elseif not io.exists(path) then
					-- 	warn("Loading", "File doesn't exist: " .. path)
					-- else
					-- 	warn("Loading", "Unable to open file: " .. path)
					-- end
					
				end

				file:close()
				
				_G[name] = ns

				return env
			end
			]]
		end

		this.load = function()

			Api.debug.write("AddonLoader", "BeginLoad.")
			
			for i, name in ipairs(this.addons) do 
				loadAddon(name)
			end

			Api.debug.write("AddonLoader", "EndLoad.")

		end

		return this

	end,

}