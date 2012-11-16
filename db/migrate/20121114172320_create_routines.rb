class CreateRoutines < ActiveRecord::Migration
  def change
    create_table :routines do |t|
      t.string :code
      t.integer :departure_jetty_id
      t.integer :arrival_jetty_id
      t.integer :sequence_no
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :routines, :departure_jetty_id
    add_index :routines, :arrival_jetty_id
  end
end
