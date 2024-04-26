FactoryBot.define do
  factory :movie do
    name { Faker::Movie.title }
    producer { Faker::Name.name }
    accessibility { [0,1].sample }
    released_date { Faker::Date.backward }

    association :user

    trait :for_self do
      accessibility { 0 }
    end

    trait :for_all do
      accessibility { 1 }
    end
  end
end
