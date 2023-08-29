class AdminsController < ApplicationController

    def approve
        @bus =Bus.find(params[:id])
        @bus.approve
        redirect_to buses_path, notice: 'Bus approved successfully.'
    end
    def disapprove
        @bus =Bus.find(params[:id])
        @bus.disapprove
        redirect_to buses_path, alert: 'Bus approval cancelled.'
    end

end
