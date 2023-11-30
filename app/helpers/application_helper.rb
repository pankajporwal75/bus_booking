module ApplicationHelper
  def formatted_date(date)
    date.strftime("%d %b, %Y")
  end

  def format_time(time)
    time.strftime("%H:%M:%S")
  end

  def formatted_time(time)
    time.strftime("%I:%M %p")
  end

  def profile_image(user)
    if user.profile_image.attached?
      image_tag user.profile_image
    end
  end
end
