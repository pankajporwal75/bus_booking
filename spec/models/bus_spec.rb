require 'rails_helper'

RSpec.describe Bus, type: :model do
  context "when creating a bus" do 
    
    let(:bus_owner) {build :bus_owner}
    let(:bus) {build :bus, bus_owner: bus_owner}

    describe "Associations" do
      it { is_expected.to belong_to(:bus_owner).with_foreign_key("bus_owner_id") }
      it { is_expected.to have_many(:reservations).dependent(:destroy) }
    end

    describe "Validations" do
      it "must be a valid bus" do
        expect(bus.valid?).to eq(true)
      end

      it "must have a source" do
        expect(bus.source).to be_present
      end

      it "must have a destination" do
        expect(bus.destination).to be_present
      end

      it "must have a registration number" do
        expect(bus.bus_number).to be_present
      end

      it "must have a bus owner" do
        expect(bus.bus_owner).to be_present
      end

      it "must have total seats count" do
        expect(bus.capacity).to be >=1
      end
    end

    describe "Scopes" do
      it "must return the approved buses" do
        bus = FactoryBot.create(:bus, :approved)
        expect(Bus.approved).to include(bus)
      end

      it "must return the upcoming buses" do
        bus = FactoryBot.create(:bus, journey_date: Time.now + 1.day)
        expect(Bus.upcoming).to include(bus)
      end

      it "must return the bus on specific date" do
        bus1 = FactoryBot.create(:bus, journey_date: Date.today)
        bus2 = FactoryBot.create(:bus, journey_date: Date.tomorrow)
        bus3 = FactoryBot.create(:bus, journey_date: Date.today + 5.days)
        expect(Bus.on_date(Date.today)).to include(bus1)
        expect(Bus.on_date(Date.today)).not_to include(bus2, bus3)
      end
    end

    describe "Methods" do
      it "must return the number of seats available" do
        bus = FactoryBot.create(:bus, capacity: 30)
        reservation1 = FactoryBot.create(:reservation, bus: bus, seats: 10)
        reservation2 = FactoryBot.create(:reservation, bus: bus, seats: 10)
        remaining_seats = bus.available_seats
        expect(remaining_seats).to eq(10)
      end
    end
  end
end
