class OrderItem < ActiveRecord::Base
  attr_accessible :departure_id, :order_id, :ticket_id

  belongs_to :order
  belongs_to :departure
  belongs_to :ticket
end
