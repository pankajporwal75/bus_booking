require 'rails_helper'
RSpec.describe ApplicationHelper do
  describe 'formatted_date(date)' do
    it 'formats the date' do
      date = Date.new(2023,10,6)
      expect(helper.formatted_date(date)).to eq('06 Oct, 2023')
    end
  end

  describe 'formatted_time(time)' do
    it 'formats the time' do
      time = Time.new(2023, 10, 6, 19, 24, 0, "+00:00")
      expect(helper.formatted_time(time)).to eq('07:24 PM')
    end
  end
end