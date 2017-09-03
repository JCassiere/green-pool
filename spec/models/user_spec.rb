require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@user = dummy_user_model
	end

	it "is valid with valid attributes" do
		expect(@user).to be_valid
	end

  it "is not valid without a first name" do
  	@user.first_name = nil
  	expect(@user).to_not be_valid
  end

  it "is not valid without a last name" do
  	@user.last_name = nil
  	expect(@user).to_not be_valid
  end

  it "is not valid without an email" do
  	@user.email = nil
   	expect(@user).to_not be_valid
  end

  it "is not valid without a password" do
  	@user.password_digest = nil
  	expect(@user).to_not be_valid
  end

  it "is not valid without a profile picture" do
  	@user.avatar = nil
   	expect(@user).to_not be_valid
  end

  it "is not valid without a street" do
    @user.street = nil
    expect(@user).to_not be_valid
  end

  it "is not valid without a city" do
    @user.city = nil
    expect(@user).to_not be_valid
  end

  it "is not valid without a state" do
    @user.state = nil
    expect(@user).to_not be_valid
  end

  it "is not valid without a country" do
    @user.country = nil
    expect(@user).to_not be_valid
  end

  it "is not valid without a zip code" do
    @user.zip_code = nil
    expect(@user).to_not be_valid
  end

  it "is geocoded by its address" do
    @user.save
    expect(@user.latitude).to_not be_nil
  end

  it "should verify that email is unique" do
  	@user.save
  	@another_user = dummy_user_model
  	expect(@another_user).to_not be_valid
  end
end