class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id, :null => false
      t.integer :ticket_id, :null => false
      t.integer :departure_id, :null => false

      t.timestamps
    end
    add_index :order_items, :order_id
    add_index :order_items, :ticket_id
    add_index :order_items, :departure_id
  end
end
