class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :reservation, :bus

    def initialize(user, reservation)
      @user = user
      @reservation= reservation
      @bus = bus
    end
    def index?
      user.busowner?
    end

    def new?
      user.busowner? || user.user?
    end

    def create?
      user.busowner? || user.user?
    end

    def edit?
      user.user?
    end

    def update?
      user.user?
    end
end
