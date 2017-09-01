class Pickup < ApplicationRecord
  belongs_to :user
	belongs_to :trip
  enum status: [:created, :accepted, :picked_up, :completed]

  def driver_name
  	self.trip.driver_name
  end

  def recycler_name
  	self.user.full_name
  end

  def address
  	self.user.address
  end
end