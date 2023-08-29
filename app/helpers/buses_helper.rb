module BusesHelper
    def available_seats(bus)
        @occupied = 0
        bus.reservations.each do |reservation|
            @occupied+=reservation.seats
        end
        bus.capacity - @occupied
    end
end
