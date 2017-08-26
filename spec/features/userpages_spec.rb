require 'rails_helper'

RSpec.feature "Userpages", type: :feature do
  it "I should be able to go to the homepage and see the link to go to my profile if logged in"
  it "userpage should load"
  it "userpage should show user's trips"
  it "userpage should show pending trips"
  it "userpage should show number of credits"
  it "userpage should allow user to logout and be redirected to homepage"
end
