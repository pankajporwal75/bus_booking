FactoryBot.define do
  factory :bus do
    source {Faker::Address.city}
    destination {Faker::Address.city}
    depart_time {Time.now + 1.hour}
    capacity {rand(10..50)}
    bus_number {"MP13CB5906"}
    status {"disapproved"}
    association :bus_owner, factory: :user

    trait :approved do
      status {"approved"}
    end
  end
end
