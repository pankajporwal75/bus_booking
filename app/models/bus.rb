class Bus < ApplicationRecord
    belongs_to :bus_owner
    has_many :bookings, dependent: :destroy

    
end
