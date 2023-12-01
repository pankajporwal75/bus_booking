module BusesHelper
  def available_seats(bus,date)
    @occupied = bus.reservations.where(date: date).count
    bus.capacity - @occupied
  end
  
end
