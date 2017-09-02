require 'rails_helper'

RSpec.feature "Newtrippages", type: :feature do
  before(:each) do
    @driver = dummy_user
    visit login_path
    fill_in "Email", with: @driver.email
    fill_in "Password", with: @driver.password_digest
    click_button("Log In")
    visit root_path
    click_button("Schedule Trip")
  end

  describe "clicking new trip link" do
    it "should show user's name" do
      expect(page).to have_content(@driver.first_name)
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

  describe "after creating a trip" do
    before(:each) do
      fill_in "Total Space", with: 5
      fill_in "Pickup Time", with: "2018-09-02T22:30"
      click_button("Create Trip")
    end

    it "the user should now have a new trip on their user page" do
      expect(page).to have_content("September 2, 2018 at 10:30 PM")
    end

    describe "when visiting the driver trip page" do
      before(:each) do
        click_button("View Trip")
      end

      it "should display the driver's name" do
        expect(page).to have_content("Random Person's Trip")
      end

      it "should display the trip's date" do
        expect(page).to have_content("September 2, 2018 at 10:30 PM")
      end

      it "should show the space remaining for the trip" do
        expect(page).to have_content("Space left for 5 bags")
      end

      it "should have no pickups associated with it" do
        expect(page).to_not have_content("Pickups")
      end

      it "should have a button for cancelling a trip" do
        expect(find_button('Cancel Trip').visible?).to be true
      end


      describe "cancelling a trip" do
        before(:each) do
          click_button("Cancel Trip")
        end

        it "should no longer have the trip on the driver's page" do
          expect(page).to_not have_content("Trips")
        end
      end

    end
  end
end