class BusOwnersController < ApplicationController

    def new
        @bus_owner = BusOwner.new
    end

    def create
        @bus_owner = BusOwner.new(busowner_params)
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
    def busowner_params
        params.require(:bus_owner).permit(:name, :email, :password, :password_confirmation)
    end
end
