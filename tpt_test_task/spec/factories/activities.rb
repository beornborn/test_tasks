FactoryBot.define do
  factory :activity do
    description { Faker::Lorem.sentence }
    duration 100
    start { Date.today }
    user { create :user, :regular }
  end
end
