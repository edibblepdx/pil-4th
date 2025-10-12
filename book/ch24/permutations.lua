-- Iterator over permutations implemented with a coroutine
-- Chapter 24.2
--
-- Coroutines are useful to turn existing generators into an iterator

function permgen(a, n)
  n = n or #a          -- default for 'n' is the size of 'a'
  if n <= 1 then       -- nothing to change?
    coroutine.yield(a) -- make this change
  else
    for i = 1, n do
      -- put i-th element as the last one
      a[n], a[i] = a[i], a[n]

      -- generate all permutations of the other elements
      permgen(a, n - 1)

      -- restore the i-th element
      a[n], a[i] = a[i], a[n]
    end
  end
end

function printResult(a)
  for i = 1, #a do io.write(a[i], " ") end
  io.write("\n")
end

-- factory
function permutations(a)
  -- local co = coroutine.create(function() permgen(a) end)
  -- return function() -- iterator
  -- local code, res = coroutine.resume(co)
  -- return res
  -- end
  return coroutine.wrap(function() permgen(a) end)
end

for p in permutations { "a", "b", "c" } do
  printResult(p)
end
