-- Lua has asymmetric coroutines meaning that it has a different function to supend
-- and resume the execution of a coroutine.
-- coroutines have the states: suspended, dead, normal.
-- suspend after creation or yield.
-- dead when finished.
-- normal when waiting on another coroutine to finish or yield.
-- you can symmetrically pass arguments through coroutine.yield and coroutine.resume.
-- arguments returned from the main function go to the corresponding resume.

-- consumer-driven-design where the producer is the coroutine
-- producer-driven-design would have the consumer instead be the coroutine

local function send(x)
  coroutine.yield(x)
end

local function producer()
  while true do
    local x = io.read()
    send(x)
  end
end

producer = coroutine.create(producer)

local function receive()
  local status, value = coroutine.resume(producer)
  return value
end

local function consumer()
  while true do
    local x = receive()
    io.write(x, "\n")
  end
end

consumer()
