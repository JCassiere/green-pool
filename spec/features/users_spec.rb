require 'rails_helper'

RSpec.feature "Users", type: :feature do

  describe "before creating a new user" do
    it "should be able to go to the homepage and see the link to signup as a new user" do
      visit("/")
      expect(find_link('Sign Up').visible?).to be true
    end
  end

  describe "to create a new user" do
    before(:each) do
      visit(signup_path)
      fill_in "Name", with: "Random Person"
      fill_in "Email", with: "fakeemail@gmail.com"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_button "Submit"
      @joe = User.first
    end

    it "should be able to fill out the sign up form to create an account" do
      @joe.name = "Random Person"
    end

    it "should redirect to homepage and see a welcome message only after creating an account" do
      expect(page).to have_content("Welcome, Joe!")
    end
    it "should verify that a name/email/address/password/password confirmation image was uploaded"
    it "should verify that email is unique"
  end

  describe "login to the service" do
    it "I should be able to go to the homepage and see the link to login"
    it "should be able to fill out the login form to sign in to my account"
    it "should redirect to homepage and see a welcome message only after successfully logging into my account"
    it "should verify that the email/password exist"
  end
end
