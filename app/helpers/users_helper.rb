module UsersHelper
  def bus_time(bus)
    journey_date.strftime("%d %b, %Y")
  end
end
