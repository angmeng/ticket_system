class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :code
      t.time :departure_time
      t.integer :routine_id
      t.integer :sales_quota, :default => 0
      t.integer :online_quota, :default => 0
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :schedules, :code, :unique => true
    add_index :schedules, :routine_id
  end
end
