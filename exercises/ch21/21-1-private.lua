-- implement a stack class with methods push, pop, top, isempty
-- I'm going to rename the top method to peek and have top as a number
-- private version
-- could also make the returned table read only

function newStack ()
    local self = {top = -1}

    local function push (v)
        self.top = self.top + 1
        self[self.top] = v     
    end

    local function pop ()
        if self.top == -1 then error"stack is empty" end
        self[self.top] = nil     -- garbage collection
        self.top = self.top - 1
    end

    local function peek ()
        return self[self.top]
    end

    local function isempty ()
        return self.top == -1 and true or false 
    end

    return {
        push    = push,
        pop     = pop,
        peek    = peek,
        isempty = isempty,
    }
end

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
