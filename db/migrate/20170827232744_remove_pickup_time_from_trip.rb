class RemovePickupTimeFromTrip < ActiveRecord::Migration[5.1]
  def change
    remove_column :trips, :pickup_time, :string
  end
end
