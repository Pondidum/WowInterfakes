string.endsWith = function(self, value)
	return string.sub(self, #self - #value + 1) == value
end

io.exists = function(name)
	
	local f = io.open(name,"r")
	
	if f ~= nil then 
		io.close(f) 
		return true 
	else 
		return false
	end
	
end

io.path = {

	getDirectory = function(str,sep)
	    sep = sep or '\\'
	    return str:match("(.*"..sep..")")
	end,

	getFilename = function( path )

		local dir, file, ext = string.match(path, "(.-)([^\\/]-%.?([^%.\\/]*))$")

		return file
	end,
	
	combine = function(...)	

		local paths = {...}
		local result = paths[1]

		for i = 2, #paths do
			
			local part = paths[i]
			
			if not result:endsWith("\\") then
				result = result .. "\\"
			end

			result = result .. part

		end

		return result 
	end,
}
