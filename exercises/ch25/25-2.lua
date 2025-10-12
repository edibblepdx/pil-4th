-- 25.2 Write a function setvarvalue similar to getvarvalue

local p = print; print = function() end -- suppress any print

-- Just loading 25.1 for the side effects (import getvarvalue)
require "25-1"

print = p -- restore print

--[[
  Set the value of a variable
  -> string
  2. string|nil
  3. any
  name: string
  value: any
  level: number|nil
  isenv: boolean|nil
--]]
function setvarvalue(name, value, level, isenv)
  local found = false

  level = (level or 1) + 1

  -- try local variables
  local index
  for i = 1, math.huge do
    -- go through all to get the most recently declared
    local n = debug.getlocal(level, i)
    if not n then break end
    if n == name then
      index = i
      found = true
    end
  end
  if found then
    return "local", debug.setlocal(level, index, value), value
  end

  -- try non-local variables
  local func = debug.getinfo(level, "f").func
  for i = 1, math.huge do
    local n = debug.getupvalue(func, i)
    if not n then break end
    if n == name then
      return "upvalue", debug.setlocal(level, i, value), value
    end
  end

  if isenv then return "noenv" end -- avoid loop

  -- not found; get value from the environment
  local _, env = getvarvalue("_ENV", level, true) -- needed this from 25.1
  if env then
    if env[name] then env[name] = value end
    return "global", name, env[name]
  else -- no _ENV available
    return "noenv"
  end
end

local a = 4; print(setvarvalue("a", 2))        --> local a 2
print(a)                                       --> 2

b = 4; print(setvarvalue("b", 2))              --> global b 2
print(b)                                       --> 2

c = 4; print(setvarvalue("c", function() end)) --> global c function: 0x4ee150
print(c)                                       --> function: 0x4ee150
