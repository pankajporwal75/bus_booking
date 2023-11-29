class Seat < ApplicationRecord
  belongs_to :bus
  has_many :reservations

  def reserved?(date)
    reservations = bus.reservations.where(date: date)
    seat_ids = []
    reservations.each do |reservation|
      seat_ids << reservation.seat_id
    end
    return true if seat_ids.include?(self.id)
    false
  end
end
