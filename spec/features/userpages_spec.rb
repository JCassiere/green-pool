require 'rails_helper'

RSpec.feature "Userpages", type: :feature do
  it "I should be able to go to the homepage and see the link to go to my profile" do
    visit '/'
    expect(page).to have_content('Profile')
    find_link('Profile').click
  end

  it "userpage should load if logged in" do
    user = User.create!(name: Faker::Name.name, email: Faker::Internet.email, address: "#{Faker::Address.street_address} #{Faker::Address.city},#{Faker::Address.state_abbr} #{Faker::Address.zip}", credit_count: 3, password_digest: Faker::DragonBall.character)
    visit "/users/#{user.id}"
    expect(page).to have_content("Hello, #{user.name}!" )
  end
  it "userpage should show user's trips"
  it "userpage should show pending trips"
  it "userpage should show number of credits"
  it "userpage should allow user to logout and be redirected to homepage"
end
