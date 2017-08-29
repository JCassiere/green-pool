class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :entry_type, default: 0

      t.timestamps
    end
  end
end