print([=[
--------------------
    Lua core 
--------------------

__add       addition
__mul       multiplication
__sub       subtraction
__div       float division
__idiv      floor division
__unm       negation
__mod       modulo
__pow       exponentiation

__band      bitwise AND
__bor       bitwise OR
__bxor      bitwise exclusive OR
__bnot      bitwise NOT
__shl       left shift
__shr       right shift

__concat    concatenation

__eq        equal to
__lt        less than
__le        less than or equal to

Lua translates left column to right
a ~= b      not (a == b)
a >  b      b <  a
a >= b      b <= a

Equality operations result in false,
without calling any metamethod if two
objects have different basic types.

--------------------
    Library-Defined
--------------------

__tostring  what tostring() calls, and by extension print() also calls

__metatable protected metatable; value returned by getmetable() and setmetable() will raise an error

__pairs     what pairs() calls; add traversal behavior to non-table objects

--------------------
    Table-Access
--------------------

__index     if exists, returned when accessing an empty field, nil is returned otherwise; used for inheritence
            rawget(t,i) accesses a table without invoking its __index metamethod; no speedup

__newindex  when assigning a value to an absent index the interpreter calls the metamethod if it exists
            rawset(t,k,v) does the equivalent of t[k] = v without invoking any metamethod.
]=])
