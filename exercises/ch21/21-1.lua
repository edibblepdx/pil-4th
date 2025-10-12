-- implement a stack class with methods push, pop, top, isempty
-- I'm going to rename the top method to peek and have top as a number

local Stack = {top = -1}

function Stack:new (o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

function Stack:push (v)
    self.top = self.top + 1
    self[self.top] = v     
end

function Stack:pop ()
    if self:isempty() then error"stack is empty" end
    self[self.top] = nil     -- garbage collection
    self.top = self.top - 1
end

function Stack:peek ()
    return self[self.top]
end

function Stack:isempty ()
    return self.top == -1 and true or false 
end

if ... == nil then
    stack = Stack:new()
    print("is empty?", stack:isempty())
    print("push 5"); stack:push(5)
    print("push 6"); stack:push(6)
    print("is empty?", stack:isempty())
    print("top", stack:peek())
    print("pop"); stack:pop()
    print("top", stack:peek())
    print("pop"); stack:pop()
    print("is empty?", stack:isempty())
    print("pop", "should fail"); stack:pop()   --> fail
end

return Stack
