class CreateWarrants < ActiveRecord::Migration
  def change
    create_table :warrants do |t|
      t.string :code
      t.string :name
      t.text :address
      t.string :phone, :limit => 16
      t.string :fax, :limit => 16
      t.string :email
      t.text :remark
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :warrants, :code, :unique => true
  end
end
