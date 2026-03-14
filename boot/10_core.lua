_libCache = {}

function require(libName)
	local lib = _libCache[libName]
	if lib then
		return lib
	end
	local libPath = "/lib/" .. libName
	if not filesystem.isFile(libPath) then
		libPath = libPath .. ".lua"
	end
    if not filesystem.isFile(libPath) and _libCache["process"] then
		local p = _libCache["process"].running()
		if p then
        	libPath = p.environment["PWD"] .. "/" .. libName
			if not filesystem.isFile(libPath) then
				libPath = libPath .. ".lua"
			end
		end
	end
    if not filesystem.isFile(libPath) then
        return nil
    end
	print("Lib: load Lib '" .. libPath .. "'")
	local libFunc = filesystem.loadFile(libPath)
	if type(libFunc) ~= "function" then
		print("Lib: failed to load Lib '" .. libPath .. "'!")
	else
		lib = libFunc()
		_libCache[libName] = lib
		return lib
	end
end

local process = require("process")

process.create(coroutine.running())