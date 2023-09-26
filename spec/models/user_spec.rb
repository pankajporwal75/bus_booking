require 'rails_helper'

RSpec.describe User, type: :model do
  user = FactoryBot.create(:user)
  # let(:user) {build :user}
  it "must be a valid user" do
    expect(user.valid?).to eq(true)
  end

  it "must have a name" do
    user = User.new(name: "Pankaj")
    expect(user.name).to be_present
  end

  it "must have an email" do
    user = User.new(email: "pankaj.porwal@gemsessence.com")
    expect(user.email).to be_present
  end

  it "must not have a duplicate email" do
    User.create(email: "pankaj.porwal@gemsessence.com")
    user = User.new(email: "pankaj.porwal@gemsessence.com")
    expect(user).not_to be_valid
  end

  it "must have a role" do
    user = User.create(name: "Mayur", email: "mayur@gmail.com", role: "user")
    expect(user.role).not_to be nil
  end

end
