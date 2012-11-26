class AddTypeIdToTicketCategories < ActiveRecord::Migration
  def change
    add_column :ticket_categories, :type_id, :integer, :null => false
    add_index  :ticket_categories, :type_id
  end
end
