class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :code
      t.string :name
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :branches, :code, :unique => true
  end
end
