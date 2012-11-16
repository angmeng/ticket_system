class CreateDepartures < ActiveRecord::Migration
  def change
    create_table :departures do |t|
      t.integer :vessel_id
      t.integer :sales_quota, :default => 100
      t.integer :online_quota, :default => 0
      t.boolean :custom_quota, :default => false
      t.boolean :on_call, :default => false
      t.integer :status_id, :default => 1
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :departures, :vessel_id
  end
end
