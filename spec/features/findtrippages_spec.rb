require 'rails_helper'

RSpec.feature "Find Trip Page", type: :feature do
  context "a signed in user adds recycling to a trip" do
    before(:each) do
      @user = dummy_user
    end

    describe "after a trip is created by a different user" do
      before(:each) do
        @other_user = faker_dummy
        @pickup_time = Faker::Time.forward(2, :morning)
        @trip = @other_user.trips.create(
          pickup_time: @pickup_time,
          total_space: 5
        )
      end

      it "I should be able to go to the homepage and see the find trip link" do
        expect(find_link('Have Your Recycling Picked Up').visible?).to be true
      end

      describe "on the find trip page" do
        before(:each) do
          click_link('Have Your Recycling Picked Up')
        end

        it "a trip's driver should be visible" do
          expect(page).to have_content(@other_user.full_name)
        end

        it "a trip's start_location should be visible" do
          expect(page).to have_content(@other_user.address)
        end

        it "a trip's available space should be visible" do
          expect(page).to have_content("Space Remaining: 5")
        end

        it "a trip's date should be visible" do
          pickup = @pickup_time.strftime("%B %e, %Y at %l:%M %p")
          expect(page).to have_content("Scheduled for #{pickup}")
        end

        it "I should be able to press a button to add my recycling to a trip" do
          expect(find_link('Add Recycling').visible?).to be true
        end
        
        describe "after clicking the Add Recycling button" do
          before(:each) do
            click_link("Add Recycling")
          end

          it "should redirect to the new trip pickup page" do
            assert_equal "/trips/#{@trip.id}/pickups/new", current_path
          end

          it "should have a form for adding the number of bags to a trip" do
            expect(page).to have_css('input[name="pickup[num_bags]"]')
          end

          it "should have a button to add a pickup to a trip" do
            expect(find_button("Add My Recycling to #{@other_user.first_name}'s Trip").visible?).to be true
          end
        end

        describe "after creating a pickup for a trip" do
          before(:each) do
            click_link("Add Recycling")
            fill_in "Number of Bags", with: 2
            click_button("Add My Recycling to #{@other_user.first_name}'s Trip")
          end

          it "should redirect to the user's page" do
            assert_equal "/users/show", current_path
          end

          it "the driver for the pickup should appear on the user's page" do
            expect(page).to have_content(@other_user.full_name)
          end

          it "the number of bags for the pickup should appear on the user's page" do
            expect(page).to have_content("2")
          end

          it "the space available on the find trip page should go decrease accordingly" do
            visit(trips_path)
            expect(page).to have_content("Space Remaining: 3")
          end
          it "the trip should disappear from the find trip page if the space available has been reached" do
            visit(trips_path)
            click_link("Add Recycling")
            fill_in "Number of Bags", with: 3
            click_button("Add My Recycling to #{@other_user.first_name}'s Trip")
            visit(trips_path)
            expect(page).to_not have_content(@other_user.full_name)
          end
        end
      end
    end

    describe "a driver's trip page after a user adds a pickup" do
      before(:each) do
        @pickup_time = Faker::Time.forward(2, :morning)
        @trip = @user.trips.create(
          pickup_time: @pickup_time,
          total_space: 5
        )
        @other_user = faker_dummy
        @other_user.recycling_pickups.create(
          num_bags: 2,
          trip_id: @trip.id
        )
        visit users_show_path
        click_link("View Trip")
      end

      it "should have a pickup with a recycler name" do
        expect(page).to have_content(@other_user.full_name)
      end
      it "should have a pickup with an address" do
        expect(page).to have_content(@other_user.full_name)
      end
      it "should have a pickup with a number of bags" do
        expect(page).to have_content("Number of Bags: 2")
      end

      it "should have a deny button" do
        expect(find_button("Deny").visible?).to be true
      end

      it "should show the pickup on the recycler's user page" do
        click_link("Logout")
        click_link("Login")
        fill_in "Email", with: @other_user.email
        fill_in "Password", with: @other_user.password
        click_button("Log In")
        visit(users_show_path)
        expect(page).to have_content(@user.full_name)
        expect(page).to have_content("Number of Bags: 2")
      end

      describe "denying a pickup" do
        before(:each) do
          click_button("Deny")
        end

        it "clicking the deny button removes the pickup from the trip page" do
          expect(page).to_not have_content(@other_user.address)
          expect(page).to_not have_content("Number of Bags: 2")
        end

        it "shows a message stating the pickup was denied" do
          expect(page).to have_content("Pickup for #{@other_user.full_name} denied")
        end

        it "should remove the pickup from the recycler's user page if denied" do
          click_link("Logout")
          click_link("Login")
          fill_in "Email", with: @other_user.email
          fill_in "Password", with: @other_user.password
          click_button("Log In")
          visit(users_show_path)
          expect(page).to_not have_content(@other_user.address)
          expect(page).to_not have_content("Number of Bags: 2")
        end
      end

      describe "accepting a pickup" do
        it "should have an accept button" do
          expect(find_button("Accept").visible?).to be true
        end

        it "should show a 'Complete' button after the trip has been accepted" do
          click_button("Accept")
          expect(find_link("Complete").visible?).to be true
        end
      end

      it "should show confirmation modal when clicking done link" 
      it "should find complete pickup button when confirmation modal appears"
      it "after complete pickup button clicked modal should disappear"
      it "trip should disappear from page after last pickup is completed"
    end
  end
end