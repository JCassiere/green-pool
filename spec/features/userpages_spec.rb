require 'rails_helper'

RSpec.feature "Userpages", type: :feature do
  before :all do
    @user = dummy_user
  end

  it "I should be able to go to the homepage and see the link to go to my profile if logged in" do
    visit(login_path)
    fill_in "Email", with: "fakeemail@gmail.com"
    fill_in "Password", with: "password"
    click_button "Login2"
    expect(page).to have_content(dummy_user.first_name)
    find_link(dummy_user.first_name).click
  end

  context 'a users profile' do
    before :each do
      visit "users/#{@user.id}"
    end

    it "userpage should load if logged in" do
      expect(page).to have_content("Hello, #{@user.first_name}!")
    end

    it "userpage should show user's trip" do
      @user.trips.create(pickup_time: Faker::Date.forward(1), total_space: 3)
      visit "/users/#{dummy_user.id}"
      expect(page).to have_content("View Trip")
    end

    it "driver page should show pending pickups" do
      @user.trips.create(pickup_time: Faker::Date.forward(1), total_space: 3)
      recycler = dummy_recycler
      @user.trips.last.pickups.create(num_bags: 3, status: 0, user: recycler)
      visit users_show_path(@user)
      expect(page).to have_content("Driver Pick ups pending: #{@user.driver_pickups.last.id}")
    end

    it "recycler page should show pending pickups" do
      @user.trips.create(pickup_time: Faker::Date.forward(1), total_space: 3)
      recycler = dummy_recycler
      @user.trips.last.pickups.create(num_bags: 3, status: 0, user: recycler)
      visit users_show_path(recycler)
      expect(page).to have_content("Recycling Pick ups pending: #{recycler.recycling_pickups.last.id}")
    end


    it "userpage should show number of credits" do
      visit users_show_path(@user)
      expect(page).to have_content("Credit count: #{@user.credit_count}")
    end

    it "userpage should allow user to logout and be redirected to login page after signing up and logging in" do
      visit(login_path)
      fill_in "Email", with: "fakeemail@gmail.com"
      fill_in "Password", with: "password"
      click_button "Login2"
      expect(page).to have_content('Logout')
      find_link('Logout').click
      save_and_open_page
      expect(page).to have_content('You have successfully logged out.')
    end

  end
end
