-- revisiting chapter 20/21 now after learning garbage collection

-- use a weak table to map a table to its default value
-- you set mt as the metatable for the new table t, but the
-- default values are not in the table mt; they are in defaults[t]
-- when you index a non existing method or member it redirects to defaults
--> one shared metatable, one defaults table, individual default tables in defaults
local defaults = {}
setmetatable(defaults, { __mode = "k" })
local mt = { __index = function(t) return defaults[t] end }
function setDefault(t, d)
  defaults[t] = d
  setmetatable(t, mt)
end

-- with memorization
-- this will reuse existing metatables previously used as default values
--> a closure to hold d, a table of memorized metatables
local metas = {}
setmetatable(metas, { __mode = "v" })
function setDefault(t, d)
  local mt = metas[d]
  if mt == nil then
    mt = { __index = function() return d end }
    metas[d] = mt -- memorize
  end
  setmetatable(t, mt)
end
