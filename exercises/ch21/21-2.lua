-- create a StackQueue class that inherits from the Stack class
-- add method insertbottom that inserts an element at the bottom of the stack

Stack = require"21-1"

StackQueue = Stack:new{top = -1, bottom = 0}

function StackQueue:insertbottom (v)
    self.bottom = self.bottom - 1
    self[self.bottom] = v     
end

-- need to redefine this method for a queue
function StackQueue:isempty ()
    return self.top < self.bottom and true or false 
end

if ... == nil then
    queue = StackQueue:new()
    print("is empty?", queue:isempty())
    print("push 6"); queue:push(6)
    print("is empty?", queue:isempty())
    print("push 5 bottom"); queue:insertbottom(5)
    print("is empty?", queue:isempty())
    print("top", queue:peek())
    print("pop"); queue:pop()
    print("top", queue:peek())
    print("pop"); queue:pop()
    print("is empty?", queue:isempty())
    print("pop", "should fail"); queue:pop()   --> fail
end
