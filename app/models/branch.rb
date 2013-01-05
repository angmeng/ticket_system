class Branch < ActiveRecord::Base
  attr_accessible :active, :code, :name
  has_many :agents
  has_many :staffs
  has_many :companies
  has_many :users
  
  validates :name, :code, :presence => true, :uniqueness => true


end
