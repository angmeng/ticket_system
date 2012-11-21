class CreateWarrants < ActiveRecord::Migration
  def change
    create_table :warrants do |t|
      t.string :code
      t.string :name
      t.text :address,           :default => ""
      t.string :phone, :limit => 16,           :default => ""
      t.string :fax, :limit => 16,           :default => ""
      t.string :email,           :default => ""
      t.text :remark,           :default => ""
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :warrants, :code, :unique => true
  end
end
