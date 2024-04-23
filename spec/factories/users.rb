FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    birthday { "2024-04-23" }
    email { "MyString" }
    password_digest { "MyString" }
  end
end
