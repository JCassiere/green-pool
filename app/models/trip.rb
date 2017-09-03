class Trip < ApplicationRecord
  belongs_to :user 
	has_many :pickups, dependent: :destroy
	validates_presence_of :pickup_time, :total_space

	def start_address
		self.user.address
	end

	def remaining_space
		self.total_space - self.pickups.sum(:num_bags)
	end

	def driver_name
		self.user.full_name
	end

	def driver_first_name
		self.user.first_name
	end
end