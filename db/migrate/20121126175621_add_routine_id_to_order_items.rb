class AddRoutineIdToOrderItems < ActiveRecord::Migration
  def change
  	remove_column :order_items, :ticket_id
    add_column :order_items, :routine_id, :integer
    add_column :order_items, :number_of_adult, :integer, :default => 0
    add_column :order_items, :number_of_kid, :integer, :default => 0
    add_column :order_items, :adult_fare, :decimal, :precision => 10, :scale => 2, :default => 0.00
    add_column :order_items, :kid_fare, :decimal, :precision => 10, :scale => 2, :default => 0.00
    add_index  :order_items, :routine_id
  end
end
