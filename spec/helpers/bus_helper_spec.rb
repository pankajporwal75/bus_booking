require 'rails_helper'
RSpec.describe BusesHelper do
  let(:bus_owner) {create:bus_owner}
  let(:bus) {create(:bus, capacity: 40)}
  let(:user) {create(:user)}
  
  describe 'available_seats(bus)' do
    it 'should return the available number of seats' do
      reservation = create(:reservation, seats: 5, bus: bus, user: user)
      seats = helper.available_seats(bus)
      expect(seats).to eq(35)
    end
  end
end