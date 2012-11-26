class Order < ActiveRecord::Base
  attr_accessible :amount_tender, :discount, :extra_charges, :free_tickets, :payment_type_id, :remark, :seller_id, :buyer_id, :buyer_type_id

  has_many :order_items

  def total_ticket
  	self.order_items.size
  end

  def total_amount
  	self.order_items.inject(0.00) {|sum, item| sum += item.fare}
  end

  def total_adult_ticket
  	adult_category = TicketCategory.find_by_type_id TicketType::ADULT
  	self.order_items.where("ticket_category_id = ?", adult_category.id)
  end
end
