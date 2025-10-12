-- Allow the sandboxed code in listing 25.6 to call its own functions

--[[
  The original listing doesn't even run as is.
--]]

local debug = require "debug"

-- maximum "steps" that can be performed
local steplimit = 1000

local count = 0 -- counter for steps

-- set of authorized functions
local validfunc = {
  [string.upper] = true,
  [string.lower] = true,
}

local function hook(event)
  if event == "call" then
    local info = debug.getinfo(2, "Sfn")
    if info.source ~= "@" .. arg[1] and -- the change
        not validfunc[info.func] then
      error("calling bad function: " .. (info.name or "?"))
    end
  end
  count = count + 1
  if count > steplimit then
    error("script uses too much CPU")
  end
end

-- load chunk
local f = assert(loadfile(arg[1], "t"))
validfunc[f] = true

debug.sethook(hook, "cl") -- set hook

f()                       -- run chunk
