class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :register_number
      t.string :address_1
      t.string :address_2
      t.string :phone, :limit => 16
      t.string :fax, :limit => 16
      t.string :email

      t.timestamps
    end
    add_index :companies, :register_number, :unique => true
  end
end
