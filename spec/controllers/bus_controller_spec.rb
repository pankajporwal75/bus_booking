require 'rails_helper'
RSpec.describe BusesController do
  let(:user) {create :user}
  let(:admin_user) {create :user, role: :admin}
  let(:bus_owner_user) {create :user, role: :bus_owner}
  let(:bus) {create :bus, bus_owner: bus_owner_user}

  describe "GET #index" do
    before do
      sign_in(user)
      get :index
    end
    it {should render_template('index')}
    it {should route(:get, '/').to(action: :index)}
    it {should respond_with(200)}
  end

  describe "GET #show" do
    before do
      sign_in(user)
      get :show, params: {id: bus.id}
    end
    it {should render_template('show')}
    it {should route(:get, '/buses/1').to(action: :show, id: 1)}
    it {should respond_with(200)}
  end
  
  describe "GET #new" do
    before do
      sign_in(bus_owner_user)
      get :new
    end
    it {should render_template('new')}
    it {should route(:get, '/buses/new').to(action: :new)}
    it {should respond_with(200)}
  end

  describe "POST #create" do
    count = Bus.count
    context "with valid parameters" do
      it "creates a new bus" do
        sign_in(bus_owner_user)
        valid_params = {bus: attributes_for(:bus)}
        post :create, params: valid_params
        expect(Bus.count).to be > count
        is_expected.to respond_with(:redirect)
        is_expected.to redirect_to(bus_path(Bus.last))
      end
    end
    context "with invalid parameters" do
      it "does not create a new bus" do
        sign_in(bus_owner_user)
        invalid_params = {bus: attributes_for(:bus, capacity: nil)}
        post :create, params: invalid_params
        expect(Bus.count).to eq(count)
        is_expected.to respond_with(:unprocessable_entity)
        is_expected.to render_template(:new)
      end
    end
  end
  
  describe "GET #edit" do
    before do
      sign_in(bus.bus_owner)
      get :edit, params: {id: bus.id}
    end
    it {should render_template('edit')}
    it {should route(:get, '/buses/1/edit').to(action: :edit, id: 1)}
    it {should respond_with(200)}
  end
  
  describe "GET #search" do
    before do
      sign_in(user)
      get :search, params: {search_date: '2023-12-31'}, format: :js
    end 
    it {should render_template('search')}
    it {should route(:get, '/search').to(action: :search)}
  end

  describe "DELETE #destroy" do
    let(:newbus) {create :bus, bus_owner: bus_owner_user}
    it "deletes a bus" do
      sign_in(bus_owner_user)
      expect(Bus.exists?(newbus.id)).to be true
      delete :destroy, params: {id: newbus.id}
      expect(Bus.exists?(newbus.id)).to be false
    end
  end
  
  describe "permit params" do
    before {sign_in(bus_owner_user)}
    it do
      params = {
        bus: {
          source: Faker::Address.city,
          destination: Faker::Address.city,
          journey_date: Faker::Date.between(from: '2023-09-30', to: '2023-12-30'),
          depart_time: "10:30:00",
          capacity: rand(30..50),
          bus_number: "MP13CB5906"
        }
      }
      should permit(:source, :destination, :journey_date, :depart_time, :capacity, :bus_number).
      for(:create, params: params).
        on(:bus)
      end
  end
end