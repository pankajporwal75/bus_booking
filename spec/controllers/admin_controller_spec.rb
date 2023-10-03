require 'rails_helper'
RSpec.describe AdminsController do
  let(:admin) {create(:user, role: 'admin')}
  let(:bus_owner) {create(:user, role: 'bus_owner')}
  let(:bus) {create(:bus, bus_owner: bus_owner)}
  let(:user) {create :user}
  describe "PATCH #change_status" do
    context "when admin user" do
      it 'should change the status of bus' do
        sign_in(admin)
        expect(bus.status).to eq('disapproved')
        patch :change_status, params: {bus_owner: bus_owner.id, id: bus.id}, format: :js
        bus.reload
        expect(bus.status).to eq('approved')
      end

      it 'should delete reservations if bus is disapproved' do
        approved_bus = create(:bus, bus_owner: bus_owner, status: 'approved')
        create_list(:reservation, 3, bus: approved_bus, user: user)
        sign_in(admin)
        patch :change_status, params: {bus_owner: bus_owner.id, id: approved_bus.id}, format: :js
        expect(approved_bus.reservations.count).to eq(0)
      end
    end
    
    context "when non-admin user" do
      it 'should not change the status of bus' do
        sign_in(user)
        patch :change_status, params: {bus_owner: bus_owner.id, id: bus.id}, format: :js
        expect(bus.status).to eq('disapproved')
      end
    end
  end
end