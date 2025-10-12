-- 24.2 transform exercise 6.5 into a generator for combinations using coroutines
--[[
  for c in combinations({"a", "b", "c"}, 2) do
    printResult(c)
  end
--]]


--[[
  Generate all combinations in a of size m.
  a:  table
  n:  number (size of a)
  m:  number (size of combination)
  cn: table  (combination)
--]]
local function combingen(a, n, m, cn)
  cn = cn or {} -- combination

  --[[
    If m <= 0 then you have the empty combination.
    In other words, you have exhausted all elements in a.

    If m > n then you have no possible combination in a.

    To avoid unpacking a table each time you could instead
    add another parameter for the start of the sub-array.
  --]]

  if m <= 0 then
    -- no more combinations?
    coroutine.yield(cn)
  elseif m <= n then
    local tail = { table.unpack(a, 2) }

    cn[#cn + 1] = a[1]                -- add the first element
    combingen(tail, n - 1, m - 1, cn) -- generate C(n-1,m-1) combinations of remaining elements

    cn[#cn] = nil                     -- remove the first element
    combingen(tail, n - 1, m, cn)     -- generate C(n-1,m) combinations of remaining elements
  end
end

local function combinations(a, m)
  return coroutine.wrap(function() combingen(a, #a, m) end)
end

local function printResult(a)
  for i = 1, #a do io.write(a[i], " ") end
  io.write("\n")
end

for c in combinations({ "a", "b", "c" }, 2) do
  printResult(c)
end; print()
--> a b
--> a c
--> b c

for c in combinations({ 1, 2, 3, 4, 5 }, 3) do
  printResult(c)
end
--> 1 2 3
--> 1 2 4
--> 1 2 5
--> 1 3 4
--> 1 3 5
--> 1 4 5
--> 2 3 4
--> 2 3 5
--> 2 4 5
--> 3 4 5
