FactoryBot.define do
  factory :reservation do
    seats {2}
    association :bus, factory: :bus
    association :user, factory: :user
  end
end
