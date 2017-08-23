class Pickup < ApplicationRecord
	belongs_to :trip
  enum status: [:created, :accepted, :picked_up, :completed]
end
