class AddColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :order_items, :arrival_id, :integer, :default => 0
  	add_column :orders, :total_passenger, :integer, :default => 0
  end
end
