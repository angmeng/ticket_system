class AddReservationToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :reservation, :boolean, :default => false
  	add_column :companies, :last_reservation_number, :integer, :default => 0
  end
end
