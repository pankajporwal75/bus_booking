class Bus < ApplicationRecord
  # Associations
  belongs_to :bus_owner
  has_many :reservations, dependent: :destroy

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

end
