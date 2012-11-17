class Vessel < ActiveRecord::Base
  attr_accessible :active, :code, :name, :total_crew, :total_passenger

  validates :code, :name, :presence => true, :uniqueness => true
  validates :total_passenger, :total_crew, :numericality => true

  has_many :departures
end
