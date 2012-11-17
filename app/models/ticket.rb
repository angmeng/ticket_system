class Ticket < ActiveRecord::Base
  attr_accessible :active, :code, :expired_at, :fare, :initial_number, :inventory_count, :name, :no_expired, :required_passenger, :routine_id, :ticket_category_id, :valid_from

  belongs_to :routine
  belongs_to :ticket_category
  
  validates :code, :name, :presence => true, :uniqueness => true
  validates :fare, :initial_number, :numericality => true
  validates :routine_id, :ticket_category_id, :presence => true
  

end
