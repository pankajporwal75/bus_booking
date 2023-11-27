class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.user.paginate(page: params[:page], per_page: 5)
    authorize current_user, policy_class: AdminPolicy
  end

  def show
    @reservations = current_user.reservations.upcoming.paginate(page: params[:page], per_page: 5)
  end
end
