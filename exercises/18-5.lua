-- write a 'true iterator' that traverses
-- all subsets of a given set

-- 2^n subsets not including the empty set
-- can use a binary representation
--> either it is in the subset or it is not
--> iterate from 0 to n_subsets
--> each binary digit is in or out

function allsubsets (t, f)
    local n = #t
    local n_subsets = 2^n
    local subset = {}
    for i = 0, n_subsets - 1 do
        for j = 1, n do
            local include = i >> (n - j) & 1
            if include == 1 then
                subset[#subset + 1] = t[j]
            end
        end
        f(subset)
        subset = {}
    end
end

local a = {}
-- just going to collect the subsets 
allsubsets({1, 2, 3, 4, 5}, function (t) a[#a + 1] = t end)
for k, v in ipairs(a) do 
    io.write("{")
    for j, k in ipairs(v) do 
        io.write(string.format("%d,",k))
    end 
    io.write("}\n")
end
print(string.format("subsets: %d", #a))

