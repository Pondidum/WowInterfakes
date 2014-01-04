local ns = ...

local formats = {
	{ color = 24, video = 24, multisample = 8 },
}

local getMultisampleFormats = function(name)

	local result = {}

	for i,v in ipairs(formats) do
		table.insert(result, v.color)
		table.insert(result, v.video)
		table.insert(result, v.multisample)
	end

	return unpack(result)

end

ns.api.export("GetMultisampleFormats", getMultisampleFormats)
