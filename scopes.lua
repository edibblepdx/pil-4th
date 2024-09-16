local function foo (a, b)
    local c = a + b
    d = a - b
end

-- a and b are non-local variables (upvalues)
-- c is a local variable
-- d is a global variable

-- local function foo (a, b) <body> end expands to
-- local foo; foo = function (a, b) <body> end

foo(10, 5)
print(a)    --> nil
print(c)    --> nil
print(d)    --> 5
