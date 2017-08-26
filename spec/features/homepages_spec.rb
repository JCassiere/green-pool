require 'rails_helper'

RSpec.feature "Homepages", type: :feature do
  it "I should be able to go the page and see the start trip link"
  it "I should be able to to go to the page and see the find trip link"
  it "I should be able to go to the new trip page after I click the start trip button only if i am logged in"
  it "I should be able to go to the find trip page after I click the find trip button only if i am logged in"
end
