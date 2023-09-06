class ReservationConfirmationJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    # Do something later
    # ReservationMailer.create_reservation_email(reservation).deliver_now
  end
end
