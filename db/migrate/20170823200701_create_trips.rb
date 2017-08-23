class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.date :pickup_time
      t.integer :total_space

      t.timestamps
    end
  end
end
