user1 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "TestingUser1!",
  birthday: Faker::Date.birthday,
  email: 'testing_user1@sample.com'
)

user2 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "TestingUser2!",
  birthday: Faker::Date.birthday,
  email: 'testing_user2@sample.com'
)

# Public movies

3.times do
  Movie.create!(
    name: Faker::Movie.title,
    user: user1,
    producer: Faker::Name.name,
    accessibility: 1,
    released_date: Faker::Date.backward
  )
end

3.times do
  Movie.create!(
    name: Faker::Movie.title,
    user: user2,
    producer: Faker::Name.name,
    accessibility: 1,
    released_date: Faker::Date.backward
  )
end

# Private movies

3.times do
  Movie.create!(
    name: Faker::Movie.title,
    user: user1,
    producer: Faker::Name.name,
    accessibility: 0,
    released_date: Faker::Date.backward
  )
end

3.times do
  Movie.create!(
    name: Faker::Movie.title,
    user: user2,
    producer: Faker::Name.name,
    accessibility: 0,
    released_date: Faker::Date.backward
  )
end

# MUST ToDos:
# - Pagination
# - Missing tests
# - Readme
# - Serialization responses

# NICE TO HAVE ToDos:
# - Heroku deployment
# - Documentation (apps?)
# - Endpoint that requires server to retrieve a random number from a public API and send it back to the user
