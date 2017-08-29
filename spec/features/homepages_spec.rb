require 'rails_helper'

RSpec.feature "Homepages", type: :feature do
  before(:each) do
    dummy_user
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
