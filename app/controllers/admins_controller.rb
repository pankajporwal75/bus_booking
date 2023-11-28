class AdminsController < ApplicationController
  before_action :require_admin

  def index
    @users = User.user
    @bus_owners = BusOwner.all
    @buses = Bus.all
  end

  def change_status
    authorize current_user, :is_admin?
    @bus = Bus.find(params[:id])
    if @bus.approved?
      @bus.update(status: :disapproved)
      flash.now[:alert] = "Bus Disapproved"
      AdminMailer.disapprove_email(@bus).deliver_now
      @bus.reservations.delete_all
      respond_to do |format|
        format.html {redirect_to buses_path}
        format.js 
      end
    else
      @bus.update(status: :approved)
      flash.now[:notice] = "Bus Approved"
      AdminMailer.approve_email(@bus).deliver_now
      respond_to do |format|
        format.html {redirect_to buses_path}
        format.js
       end
    end
  end
end
