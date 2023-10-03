class Bus < ApplicationRecord
  # Associations
  belongs_to :bus_owner, class_name: "User", foreign_key: "bus_owner_id"
  has_many :reservations, dependent: :destroy

  #Validations
  validates :source, presence: true
  validates :destination, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :journey_date, presence: true
  validates :depart_time, presence: true
  validate :upcoming_journey_date
  validate :different_source_and_destination

  # Enum
  enum status: { disapproved: 0, approved: 1 }

  # Scope
  scope :upcoming, -> { where("journey_date > ?", Time.now).order("journey_date asc") }
  scope :on_date, ->(search_date) {where("journey_date = ?", search_date)}
  scope :approved, -> {where(status: :approved)}

  # Methods
  def available_seats
    capacity - reservations.sum(:seats)
  end

  def upcoming_journey_date
    if journey_date.present? && journey_date < Date.today
      errors.add(:journey_date, "must be both present and an upcoming date")
    end
  end

  def different_source_and_destination
    if source == destination
      errors.add(:destination, "must be different from the source")
    end
  end
end
