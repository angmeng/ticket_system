class AddCommissionToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :basic_commission, :decimal, :scale => 2, :precision => 10, :default => 10.00
    add_column :branches, :agent_commission, :decimal, :scale => 2, :precision => 10, :default => 10.00
  end
end
