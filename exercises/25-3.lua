-- 25.3 Write a version of getvarvalue that returns a table with all variables that
-- are visible at the calling function. (the returned table should not include
-- environmental variables; instead, it should inherit them from the original
-- environment)

-- import 25.1 for its side effects
local p = print; print = function() end
require "25-1"
print = p

function getvarvalues()
  local vars = {}

  -- collect local variables
  for i = 1, math.huge do
    local n, v = debug.getlocal(2, i)
    if not n then break end
    vars[n] = v
  end

  -- collect non-local variables
  local func = debug.getinfo(2, "f").func
  for i = 1, math.huge do
    local n, v = debug.getupvalue(func, i)
    if not n then break end
    vars[n] = v
  end

  -- inherit environment
  local _, env = getvarvalue("_ENV", 2, true)
  return setmetatable(vars, { __index = env })
end

local a = 1
b = 2
local c = function() end

local vars = getvarvalues()
for k, v in pairs(vars) do
  print(k, v)
end

print("b", vars["b"]) -- in environment
