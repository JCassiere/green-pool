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
      @user = dummy_user
    end

    it "should be able to fill out the sign up form to create an account" do
      @user.first_name = "Random"
      @user.last_name = "Person"
    end

    it "should redirect to homepage and see a welcome message only after creating an account" do
      expect(page).to have_content("Welcome, Random!")
    end

    describe "login to the service" do
      before(:each) do
        click_link("Logout")
      end

      it "I should be able to go to the homepage and see the link to login" do
        visit("/")
        expect(find_link('Login').visible?).to be true
      end

      it "should redirect to homepage and see a welcome message only after successfully logging into my account" do
        visit(login_path)
        fill_in "Email", with: "fakeemail@gmail.com"
        fill_in "Password", with: "password"
        click_button "Submit"
        expect(page).to have_content("Hello, Random!")
      end

      it "should return to the login page with invalid credentials" do
        fill_in "Email", with: Faker::Internet.email
        fill_in "Password", with: Faker::Internet.password(8)
        click_button "Submit"
        expect(page).to have_content("That email/password combination is not valid!")
      end
    end
  end
end
