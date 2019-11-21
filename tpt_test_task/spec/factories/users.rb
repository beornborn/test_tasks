FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name 'test name'
    password 'password'

    trait :regular do
      after(:create) { |u| u.add_role :regular }
    end

    trait :manager do
      after(:create) { |u| u.add_role :manager }
    end

    trait :admin do
      after(:create) { |u| u.add_role :admin }
    end
  end
end
