class Bus < ApplicationRecord
    belongs_to :bus_owner
    has_many :bookings, dependent: :destroy

<<<<<<< Updated upstream
    
=======
    def approve
        update(approved: true)
    end

    def disapprove
        update(approved: false)
        reservations.delete_all
    end

    scope :upcoming, -> { where("journey_date > ?", Time.now).order("journey_date asc") }

    def approved? 
        approved == true
    end

    def available_seats
        capacity - reservations.sum(:seats)
    end
>>>>>>> Stashed changes
end
