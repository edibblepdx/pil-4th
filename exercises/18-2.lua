-- exercise 18-2
-- add a step parameter to exercise 18-1
-- if you want to support counting down
-- could have 2 different functions you possibly return
--
-- could probably figure out a better way, but I want
-- as few operations withing the iterator as possible
-- and this is what I thought of.

function fromto(n, m, s)
    s = math.abs(s) -- s should be positive
    -- just going to handle 0 step this way and the for does nothing
    if s == 0 then return function () return nil end end
    -- counting up
    if (n <= m) then
        n, m  = n - s, m - s + 1
        return function ()
            n = (n < m) and (n + s) or nil
            return n
        end
    -- counting down
    else
        n, m  = n + s, m + s - 1
        return function ()
            n = (n > m) and (n - s) or nil
            return n
        end
    end
end

print() -- spacing
for i in fromto(1, 38, 9) do
    print(i) --> 1 10 19 28 37
end

print() -- spacing
for i in fromto(38, 1, 9) do
    print(i) --> 38 29 20 11 2
end

-- stateless version
-- iter is the iterator function
-- the table {max, s} is the invariant state
-- n-s is the control variable initial value
--
-- this doesn't include the extra checks from the other version
-- could make a local table of iterator functions if you wanted
local function iter (t, i)
    return (i < t.max) and (i + t.s) or nil
end

function fromtoagain (n, m, s)
    s = math.abs(s) -- s should be positive
    return iter, {max = m-s+1, s = s}, n-s
end

print() -- spacing
for i in fromtoagain(1, 9, 2) do
    print(i)
end

-- We can use the stateless version again in other loops
-- without the cost of making new closures. The iterator
-- maintains no state, it only uses its arguments to
-- return a value.
