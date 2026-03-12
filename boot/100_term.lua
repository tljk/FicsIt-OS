local consoleLib = require("console")
local process = require("process")
local eventLib = require("event")

local gpu = computer.getPCIDevices(classes.GPU_T2_C)[1]

terminal = process.create(function()
	console = consoleLib.createConsole()
	eventLib.subscribe("OnKeyUp", function(...) console:handleInput("OnKeyUp", ...) end)
	eventLib.subscribe("OnKeyDown", function(...) console:handleInput("OnKeyDown", ...) end)
	eventLib.subscribe("OnKeyChar", function(...) console:handleInput("OnKeyChar", ...) end)
	while true do
		console:tick()
		console:paint(gpu)
		gpu:flush()
		while eventLib.pull() do end
		coroutine.yield()
	end
end)
