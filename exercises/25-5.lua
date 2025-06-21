-- Improve 25.4 to handle updates

-- import 25.1 and 25.2 for their side effects
do
  local p = print; print = function() end
  require "25-1" -- getvarvalue
  require "25-2" -- setvarvalue
  print = p
end

function betterDebug()
  local env = setmetatable({}, {
    -- 1. __index metamethod
    -- 2. loaded function
    -- 3. betterDebug
    -- 4. frame we care about
    __index = function(_, key)
      local _, v = getvarvalue(key, 4)
      return v
    end,
    -- only require this addition
    __newindex = function(_, key, value)
      setvarvalue(key, value, 4)
    end,
  })
  while true do
    io.write("lua_debug> ")
    local cmd = io.read()
    if not cmd then return end
    local f = assert(load(cmd))
    -- set the environment as the first upvalue (_ENV)
    debug.setupvalue(f, 1, env)
    f()
  end
end

function test()
  local a = 1
  local b = function() print(2) end
  local c = "hello"
  betterDebug()
end

test()
