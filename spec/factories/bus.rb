FactoryBot.define do
  factory :bus do
    source {Faker::Address.city}
    destination {Faker::Address.city}
    journey_date {Faker::Date.between(from: '2023-09-30', to: '2023-12-30')}
    depart_time {"10:30:00"}
    capacity {rand(30..50)}
    bus_number {"MP13CB5906"}
    status {"disapproved"}
    association :bus_owner, factory: :user

    trait :approved do
      status {"approved"}
    end
  end
end
