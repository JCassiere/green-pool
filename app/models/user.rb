class User < ApplicationRecord
  has_many :pickups
  has_many :trips
  has_secure_password
end
