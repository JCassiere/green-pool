require 'rails_helper'

RSpec.feature "Finalconfirmations", type: :feature do
  describe "confirming a finished transaction on a recyclers page" do
    it "should find a confirm button on the pickup after a driver confirms the pickup is done"
    it "when clicking the confirm button a confirmation modal appears"
    it "should find a done button on a confirmation modal when it appears after clicking confirm"
    it "after clicking the done button on the confirmation modal the pickup should disappear from recycler page"
    it "after clicking the done button the recyclers credits should be decremented by the number of bags"
    it "after clicking the done button the drivers credits should be incremented by the number of bags"
  end
end
