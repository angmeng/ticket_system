class ModifyColumnsOfTickets < ActiveRecord::Migration
  def up
  	remove_column :tickets, :expired_at
  	remove_column :tickets, :valid_from
  	add_column    :tickets, :valid_days, :integer, :default => 30
  end

  def down
  	add_column :tickets, :expired_at, :date
  	add_column :tickets, :valid_from, :date
  	remove_column    :tickets, :valid_days
  end
end
