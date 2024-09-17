-- write a function that returns the date-time 
-- exactly one month after a given date-time
-- (Assume numeric coding of date-time)

function one_month_later (t)
    t = os.date("*t", t)
    t.month = t.month + 1
    return os.time(t)
end

local t = os.time()
print(t) --> number
--print(os.date("%Y-%m-%d, t")) --> year-month-day
print(os.date("%c", t)) --> date and time

t = one_month_later(t)
print(t) --> number
--print(os.date("%Y-%m-%d, t")) --> year-month-day
print(os.date("%c", t)) --> date and time


