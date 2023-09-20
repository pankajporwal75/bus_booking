class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :record, :bus

    # def initialize(user, reservation, bus)
    #   @user = user
    #   @reservation= reservation
    #   @bus = bus
    # end
    def index?
      user.busowner? && record.first.bus.bus_owner == user
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
