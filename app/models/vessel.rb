class Vessel < ActiveRecord::Base
  attr_accessible :active, :code, :name, :total_crew, :total_passenger
end
