-- 17-2 union intersection difference module

local function union(r1, r2)
  return function(x, y)
    return r1(x, y) or r2(x, y)
  end
end

local function intersection(r1, r2)
  return function(x, y)
    return r1(x, y) and r2(x, y)
  end
end

local function difference(r1, r2)
  return function(x, y)
    return r1(x, y) and not r2(x, y)
  end
end

return {
  union        = union,
  intersection = intersection,
  difference   = difference,
}
