class BusOwnersController < ApplicationController

  # before_action :require_admin, only: [:index]

  def index
    @owners = User.bus_owner.all
    authorize current_user, policy_class: AdminPolicy
  end

  def new
    @bus_owner = BusOwner.new
  end

  def create
    @bus_owner = BusOwner.new(bus_owner_params)
    if @bus_owner.save
      redirect_to buses_path, notice: "Your Account has been created. Please Sign In"
    else 
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @reservations = current_user.reservations
    render "users/show"
  end

  private
  def bus_owner_params
    params.require(:bus_owner).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
