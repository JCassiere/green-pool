require 'rails_helper'

RSpec.feature "Homepages", type: :feature do
  before(:each) do
    dummy_user
  end

  it "I should be able to go the home page and see the start trip link" do
    expect(find_button('Schedule Trip').visible?).to be true
  end

  it "I should be able to to go to the home page and see the find trip link" do
    expect(find_button('Schedule Pickup').visible?).to be true
  end

  it "I should be able to go to the new trip page after I click the start trip button if i am logged in" do
  	click_button "Schedule Trip"
  	assert_equal "/trips/new", current_path
  end

  it "should not be able to go to the new trip page after I click the start trip button if i am not logged in" do
  	click_link "Logout"
  	visit("/")
  	click_button "Schedule Trip"
  	assert_equal login_path, current_path
  end

  it "I should be able to go to the find trip page after I click the find trip button if i am logged in" do
  	click_button "Schedule Pickup"
  	assert_equal "/trips", current_path
  end

  it "I should not be able to go to the find trip page after I click the find trip button if i am not logged in" do
  	click_link "Logout"
  	visit("/")
  	click_button "Schedule Pickup"
  	assert_equal login_path, current_path
  end

end
