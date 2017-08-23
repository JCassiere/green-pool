class Pickup < ApplicationRecord
  enum status: [:created, :accepted, :picked_up, :completed]
end