class Bus < ApplicationRecord
    belongs_to :bus_owner
    has_many :reservations, dependent: :destroy

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
end
