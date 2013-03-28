local stringBuilder = {
	
	new = function()

		local parts = {}
		local this = {}

		this.append = function(value)
			table.insert(parts, value)
		end

		this.toString = function()
			return table.concat(parts)
		end

		return this

	end,

}

Api.stringBuilder = stringBuilder