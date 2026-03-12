local thread = require("thread")
local shell  = require("shell")
local process = require("process")
local eventLib = require("event")

shell.getInput().isTTY = true
local prog = process.create(filesystem.loadFile("/bin/shell.lua"))

process.createPipe(prog, terminal)
process.createPipe(terminal, prog)

while true do
	process.handleProcesses()
	local canSleep = thread.tick()
	local timeout = 0
	if canSleep then
		timeout = 0.0
	end
	if console then
		console.process = prog
		eventLib.handleEvent(event.pull(timeout))
	end
end
