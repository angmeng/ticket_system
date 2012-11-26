class AddTravelTypeIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :travel_type_id, :integer, :default => 0
    add_index  :order_items, :travel_type_id
  end
end
