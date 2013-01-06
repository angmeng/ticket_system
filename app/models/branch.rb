class Branch < ActiveRecord::Base
  attr_accessible :active, :code, :name, :basic_commission, :agent_commission
  has_many :agents
  has_many :staffs
  has_one :company
  has_many :users
  
  validates :name, :code, :presence => true, :uniqueness => true


end
