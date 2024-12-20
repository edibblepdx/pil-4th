-- exercise 18-1
-- write an iterator fromto such that the next loop becomes
-- equivalent to a numeric for
--
-- for i in fromto(n, m) do
--  <body>
-- end
--
-- then implement a stateless version

function fromto(n, m)
    -- counting up
    if (n <= m) then
        n = n - 1
        return function ()
            n = (n < m) and (n + 1) or nil
            return n
        end
    -- counting down
    else
        n = n + 1
        return function ()
            n = (n > m) and (n - 1) or nil
            return n
        end
    end
end

print() -- spacing
for i in fromto(1, 9) do
    print(i)
end

print() -- spacing
for i in fromto(9, 1) do
    print(i)
end

print() -- spacing
for i in fromto(9, 9) do
    print(i)
end

-- stateless version
-- iter is the iterator function
-- m is the invariant state
-- n-1 is the control variable initial value
local function iterup (m, i)
    return (i < m) and (i + 1) or nil
end

local function iterdown (m, i)
    return (i > m) and (i - 1) or nil
end

function fromtoagain (n, m)
    if (n <= m) then return iterup, m, n - 1 end
    return iterdown, m, n + 1
end

print() -- spacing
print("stateless")

print() -- spacing
for i in fromtoagain(1, 9) do
    print(i)
end

print() -- spacing
for i in fromtoagain(9, 1) do
    print(i)
end

print() -- spacing
for i in fromtoagain(9, 9) do
    print(i)
end

-- We can use the stateless version again in other loops
-- without the cost of making new closures. The iterator
-- maintains no state, it only uses its arguments to
-- return a value.
