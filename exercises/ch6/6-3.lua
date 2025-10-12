function return_all_but_last(...)
  a = table.pack(...)
  b = {}
  for i = 1, a.n - 1 do
    b[i] = a[i]
  end
  return table.unpack(b, 1, a.n - 1)
end

function return_all_but_last(...)
  a = table.pack(...)
  return table.unpack(a, 1, a.n - 1)
end

print(return_all_but_last("heehee", "haha", "hoohoo", "ha"))
print(return_all_but_last("glorp", nil, "gleeb", nil))
