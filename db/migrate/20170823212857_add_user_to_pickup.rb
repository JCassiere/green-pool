class AddUserToPickup < ActiveRecord::Migration[5.1]
  def change
    add_reference :pickups, :user, foreign_key: true
  end
end
