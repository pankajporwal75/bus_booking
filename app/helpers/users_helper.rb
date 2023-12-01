module UsersHelper
  def bus_time(bus)
    bus.depart_time.strftime("%H:%M:%S")
  end
end
