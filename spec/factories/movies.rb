FactoryBot.define do
  factory :movie do
    user { nil }
    name { "MyString" }
    producer { "MyString" }
    accessibility { 1 }
    released_date { "2024-04-23" }
  end
end
