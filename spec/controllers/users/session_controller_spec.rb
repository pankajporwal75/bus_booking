require 'rails_helper'
RSpec.describe Users::SessionsController do
  include Devise::Test::ControllerHelpers

  describe 'PATCH #otp_verification' do
    context 'when user present and password is valid' do
      it 'should send an email with otp' do
        user = create(:user, email: 'pankaj.porwal@gemsessence.com', password: 'password')
        @request.env["devise.mapping"] = Devise.mappings[:user]
        patch :otp_verification, params: {user: {email: 'pankaj.porwal@gemsessence.com', password: 'password'}}
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        is_expected.to render_template('otp_verification')
      end
    end
    
    context 'when user is invalid' do
      it 'should render template new' do
        user = create(:user, email: 'pankaj.porwal@gemsessence.com', password: 'password')
        @request.env["devise.mapping"] = Devise.mappings[:user]
        patch :otp_verification, params: {user: {email: 'pankaj.porwal@gemsessence.com', password: 'wrong password'}}
        is_expected.to render_template('new')
      end
    end
  end
  
  describe 'POST#create' do
    context 'when otp is correct' do
      it 'should sign in user' do
        user = create(:user, email: 'pankaj.porwal@gemsessence.com', password: 'password', otp: 123456, otp_sent_at: Time.now)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, params: {email: 'pankaj.porwal@gemsessence.com', otp: 123456}
        expect(sign_in(user))
        expect(response).to redirect_to(buses_path)
        expect(controller.current_user).to eq(user)
      end
    end
    
    context 'when otp is not valid' do
      it 'should not sign in, re render otp verification' do
        user = create(:user, email: 'pankaj.porwal@gemsessence.com', password: 'password', otp: 12345, otp_sent_at: Time.now)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, params: {email: 'pankaj.porwal@gemsessence.com', otp: 654321}
        expect(response).to render_template(:otp_verification)
        expect(controller.current_user).to be_nil
      end
    end
  end
  
  describe 'PATCH #resend_otp' do
    let(:user) {create(:user, email: 'pankaj.porwal@gemsessence.com')}
    it 'should generate a new otp' do
      old_otp = user.otp
      old_time = user.otp_sent_at
      @request.env["devise.mapping"] = Devise.mappings[:user]
      patch :resend_otp, params: {email: user.email}
      user.reload
      expect(user.otp).to_not eq(old_otp)
      expect(user.otp_sent_at).to_not eq(old_time)
      expect(response).to render_template(:otp_verification)
    end
    
    it 'should send mail after generating new otp' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      patch :resend_otp, params: {email: user.email}
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end