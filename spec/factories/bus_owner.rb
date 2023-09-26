FactoryBot.define do
  factory :bus_owner do
    name { Faker::Name.name }
    role { "bus_owner" }
    email {Faker::Internet.email}
    password {"password"}
  end
end
