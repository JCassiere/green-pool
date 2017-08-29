class User < ApplicationRecord
  has_many :trips
  has_many :recycling_pickups, class_name: 'Pickup'
  has_many :driver_pickups, through: :trips, source: :pickups
  has_attached_file :avatar, styles: { medium: "300x300>" , thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :avatar, presence: true, content_type: { content_type: /\Aimage\/.*\z/ }
  has_secure_password
  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :street, :city, :state, :country, :zip_code
  validates_uniqueness_of :email
  geocoded_by :address
  # :latitude  => :lat, :longitude => :lon
  after_validation :geocode

  def full_name
  	"#{self.first_name} #{self.last_name}"
  end

  def address
    [street, city, state, zip_code, country].compact.join(', ')
  end

end
