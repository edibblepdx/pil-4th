a = {}
mt = { __mode = "k" }
setmetatable(a, mt) -- now 'a' has weak keys
key = {}            -- creates first key
a[key] = 1
key = {}            -- creates second key that overwrites the first key reference
a[key] = 2
-- at this point the first key reference only exists as a 'weak' reference within the table a
collectgarbage()
for k, v in pairs(a) do print(v) end
--> 2

--[[
Only objects can be removed from weak tables.

Numbers and booleans, e.g. are not collectible.

If the value corresponding to a numeric key is collected
in a table with weak values then the whole entry is removed
from the table.

Strings are also not removed from weak tables unless their
associated value is collected.
]]
