require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@guy = User.new(
			first_name: "Random", 
			last_name: "Person", 
			email: "fakeemail@gmail.com", 
			password_digest: "password",
			avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg')
			)
	end

	it "is valid with valid attributes" do
		expect(@guy).to be_valid
	end

  it "is not valid without a first name" do
  	@guy.first_name = nil
  	expect(@guy).to_not be_valid
  end

  it "is not valid without a last name" do
  	@guy.last_name = nil
  	expect(@guy).to_not be_valid
  end

  it "is not valid without an email" do
  	@guy.email = nil
   	expect(@guy).to_not be_valid
  end

  it "is not valid without a password" do
  	@guy.password_digest = nil
  	expect(@guy).to_not be_valid
  end

  it "is not valid without a profile picture" do
  	@guy.password_digest = nil
   	expect(@guy).to_not be_valid
  end

  it "should verify that email is unique" do
  	@guy.save
  	@another_guy = User.new(
			first_name: "Random", 
			last_name: "Person", 
			email: "fakeemail@gmail.com", 
			password_digest: "password",
			avatar: File.new(Rails.root + 'spec/fixtures/images/rails.jpg')
			)
  	expect(@another_guy).to_not be_valid
  end
end
