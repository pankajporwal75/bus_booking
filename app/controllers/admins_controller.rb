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
            message = "Bus Disapproved"
            # render json: "Bus disapproved"
            respond_to do |format|
                format.html {redirect_to buses_path}
                # format.json {message: "Bus Diapproved"}
                format.js {render json: {message: message}}
            end
        else
            @bus.approve
            message = "Approved"
            # render json: "Bus aprooved"
            respond_to do |format|
                format.html {redirect_to buses_path}
                # format.json {message: "Bus Approved"}
                format.js {render json: {message: message}}
            end
        end
    end

end
