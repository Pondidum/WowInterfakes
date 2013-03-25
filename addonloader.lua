Api.AddonLoader = {
	
	new = function(base)

		local this = {}
		this.addons = {}

		local loadAddon = function(name)

			local tocPath = base..'\\'..name.."\\"..name..".toc"
			local parser = Api.parsers.get(tocPath)
			local ns = {}

			parser(tocPath, name, ns)

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