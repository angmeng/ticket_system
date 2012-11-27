class Ticket < ActiveRecord::Base
  attr_accessible :active, :code, :fare, :initial_number, :inventory_count, :name, :no_expired, :required_passenger, :routine_id, :ticket_category_id, :valid_days, :required_passenger_details

  belongs_to :routine
  belongs_to :ticket_category
  
  validates :code, :name, :presence => true, :uniqueness => {:scope => [:routine_id, :ticket_category_id]}
  validates :fare, :initial_number, :numericality => true
  validates :routine_id, :ticket_category_id, :presence => true

  def adult?
  	self.ticket_category.adult?
  end

  def kid?
  	self.ticket_category.kid?
  end


end
