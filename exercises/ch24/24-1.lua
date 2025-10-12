-- 24.1: Rewrite 24.2 producer-consumer example using producer-driven-design
-- where the consumer is the coroutine and the producer is the main thread

function producer()
  while true do
    local x = io.read()
    send(x)
  end
end

function consumer()
  while true do
    local x = receive()
    io.write(x, "\n")
  end
end

function receive()
  return coroutine.yield()
end

function send(x)
  status = coroutine.resume(consumer, x)
end

consumer = coroutine.create(consumer)
coroutine.resume(consumer)
-- necessary to resume so that we arrive at the yield
-- otherwise the first input is discarded since the consumer
-- function takes no arguments

producer()
