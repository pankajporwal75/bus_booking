class Bus < ApplicationRecord
    belongs_to :bus_owner
    has_many :reservations, dependent: :destroy
    enum status: { disapproved: 0, approved: 1 }

    # def approve
    #     update(approved: true)
    # end

    # def disapprove
    #     update(approved: false)
    #     reservations.delete_all
    # end

    scope :upcoming, -> { where("journey_date > ?", Time.now).order("journey_date asc") }
    scope :on_date, ->(search_date) {where("journey_date = ?", search_date)}
    scope :approved, -> {where(status: :approved)}

    # def approved? 
    #     approved == true
    # end

    def available_seats
        capacity - reservations.sum(:seats)
    end

end
