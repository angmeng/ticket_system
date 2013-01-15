class CreateWarrantPurchases < ActiveRecord::Migration
  def change
    create_table :warrant_purchases do |t|
      t.integer :warrant_id, :default => 0
      t.integer :order_id, :default => 0

      t.timestamps
    end
    add_index :warrant_purchases, :warrant_id
    add_index :warrant_purchases, :order_id
  end
end
