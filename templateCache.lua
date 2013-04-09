local cache = {}

Api.templates = {

	add = function(name, value)
		cache[name] = value
	end,

	get = function(name)
		return cache[name] or ""
	end,
}