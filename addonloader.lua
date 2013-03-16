Api.AddonLoader = {
	
	new = function(base)

		local this = {}
		this.addons = {}
		this.debug = false
		this.environments = {}

		local debug = function(...)
			if this.debug then
				print("Loader [Debug]: ", ...)
			end
		end

		local warn = function(...)
			print("Loader [Warn]: ", ...)
		end

		local loadAddon = function(name)

			local file = io.open(base..'\\'..name.."\\"..name..".toc", "r") 

			if file then

				debug("Loading","["..name.."]")
				local ns = {}

				for fileName in file:lines() do

					if fileName == nil then
						break
					end

					if fileName ~= '' and string.sub(fileName, 0, 2) ~= "##" then
						
						local path = base..'\\'..name.."\\"..fileName
						
						if io.exists(path) then

							debug("Loading", path)

							local x = loadfile(path)
							x(name, ns)

						else
							warn("Loading", "File doesn't exist: " .. path)
						end

					end

				end

				file:close()
				
				_G[name] = ns

				return env
			end

		end

		this.load = function()

			debug("Loading addons")
			
			for i, name in ipairs(this.addons) do 
				loadAddon(name)
			end

			debug("Loading done")

		end

		return this

	end,

}