class CreateReservationDetails < ActiveRecord::Migration
  def change
    create_table :reservation_details do |t|
      t.string :reservation_number
      t.integer :order_id

      t.timestamps
    end
    add_index :reservation_details, :order_id
  end
end
