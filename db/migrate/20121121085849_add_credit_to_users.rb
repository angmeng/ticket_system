class AddCreditToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit, :decimal, :precision => 10, :scale => 2, :default => 0.00
  end
end
