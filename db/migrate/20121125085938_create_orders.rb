class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :buyer_type_id
      t.integer :payment_type_id
      t.integer :free_tickets, :default => 0
      t.decimal :discount, :precision => 10, :scale => 2, :default => 0.00
      t.decimal :extra_charges, :precision => 10, :scale => 2, :default => 0.00
      t.decimal :amount_tender, :precision => 10, :scale => 2, :default => 0.00
      t.text :remark

      t.timestamps
    end
    add_index :orders, :seller_id
    add_index :orders, [:buyer_id, :buyer_type_id]
    add_index :orders, :payment_type_id

  end
end
