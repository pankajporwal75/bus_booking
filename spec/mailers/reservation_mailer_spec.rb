require 'rails_helper'

RSpec.describe ReservationMailer, type: :mailer do
  let(:user) {create :user}
  let(:bus) {create :bus}
  let(:reservation) {create(:reservation, user: user, bus: bus)}

  context 'when creating a reservation' do
    it 'should send a create reservation email' do
      email = ReservationMailer.create_reservation_email(reservation).deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([user.email])
    end
  end

  context 'when destroying a reservation' do
    it 'should send a cancel reservatoin email' do
      reservation.destroy
      email = ReservationMailer.cancel_reservation_email(reservation).deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([user.email])
    end
  end
end