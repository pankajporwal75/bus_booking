class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :record

    def index?
      user.bus_owner? && bus.bus_owner.id == user.id
    end

    def new?
      (user.bus_owner? || user.user?)
    end

    def create?
      user.bus_owner? || user.user?
    end

    def edit?
      user.user?
    end

    def update?
      user.user?
    end
end
