require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@user = User.new(
			first_name: "Random", 
			last_name: "Person", 
			email: "fakeemail@gmail.com", 
			password_digest: "password",
			avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg')
			)
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

  it "should verify that email is unique" do
  	@user.save
  	@another_user = User.new(
			first_name: "Random", 
			last_name: "Person", 
			email: "fakeemail@gmail.com", 
			password_digest: "password",
			avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg')
			)
  	expect(@another_user).to_not be_valid
  end
end
