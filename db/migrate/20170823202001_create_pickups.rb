class CreatePickups < ActiveRecord::Migration[5.1]
  def change
    create_table :pickups do |t|
      t.integer :num_bags
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
