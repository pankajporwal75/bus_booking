module BusesHelper
    def available_seats(bus)
        @occupied = 0
        bus.bookings.each do |booking|
            @occupied+=booking.seats
        end
        bus.capacity - @occupied
    end
end
