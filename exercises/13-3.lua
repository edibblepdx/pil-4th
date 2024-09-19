function power_of_2 (x)
    if (x % 2 == 0) then return true else return false end
end

function unsigned_power_of_2 (x)
    if (x & 1 == 0) then return true else return false end
end

local x = os.clock()
print(power_of_2(20))
print("time:", os.clock() - x)
print()

local a = (3 << 63) 
local b = (3 << 63) + 1

print(string.format("%u", a))
x = os.clock()
print(unsigned_power_of_2(a))
print("time:", os.clock() - x)
print()

print(string.format("%u", b))
x = os.clock()
print(unsigned_power_of_2(b))
print("time:", os.clock() - x)
print()

