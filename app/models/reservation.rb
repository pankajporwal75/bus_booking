class Reservation < ApplicationRecord
  belongs_to :bus
  belongs_to :user

  validates :seats, presence: true
  validate :seats_less_then_capacity

  scope :upcoming, -> {
    joins(:bus)
      .where('buses.journey_date > ?', Time.now)
  }

  def seats_less_then_capacity
    if (seats == nil || seats<1)
    errors.add(:reservation, "seats must be greater then 1.")
    elsif(seats > bus.capacity)
      errors.add(:reservation, "seats must be less then capacity of bus")
    end
  end
end
