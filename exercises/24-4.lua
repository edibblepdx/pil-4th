-- 24.4 Write a line iterator for listing 24-5 so that you can read a file with a for loop.

local lib = require "24-async-lib"

function run(code)
  local co = coroutine.wrap(function()
    code()
    lib.stop()  -- finish event loop when done
  end)
  co()          -- start the coroutine
  lib.runloop() -- start event loop
end

local putmemo = {}               -- memorizing table
function putline(stream, line)
  local co = coroutine.running() -- calling coroutine
  local callback = putmemo[co] or (function() coroutine.resume(co) end)
  if not putmemo[co] then putmemo[co] = callback end
  lib.writeline(stream, line, callback)
  coroutine.yield()
end

local getmemo = {}               -- memorizing table
function getline(stream)
  local co = coroutine.running() -- calling coroutine
  local callback = getmemo[co] or (function(l) coroutine.resume(co, l) end)
  if not getmemo[co] then getmemo[co] = callback end
  lib.readline(stream, callback)
  local line = coroutine.yield()
  return line
end

--[[
  Since getline returns a line or nil for EOF we
  can just make a generator over getline.
--]]
function lines(stream)
  return function() return getline(stream) end
end

run(function()
  local t = {}
  local inp = io.input()
  local out = io.output()

  for line in lines(inp) do
    t[#t + 1] = line
  end

  for i = #t, 1, -1 do
    putline(out, t[i] .. "\n")
  end
end)
