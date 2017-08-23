class Pickup < ApplicationRecord
	has_one :transaction
  enum status: [:created, :accepted, :picked_up, :completed]
end