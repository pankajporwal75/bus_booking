FactoryBot.define do
  factory :reservation do
    date {Date.today}
    association :seat, factory: :seat
    association :bus, factory: :bus
    association :user, factory: :user
  end
end
