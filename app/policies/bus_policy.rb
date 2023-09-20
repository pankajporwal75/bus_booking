class BusPolicy < ApplicationPolicy
  attr_reader :user, :bus

    def initialize(user, bus)
      @user = user
      @bus= bus
    end
    def index?
      user.busowner? || user.admin?
    end

    def show?
      user.user? || user.busowner? && bus.bus_owner == user
    end

    def new?
      user.busowner?
    end

    def create?
      user.busowner?
    end

    def edit?
      user.busowner?
    end

    def update?
      user.busowner?
    end

    def destroy?
      user.busowner?
    end
end
