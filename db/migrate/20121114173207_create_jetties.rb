class CreateJetties < ActiveRecord::Migration
  def change
    create_table :jetties do |t|
      t.string :code
      t.string :name
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :jetties, :code, :unique => true
  end
end
