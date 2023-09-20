class UserPolicy < ApplicationPolicy

  def create?
    user.user? || user.bus_owner?
  end
  
  def is_bus_owner?
    user.bus_owner?
  end

  def is_admin?
    user.admin?
  end

  def all_users?
    user.user? || user.bus_owner? || user.admin?
  end
end

# nutan.rawat@indoreinstitute.com