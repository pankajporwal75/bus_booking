class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.user.paginate(page: params[:page], per_page: 5)
    authorize current_user, policy_class: AdminPolicy
  end

  def show
    @reservations = current_user.reservations.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    @today_tickets = current_user.reservations.where(date: Date.today)
    authorize current_user
  end
end
