-- 22.2 eplain in detail what happens in the following program and what it will print

local foo
do
  local _ENV = _ENV
  function foo() print(X) end
end
X = 13
_ENV = nil
foo()
X = 0

--[[
-- The local _ENV on line 5 is created as an upvalue for the function foo which will
-- print 13. Line 5 essentially saves the _ENV table of the chunk, which is later
-- thrown away on line 9. After that point, only the function foo may access that
-- specific _ENV table. Line 11 will throw an error because there _ENV.X does not
-- exist in that scope; you are indexing a nil value.
--]]
