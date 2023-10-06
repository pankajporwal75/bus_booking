require 'rails_helper'
RSpec.describe UsersHelper do
  let(:bus_owner) {create:bus_owner}
  let(:bus) {create(:bus, journey_date: '2023-11-30')}
  describe 'bus_time(bus)' do
    it 'should format the journey date' do
      formatted_time = helper.bus_time(bus)
      expect(formatted_time).to eq('30 Nov, 2023')
    end
  end
end