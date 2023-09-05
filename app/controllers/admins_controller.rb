class AdminsController < ApplicationController
    before_action :require_admin
    def change_status
        @bus = Bus.find(params[:id])
        authorize @bus, :index?
        if @bus.approved?
            @bus.disapprove
            respond_to do |format|
                format.html {redirect_to buses_path}
                format.js 
            end
        else
            @bus.approve
            respond_to do |format|
                format.html {redirect_to buses_path}
                format.js
            end
        end

    end

end
