-- 5-4 stuff
function polynomial (a, x)
    local sum = 0.0
    for n = 1, #a do
        sum = sum + (a[n] * x^(n-1))
    end

    return sum
end

print(polynomial({1, 2, 3, 4, 5}, 2))

-- 9-3 stuff
function newpoly(a)
    return function (x)
        local sum = 0.0
        for n = 1, #a do
            sum = sum + (a[n] * x^(n-1))
        end
        return sum
    end
end

f = newpoly({3, 0, 1})
print(f(0))     --> 3
print(f(5))     --> 28
print(f(10))    --> 103
