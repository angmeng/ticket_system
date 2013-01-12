class OrderItemDetail < ActiveRecord::Base
  attr_accessible :fare, :order_item_id, :serial_number, :ticket_category_id, :ticket_status_id

  belongs_to :order_item
  belongs_to :ticket_category

end
