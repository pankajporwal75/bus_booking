class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image])
  end

  private

    def current_user_admin?
      user_signed_in? && current_user.admin?
    end

    def current_user_bus_owner?
      user_signed_in? && current_user.busowner?
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