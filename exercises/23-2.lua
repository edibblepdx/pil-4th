-- 23.2 test the gc

o = { x = "hi" }
setmetatable(o, { __gc = function(o) print(o.x) end })
o = nil

if #arg < 1 then
  print("normal gc")
  collectgarbage()
else
  local a = tonumber(arg[1])
  if a == 1 then
    print("without collection cycle")
  elseif a == 2 then
    -- NOTE: Only one that doest not collect the garbage
    print("os.exit()")
    os.exit()
  elseif a == 3 then
    print("error")
    error("error", 1)
  else
    print("hi :-)")
  end
end
