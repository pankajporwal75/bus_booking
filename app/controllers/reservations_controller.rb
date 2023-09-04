class ReservationsController < ApplicationController

    before_action :authenticate_user!
    # before_action :require_bus_owner, only: [:index]
    
    def index
        @bus = Bus.find(params[:bus_id])
        # if(current_user == @bus.bus_owner)
            @reservations = @bus.reservations
            authorize @reservations
        # else
            # redirect_to bus_path(@bus), alert: "Unauthorized Access"
        # end
        # authorize @reservations
    end

    def new
        @bus = Bus.find(params[:bus_id])
        if @bus.approved?
            @reservation = @bus.reservations.new
            authorize @reservation
        else
            redirect_to @bus, alert: "Bus not approved!"
        end
    end

    def create
        @bus = Bus.find(params[:bus_id])
        required_seats = params[:reservation][:seats].to_i
        if (@bus.journey_date > Time.now && required_seats<=@bus.available_seats)
            @reservation = @bus.reservations.new(reservation_params)
            authorize @reservation
            @reservation.user = current_user
            if @reservation.save
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
            redirect_to current_user, status: :see_other, notice: "Ticket Cancelled"
        else
            redirect_to user_path(current_user), status: :see_other, notice: "Ticket cannot be cancelled."
        end
    end

    private
    def reservation_params
        params.require(:reservation).permit(:seats)
    end
end
