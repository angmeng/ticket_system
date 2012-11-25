class OrderItem < ActiveRecord::Base
  attr_accessible :departure_id, :order_id, :ticket_id
end
