FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    role { "user" }
    email {Faker::Internet.email}
    password {"password"}
  end
end
