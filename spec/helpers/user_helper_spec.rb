require 'rails_helper'
RSpec.describe UsersHelper do
  let(:bus_owner) {create:bus_owner}
  let(:bus) {create(:bus, depart_time: "2023-12-01 17:22:23.912301466 +0530")}
  describe 'bus_time(bus)' do
    it 'should format the departure time' do
      formatted_time = helper.bus_time(bus)
      expect(formatted_time).to eq('17:22:23')
    end
  end
end