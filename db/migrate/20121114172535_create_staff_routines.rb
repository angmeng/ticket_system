class CreateStaffRoutines < ActiveRecord::Migration
  def change
    create_table :staff_routines do |t|
      t.integer :staff_id
      t.integer :routine_id

      t.timestamps
    end
    add_index :staff_routines, :staff_id
    add_index :staff_routines, :routine_id
  end
end
