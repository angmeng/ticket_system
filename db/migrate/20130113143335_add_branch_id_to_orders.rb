class AddBranchIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :branch_id, :integer, :default => 0
    add_index  :orders, :branch_id
    add_index  :order_item_details, :order_item_id
    add_index  :order_item_details, :serial_number
    add_index  :order_item_details, :ticket_status_id
  end
end
