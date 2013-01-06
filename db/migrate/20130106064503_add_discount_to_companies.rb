class AddDiscountToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :discount_on_two_way_ticket, :decimal, :precision => 10, :scale => 2, :default => 5.00
  end
end
