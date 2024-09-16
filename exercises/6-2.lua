function return_all_but_first (...)
    a = table.pack(...)
    b = {}
    for i = 2, a.n do
        b[i-1] = a[i]
    end
    return table.unpack(b, 1, a.n - 1)
end

print(return_all_but_first("heehee", "haha", "hoohoo", "ha"))
print(return_all_but_first("glorp", nil, "gleeb", nil))
