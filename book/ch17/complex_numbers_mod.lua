-- A simple module for complex numbers from chapter 17.2
-- This basic approach is what you will probably use most of the time
--! Read the end of this file for alternative export style

-- how to use:
-- local cpx = require "complex"
-- print(cpx.tostring(cpx.add(cpx.new(3,4), cpx.i)))
--> (3,5)

--! alternative method without return statement
-- local M = {}
-- package.loaded[...] = M
-- <as before, without the return statement>

local M = {}        -- the module

-- creates a new complex number
local function new (r, i)
    return {r=r, i=i}
end

M.new = new         -- add 'new' to the module

-- constant 'i'
M.i = new(0, 1)

function M.add (c1, c2)
    return new(c1.r + c2.r, c1.i + c2.i)
end

function M.sub (c1, c2)
    return new(c1.r - c2.r, c1.i - c2.i)
end

function M.mul (c1, c2)
    return new(c1.r*c2.r - c1.i*c2.i, c1.r*c2.i + c1.i*c2.r)
end

-- only used by M.div
local function inv (c)
    local n = c.r^2 + c.i^2
    return new(c.r/n, -c.i/n)
end

function M.div (c1, c2)
    return M.mul(c1, inv(c2))
end

function M.tostring (c)
    -- I believe %g is shortest of scientific or float
    return string.format("(%g,%g)", c.r, c.i)
end

--! return M or see below
return M

-- Alternative explicit export list style
--> define all functions as locals and build the returning table at the end
--> don't prefix members with "M."; you would have never created M anyway

return {
    new         = new,
    i           = i,
    add         = add,
    sub         = sub,
    mul         = mul,
    div         = div,
    tostring    = tostring,
}

-- Advantages: 
--> You can have different names inside / outside the module
--> Similar to JavaScript if you like that style

-- Disadvantages: 
--> Somewhat redundant
