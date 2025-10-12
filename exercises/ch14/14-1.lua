-- write a function to add two sparse matrices

-- print all nils as 0
-- will not always work based on how # is defined 
function printMatrix (a)
    local nrows = #a
    local ncols = 0
    for m, row in pairs(a) do
        if #row > ncols then ncols = #row end
    end

    for m = 1, nrows do
        for n = 1, ncols do
            io.write(string.format("%d\t", a[m][n] and a[m][n] or 0))
        end
        print()
    end
end

function add (a, b)
    local c = {}            -- resulting matrix
    for row = 1, #a do
        local resultrow = {}
        for col, aij in pairs(a[row]) do
            resultrow[col] = aij
        end
        for col, bij in pairs(b[row]) do
            resultrow[col] = (resultrow[col] or 0) + bij
        end
        c[row] = resultrow
    end
    return c
end

local a = {
    {1, nil, 5},
    {7, 4, 1},
    {nil, -3, 3}
}

local b = {
    {-1, 5, nil},
    {3, -4, nil},
    {4, 3, 3}
}

printMatrix(a)
print()
printMatrix(b)
print()
printMatrix(add(a, b))
