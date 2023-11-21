require 'rails_helper'

RSpec.describe OtpMailer, type: :mailer do
  let(:bus) {create :bus}

  context 'when approving a bus' do
    it 'should send an approval email' do
      email = AdminMailer.approve_email(bus).deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([bus.bus_owner.email])
      expect(email.from).to eq(['admin@busreservation.com'])
      expect(email.subject).to eq('Bus Approved!!')
    end
  end

  context 'when disapproving a bus' do
    it 'should send a disapproval email' do
      email = AdminMailer.disapprove_email(bus).deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([bus.bus_owner.email])
      expect(email.from).to eq(['admin@busreservation.com'])
      expect(email.subject).to eq('Bus Disapproved!!')
    end
  end
end