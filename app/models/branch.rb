class Branch < ActiveRecord::Base
  attr_accessible :active, :code, :name

  validates :name, :code, :presence => true, :uniqueness => true

  has_many :agents
end
