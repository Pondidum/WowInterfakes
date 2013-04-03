local startInfo = ...

Api.AddonLoader = {
	
	new = function()

		local this = {}
		this.addonBase = ""
		this.addons = {}

		local loadAddon = function(base, name)

			local tocPath = io.path.combine(base, name, name .. ".toc")
			local parser = Api.parsers.get(tocPath)
			local ns = {}

			parser(tocPath, name, ns)

		end

		this.loadBlizzard = function()

			loadAddon(Api.root .. "wow-ui-source", "FrameXml")

		end

		this.load = function()

			Api.debug.write("AddonLoader", "BeginLoad.")
			
			for i, name in ipairs(this.addons) do 
				loadAddon(this.addonBase, name)
			end

			Api.debug.write("AddonLoader", "EndLoad.")

		end

		return this

	end,

}