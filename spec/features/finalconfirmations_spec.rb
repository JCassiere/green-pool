require 'rails_helper'

RSpec.feature "Finalconfirmations", type: :feature do
  describe "confirming a finished transaction on a recyclers page" do
    it "should find a complete link on the pickup after a driver accepts the pickup " do
      driver = dummy_user
      recycler = faker_dummy
      trip = driver.trips.create(pickup_time: Faker::Time.forward(2, :morning), total_space: 5)
      trip.pickups.create(num_bags: 3,status: 0, user_id: recycler.id)
      visit trip_path(trip)
      click_button("Accept")
      expect(find_link("Complete").visible?).to be true
    end
    it "when clicking the complete button a confirmation modal appears"
    it "should find a done button on a confirmation modal when it appears after clicking confirm"
    it "after clicking the done button on the confirmation modal the pickup should disappear from recycler page"
    it "after clicking the done button the recyclers credits should be decremented by the number of bags"
    it "after clicking the done button the drivers credits should be incremented by the number of bags"
  end
end
