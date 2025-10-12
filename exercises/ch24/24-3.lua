-- 24.3 Modify listing 24.5 to use memorization for getline and putline

--[[
  24-async-lib mimics an asynchronous library. This file is a synchronous
  wrapper over that asynchronous code. What the asynchronous library would be
  doing is populating a command queue with events and filtering it out in the
  'runloop' function. This file creates those events. Typically we would
  initialize some stuff then call 'runloop' and wait for events to handle.
  When we use coroutines to run synchronous code on top of an asynchronous
  library, the event queue only ever has a single event.

  To try and explain what is happening, we call the function 'run' passing an
  anonymous function that reads the lines then reverses them. 'run' wraps that
  function in a coroutine. When we call 'co' inside run we (re)start or resume
  that coroutine. It enters the 'while true' loop and calls getline which
  creates a callback to resume the calling coroutine and passes it to the
  async lib function 'readline' which adds that callback (which takes a line)
  to the command queue. We then yield to the 'run' function which starts the
  'runloop.' Now we only have a single command in the queue, which when taken
  off the queue reads a line and resumes 'getline' with the line read. We
  return that line to the anonymous function in the while true loop, add it to
  the list, and call getline again. We are still in the thread that 'run'
  created, but next time we yield to the 'runloop'. The function 'putline'
  behaves similarly and when finished we add the stop command, the coroutine
  dies, and we yield to the runloop which terminates.
--]]

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

run(function()
  local t = {}
  local inp = io.input()
  local out = io.output()

  while true do
    local line = getline(inp)
    if not line then break end
    t[#t + 1] = line
  end

  for i = #t, 1, -1 do
    putline(out, t[i] .. "\n")
  end
end)
