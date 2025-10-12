-- A finalizer is a function associated with an object that
-- is called when that object is about to be collected.
-- Implemented through the metamethod __gc

local o, mt, list -- silence some errors

o = { x = "hi" }
setmetatable(o, { __gc = function(o) print(o.x) end })
o = nil          -- remove strong reference from the table
collectgarbage() --> hi

-- this however will not work as what might be intended
-- since the object is not marked for finalization
o = { x = "hi" }
mt = {}
setmetatable(o, mt)
mt.__gc = function(o) print(o.x) end
o = nil          -- remove strong reference from the table
collectgarbage() --> (nothing)

-- instead add a placeholder for the __gc metamethod so that
-- lua marks the object for finalization
o = { x = "hi" }
mt = { __gc = true }
setmetatable(o, mt)
mt.__gc = function(o) print(o.x) end
o = nil          -- remove strong reference from the table
collectgarbage() --> (nothing)

-- the collector finalizes several objects in the reverse order
-- that the objects were marked for finalization
mt = { __gc = function(o) print(o[1]) end }
list = nil
for i = 1, 3 do
  list = setmetatable({ i, link = list }, mt)
end
list = nil
collectgarbage()
--> 3
--> 2
--> 1

-- finalization may resurrect an object (transient resurrection)
-- there is nothing stopping the finalizer from permanently
-- resurrecting the object by storing it in a global var e.g.
A = { x = "this is A" }
B = { f = A }
setmetatable(B, { __gc = function(o) print(o.f.x) end })
A, B = nil, nil
collectgarbage() --> this is A
-- must call collectgarbage twice to make sure all garbage is collected

-- finalization can simulate an atexit function
local t = {
  __gc = function()
    -- your 'atexit' code comes here
    print("finidhing Lua program")
  end
}
setmetatable(t, t)
_G["*AA*"] = t -- to anchor it somewhere

-- running a function at every Garbage Collection cycle
do
  local mt = {
    __gc = function(o)
      -- whatever you want to do
      print("new cycle")
      -- creates new object for the next cycle
      setmetatable({}, getmetatable(o))
    end
  }
  -- creates first object
  setmetatable({}, mt)
end

collectgarbage() --> new cycle
collectgarbage() --> new cycle
collectgarbage() --> new cycle
