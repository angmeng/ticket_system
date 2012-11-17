class Routine < ActiveRecord::Base
  attr_accessible :active, :arrival_jetty_id, :code, :departure_jetty_id, :sequence_no
  validates :code, :presence => true, :uniqueness => true
  validates :arrival_jetty_id, :departure_jetty_id, :presence => true

  belongs_to :arrival_jetty, :class_name => "Jetty"
  belongs_to :departure_jetty, :class_name => "Jetty"
  has_many   :schedules
  has_many   :tickets
  has_many   :ticket_categories
end
