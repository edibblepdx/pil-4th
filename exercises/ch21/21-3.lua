-- 21-3 reimplement the stack class using dual representation
-- dual representation is a form of privacy where the class instance
-- is used as a key to it's private data

local data = {}     -- private to this chunk
Stack = {}

function Stack:push (v)
    local oldTop = data[self].top   -- minimize table accesses
    data[self][oldTop + 1] = v     
    data[self].top = oldTop + 1
end

function Stack:pop ()
    if self:isempty() then error"stack is empty" end
    local oldTop = data[self].top   -- minimize table accesses
    data[self][oldTop] = nil        -- garbage collection
    data[self].top = oldTop - 1
end

function Stack:peek ()
    return data[self][data[self].top]
end

function Stack:isempty ()
    return data[self].top == -1 and true or false 
end

function Stack:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    data[o] = {}            -- should b 'o' not 'self'
    data[o]["top"] = -1     -- should b 'o' not 'self'
    return o
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
