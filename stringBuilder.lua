local stringBuilder = {
	
	new = function()

		local parts = {}
		local this = {}

		this.append = function(format, ...)
			table.insert(parts, string.format(format, ...))
		end

		this.toString = function()
			return table.concat(parts)
		end

		return this

	end,

}

Api.stringBuilder = stringBuilder