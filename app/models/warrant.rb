 class Warrant < ActiveRecord::Base
  attr_accessible :active, :address, :code, :email, :fax, :name, :phone, :remark

  validates :name, :code, :email, :presence => true, :uniqueness => true
end
