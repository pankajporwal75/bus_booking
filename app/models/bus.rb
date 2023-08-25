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

    # def 
    #     approved == true
    # end
end
