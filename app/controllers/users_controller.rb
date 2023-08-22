class UsersController < ApplicationController

    before_action :authenticate_user!

    def show
        @bookings = current_user.bookings
    end
end
