class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def new
    @bus = Bus.find(params[:bus_id])
    @user = current_user
    authorize @user, policy_class: ReservationPolicy
    if @bus.approved?
      @reservation = @bus.reservations.new
    else
      redirect_to @bus, alert: "Bus not approved!"
    end
  end

  def create
    @bus = Bus.find(params[:bus_id])
    required_seats = params[:reservation][:seats].to_i
    if (@bus.journey_date > Time.now && required_seats<=@bus.available_seats)
      @reservation = @bus.reservations.new(reservation_params)
      authorize current_user
      @reservation.user = current_user
      if @reservation.save
        ReservationMailer.with(reservation: @reservation).create_reservation_email.deliver_now
        # ReservationConfirmationJob.perform_now(@reservation)
        redirect_to buses_path, notice: "Reservation Successful"
      else
        render "new", status: :unprocessable_entity
      end
    # elsif (required_seats>@bus.available_seats)
    #     render "new", alert: "Selected number of seats not available"
    else
      redirect_to buses_path, alert: "This bus has already departed!!"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      ReservationMailer.with(reservation: @reservation).cancel_reservation_email.deliver_now
      redirect_to current_user, status: :see_other, notice: "Ticket Cancelled"
    else
      redirect_to user_path(current_user), status: :see_other, notice: "Ticket cannot be cancelled."
    end
  end

  private

  def policy_scope(scope)
    Pundit.policy_scope!(current_user, scope)
  end

  def reservation_params
    params.require(:reservation).permit(:seats)
  end
end
