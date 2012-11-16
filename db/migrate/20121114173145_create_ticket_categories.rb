class CreateTicketCategories < ActiveRecord::Migration
  def change
    create_table :ticket_categories do |t|
      t.string :code
      t.string :name
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :ticket_categories, :code, :unique => true
  end
end
