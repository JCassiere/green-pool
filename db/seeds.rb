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
  email: "fakeemail@gmail.com", 
  avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
  street: "549 NW 28th St.",
  city: "Miami",
  state: "FL",
  zip_code: "33127",
  country: "USA"
)

user_one.password = 'password'
user_one.password_confirmation = 'password'
user_one.save

user_two = User.new(
  first_name: "Random", 
  last_name: "Person2", 
  email: "fakeemail2@gmail.com", 
  avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
  street: "549 NW 28th St.",
  city: "Miami",
  state: "FL",
  zip_code: "33127",
  country: "USA"
)

user_two.password = "password"
user_two.password_confirmation = "password" 
user_two.save

trip = user_one.trips.create(
  pickup_time: Faker::Time.forward(2, :morning),
  total_space: 5
)

trip.pickups.create(
	user_id: user_two.id,
	num_bags: 2
	)