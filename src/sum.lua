local sum = {}
local utils = require("utils");

--- Adds two numbers
--- @param a number first value
--- @param b? number second value (defaults to 0)
--- @return number sum of a and b
function sum.add(a, b)
    b = b or 0; -- default value
    return a + b
end

return sum