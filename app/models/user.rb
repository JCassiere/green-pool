class User < ApplicationRecord
  has_many :pickups
  has_many :trips
  has_attached_file :avatar, styles: { medium: "300x300>" , thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :avatar, presence: true, content_type: { content_type: /\Aimage\/.*\z/ }
  has_secure_password
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
end
