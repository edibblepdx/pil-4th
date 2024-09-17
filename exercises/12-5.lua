-- write a function that computes the number of complete days
-- between two given dates

function days_between (t1, t2)
    local sec2day = 60 * 60 * 24
    return math.abs((t2 - t1) // sec2day)
end

local t1 = os.time()            -- today

local t2 = os.date("*t", t1)
t2.day = t2.day + 42
t2 = os.time(t2)                -- 42 days later

print(days_between(t1, t2)) --> 42

