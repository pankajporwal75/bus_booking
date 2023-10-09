require 'rails_helper'
RSpec.describe AdminsController do
  let(:admin) {create(:user, role: 'admin')}
  let(:bus_owner) {create(:user, role: 'bus_owner')}
  let(:bus) {create(:bus, bus_owner: bus_owner)}
  let(:user) {create :user}

  describe "GET #index" do
    before do
      sign_in(admin)
      get :index
    end
    it {should render_template('index')}
    it 'assigns @buses, @users and @bus_owners' do
      user1 = create(:user)
      user2 = create(:user)
      bus_owner1 = create(:bus_owner)
      bus_owner2 = create(:bus_owner)
      bus1 = create(:bus, bus_owner: bus_owner1)
      bus2 = create(:bus, bus_owner: bus_owner2)
      expect(assigns(:users)).not_to be_nil
      expect(assigns(:bus_owners)).not_to be_nil
      expect(assigns(:buses)).not_to be_nil
    end
  end

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