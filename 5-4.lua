function polynomial (a, x)
    local sum = 0.0
    for n = 1, #a do
        sum = sum + (a[n] * x^(n-1))
    end

    return sum
end

print(polynomial({1, 2, 3, 4, 5}, 2))
