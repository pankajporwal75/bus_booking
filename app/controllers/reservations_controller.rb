class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def new
    @bus = Bus.find(params[:bus_id])
    @user = current_user
    authorize @user, policy_class: ReservationPolicy
    if @bus.approved?
      @reservation = @bus.reservations.new
      @date = params[:date] || Date.today
      @available_seats = Reservation.seats_on_date(@bus, @date)
      @all_seats = @bus.seats.all
    else
      redirect_to @bus, alert: "Bus not approved!"
    end
  end

  def create
    @bus = Bus.find(params[:bus_id])
    seat_ids = params[:reservation][:seat_id]
    date = params[:reservation][:date]
    parse_date = Date.parse(date)
    @reservation = Reservation.create_reservations(current_user.id, @bus.id, seat_ids, parse_date)
    if @reservation
      # ReservationMailer.create_reservation_email(@reservation).deliver_now
      redirect_to user_path(current_user), notice: "Reservation Successful"
    else
      flash[:alert] = "Select Date & Seats"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @user = @reservation.user
    if @reservation.destroy
      # ReservationMailer.cancel_reservation_email(@reservation).deliver_now
      redirect_to current_user, status: :see_other, notice: "Ticket Cancelled"
    else
      redirect_to user_path(current_user), status: :see_other, notice: "Ticket cannot be cancelled."
    end
  end

  def booking
    @user = params[:user_id]
    # @bookings = policy_scope(Reservation)
  end

  private

  def policy_scope(scope)
    Pundit.policy_scope!(current_user, scope)
  end

  # def reservation_params
  #   params.require(:reservation).permit(:seats)
  # end

  def require_approved
    @bus = Bus.find(params[:bus_id])
    unless @bus.approved
      redirect_to root_path, alert: "Bus not approved yet!"
    end
  end
end
