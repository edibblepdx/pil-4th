-- take a function f and return an approximation of it's integral
function integral (f, delta)
    delta = delta or 1e-4
    local sum = 0
    return function (a, b)
        local n = math.floor((b - a) / delta)
        -- right reimann sum
        for i = 1, n do
            sum = sum + f(a + delta * i) * delta
        end
        return sum
    end
end

c = integral(math.sin)
print(c(1, 5))                      -- 0.25655010042807
print(math.cos(1) - math.cos(5))    -- 0.25664012040491
