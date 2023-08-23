class ReservationsController < ApplicationController

    before_action :authenticate_user!
    
    def new
        @bus = Bus.find(params[:bus_id])
        @reservation = @bus.reservations.new
    end

    def index
        @bus = Bus.find(params[:bus_id])
        @reservations = @bus.reservations.all
    end

    def create
        @bus = Bus.find(params[:bus_id])
        @reservation = @bus.reservations.new(reservation_params)
        @reservation.user = current_user
        if @reservation.save
            redirect_to buses_path, notice: "Reservation Successful"
        else
            render "new", status: :unprocessable_entity
        end
    end

    def destroy
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        redirect_to current_user, status: :see_other, notice: "Ticket Cancelled"
    end

    private
    def reservation_params
        params.require(:reservation).permit(:seats)
    end
end
