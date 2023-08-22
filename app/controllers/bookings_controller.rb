class BookingsController < ApplicationController

    before_action :authenticate_user!
    
    def new
        @bus = Bus.find(params[:bus_id])
        @booking = @bus.bookings.new
    end

    def index
        @bookings = Booking.all
    end

    def create
        @bus = Bus.find(params[:bus_id])
        @booking = @bus.bookings.new(booking_params)
        @booking.user = current_user
        if @booking.save
            redirect_to buses_path, notice: "Booking Successful"
        else
            render "new", status: :unprocessable_entity
        end
    end

    private
    def booking_params
        params.require(:booking).permit(:seats)
    end
end
