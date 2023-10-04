class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @reservations = current_user.reservations.paginate(page: params[:page], per_page: 5)
  end
end
