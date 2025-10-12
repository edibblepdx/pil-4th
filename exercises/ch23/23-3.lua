-- 23.3 memorization with strings
-- I guess wrap the string in its own table? This one works!
-- Or in a function? The function isn't garbage collected

local stringMemo; do
  local mem = {}
  local mt = { __gc = function() print("I am being collected") end }
  setmetatable(mem, { __mode = "v" })
  function stringMemo(s)
    local res = mem[s]
    if res == nil then
      res = { s .. "!!" }
      setmetatable(res, mt)
      mem[s] = res
    end
    return res[1]
  end
end

local myString = stringMemo("fish")
local myOtherString = stringMemo("fish")
assert(myString == myOtherString)
print(myString)

myString, myOtherString = nil, nil
collectgarbage()
print()

myString = stringMemo("fish")
myOtherString = stringMemo("fish")
assert(myString == myOtherString)
print(myString)
