-- (since Lua 5.2) Consider the entry (k, v) in an ephemeron table.
-- The reference to v is only string if there is some other external
-- reference to k. Otherwise, the collector will eventually collect k
-- and remove the entry from the table, even if v referes (directly or
-- indirectly) to k.

-- constant function factory with memorization
do
  local mem = {} -- memorization table
  setmetatable(mem, { __mode = "k" })
  function factory(o)
    local res = mem[o]
    if not res then
      res = (function() return o end)
      mem[o] = res
    end
    return res
  end
end
