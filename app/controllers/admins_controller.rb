class AdminsController < ApplicationController

    # def approve
    #     @bus =Bus.find(params[:id])
    #     @bus.approve
    #     redirect_to buses_path, notice: 'Bus approved successfully.'
    # end
    # def disapprove
    #     @bus =Bus.find(params[:id])
    #     @bus.disapprove
    #     redirect_to buses_path, alert: 'Bus approval cancelled.'
    # 
    def change_status
        @bus = Bus.find(params[:id])
        if @bus.approved?
            @bus.disapprove
            respond_to do |format|
                format.html {redirect_to buses_path}
                format.js 
            end
        else
            @bus.approve
            message = "Approved"
            respond_to do |format|
                format.html {redirect_to buses_path}
                format.js
            end
        end

    end

end
