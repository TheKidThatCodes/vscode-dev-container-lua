if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
  require("lldebugger").start()
end

-- Sum is just a basic example
local sum = require("sum");
local stopwatch = require("stopwatch");
local socket = require("socket")

print("hello world")

-- Example of sum
local res = sum.add(12,12);
print(string.format("12 + 12 = %d", res))

-- Example of stopwatch
-- It's a test that we can use socket.gettime in a module
local osclock_time = stopwatch.get_os_clock_ms();
local socket_time = stopwatch.get_time_ms()
print("OS tick in ms = " .. osclock_time);
print("Socket time in ms = " .. socket_time);
print("delta = " .. socket_time - osclock_time); -- Note: We're also having a delay from os.clock called first

-- ********************* Lua socket example code *********************
-- create a TCP socket and bind it to the local host, at any port
local server = assert(socket.bind("*", 0))
-- find out which port the OS chose for us
local _, port = server:getsockname()
-- print a message informing what's up
print("Please telnet to localhost on port " .. port)
print("After connecting, you have 10s to enter a line to be echoed")
-- loop forever waiting for clients
while 1 do
  -- wait for a connection from any client
  local client = server:accept()
  -- make sure we don't block waiting for this client's line
  client:settimeout(10)
  -- receive the line
  local line, err = client:receive()
  -- if there was no error, send it back to the client
  if not err then client:send(line .. "\n") end

  print("got the following message: " .. tostring(line))
  -- done with client, close the object
  client:close()
end
