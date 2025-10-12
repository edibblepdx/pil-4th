-- Chapter 25 Reflection
-- Reflection is the ability of a program to inspect and modify some aspects of its own execution.

--[[
  debug.getinfo is the main instrospective function of the debug library.
  Its first parameter can be a function or a stack level. When we call debug.getinfo(foo)
  for a function foo we get a table that can have the following fields:

  source:           where the function was defined.
  short_src:        short version of the source up to 60 characters.
  linedefined:      first line in the source where the function was defined.
  lastlinedefined:  last line in the source where the function was defined.
  what:             "Lua" if foo is a regular lua function, "C" if it is a C function,
  name:             reasonable name for the function.
  namewhat:         "global", "local", "method", "field", or "" (empty string).
  nups:             the number of upvalues of the function.
  nparams:          the number of parameters of the function.
  activelines:      the set of active lines of the function.
  func:             the function itself.

  If called debug.getinfo(n) with an number n representing stack number (with 1 being
  the calling function), we get a table with info about the function at that stack level
  with two extra fields:

  currentline:  the line where the function is at that moment.
  istailcall:   boolean true if this function was called by a tail call.
                In this case the real caller is not on the stack anymore.

  debug.getinfo takes an optional second argument as a string with the info we want.

  'n' selects name and namewhat
  'f' selects func
  'S' selects source, short_src, what, linedefined, and lastlinedefined
  'l' selects currentline
  'L' selects activelines
  'u' selects nups, nparams, and isvararg
--]]

-- print a primitive traceback of the active stack
-- also the library function debug.traceback
function trceback()
  for level = 1, math.huge do
    local info = debug.getinfo(level, "Sl")
    if not info then break end
    if info.what == "C" then -- is a C funciton?
      print(string.format("%d\tC function", level))
    else                     -- a Lua function
      print(string.format("%d\t[%s]:%d", level,
        info.short_src, info.currentline))
    end
  end
end

-- accessing local variables
-- you can also set local variables with debug.setlocal
function foo(a, b)
  local x
  do local c = a - b end
  local a = 1
  while true do
    local name, value = debug.getlocal(1, a)
    if not name then break end
    print(name, value)
  end
end

-- foo(10, 20)
--> a   10
--> b   20
--> x   nil
--> a   4

-- You can also access non-local variables with debug.getupvalue
-- And set non-local variables with debug.setupvalue

--[[
  All introspective functions from the debug library take
  an optional coroutine as the first argument so that we
  can inspect a coroutine from the outside.

  A stack trace will not go through the call to resume
  because the coroutine and the main program run in
  different stacks. When a coroutine raises an error it
  does not unwind its stack so we can call any of the
  introspective functions.
--]]
