class AddInfantToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :number_of_infant, :integer, :default => 0
  end
end
