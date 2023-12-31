require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Associations" do
    it {is_expected.to have_many(:reservations).dependent(:destroy)}
    it {is_expected.to have_one_attached(:profile_image)}
  end
  
  describe "Validations" do
    let(:user) {create(:user, role: 'user')}
    
    # Shoulda Matchers
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_uniqueness_of(:email).case_insensitive}
    
    it "should be a valid user" do
      expect(user.valid?).to eq(true)
    end
    
    it "should have a role" do
      user = User.create(name: "Mayur", email: "mayur@gmail.com", role: "user")
      expect(user.role).not_to be nil
    end
  end
  
  describe "Enum" do
    # it do
    #   should define_enum_for(:role)
    #   with_values(
    #     user: "user",
    #     bus_owner: "bus_owner",
    #     admin: "admin"
    #   ).backed_by_column_of_type(:string)
    # end
  end
end
  