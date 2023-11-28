class Reservation < ApplicationRecord
  belongs_to :bus
  belongs_to :user
  belongs_to :seat

  validates :date, presence: true
  # validate :seats_less_then_capacity


  def seats_less_then_capacity
    if (seats == nil || seats<1)
    errors.add(:reservation, "seats must be greater then 1.")
    elsif(seats > bus.capacity)
      errors.add(:reservation, "seats must be less then capacity of bus")
    end
  end

  def self.seats_on_date(bus, date)
    rsv_on_search_date = bus.reservations.where(date: date)
    booked_seat_ids = rsv_on_search_date.pluck(:seat_id)
    bus.seats.where.not(id: booked_seat_ids)
  end

  def self.check_booked?(seat_id, bus_id, date)
    result = Reservation.where(seat_id: seat_id, date: date, bus_id: bus_id)
    !(result.blank?) 
  end

  def self.create_reservations(user_id, bus_id, seat_ids, date)
    return false if seat_ids.blank?
    reservations = seat_ids.map do |seat_id|
      next if Reservation.check_booked?(seat_id, bus_id, date)
      Reservation.new(user_id: user_id, bus_id: bus_id, seat_id: seat_id, date: date)
    end
    Reservation.transaction do
      Reservation.import(reservations.compact) # Using 'activerecord-import' gem
    end
    true
  end
end
