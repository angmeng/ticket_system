class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :email, :fax, :name, :phone, :register_number, :branch_id
  belongs_to :branch

  validates :name, :register_number, :address_1, :presence => true, :uniqueness => true
end
