-- 21-4 reimplement the stack class using dual representation with proxies
--
-- Pros:    the data is private even within the chunk,
--          generally less table accesses per operation
--
-- Cons:    memory cost of an extra tables per instance
--          different syntax. You won't be using ':' here for access

function newStack ()
    local top = -1      -- private everywhere
    local data = {}     -- private everywhere
    local proxy = {}

    local methods = {
        push = function (v)
            top = top + 1
            data[top] = v
        end,

        pop = function ()
            if top == -1 then error"stack is empty" end
            data[top] = nil     -- garbage collection
            top = top - 1
        end,

        peek = function ()
            return data[top]
        end,

        isempty = function ()
            return top == -1 and true or false 
        end,
    }

    local mt = {__index = methods}

    setmetatable(proxy, mt)

    return proxy
end

if ... == nil then
    stack = newStack()
    print("is empty?", stack.isempty())
    print("push 5"); stack.push(5)
    print("push 6"); stack.push(6)
    print("is empty?", stack.isempty())
    print("top", stack.peek())
    print("pop"); stack.pop()
    print("top", stack.peek())
    print("pop"); stack.pop()
    print("is empty?", stack.isempty())
    print("pop", "should fail"); stack.pop()   --> fail
end

return Stack
