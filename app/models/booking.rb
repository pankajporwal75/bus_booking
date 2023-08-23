class Booking < ApplicationRecord
  belongs_to :bus, optional: true
  belongs_to :user, optional: true

end
