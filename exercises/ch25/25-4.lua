-- 25.4 Write an improved version of debug that runs the given commands as if
-- they were in the lexical scope of the calling function. (Hint: run the commands
-- in and empty environment and use the __index metamethod attached to getvarvalue
-- to do all accesses to variables.)

-- import 25.1 for its side effects
local p = print; print = function() end
require "25-1"
print = p

function betterDebug()
  local env = setmetatable({}, {
    __index = function(_, key)
      -- 1. __index metamethod
      -- 2. loaded function
      -- 3. betterDebug
      -- 4. frame we care about
      local _, v = getvarvalue(key, 4)
      return v
    end
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
