class AdminPolicy < ApplicationPolicy
    attr_reader :user, :bus

    def update?
        user.admin?
    end
end