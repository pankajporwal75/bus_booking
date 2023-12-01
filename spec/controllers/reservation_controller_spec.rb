require 'rails_helper'
RSpec.describe ReservationsController do
  let(:disapproved_bus) {create(:bus, capacity: 30)}
  let(:approved_bus) {create(:bus, :approved, capacity: 30)}
  let(:user) {create(:user, :user)}

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
      it "should create a new reservation" do
        sign_in(user)
        # binding.pry
        # valid_params = attributes_for(:reservation, user_id: user.id, bus_id: approved_bus.id, seat_id: approved_bus.seats.first.id, date: Date.tomorrow)
        post :create, params: {bus_id: approved_bus.id, reservation: {seat_id: [approved_bus.seats.first.id], date: Date.tomorrow}}
        expect(Reservation.count > 0).to be_truthy
        is_expected.to respond_with(:redirect)
        is_expected.to redirect_to(user_path(user))
      end
    end
    context "with invalid parameters" do
      it "should not create a new reservation" do
        sign_in(user)
        invalid_params = attributes_for(:reservation, seats: 40)
        post :create, params: {bus_id: approved_bus.id, reservation: invalid_params}
        expect(Reservation.count).to eq(count)
        # is_expected.to respond_with(:redirect)
        is_expected.to redirect_to(new_bus_reservation_path(approved_bus))
      end
    end
  end
  
  describe "DELETE #destroy" do
    let(:reservation) {create :reservation, user: user, bus: approved_bus, date: Date.today, seat: approved_bus.seats.first}
    it "should cancel a reservation" do
      sign_in(user)
      expect(Reservation.exists?(reservation.id)).to be true
      delete :destroy, params: {bus_id: reservation.bus.id, id: reservation.id}
      expect(Reservation.exists?(reservation.id)).to be false
    end
  end
end