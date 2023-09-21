class AdminsController < ApplicationController
  before_action :require_admin
  def change_status
    authorize current_user, :is_admin?
    @bus = Bus.find(params[:id])
    if @bus.approved?
      @bus.update(status: :disapproved)
      @bus.reservations.delete_all
      respond_to do |format|
        format.html {redirect_to buses_path}
        format.js 
      end
    else
      @bus.update(status: :approved)
      respond_to do |format|
        format.html {redirect_to buses_path}
        format.js
       end
    end
  end
end
