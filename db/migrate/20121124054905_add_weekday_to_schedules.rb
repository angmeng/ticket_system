class AddWeekdayToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :weekday, :integer
    add_column :schedules, :departure_date, :date
    add_column :schedules, :extra_trip, :boolean, :default => false
    add_index :schedules, :extra_trip
  end
end
