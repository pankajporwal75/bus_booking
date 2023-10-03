class Reservation < ApplicationRecord
  belongs_to :bus
  belongs_to :user

  validates :seats, presence: true
  validate :seats_less_then_capacity


  def seats_less_then_capacity
    if(seats > bus.capacity)
      errors.add(:seats, "must be less then capacity of bus")
    end
  end
end
