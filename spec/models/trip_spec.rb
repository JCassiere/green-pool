require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe "when a trip is created" do
    before(:each) do
    	@user = dummy_user_model
    	@user.save
      @pickup_time = Faker::Time.forward(2, :morning) 
      @trip = @user.trips.create(
        pickup_time: @pickup_time,
        total_space: 5
      )
    end

    it "should have a start address" do
    	expect(@trip.start_address).to eq("549 NW 28th St., Miami, FL, 33127, USA")
    end

    it "should have the remaing space available" do
    	expect(@trip.remaining_space).to eq(5)
    end

    it "should have a trip driver" do
    	expect(@trip.driver_name).to eq("Random Person")
    end
    
    it "should have a trip date" do
    	expect(@trip.pickup_time).to eq(@pickup_time)
    end
  end
end
