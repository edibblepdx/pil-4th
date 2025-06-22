-- 25.6 Implement some of the suggested improvements for the basic profiler from section 25.3
-- sort the output, print better function names, embellish output format

--[[
  Changes made:
  - sorted in descending order of count
  - dynamic width, left-aligned, function names
  - '-s' option to suppress program output
--]]

local Counters = {}
local Names = {}

local noprint = arg[2] == "-s" -- suppress program output

local function hook()
  local f = debug.getinfo(2, "f").func
  local count = Counters[f]
  if count == nil then -- first time 'f' is called?
    Counters[f] = 1
    Names[f] = debug.getinfo(2, "Sn")
  else -- only increment the counter
    Counters[f] = count + 1
  end
end

local f = assert(loadfile(arg[1]))
debug.sethook(hook, "c") -- turn on the hook for calls
if noprint then
  -- suppress the program output
  local w = io.write
  local p = print
  print = function() end
  io.write = function() end

  f() -- run the main program

  -- restore print and write
  print = p
  io.write = w
else
  f()
end
debug.sethook() -- turn off the hook

function getname(func)
  local n = Names[func]
  if n.what == "C" then
    return n.name
  end
  local lc = string.format("[%s]:%d", n.short_src, n.linedefined)
  if n.what ~= "main" and n.namewhat ~= "" then
    return string.format("%s (%s)", lc, n.name)
  else
    return lc
  end
end

-- collect name and count
local Out = {}
local maxlen = 0
for func, count in pairs(Counters) do
  Out[#Out + 1] = {
    ["name"] = getname(func),
    ["count"] = count,
  }
  local len = Out[#Out].name:len()
  maxlen = maxlen > len and maxlen or len
end
-- sort in descending order of count
table.sort(Out, function(a, b) return a.count > b.count end)

-- print
for _, t in ipairs(Out) do
  print(string.format("%-" .. maxlen .. "s %d", t.name, t.count))
end
