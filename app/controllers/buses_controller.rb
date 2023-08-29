class BusesController < ApplicationController

    before_action :authenticate_user!, only: [:show, :index]
    # before_action :require_bus_owner, only: [:new, :create, :destroy]
    
    def index
        if current_user.user?
            @buses = Bus.upcoming.where(approved: true)
        else
            @buses = Bus.upcoming.order(journey_date: :asc)
        end
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

    def edit
        @bus = Bus.find_by(params[:id])
        authorize @bus
    end

    def update
        @bus = Bus.find_by(params[:id])
        authorize @bus
        if @bus.update(bus_params)
            redirect_to @bus, notice: "Bus Updated"
        else
            render "edit", status: :unprocessable_entity
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
