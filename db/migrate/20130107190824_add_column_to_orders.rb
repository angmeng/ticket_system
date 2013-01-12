class AddColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :order_items, :arrival_id, :integer, :default => 0
  	add_column :orders, :total_passenger, :integer, :default => 0

  	remove_column :orders, :status_id
  	add_column :order_items, :status_id, :integer, :default => 0

  	add_column :companies, :last_voucher_number, :integer, :default => 0
  	add_column :companies, :last_receipt_number, :integer, :default => 0

  	add_column :orders, :bypass_credit, :boolean, :default => false
  	add_column :orders, :bypass_credit_manager_id, :integer, :default => 0

    add_column :order_items, :infant_fare, :decimal, :precision => 10, :scale => 2, :default => 0.00
  end
end
