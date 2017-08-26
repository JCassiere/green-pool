require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "to create a new user" do
    it "I should be able to go to the homepage and see the link to signup as a new user"
    it "should be able to fill out the sign up form to create an account"
    it "should redirect to homepage and see a welcome message only after creating an account"
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
