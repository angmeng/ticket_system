class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :register_number
      t.string :address_1,           :default => ""
      t.string :address_2,           :default => ""
      t.string :phone, :limit => 16,           :default => ""
      t.string :fax, :limit => 16,           :default => ""
      t.string :email,           :default => ""

      t.timestamps
    end
    add_index :companies, :register_number, :unique => true
  end
end
