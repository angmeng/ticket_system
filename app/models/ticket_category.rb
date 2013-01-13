class TicketCategory < ActiveRecord::Base
  attr_accessible :active, :code, :name, :type_id
  validates :name, :code, :type_id, :presence => true, :uniqueness => true

  has_many :tickets
  has_one  :order_item_detail

  def type
  	case self.type_id
  	when TicketType::ADULT
  	  "Adult"
  	when TicketType::KID
  	  "Child"
    when TicketType::INFANT
      "Infant"
  	end
  end

  def adult?
    self.type_id == TicketType::ADULT
  end

  def kid?
    self.type_id == TicketType::KID
  end

  def infant?
    self.type_id == TicketType::INFANT
  end

end
