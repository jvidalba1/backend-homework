FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.birthday }
    email { Faker::Internet.email }
    password { "BackendHomework!" }
  end
end
