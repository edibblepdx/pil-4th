-- determine whether Lua actually implements ephemeron tables

local factory; do
  local mem = {}                      -- memorizing table
  setmetatable(mem, { __mode = "k" }) --weak keys
  function factory(o)
    local res = mem[o]
    if not res then
      res = (function() return o end)
      mem[o] = res
    end
    return res
  end
end

-- o is a strong reference to k; it is maintained in a
-- closure of the function 'factory'. Each key in the
-- table 'mem' thus has a strong reference to itself in
-- the associated table value.

-- now to test if lua implements ephemeron tables
local a = {}
setmetatable(a, { __gc = function() print("I am being collected") end })
factory(a)
a = nil

collectgarbage()
--> (Lua 5.4.7) I am being collected
--> (Luajit) (nothing)
