FactoryBot.define do
  factory :movie do
    association :user
    name { Faker::Movie.title }
    producer { Faker::Name.name }
    accessibility { [0,1].sample }
    released_date { Faker::Date.backward }

    trait :private do
      accessibility { 1 }
    end

    trait :public do
      accessibility { 0 }
    end
  end
end
