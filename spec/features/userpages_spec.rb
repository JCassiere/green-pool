require 'rails_helper'

RSpec.feature "Userpages", type: :feature do
  before :all do
    @user = User.create!(name: Faker::Name.name, email: Faker::Internet.email, address: "#{Faker::Address.street_address} #{Faker::Address.city},#{Faker::Address.state_abbr} #{Faker::Address.zip}", credit_count: 3, password_digest: Faker::DragonBall.character)
  end

  it "I should be able to go to the homepage and see the link to go to my profile" do
    visit '/'
    expect(page).to have_content('Profile')
    find_link('Profile').click
  end

  context 'a users profile' do
    before :each do
      visit "users/#{@user.id}"
    end

    it "userpage should load if logged in" do
      expect(page).to have_content("Hello, #{@user.name}!" )
    end

    it "userpage should show user's trip" do
      @user.trips.create(pickup_time: Faker::Date.forward(1), total_space: 3)
      # Trip.create(pickup_time: Faker::Date.forward(1), total_space: 3, user_id: @user.id)
      # Trip.create(pickup_time: Faker::Date.forward(1), total_space: 3, user_id: @user.id)
      # Trip.create(pickup_time: Faker::Date.forward(1), total_space: 3, user_id: @user.id)
      visit "/users/#{@user.id}"
      expect(page).to have_content("Trip: #{@user.trips[0].id}")
      #expect(page).to have_content("Trip")
    end

    it "driver page should show pending pickups" do
      @user.trips.create(pickup_time: Faker::Date.forward(1), total_space: 3)
      recycler = User.create!(name: Faker::Name.name, email: Faker::Internet.email, address: "#{Faker::Address.street_address} #{Faker::Address.city},#{Faker::Address.state_abbr} #{Faker::Address.zip}", credit_count: 3, password_digest: Faker::DragonBall.character)
      @user.trips.last.pickups.create(num_bags: 3, status: 0, user: recycler)
      visit user_path(@user)
      expect(page).to have_content("Pick ups pending: #{@user.driver_pickups.last.id}")
    end

    it "recycler page should show pending pickups" do
      @user.trips.create(pickup_time: Faker::Date.forward(1), total_space: 3)
      recycler = User.create!(name: Faker::Name.name, email: Faker::Internet.email, address: "#{Faker::Address.street_address} #{Faker::Address.city},#{Faker::Address.state_abbr} #{Faker::Address.zip}", credit_count: 3, password_digest: Faker::DragonBall.character)
      @user.trips.last.pickups.create(num_bags: 3, status: 0, user: recycler)
      visit user_path(recycler)
      expect(page).to have_content("Pick ups pending: #{recycler.recycling_pickups.last.id}")
    end


    it "userpage should show number of credits" do
      visit user_path(@user)
      expect(page).to have_content("Credit count: #{@user.credit_count}")
    end

    it "userpage should allow user to logout and be redirected to homepage"

  end
end
