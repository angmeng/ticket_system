class Routine < ActiveRecord::Base
  attr_accessible :active, :arrival_jetty_id, :code, :departure_jetty_id, :sequence_no
end
