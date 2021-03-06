# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def autopopulated_signup
  visit(signup_path)
  fill_in "First Name", with: "Random"
  fill_in "Last Name", with: "Person"
  fill_in "Phone Number", with: '(513) 703-4852'
  fill_in "Email", with: "fakeemail@gmail.com"
  fill_in "Password", with: "password"
  fill_in "Password Confirmation", with: "password"
  attach_file("Profile Picture", Rails.root.join('spec/fixtures/images/rails.jpg'))
end

def click_submit_button
  click_button "Submit"
end

def dummy_user_signup
  autopopulated_signup
  fill_in "Street", with: "549 NW 28th St."
  fill_in "City", with: "Miami"
  fill_in "State", with: "FL"
  fill_in "Zip/Postal Code", with: "33127"
  fill_in "Country", with: "US"
  click_submit_button
end

def dummy_user
  dummy_user_signup
  User.find_by(email: "fakeemail@gmail.com")
end

def faker_dummy
  user = User.new(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    email: Faker::Internet.email, 
    phone_number: '(513) 703-4852',
    avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip_code,
    country: Faker::Address.country_code,
    credit_count: 5
  )
  # password = Faker::Internet.password
  user.password = "password"
  user.password_confirmation = "password"
  user.save
  user
end

def dummy_user_model
  user = User.new(
    first_name: "Random", 
    last_name: "Person", 
    phone_number: '(513) 703-4852',
    email: "fakeemail@gmail.com", 
    avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
    street: "549 NW 28th St.",
    city: "Miami",
    state: "FL",
    zip_code: "33127",
    country: "USA"
  )
  user.password = "password"
  user.password_confirmation = "password"
  user.save
  user
end

def other_user_model
  user = User.new(
    first_name: "Other", 
    last_name: "Person", 
    phone_number: '(513) 703-4852',
    email: "fakeemail2@gmail.com", 
    avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
    street: "2451 NW 5 Ave",
    city: "Miami",
    state: "FL",
    zip_code: "33127",
    country: "USA",
  )
  user.password = "password"
  user.password_confirmation = "password"
  user.save
  user
end

def far_away_user_model
  user = User.new(
    first_name: "Far", 
    last_name: "Person", 
    phone_number: '(513) 703-4852',
    email: "fakeemail3@gmail.com", 
    avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
    street: "6825 Bridgetown Rd.",
    city: "Cincinnati",
    state: "OH",
    zip_code: "45248",
    country: "USA",
  )
  user.password = "password"
  user.password_confirmation = "password"
  user.save
  user
end

def dummy_driver
  User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password_digest: Faker::DragonBall.character,
    avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip,
    country: Faker::Address.country
  )
end

def dummy_recycler
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg'),
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip,
    country: Faker::Address.country
  )
  password = Faker::DragonBall.character
  user.password = password
  user.password_digest = password
  user.save
  user
end