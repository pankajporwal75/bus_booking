require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context "when creating a reservation" do

    let(:bus_owner) {create :bus_owner}
    let(:bus) {create :bus, bus_owner: bus_owner}
    let(:user) {create :user}
    let(:reservation) {create :reservation, user: user, bus: bus}

    describe "Associations" do
      it { is_expected.to belong_to(:bus) }
      it { is_expected.to belong_to(:user) }
    end

    describe "Validations" do
      it "must have one or more then one seat" do
        expect(reservation.seats).to be >= 1
      end

      it "is valid when number of seats is less then or equal to available seats" do
        bus = FactoryBot.create(:bus, capacity: 40)
        reservation = FactoryBot.create(:reservation, bus: bus, seats: 40)
        expect(reservation).to be_valid
      end
      
      it "is invalid when number of seats is greater available seats" do
        bus = FactoryBot.create(:bus, capacity: 40)
        reservation = FactoryBot.build(:reservation, bus: bus, seats: 50)
        expect(reservation).not_to be_valid
      end
    end
  end
end
