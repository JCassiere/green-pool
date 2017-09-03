require 'rails_helper'

RSpec.feature "Finalconfirmations", type: :feature do
  before(:each) do
    @driver = dummy_user
    @recycler = faker_dummy
    @trip = @driver.trips.create(pickup_time: Faker::Time.forward(2, :morning), total_space: 5)
    @pickup = @trip.pickups.create(num_bags: 3,status: 0, user_id: @recycler.id)
    visit trip_path(@trip)
    click_button("Accept")
  end

  describe "confirming a finished transaction on a recyclers page" do
    it "should find a complete link on the pickup after a driver accepts the pickup " do
      expect(find_button("Complete").visible?).to be true
    end

    it "when clicking the complete button a confirmation modal appears" do
      click_button("Complete")
      expect(page).to have_content("All done? Your community thanks you, but more importantly, the Earth does!")
    end

    it "should find a done button on a confirmation modal when it appears after clicking confirm"do
      click_button("Complete")
      expect(find_button("Done").visible?).to be true
    end
    it "after the driver clicks the done button on the confirmation modal the pickup should change to pending" do
      click_button("Complete")
      # click_button("Done")
      expect(find_button("Done").visible?).to be true
      click_button("Done")
      expect(page).to have_content("Pending")
    end

    it "when the driver clicks the done button the recycler pages pickup should change to allow confirmation" do
      visit logout_path
      visit login_path
      fill_in("email",:with => @recycler.email)
      fill_in("password",:with => @recycler.password)
      click_button("Log In")
      visit users_show_path
      expect(page).to have_content("Status: Accepted! Put your bag out for pickup.")
      visit logout_path
      fill_in("email",:with => @driver.email)
      fill_in("password",:with => "password")
      click_button("Log In")
      visit trip_path(@trip)
      click_button("Complete")
      click_button("Done")
      visit logout_path
      visit login_path
      fill_in("email",:with => @recycler.email)
      fill_in("password",:with => @recycler.password)
      click_button("Log In")
      visit users_show_path
      expect(page).to have_content("Status: Your bag has been picked up, please confirm!")
    end

    it "the recycler should be able to confirm the pickup with a confirmation modal" do
      click_button("Complete")
      click_button("Done")
      visit logout_path
      fill_in("email",:with => @recycler.email)
      fill_in("password",:with => @recycler.password)
      click_button("Log In")
      visit users_show_path
      expect(find_button("Complete").visible?).to be true
      click_button("Complete")
      expect(find_button("Done").visible?).to be true
      click_button("Done")
    end

    it "after clicking the done button the recycler's credits should be decremented by the number of bags" do
      click_button("Complete")
      click_button("Done")
      visit logout_path
      fill_in("email",:with => @recycler.email)
      fill_in("password",:with => @recycler.password)
      click_button("Log In")
      visit users_show_path
      expect(find_button("Complete").visible?).to be true
      click_button("Complete")
      expect(find_button("Done").visible?).to be true
      click_button("Done")
      expect(page).to have_content("Credit count: 2")
    end

    it "after the recycler clicks the done button the drivers credits should be incremented by the number of bags" do
      click_button("Complete")
      click_button("Done")
      visit logout_path
      fill_in("email",:with => @recycler.email)
      fill_in("password",:with => @recycler.password)
      click_button("Log In")
      visit users_show_path
      expect(find_button("Complete").visible?).to be true
      click_button("Complete")
      expect(find_button("Done").visible?).to be true
      click_button("Done")
      visit logout_path
      fill_in("email",:with => @driver.email)
      fill_in("password",:with => "password")
      click_button("Log In")
      visit users_show_path
      expect(page).to have_content("Credit count: 4")
    end
  end
end
