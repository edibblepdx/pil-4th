-- Chapter 25.4 Sandboxing

--[[
-- Listing 25.4
-- A naive sandbox with hooks
--]]
local debug = require "debug"

-- maximum "steps" that can be performed
local steplimit = 1000

local count = 0 -- counter for steps

local function step()
  count = count + 1
  if count > steplimit then
    error("script uses too much CPU")
  end
end

-- load file
local f = assert(loadfile(arg[1], "t", {}))

debug.sethook(step, "", 100) -- set hook

f()                          -- run file

--[[
-- Listing 25.5
-- Controlling memory use
--]]
-- maximum memory (in KB) that can be used
local memlimit = 1000

-- maximum "steps" that can be performed
local steplimit = 1000

local function checkmem()
  if collectgarbage("count") > memlimit then
    error("script uses too much memory")
  end
end

local count = 0
local function step()
  checkmem()
  count = count + 1
  if count > steplimit then
    error("script uses too much CPU")
  end
end

-- load file
local f = assert(loadfile(arg[1], "t", {}))

debug.sethook(step, "", 100) -- set hook

f()                          -- run file

--[[
-- Listing 25.6
-- Using hooks to bar calls to unauthorized functions
--]]
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
    local info = debug.getinfo(2, "fn")
    if not validfunc[info.func] then
      error("calling bad function: " .. (info.name or "?"))
    end
  end
  count = count + 1
  if count > steplimit then
    error("script uses too much CPU")
  end
end

-- load chunk
local f = assert(loadfile(arg[1], "t", {}))

debug.sethook(hook, "", 100) -- set hook

f()                          -- run chunk

