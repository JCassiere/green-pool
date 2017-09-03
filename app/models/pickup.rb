class Pickup < ApplicationRecord
  belongs_to :user
	belongs_to :trip
  validates_presence_of :num_bags
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

  def update_status
    case self.status
    when "created"
      self.accepted!
    when "accepted"
      self.picked_up!
    when "picked_up"
      self.completed!
    end
  end
end