class User < ApplicationRecord
  has_many :trips
  has_many :recycling_pickups, class_name: 'Pickup'
  has_many :driver_pickups, through: :trips, source: :pickups
  has_attached_file :avatar, styles: { medium: "300x300>" , thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_secure_password

end
