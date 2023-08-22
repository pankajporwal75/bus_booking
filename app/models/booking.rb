class Booking < ApplicationRecord
  belongs_to :bus
  belongs_to :user, optional: true
end
