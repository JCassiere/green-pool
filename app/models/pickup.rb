class Pickup < ApplicationRecord
  belongs_to :user
	belongs_to :trip
  validates_presence_of :num_bags
  enum status: [:created, :accepted, :picked_up, :completed]

  after_create :reminder

  def driver_name
  	self.trip.driver_name
  end

  def driver_phone_number
    self.trip.user.phone_number
  end

  def recycler_phone_number
    self.user.phone_number
  end

  def recycler_name
  	self.user.full_name
  end

  def address
  	self.user.address
  end

  def pickup_time
    self.trip.pickup_time
  end

  def update_status
    case self.status
    when "created"
      self.accepted!
    when "accepted"
      self.picked_up!
    when "picked_up"
      self.completed!
    end
  end

  def reminder
    @twilio_number = Rails.application.secrets.twilio_phone_number
    @client = Twilio::REST::Client.new(
      Rails.application.secrets.twilio_account_sid,
      Rails.application.secrets.twilio_auth_token
    )
    time_str = ((self.pickup_time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    reminder = "Hi #{self.recycler_name}. Just a reminder that your recycling will be picked up at #{time_str}.  Your driver's name is #{self.driver_name} and their phone number is #{self.driver_phone_number}"
    message = @client.messages.create(
      :from => @twilio_number,
      :to => self.recycler_phone_number,
      :body => reminder,
    )
  end

  def when_to_run
    minutes_before_trip = 30.minutes
    self.pickup_time - minutes_before_trip
  end

  handle_asynchronously :reminder, run_at: Proc.new { 239.minutes.ago }
end