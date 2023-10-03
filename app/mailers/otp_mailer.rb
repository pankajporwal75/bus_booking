class OtpMailer < ApplicationMailer

  def send_verification_otp(user, otp)
    @user = user
    @otp = otp
    mail(to: @user.email, subject: "Login OTP for BusReservation")
  end
end
