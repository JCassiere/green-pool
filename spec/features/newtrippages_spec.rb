require 'rails_helper'

RSpec.feature "Newtrippages", type: :feature do
  describe "to create a new trip" do
    it "I should be able to go to the homepage and find the new trip link"
    it "should redirect me to the new trip page after clicking the new trip link"
    it "I should be able to go to the new trip page and find a create trip button"
    it "after clicking new trip link should show user's name/space available form/date form"
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
