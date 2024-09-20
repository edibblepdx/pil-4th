
list = nil  -- root

list = {next = list, value = v} -- insert at beginning

-- traverse
local l = list
while l do
    print(l.value)
    l = l.next
end
