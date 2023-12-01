class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def index
      @bus = Bus.find(params[:bus_id])
      @reservations = Reservation.where(bus_id: @bus.id).order(date: :desc)
      @bus_owner = @bus.bus_owner
      authorize (@bus), policy_class: ReservationPolicy
  end

  def new
    @bus = Bus.find(params[:bus_id])
    @user = current_user
    authorize @user, policy_class: ReservationPolicy
    if @bus.approved?
      @reservation = @bus.reservations.new
      @date = params[:date] || (@bus.depart_time.strftime("%H:%M:%S") < Time.now.strftime("%H:%M:%S") ? Date.tomorrow : Date.today)
      @available_seats = Reservation.seats_on_date(@bus, @date)
      @all_seats = @bus.seats.all
      @booked_seats = Reservation.booked_on_date(@bus, @date)
    else
      redirect_to @bus, alert: "Bus not approved!"
    end
  end

  def create
    @bus = Bus.find(params[:bus_id])
    seat_ids = params[:reservation][:seat_id]
    date = params[:reservation][:date]
    parse_date = Date.parse(date)
    # binding.pry
    @reservation = Reservation.create_reservations(current_user.id, @bus.id, seat_ids, parse_date)
    # binding.pry
    if @reservation
      # ReservationMailer.create_reservation_email(@reservation).deliver_now
      redirect_to user_path(current_user), notice: "Reservation Successful"
    else
      flash[:alert] = "Select valid date & seats"
      redirect_to new_bus_reservation_path(@bus)
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

  def search
    date = params[:search_date]
    @bus = Bus.find(params[:bus_id])
    if (date.present?)
      @date = Date.parse(date)
      authorize current_user, :all_users?
      @reservations = @bus.reservations.where(date: @date)
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to buses_path, alert: "Enter valid date!!"}
          format.js
        end
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
