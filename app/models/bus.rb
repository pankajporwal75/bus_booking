class Bus < ApplicationRecord
  # Associations
  belongs_to :bus_owner, class_name: "User", foreign_key: "bus_owner_id"
  has_many :seats, dependent: :destroy
  has_many :reservations, dependent: :destroy

  #Validations
  validates :source, presence: true
  validates :destination, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 50 }
  validates :depart_time, presence: true
  validates :bus_number, presence: true
  validate :different_source_and_destination

  #Callbacks
  after_create :initialize_seats
  after_update :adjust_seats
  before_destroy :delete_seats
  before_save :capitalize_route

  # Enum
  enum status: { disapproved: 0, approved: 1 }

  # Scope
  # scope :upcoming, -> { where("journey_date > ?", Time.now).order("journey_date asc") }
  # scope :on_date, ->(search_date) {where("journey_date = ?", search_date)}
  scope :approved, -> {where(status: :approved)}

  # Methods
  def initialize_seats(n = 1)
    seats = (n..capacity).map do |seat|
      Seat.new(bus_id: id, seat_no: seat)
    end

    Seat.transaction do
      Seat.import(seats)
    end
  end

  def delete_seats
    Seat.where(bus_id: id).delete_all
  end

  def adjust_seats
    initial_no_of_seat = seats.count
    if capacity > initial_no_of_seat
      create_seats(initial_no_of_seat + 1)
    elsif capacity < initial_no_of_seat
      seats.where(bus_id: id).where(" seat_no > ? ", capacity).destroy_all
    end
  end

  def capitalize_route
    self.source = source.capitalize
    self.destination = destination.capitalize
  end

  def departed?
    return true if (self.depart_time.strftime("%H:%M:%S")) < (Time.now.strftime("%H:%M:%S"))
    false
  end
  
  # def available_seats
  #   capacity - reservations.sum(:seats)
  # end

  # def upcoming_journey_date
  #   if journey_date.present? && journey_date < Date.today
  #     errors.add(:journey_date, "must be both present and an upcoming date")
  #   end
  # end

  def different_source_and_destination
    if source == destination
      errors.add(:destination, "must be different from the source")
    end
  end
end
