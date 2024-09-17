-- write a function that takes a year and
-- returns the day of its first friday

function first_friday (year)
    t = os.date("*t", os.time({["year"] = year, ["month"] = 1, ["day"] = 1}))
    while true do
        if t.wday == 6 then break else t.day = t.day + 1 end
        t = os.date("*t", os.time(t)) 
    end

    return os.time(t)
end

print(os.date("%c", first_friday(2024)))
