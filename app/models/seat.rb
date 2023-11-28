class Seat < ApplicationRecord
  belongs_to :bus
  has_many :reservations

  def reserved?
    reservations.exists? # Check if there are any reservations associated with this seat
  end
end
