class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image])
  end

  private

    def user_not_authorized
      render file: "#{Rails.root}/public/403.html", layout: false, status: :forbidden
    end

    def current_user_admin?
      user_signed_in? && current_user.admin?
    end

    def current_user_bus_owner?
      user_signed_in? && current_user.bus_owner?
    end

    def require_bus_owner
      unless current_user_bus_owner?
        redirect_to root_url, alert: "Unauthorized Access"
      end
    end

    def require_admin
      unless current_user_admin?
        redirect_to root_url, alert: "Unauthorized Access"
      end
    end
end