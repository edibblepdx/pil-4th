-- 24.6 Implement a transfer function. If you think about resume-yield as similar to call-return
-- then a transfer would be like a goto: it suspends to running coroutine and resumes any other
-- coroutine, given as an argument. Use a kind of dispatch to control your coroutines.

--[[
  This hides coroutine.yield and coroutine.resume and redefines coroutine.create.
  And you have to create a main function to act the main thread.
--]]

function main()
  coroutine.create("1", function(v)
    for _ = 1, 2 do -- could run this forever
      print(1, v)
      v = coroutine.transfer("2", "hello from 1")
    end
    coroutine.transfer("3", "hello from 1")
  end)

  coroutine.create("2", function(v)
    for _ = 1, 2 do -- could run this forever
      print(2, v)
      v = coroutine.transfer("1", "hello from 2")
    end
  end)

  coroutine.create("3", function(v)
    print(3, v)
    coroutine.transfer("4", "hello from 3")
  end)

  coroutine.create("4", function(v)
    print(4, v)
    coroutine.transfer("main", "hello from 4")
  end)

  print("main", coroutine.transfer("1", "hello from main"))
end

--> 1       hello from main
--> 2       hello from 1
--> 1       hello from 2
--> 2       hello from 1
--> 3       hello from 1
--> 4       hello from 3
--> main    hello from 4

do
  local yield = coroutine.yield           -- store coroutine.yield
  coroutine.yield = nil                   -- hide coroutine.yield
  function coroutine.transfer(label, ...) -- define coroutine.transfer
    return yield(label, ...)
  end
end

do
  local create = coroutine.create       -- store coroutine.create
  Threads = { ["main"] = create(main) } -- create Threads table
  coroutine.create = function(label, f) -- redefine coroutine.create
    Threads[label] = create(f)
  end
end

do
  local resume = coroutine.resume -- store coroutine.resume
  coroutine.resume = nil          -- hide coroutine.resume
  local label, args = "main", nil -- loop variables
  while true do                   -- dispatcher
    _, label, args = resume(Threads[label], args)
    if not label then break end
  end
end
