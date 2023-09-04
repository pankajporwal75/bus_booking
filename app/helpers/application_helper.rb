module ApplicationHelper
    def formatted_date(date)
        date.strftime("%d %b, %Y")
    end

    def formatted_time(time)
        time.strftime("%I:%M %p")
    end
end
