-- double ended queue
-- This module provides functions to modify a double
-- ended queue. This could be made into a class.

local deque = {
    first = 0,
    last = -1,
    list = {},
}

function deque:new (o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

function deque:pushFirst (value)
    local first = self.first - 1
    self.first = first
    self.list[first] = value
end

function deque:pushLast (value)
    local last = self.last + 1
    self.last = last
    self.list[last] = value
end

function deque:popFirst ()
    local first = self.first
    if first > self.last then error("list is empty") end
    local value = self.list[first]
    self.list[first] = nil           -- to allow garbage collection
    self.first = first + 1
    return value
end

function deque:popLast ()
    local last = self.last
    if self.first > last then error("list is empty") end
    local value = self.list[last]
    self.list[last] = nil            -- to allow garbage collection
    self.last = last - 1
    return value
end

function deque:print ()
    if self.last < self.first then return end
    for i = self.first, self.last do print(self.list[i]) end
end

return deque
