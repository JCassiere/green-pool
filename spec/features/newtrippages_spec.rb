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
      expect(page).to have_css('select[name="trip[pickup_time(1i)]"]')
    end
    it "should have a create trip button" do
      expect(find_button('Create Trip').visible?).to be true
    end
  end

  describe "after creating a trip" do
    before(:each) do
      fill_in "Total Space", with: 5
      select_date("2018,September,5", :from => "Pickup Time")
      select_time("14", "00", :from => "Pickup Time")
      click_button("Create Trip")
    end

    it "the user should now have a new trip on their user page" do
      expect(page).to have_content("September 5, 2018 at 2:00 PM")
    end

    describe "when visiting the driver trip page" do
      before(:each) do
        click_link("View Trip")
      end

      it "should display the driver's name" do
        expect(page).to have_content("Random Person's Trip")
      end

      it "should display the trip's date" do
        expect(page).to have_content("September 5, 2018 at 2:00 PM")
      end

      it "should show the space remaining for the trip" do
        expect(page).to have_content("Space left for 5 bags")
      end

      it "should have no pickups associated with it" do
        expect(page).to_not have_content("Pickups")
      end
    end
  end
end
