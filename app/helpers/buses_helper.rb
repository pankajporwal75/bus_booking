module BusesHelper
  def available_seats(bus)
    @occupied = bus.reservations.count
    bus.capacity - @occupied
  end
  
end
