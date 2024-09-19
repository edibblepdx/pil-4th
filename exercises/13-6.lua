-- bit array

function newBitArray (n)
    a = {}
    for i = 1, n do
        a[i] = false
    end
    return a
end

function setBit (a, n, v)
    a[n] = v
end

function testBit (a, n)
    return a[n]
end
