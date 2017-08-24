class User < ApplicationRecord
  has_many :pickups
  has_many :trips
end
