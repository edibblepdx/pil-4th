-- global function
function global_fact (n)
    if n == 0 then return 1
    else return n * global_fact(n-1)
    end
end

-- local function
local function local_fact (n)
    if n == 0 then return 1
    else return n * local_fact(n-1)
    end
end

-- "local function fact (x) end" expands to 
-- "local fact; fact = function (x) end"

-- if you do "local fact = function (x) end" you will get an error
-- because the local fact is not yet defined and it tries to call the global fact

-- instead do
-- local fact
-- fact = function (x) end

-- for indirect recursion you need to use forward declarations
-- local f
-- local function g () f() end
-- function f () g() end
--> this would be an infinite loop

print(global_fact(5))
print(local_fact(5))
