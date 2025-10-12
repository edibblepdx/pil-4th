print([[
for <var-list> in <exp-list> do
    <body>
end

<var-list> : one or more variable names separated by commas
<exp-list> : one or more expressions separated by commas; usually a call to an iterator factory

the generic for keeps 3 values:
- the iterator function
- an invariant state
- and a control variable: the first (or only) variable in the list

in the following: for k, v in pairs(t) do print(k,v) end
- k is the control variable; if k is nil the loop ends

first the expressions after 'in' are evaluated and provide the generic for with 3 values:
- the iterator function
- an invariant state
- control variable initial value

after initialization, the for calls the iterator function with two arguments:
- the invariant state
- the control variable

if the first returned value is nil, the loop terminates. otherwise, the for executes its body
and calls the iteration function again repeating the process.

stateless iterators

local function iterator (<invariant-state>, <control-variable>)
    <body>
    return <control-variable>, <value>
end

function factory (<invariant-state>)
    return iterator, <invariant-state>, <control-variable-initial-value>
end

then for calls the iterator passing the <invariant-state> and <control-variable>
and receives <control-variable> and <value>
]])

