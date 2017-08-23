class AddPickupToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :pickup, foreign_key: true
  end
end
