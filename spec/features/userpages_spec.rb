require 'rails_helper'

RSpec.feature "Userpages", type: :feature do
	before(:each) do
		@email = Faker::Internet.email
		@password = Faker::Internet.password(8)
    visit(signup_path)
    fill_in "First Name", with: Faker::Name.first_name
    fill_in "Last Name", with: Faker::Name.last_name
    fill_in "Email", with: @email
    fill_in "Password", with: @password
    fill_in "Password Confirmation", with: @password
    click_button "Submit"
		@user = User.find_by(email: @email)
		@pickup_time = Faker::Date.forward(2)
		@trip = @user.trips.create(
			pickup_time: @pickup_time,
			total_space: 5
			)
	end

  it "I should be able to go to the homepage and see the link to go to my profile if logged in" do
  	expect(find_link('Profile').visible?).to be true
  end
  it "userpage should load" do
  	click_link('Profile')
  	assert_equal "/users/#{@user.id}", current_path
  end
  it "userpage should show user's trips" do
  	click_link('Profile')
  	expect(page).to have_content(@pickup_time)
  end
  it "userpage should show pending pickups" do
  	@user_two = User.create(
  		first_name: Faker::Name.first_name
  		last_name: Faker::Name.last_name
  		email: Faker::Internet.email
  		password_digest: Faker::Internet.password

  		)
  end
  it "userpage should show number of credits"
  it "userpage should allow user to logout and be redirected to homepage"
end