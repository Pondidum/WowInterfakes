local ns = ...

local stack = {

	new = function()

		local storage = {}

		local this = {}

		this.push = function(item)
			table.insert(storage, item)
		end

		this.pop = function()
			return table.remove(storage, #storage)
		end

		this.tip = function()
			return storage[#storage]
		end

		return this 

	end,

}

ns.stack = stack
