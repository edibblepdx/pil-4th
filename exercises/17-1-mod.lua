-- double ended queue
-- This module provides functions to modify a double
-- ended queue. This could be made into a class.

local deque = {}

function deque.listNew()
  return { first = 0, last = -1 }
end

-- deque.list = listNew()

function deque.pushFirst(list, value)
  local first = list.first - 1
  list.first = first
  list[first] = value
end

function deque.pushLast(list, value)
  local last = list.last + 1
  list.last = last
  list[last] = value
end

function deque.popFirst(list)
  local first = list.first
  if first > list.last then error("list is empty") end
  local value = list[first]
  list[first] = nil   -- to allow garbage collection
  list.first = first + 1
  return value
end

function deque.popLast(list)
  local last = list.last
  if list.first > last then error("list is empty") end
  local value = list[last]
  list[last] = nil   -- to allow garbage collection
  list.last = last - 1
  return value
end

return deque
