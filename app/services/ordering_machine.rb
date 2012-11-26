class OrderingMachine

  def self.make(order)
  	@order_params = order
  	@order = Order.new
  	make_order
  	make_order_items

  end

  def self.make_order
  	@order.seller_id = @order_params["seller_id"]
  	case @order_params["buyer_type"]
  	when "normal"
  	  @order.buyer_type_id  = BuyerType::PUBLIC
   	  @order.buyer_id  = 0
   	when "agent"
   	  @order.buyer_type_id  = BuyerType::SUB_AGENT
   	  @order.buyer_id  = @order_params["agent_id"]
   	when "warrant"
   	  @order.buyer_type_id  = BuyerType::WARRANT
   	  @order.buyer_id  = @order_params["warrant_id"]
   	end
   	@order.save!
  end

  def self.make_order_items
  	if @order_params["adult"].to_i > 0
  		item = @order.order_items.new
  		item.departure_id = @order_params["departure_routine_id"]
  		adult_category = TicketCategory.find_by_type_id TicketType::ADULT
  		ticket = Ticket.where("id IN(?) and ticket_category_id = ?", [@order_params["departure_ticket_ids"]], adult_category.id).first
  		item.ticket_id = ticket.id
  		item.save!
  	end
  	if @order_params["kid"].to_i > 0
        item = @order.order_items.new
  		item.departure_id = @order_params["departure_routine_id"]
  		kid_category = TicketCategory.find_by_type_id TicketType::KID
  		ticket = Ticket.where("id IN(?) and ticket_category_id = ?", [@order_params["departure_ticket_ids"]], kid_category.id).first
  		item.ticket_id = ticket.id
  		item.save!

  	end

  	@order_params["trip_type"]
    @order_params["departure_jetty_id"]
    @order_params["arrival_jetty_id"]
    @order_params["depart_date"]
    @order_params["return_date"]
    @order_params["kid"]
    @order_params["arrival_routine_id"]
    @order_params["arrival_ticket_ids"]
  end

end