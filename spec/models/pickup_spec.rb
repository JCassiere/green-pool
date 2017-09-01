require 'rails_helper'

RSpec.describe Pickup, type: :model do
  describe "when a pickup is created" do
  	before(:each) do
    	@driver = dummy_user_model
    	@driver.save
      @pickup_time = Faker::Time.forward(2, :morning) 
      @trip = @driver.trips.create(
        pickup_time: @pickup_time,
        total_space: 5
      )
      @recycler = faker_dummy
      @pickup = Pickup.new(
      	trip_id: @trip.id,
      	num_bags: 2,
      	user_id: @recycler.id
      )
    end

    it "is not valid without a given number of bags" do
    	@pickup.num_bags = nil
    	expect(@pickup).to_not be_valid
    end

    it "is not valid without a trip" do
    	@pickup.trip_id = nil
    	expect(@pickup).to_not be_valid
    end

    it "is not valid without a user" do
    	@pickup.user_id = nil
    	expect(@pickup).to_not be_valid
    end

    describe "after a pickup is created" do
    	before(:each) do
    		@pickup.save
    	end

    	it "should have a driver name" do
    		expect(@pickup.driver_name).to eq(@driver.full_name)
    	end

    	it "should have a recycler name" do
    		expect(@pickup.recycler_name).to eq(@recycler.full_name)
    	end

    	it "should have an address" do
    		expect(@pickup.address).to eq(@recycler.address)
    	end

    	describe "changing a status" do
    		it "has the status of 'created' to start" do
    			expect(@pickup.status).to eq("created")
    		end

    		it "is next changed to 'accepted'" do
    			@pickup.update_status
    			expect(@pickup.status).to eq("accepted")
    		end

    		it "is next changed to 'picked up'" do
    			2.times { @pickup.update_status }
    			expect(@pickup.status).to eq("picked_up")
    		end

    		it "is next changed to 'completed'" do
    			3.times { @pickup.update_status }
    			expect(@pickup.status).to eq("completed")
    		end

    	end

    end
  end
end
