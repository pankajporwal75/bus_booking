FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email {Faker::Internet.email}
    password {"password"}
    otp {123456}
    otp_sent_at {Time.now}

    trait :user do
      role {"user"}
    end

    trait :bus_owner do
      role {"bus_owner"}
    end
  end
end
