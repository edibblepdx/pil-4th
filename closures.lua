-- What is a value in Lua is the closure, not the function.
-- The function itself is a kind of prototype for closures.
-- Each closure has an independent instantiation of the variable count.

function newCounter ()
    local count = 0     -- here count is a local variable
    return function ()
             count = count + 1
             return count
           end
end

function newCounterAlt (count)  -- here count is a non-local variable (upvalue)
    return function ()
             count = count + 1
             return count
           end
end

c1 = newCounter()
c2 = newCounter()

print(c1())
print(c1())
print(c2())
print(c2())

print()

c1 = newCounterAlt(1)
c2 = newCounterAlt(7)

print(c1())
print(c1())
print(c2())
print(c2())
