local mem_loadstring = function() end; do
  local results = {}
  setmetatable(results, { __mode = "v" }) -- make values weak (prevents exhaustion of memory)
  function mem_loadstring(s)
    local res = results[s]
    if res == nil then      -- result not available?
      res = assert(load(s)) -- compute new results
      results[s] = res      -- save for later reuse
    end
    return res
  end
end

local createRGB = function() end; do
  -- a side effect of this is that you can compare colors with the equality operator
  local results = {}
  setmetatable(results, { __mode = "v" }) -- make values weak (reuse old colors)
  function createRGB(r, g, b)
    local key = string.format("%d-%d-%d", r, g, b)
    local color = results[key]
    if color == nil then
      color = { red = r, green = g, blue = b }
      results[key] = color
    end
    return color
  end
end
