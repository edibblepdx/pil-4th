-- 6.5 write a function that takes an array and returns all combinations of the elements in that array.
-- Recursive formula: C(n,m) = C(n-1,m-1)+C(n-1,m) to generate all C(n,m) combinations of n elements in groups of size m.

--[[
 Return all combinations of n elements in groups of size m.
 -> table
 a: table
 m: number
--]]
local function combinations(a, m)
  if (m or 0) == 0 then return { {} } end
  if m > #a then return {} end

  local tail, k
  local res = {}

  tail = { table.unpack(a, 2) } -- add the first element
  k = combinations(tail, m - 1) -- generate C(n-1,m-1) combinations of remaining elements
  for i, tbl in ipairs(k) do
    res[i] = { a[1], table.unpack(tbl) }
  end

  k = combinations(tail, m) -- generate C(n-1,m) combinations of remaining elements
  for i, tbl in ipairs(k) do
    res[#res + i] = { table.unpack(tbl) }
  end

  return res
end

local function pretty(t)
  local res = {}
  for i = 1, #t do
    res[#res + 1] = t[i] and "{" .. table.concat(t[i], ",") .. "}"
  end
  return res
end

local t = combinations({ 1, 2, 3, 4, 5 }, 3)
for _, v in ipairs(pretty(t)) do print(v) end
