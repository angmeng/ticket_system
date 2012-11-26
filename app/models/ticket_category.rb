class TicketCategory < ActiveRecord::Base
  attr_accessible :active, :code, :name, :type_id
  validates :name, :code, :type_id, :presence => true, :uniqueness => true

  has_many :tickets

  def type
  	case type_id
  	when TicketType::ADULT
  	  "Adult"
  	when TicketType::KID
  	  "Kid"
  	end
  end

end
