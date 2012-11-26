class AddTravelTypeIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :travel_type_id, :integer, :default => 0
    add_index :orders, :travel_type_id
  end
end
