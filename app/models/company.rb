class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :email, :fax, :name, :phone, :register_number
end
