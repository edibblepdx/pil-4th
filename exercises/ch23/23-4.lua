-- 23.4 explain the following

local count = 0

local mt = { __gc = function() count = count - 1 end } -- count down when finalized
local a = {}

for i = 1, 10000 do
  count = count + 1
  a[i] = setmetatable({}, mt)
end

collectgarbage()
print(collectgarbage("count") * 1024, count) --> number of bytes
a = nil
collectgarbage()                             --> clean up the keys and values in a??
print(collectgarbage("count") * 1024, count) --> number of bytes
collectgarbage()                             --> clean up missed things??
print(collectgarbage("count") * 1024, count) --> number of bytes
