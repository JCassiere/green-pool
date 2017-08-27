require 'rails_helper'

RSpec.feature "Homepages", type: :feature do
  before(:each) do
    visit(signup_path)
    fill_in "First Name", with: "Random"
    fill_in "Last Name", with: "Person"
    fill_in "Email", with: "fakeemail@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    attach_file("Profile Picture", Rails.root.join('spec/fixtures/images/rails.jpg'))
    click_button "Submit"
  end

  it "I should be able to go the home page and see the start trip link" do
    expect(find_link('Schedule Trip').visible?).to be true
  end

  it "I should be able to to go to the home page and see the find trip link" do
    expect(find_link('Have Your Recycling Picked Up').visible?).to be true
  end

  it "I should be able to go to the new trip page after I click the start trip button if i am logged in" do
  	click_link "Schedule Trip"
  	assert_equal "/trips/new", current_path
  end

  it "I should not be able to go to the new trip page after I click the start trip button if i am not logged in" do
  	click_link "Logout"
  	visit("/")
  	click_link "Schedule Trip"
  	assert_equal login_path, current_path
  end

  it "I should be able to go to the find trip page after I click the find trip button if i am logged in" do
  	click_link "Have Your Recycling Picked Up"
  	assert_equal "/trips", current_path
  end

  it "I should not be able to go to the find trip page after I click the find trip button if i am not logged in" do
  	click_link "Logout"
  	visit("/")
  	click_link "Have Your Recycling Picked Up"
  	assert_equal login_path, current_path
  end

end
