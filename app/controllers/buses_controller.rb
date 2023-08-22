class BusesController < ApplicationController
    
    def index
        @buses = Bus.all
    end

    def show
        @bus = Bus.find(params[:id])
    end
end
