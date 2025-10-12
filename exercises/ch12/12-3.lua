-- write a function that takes a date-time (coded as a number)
-- and returns the number of seconds passed since the beginning
-- of its respecctive day.

function seconds_passed_today (t)
    local seconds2day = 60 * 60 * 24
    return t % seconds2day
end

local t = os.time()
print (seconds_passed_today(t)) --> UTC time

