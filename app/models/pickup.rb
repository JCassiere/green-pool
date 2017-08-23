class Pickup < ApplicationRecord
	has_one :transaction
	belongs_to :trip
  enum status: [:created, :accepted, :picked_up, :completed]
end