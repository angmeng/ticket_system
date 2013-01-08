class AddSalesToDepartures < ActiveRecord::Migration
  def change
    add_column :departures, :online_sales, :integer, :default => 0
    add_column :departures, :counter_sales, :integer, :default => 0
    add_column :departures, :available_online_sales, :integer, :default => 0
    add_column :departures, :available_counter_sales, :integer, :default => 0
  end
end
