local Deque = require "17-1-class"

deque = Deque:new()

deque:pushFirst(5)
deque:pushFirst(4)
deque:pushFirst(3)
deque:pushFirst(2)
deque:pushFirst(1)
deque:pushLast(6)
deque:pushLast(7)
deque:pushLast(8)
deque:pushLast(9)

deque:print()       --> 1 2 3 4 5 6 7 8 9
print()

deque:popFirst()    -- 1
deque:popFirst()    -- 2
deque:popFirst()    -- 3
deque:popLast()     -- 7
deque:popLast()     -- 8
deque:popLast()     -- 9

deque:print()       --> 4 5 6
print()
