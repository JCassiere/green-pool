class Trip < ApplicationRecord
  belongs_to :user 
	has_many :pickups

	def start_address
		self.user.address
	end

	def remaining_space
		self.total_space - self.pickups.count
	end

	def driver_name
		self.user.full_name
	end
end
