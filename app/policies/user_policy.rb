class UserPolicy < ApplicationPolicy
  
  def is_bus_owner?
    user.bus_owner?
  end

  def is_admin?
    user.admin?
  end
end
