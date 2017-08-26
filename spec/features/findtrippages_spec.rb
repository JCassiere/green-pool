require 'rails_helper'

RSpec.feature "Findtrippages", type: :feature do
  describe "a signed in user adds recycling to a trip" do
    it "I should be able to go to the homepage and find the find trip link"
    it "after a trip is created by a different user a trip should be be on the find trip page"
    it "after a trip is created by a different user it's driver/start location/space availbale/ date should be displayed"
    it "after a trip is created by a different user a user should be able to decrement the space available by adding bags using a form"
    it "I should be able to find an add to trip button"
    it "I should be redirected to the find trip page after clicking the add to trip button"
    it "after clicking the add to trip button a new pickup should appear on the driver page"
    it "after a new pickup is created the space available on the find trip page should go down if there is still space available"
    it "after a new pickup is create the trip should disappear if the space available has been reached"
  end

  describe "a driver's trip page after a user adds a pickup" do
    it "should have a new pickup on the user page"
    it "should have a pickup with a recycler name/address/number of bags"
    it "should have a pickup with the ability to accept or deny it"
    it "should remove the pickup from the trip, the driver page, the recycler page if denied"
    it "should change the accept and deny links to done link when accepted"
    it "should now have an updated space available attribute for the trip if the pickup is accepted"
    it "should show confirmation modal when clicking done link"
    it "should find complete pickup button when confirmation modal appears"
    it "after confirmation link clicked modal should have a complete pickup button"  
  end
end
