-- write a function to compute the hamming weight of a given integer

-- this is a slow method O(n) as it checks every bit
function hamming (x)
    local weight = 0
    while x ~= 0 do
        weight = weight + (x & 1)
        x = x >> 1
    end
    return weight
end

-- maximum unsigned integer
print("large numbers:")
print(string.format("%u", 0xffffffffffffffff))
print(string.format("%u", (1 << 64) - 1))
print()

print("1:", hamming(1)) --> 1
print("2:", hamming(2)) --> 10
print("3:", hamming(3)) --> 11
print("4:", hamming(4)) --> 100
print("5:", hamming(5)) --> 101
print("6:", hamming(6)) --> 110
print("7:", hamming(7)) --> 111
print("8:", hamming(8)) --> 1000
print("9:", hamming(9)) --> 1001
print("huge:", hamming(0xffffffffffffffff)) --> 64 ALL BITS ON YIPPEE!!!
print()
