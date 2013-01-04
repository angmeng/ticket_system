class AddIsAdminToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :branch_id, :integer
  end
end
