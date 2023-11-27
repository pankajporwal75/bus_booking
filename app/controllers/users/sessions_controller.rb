# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def otp_verification
    @user = User.find_by(email: params[:email])
    @email = params[:email]
    if @user.present? && @user.valid_password?(params[:password])
      @user.send_otp_email
      flash[:notice] = "Please check for the OTP sent to your email address."
    else
      redirect_to new_user_session_path
      flash[:alert] = "Invalid Email/Password"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    @email = params[:email]
    if user && user.valid_otp?(params[:otp])
      sign_in(user)
      redirect_to after_sign_in_path_for(user)
    else
      flash.now[:alert] = "Invalid OTP, Please make sure you enter correct OTP"
      render :otp_verification, locals: {email: @email}, status: :unprocessable_entity
    end
  end

  def resend_otp
    @user = User.find_by(email: params[:email])
    @user.send_otp_email
    render :otp_verification, locals: { email: @user.email, notice: "A new OTP is sent to your registered email." }
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      flash[:notice] = "Welcome Admin"
      admin_dashboard_path
    else
      flash[:notice] = "Welcome #{resource.name}!"
      buses_path
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
