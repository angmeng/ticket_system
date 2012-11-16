class CreateVessels < ActiveRecord::Migration
  def change
    create_table :vessels do |t|
      t.string :code
      t.string :name
      t.integer :total_passenger, :default => 100
      t.integer :total_crew, :default => 0
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :vessels, :code, :unique => true
  end
end
