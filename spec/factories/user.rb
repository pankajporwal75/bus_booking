FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    role { :user }
    email {Faker::Internet.email}
    password {"password"}
    otp {123456}
    otp_sent_at {Time.now}
  end
end
