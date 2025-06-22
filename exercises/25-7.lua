-- 25.7 Write a library for breakpoints. Include
--
-- setbreakpoint(function, line) --> returns handle
-- removebreakpoint(handle)
--
-- We specify a breakpoint by a function and a line inside that function.
-- When the program hits a breakpoint, the library should call debug.debug.
-- (Use a line hook for a basic implementation. Use a call hook that enables
-- the line hook only when running the target function for a more efficient
-- implementation)

-- Must type 'cont' inside debug.debug to finish the debug function not ctrl-d

local M = {}

--[[
  Table of breakpoints
  key: function
  value: Table {
    key: handle as an auto-incrementing number
    value: line number
    ...
    n: number of breakpoints in this function
  }
--]]
local breakpoints = {}

--[[
  Set a breakpoint
  -> handle: string
  func: function
  line: number
--]]
local count = 0 -- auto-incrementing handle
function M.setbreakpoint(func, line)
  if type(func) ~= "function" then
    error("bad argument 1 to setbreakpoint: expected function", 2)
  end
  if type(line) ~= "number" then
    error("bad argument 2 to setbreakpoint: expected number", 2)
  end
  count = count + 1

  local bp = breakpoints[func] or {}
  bp[count] = line
  bp.n = (bp.n or 0) + 1
  breakpoints[func] = bp

  return count
end

--[[
  Remove a breakpoint
  handle: string
--]]
function M.removebreakpoint(handle)
  for _, bps in pairs(breakpoints) do
    if bps[handle] then
      bps[handle] = nil
      bps.n = bps.n - 1
    end
  end
end

local callhook

local function linehook()
  local info = debug.getinfo(2, "fl")

  local bps = breakpoints[info.func]
  if bps and bps.n > 0 then
    for handle, line in pairs(bps) do
      if info.currentline == line then
        print(string.format("breakpoint found: %d", handle))
        debug.debug()
      end
    end
  else
    debug.sethook(callhook, "cr")
  end
end

function callhook()
  local func = debug.getinfo(2, "f").func

  local bps = breakpoints[func]
  if bps and bps.n > 0 then
    debug.sethook(linehook, "l")
  end
end

debug.sethook(callhook, "cr")

return M
