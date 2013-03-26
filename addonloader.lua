Api.AddonLoader = {
	
	new = function()

		local this = {}
		this.addonBase = ""
		this.addons = {}

		local loadAddon = function(name)

			local tocPath = io.path.combine(this.addonBase, name, name .. ".toc")
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