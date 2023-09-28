require 'rails_helper'
RSpec.describe ReservationsController do
  let(:disapproved_bus) {create :bus, capacity: 30}
  let(:approved_bus) {create :bus, status: 'approved', capacity: 30}
  let(:user) {create :user}
  
  describe "GET #new" do
    context "for approved bus" do
      it "should render new" do
        sign_in(user)
        get :new, params: {bus_id: approved_bus.id}
        is_expected.to render_template('new')
        is_expected.to route(:get, '/buses/1/reservations/new').to(action: :new, bus_id: 1)
      end
    end
    context "for disapproved bus" do
      it "should not render new" do
        sign_in(user)
        get :new, params: {bus_id: disapproved_bus.id}
        is_expected.to respond_with(:redirect)
        is_expected.to redirect_to(bus_path(disapproved_bus))
      end
    end
  end
  
  describe "POST #create" do
    count = Reservation.count
    context "with valid parameters" do
      it "creates a new reservation" do
        sign_in(user)
        valid_params = attributes_for(:reservation, seats: rand(1..approved_bus.available_seats))
        post :create, params: {bus_id: approved_bus.id, reservation: valid_params}
        expect(Reservation.count).to be > count
        is_expected.to respond_with(:redirect)
        is_expected.to redirect_to(buses_path)
      end
    end
    context "with invalid parameters" do
      it "does not create a new reservation" do
        sign_in(user)
        invalid_params = attributes_for(:reservation, seats: 40)
        post :create, params: {bus_id: approved_bus.id, reservation: invalid_params}
        expect(Reservation.count).to eq(count)
        is_expected.to respond_with(:redirect)
        is_expected.to redirect_to(buses_path)
      end
    end
  end
  
  describe "DELETE #destroy" do
    let(:reservation) {create :reservation, user: user, bus: approved_bus, seats: 5}
    it "cancels a reservation" do
      sign_in(user)
      expect(Reservation.exists?(reservation.id)).to be true
      delete :destroy, params: {bus_id: reservation.bus.id, id: reservation.id}
      expect(Reservation.exists?(reservation.id)).to be false
    end
  end
end