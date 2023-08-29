class Reservation < ApplicationRecord
  belongs_to :bus
  belongs_to :user

  validates :seats, presence: true
end
