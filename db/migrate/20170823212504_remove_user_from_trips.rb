class RemoveUserFromTrips < ActiveRecord::Migration[5.1]
  def change
    remove_column :trips, :user_id, :bigint
  end
end
