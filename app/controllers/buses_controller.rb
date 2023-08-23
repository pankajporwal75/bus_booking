class BusesController < ApplicationController
    
    def index
        @buses = Bus.all
    end

    def show
        @bus = Bus.find(params[:id])
    end

    def new
        @owner = current_user
        @bus = @owner.buses.new
    end

    def create
        @owner = current_user
        @bus = @owner.buses.new(bus_params)
        if @bus.save
            redirect_to bus_path(@bus), notice: "Bus Added Successfully"
        else
            render "new", status: :unprocessable_entity
        end
    end

    def destroy
        @owner = current_user
        @bus = @owner.buses.find(params[:id])
        @bus.destroy
        redirect_to buses_path, notice: "Trip Cancelled Successfully"
    end

    private
    def bus_params
        params.require(:bus).permit(:source, :destination, :depart_time, :bus_number, :journey_date, :capacity)
    end
end
