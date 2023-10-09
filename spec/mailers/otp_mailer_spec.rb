require 'rails_helper'

RSpec.describe OtpMailer, type: :mailer do
  let(:user) {create(:user, otp: 123456)}

  context 'when user log in' do
    it 'should send an otp verification mail' do
      email = OtpMailer.send_verification_otp(user, user.otp).deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([user.email])
    end
  end
end