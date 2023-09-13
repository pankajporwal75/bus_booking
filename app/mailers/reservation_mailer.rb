class ReservationMailer < ApplicationMailer
  default from: 'admin@busreservation.com'

  def create_reservation_email
    @reservation = params[:reservation]
    # @reservation = reservation
    mail(to: @reservation.user.email, subject: 'Reservation Confirmed!')
  end

  def cancel_reservation_email
    @reservation = params[:reservation]
    # @reservation = reservation
    mail(to: @reservation.user.email, subject: 'Reservation Cancelled!')
  end

end
