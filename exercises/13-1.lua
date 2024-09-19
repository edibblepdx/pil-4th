-- write a function to compute the modulo operation
-- for unsigned integers

-- defines the modulo operator:
-- a % b == a - ((a // b)) * b)
-- b cannot be 0

--[[
my attempt that kind of follows the unsigned division example in the book
]]
function umod (a, b)
    if b < 0 then
        if math.ult(a, b) then return a
        else return a - b
        end
    end
    local quotient = ((a >> 1) // b) << 1
    local remainder = a - quotient * b
    if not math.ult(remainder, b) then remainder = remainder - b end
    return remainder
end

--[[
Online Solution Source (I just tried to annotate it)
https://stackoverflow.com/questions/53083550/how-to-implement-the-operator-for-unsigned-integer
]]
function umod2 (x, y)
    -- A and B and C or D and E or C
    -- if A, B, C are true it returns C
    -- if any of A, B, C are false it returns D and E or C
    -- if D and E are true it returns E
    -- if any of D or E are false it returns C
    --
    -- a < 0 is equivalent to testing if a > 2^63
    -- a >> 1 is equivalent to division by 2
    --
    -- if (y <= x) and (x > 2^63) then return (x - y)
    -- else if (y > 2^63) return (x)
    -- else return (((x>>1))%y*2+(x&1)-y)%y) end
    return y<=x and x<0 and x-y or y<0 and x or ((x>>1)%y*2+(x&1)-y)%y
end

local a = (3 << 62)
local b = (3 << 62) - 50
print(a, b)
print(string.format("%u", a), string.format("%u", b))
print(string.format("%u", umod(a, b))) --> 50
print(string.format("%u", umod2(a, b))) --> 50

print(string.format("%u", umod(20, 11))) --> 9
print(string.format("%u", umod2(20, 11))) --> 9


