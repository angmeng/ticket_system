class Warrant < ActiveRecord::Base
  attr_accessible :active, :address, :code, :email, :fax, :name, :phone, :remark
end
