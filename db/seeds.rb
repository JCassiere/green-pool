# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_one = User.new(
  first_name: "Random",
  last_name: "Person",
  phone_number: '(513) 703-4852',
  email: "fakeemail@gmail.com",
  avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
  street: "549 NW 28th St.",
  city: "Miami",
  state: "FL",
  zip_code: "33127",
  country: "USA",
  credit_count: 3
)

user_one.password = 'password'
user_one.password_confirmation = 'password'
user_one.save

user_two = User.new(
  first_name: "Random",
  last_name: "Person2",
  phone_number: '(513) 703-4852',
  email: "fakeemail2@gmail.com",
  avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
  street: "549 NW 28th St.",
  city: "Miami",
  state: "FL",
  zip_code: "33127",
  country: "USA",
  credit_count: 3
)

user_three = User.new(
  first_name: "Another", 
  last_name: "Person", 
  phone_number: '(513) 703-4852',
  email: "fakeemail3@gmail.com", 
  avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
  street: "2451 NW 5 Ave",
  city: "Miami",
  state: "FL",
  zip_code: "33127",
  country: "USA",
  credit_count: 3
)

user_four = User.new(
  first_name: "Other", 
  last_name: "Person", 
  phone_number: '(513) 703-4852',
  email: "fakeemail4@gmail.com", 
  avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
  street: "1251 SW 21 Ter",
  city: "Miami",
  state: "FL",
  zip_code: "33145",
  country: "USA",
  credit_count: 3
)

user_two.password = "password"
user_two.password_confirmation = "password"
user_two.save

user_three.password = "password"
user_three.password_confirmation = "password"
user_three.save

user_four.password = "password"
user_four.password_confirmation = "password"
user_four.save

trip = user_one.trips.create(
  pickup_time: Faker::Time.forward(2, :morning),
  total_space: 5
)

trip.pickups.create(
	user_id: user_two.id,
	num_bags: 2
	)

trip_two = user_one.trips.create(
  pickup_time: Time.now + 31.minutes,
  total_space: 5
)

trip_two.pickups.create(
  user_id: user_two.id,
  num_bags: 2
)

user_three.trips.create(
  pickup_time: Faker::Time.forward(2, :morning),
  total_space: 5
)

user_four.trips.create(
  pickup_time: Faker::Time.forward(2, :morning),
  total_space: 5
)