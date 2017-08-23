class RemoveUserFromPickups < ActiveRecord::Migration[5.1]
  def change
    remove_column :pickups, :user_id, :bigint
  end
end
