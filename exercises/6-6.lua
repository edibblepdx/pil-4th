-- 6.6 Write an unbounded call chain without recursion
-- Show that proper tail calls do not only benefit recursion in dynamic languages like Lua

--[[
  This is the example that I often see and it is unbounded but I'm not sure if it benefits from tail calls.
  And it is not a proper chain since the reader returns before it is called again.

  The hint is to use section 16.1
--]]

-- reader that never returns nil
local function reader()
  i = (i or 0) + 1 -- global (load does not have lexical scoping)
  print("ctrl-c to stop", i)
  return ";"       -- program of many ';'
end

assert(load(reader))()
