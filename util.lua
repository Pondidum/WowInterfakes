io.exists = function(name)
	
	local f = io.open(name,"r")
	
	if f ~= nil then 
		io.close(f) 
		return true 
	else 
		return false
	end
	
end

path = {}
path.getDirectory = function(str,sep)
    sep=sep or'\\'
    return str:match("(.*"..sep..")")
end