class AddPickupDatetimeToTrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :pickup_time, :datetime
  end
end
