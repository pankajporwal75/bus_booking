require 'rails_helper'
RSpec.describe BusesHelper do
  let(:bus_owner) {create:bus_owner}
  let(:bus) {create(:bus, capacity: 40)}
  let(:user) {create(:user)}
  
  describe 'available_seats(bus,date)' do
    it 'should return the available number of seats on specific date' do
      reservation = create(:reservation, date: Date.today, bus: bus, user: user, seat: bus.seats.first)
      seats = helper.available_seats(bus, Date.today)
      expect(seats).to eq(39)
    end
  end
end