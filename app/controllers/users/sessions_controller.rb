# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def otp_verification
    # fail
    @user = User.find_by(email: params[:user][:email])
    @email = @user.email
    if @user.present? && @user.valid_password?(params[:user][:password])
      @user.send_otp_email
      flash[:notice] = "Please check for the OTP sent to your email address."
    else
      render :new
      flash[:alert] = "Invalid Email/Password"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.valid_otp?(params[:otp])
      sign_in(user)
      redirect_to buses_path, notice: "You have now logged in"
    else
      flash.now[:alert] = "Invalid OTP, Please make sure you enter correct OTP"
      render :otp_verification, status: :unprocessable_entity
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
