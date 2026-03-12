local consoleLib = require("console")
local process = require("process")

local gpu = computer.getPCIDevices(classes.GPU_T2_C)[1]

terminal = process.create(function()
	console = consoleLib.createConsole()
	while true do
		console:tick()
		console:paint(gpu)
		gpu:flush()
		coroutine.yield()
	end
end)
