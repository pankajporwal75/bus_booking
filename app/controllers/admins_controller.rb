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
                format.json {head :no_content}
                format.js {render :layout => false}
            end
        else
            @bus.approve
            respond_to do |format|
                format.html {redirect_to buses_path}
                format.json {head :no_content}
                format.js {render :layout => false}
            end
            # redirect_to buses_path
        end
    end

end
