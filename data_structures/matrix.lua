
local N = 10
local M = 10

-- method 1: jagged array (array of arrays)
local mt = {}           -- create the matrix
for i = 1, N do
    local row = {}      
    mt[i] = row         -- create a new row
    for j = 1, M do     -- to create a triangular matrix: "for j = 1, i do ... end"
        row[j] = 0
    end
end

-- method 2: composing the two indices into a single one
local mt = {}
for i = 1, N do
    local aux = (i - 1) * M
    for j = 1, M do
        mt[aux + j] = 0
    end
end
