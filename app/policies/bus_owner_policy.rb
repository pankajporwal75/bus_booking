class BusOwnerPolicy < ApplicationPolicy
  def new?
    user.bus_owner?
  end
end
