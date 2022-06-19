local socket = require("socket")
local stopwatch = {}

function stopwatch.get_time_ms()
    return socket.gettime() * 1000;
end

function stopwatch.get_os_clock_ms()
    return os.time() * 1000;
end

return stopwatch;
