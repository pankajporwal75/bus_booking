class AdminPolicy < ApplicationPolicy
  attr_reader :user, :bus

  def index?
    user.admin?
  end
end