-- 22.3 explain in detail what happens in the following program and what it wil print

local print = print
function foo(_ENV, a)
  print(a + b)
end

foo({ b = 14 }, 12) --> 26
foo({ b = 10 }, 1) --> 11

--[[
-- The function foo has its own local environment, which contains _ENV.b.
-- In that table there is no print function, but print is saved as an
-- external local variable, or upvalue, of the function foo. The variable
-- a is passed to the function.
--]]
