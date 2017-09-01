require 'rails_helper'

RSpec.feature "Userpages", type: :feature do
  before(:each) do
    @user = dummy_user_model
    visit(login_path)
    fill_in "Email", with: "fakeemail@gmail.com"
    fill_in "Password", with: "password"
    click_button "Log In"
  end

  it "I should be able to go to the homepage and see the link to go to my profile if logged in" do
    expect(page).to have_content(@user.first_name)
    click_link(@user.first_name)
  end

  context 'a users profile' do
    before(:each) do
      visit users_show_path
    end

    it "userpage should load if logged in" do
      expect(page).to have_content("Hello, #{@user.first_name}!")
    end

    it "userpage should show user's trip" do
      @user.trips.create(
        pickup_time: Faker::Date.forward(1),
        total_space: 3
        )
      visit users_show_path
      expect(page).to have_content("View Trip")
    end



    it "user page should show pending pickups" do
      driver = faker_dummy
      trip = driver.trips.create(pickup_time: Faker::Date.forward(1), total_space: 3)
      trip.pickups.create(num_bags: 3, user: @user)
      visit users_show_path
      expect(page).to have_content(driver.full_name)
      expect(page).to have_content("Number of Bags: 3")
    end


    it "userpage should show number of credits" do
      visit users_show_path(@user)
      expect(page).to have_content("Credit count: #{@user.credit_count}")
    end

    it "userpage should allow user to logout and be redirected to login page after signing up and logging in" do
      visit(login_path)
      fill_in "Email", with: "fakeemail@gmail.com"
      fill_in "Password", with: "password"
      click_button "Log In"
      expect(page).to have_content('Logout')
      find_link('Logout').click
      expect(page).to have_content('You have successfully logged out.')
    end

  end
end
