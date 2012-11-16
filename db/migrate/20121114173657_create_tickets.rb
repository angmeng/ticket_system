class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :routine_id
      t.integer :ticket_category_id
      t.string :code
      t.string :name
      t.integer :initial_number, :default => 0
      t.decimal :fare, :scale => 2, :precision => 10, :default => 0.00
      t.boolean :inventory_count, :default => true
      t.boolean :required_passenger_details, :default => true
      t.date :valid_from
      t.date :expired_at
      t.boolean :no_expired, :default => false
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :tickets, :code, :unique => true
    add_index :tickets, :routine_id
    add_index :tickets, :ticket_category_id
  end
end
