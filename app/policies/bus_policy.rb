class BusPolicy < ApplicationPolicy
  attr_reader :user, :bus

    def initialize(user, bus)
      @user = user
      @bus= bus
    end
    def index?
      user.bus_owner? || user.admin? || user.user?
    end

    def show?
      (user.user?) || (user.bus_owner? && bus.bus_owner.id == user.id)
    end

    def new?
      user.bus_owner?
    end

    def search?
      record > Time.now
    end

    def create?
      user.bus_owner?
    end

    def edit?
      bus.bus_owner.id == user.id
    end

    def update?
      user.bus_owner?
    end

    def destroy?
      user.bus_owner?
    end
end
