class CreateAgentGroups < ActiveRecord::Migration
  def change
    create_table :agent_groups do |t|
      t.string :code
      t.string :name
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :agent_groups, :code, :unique => true
  end
end
