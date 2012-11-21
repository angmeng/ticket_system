class CreateTopupCredits < ActiveRecord::Migration
  def change
    create_table :topup_credits do |t|
      t.integer :agent_id
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0.00
      t.text :remark,           :default => ""
      t.integer :staff_id

      t.timestamps
    end
    add_index :topup_credits, :agent_id
    add_index :topup_credits, :staff_id

  end
end
