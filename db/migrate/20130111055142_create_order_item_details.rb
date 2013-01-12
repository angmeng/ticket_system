class CreateOrderItemDetails < ActiveRecord::Migration
  def change
    create_table :order_item_details do |t|
      t.integer :order_item_id, :default => 0
      t.string :serial_number
      t.integer :ticket_status_id, :default => 0
      t.decimal :fare, :precision => 10, :scale => 2, :default => 0.00
      t.integer :ticket_category_id, :default => 0 

      t.timestamps
    end
  end
end
