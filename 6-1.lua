function print_elements1 (a)
    for i = 1, #a do
        io.write(a[i], " ")
    end
    print()
end

function print_elements2 (a)
    print(table.unpack(a))
end

function print_elements3 (a)
    for k, v in ipairs(a) do
        print(k, v)
    end
end

function print_elements4 (a)
    a = table.pack(table.unpack(a))
    for i = 1, a.n do
        io.write(a[i], " ")
    end
    print()
end

print("using #")
print_elements1({1,2,3,4,5,6,7,8,9})
-- print_elements1({1,2,nil,4,5,nil,7,8,9}) --> breaks

print("\nusing table.unpack")
print_elements2({1,2,3,4,5,6,7,8,9})
print()
print_elements2({1,2,nil,4,5,nil,7,8,9})

print("\nusing ipairs")
print_elements3({1,2,3,4,5,6,7,8,9})
print()
print_elements3({1,2,nil,4,5,nil,7,8,9})    --> will not work because of nil (no error msg)

print("\nusing table.unpack then table.pack") --> this method is bad
print_elements4({1,2,3,4,5,6,7,8,9})
-- print_elements4({1,2,nil,4,5,nil,7,8,9}) --> breaks
