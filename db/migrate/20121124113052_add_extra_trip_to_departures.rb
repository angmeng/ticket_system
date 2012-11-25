class AddExtraTripToDepartures < ActiveRecord::Migration
  def change
    add_column :departures, :extra_trip, :boolean
    add_column :departures, :routine_id, :integer
    add_column :departures, :date, :date
    add_column :departures, :time, :time
    add_index :departures, :routine_id
  end
end
