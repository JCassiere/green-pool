require 'rails_helper'

RSpec.feature "Newtrippages", type: :feature do
  before(:each) do
    @user = dummy_user
    click_link("Schedule Trip")
  end

  describe "clicking new trip link" do
    it "should show user's name" do
      expect(page).to have_content(@user.full_name)
    end
    it "should show space available form" do
      expect(page).to have_css('input[name="trip[total_space]"]')
    end
    it "should show date form" do
      expect(page).to have_css('input[name="trip[pickup_time]"]')
    end
    it "should have a create trip button" do
      expect(find_button('Create Trip').visible?).to be true
    end
  end

  describe "when a trip is created" do
    it "should have a start address"
    it "should have the remaing space available"
    it "should have a trip driver"
    it "should have a trip date"
    it "the user should now have a new trip on their user page"
  end

  describe "when visiting the driver trip page" do
    it "should display the driver's name"
    it "should display the trip's date"
    it "should show the space remaing for the trip"
    it "should have no pickups associated with it"
  end
end
