class OrderingMachine

  def initialize(order, company, branch)
  	@order_params = order
    @company = company
    @branch  = branch
    # @order_params["departure_jetty_id"]
    # @order_params["arrival_jetty_id"]
    # @order_params["depart_date"]
    # @order_params["return_date"]
    # @order_params["arrival_routine_id"]
    # @order_params["arrival_ticket_ids"]
    @total_ticket = @order_params["adult"].to_i + @order_params["kid"].to_i + @order_params["infant"].to_i
  	@order = Order.new
    @order.branch_id = @branch.id
  end

  def process
    make_order
    make_order_items
    @order
  end

  def make_order
  	@order.seller_id = @order_params["seller_id"]
  	case @order_params["buyer_type"]
  	when "normal"
  	  @order.buyer_type_id  = BuyerType::PUBLIC
   	  @order.buyer_id  = 0
   	when "agent"
   	  @order.buyer_type_id  = BuyerType::AGENT
   	  @order.buyer_id  = @order_params["agent_id"]
   	when "warrant"
   	  @order.buyer_type_id  = BuyerType::WARRANT
   	  @order.buyer_id  = @order_params["warrant_id"]
   	end

    case @order_params["trip_type"]
    when "round"
      @order.travel_type_id = TravelType::ROUND_TRIP
      @order.discount = Company.first.discount_on_two_way_ticket
    when "one"
      @order.travel_type_id = TravelType::SINGLE_TRIP
    when "open_ticket"
      @order.travel_type_id = TravelType::OPEN_TICKET
      @order.discount = Company.first.discount_on_two_way_ticket
    end
    @order.total_passenger = @total_ticket
   	@order.save!
  end

  def make_order_items
  	make_departure_order
    make_arrival_order if @order.is_round_trip?
    make_voucher if @order.is_open_ticket?
  end

  def make_departure_order
    if @order_params["adult"].to_i > 0
      item = @order.order_items.new
      item.departure_id = @order_params["departure_routine_id"]
      #item.arrival_id = @order_params["arrival_routine_id"]
      item.routine_id = item.departure.routine_id
      adult_category = TicketCategory.find_by_type_id TicketType::ADULT
      ticket = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], adult_category.id).first
      item.adult_fare = ticket.fare if ticket
      kid_category = TicketCategory.find_by_type_id TicketType::KID
      ticket = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], kid_category.id).first
      item.kid_fare = ticket.fare if ticket
      infant_category = TicketCategory.find_by_type_id TicketType::INFANT
      ticket = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], infant_category.id).first
      item.infant_fare = ticket.fare if ticket
      item.number_of_adult = @order_params["adult"].to_i
      item.number_of_kid = @order_params["kid"].to_i
      item.number_of_infant = @order_params["infant"].to_i
      item.travel_type_id = TravelType::GOING_OUT
      item.status_id = OrderStatus::VERIFIED
      if item.save
        generate_item_detail(item)
        update_departure_balance(item.departure_id)
      end
    end
  end

  def make_arrival_order
    if @order_params["adult"].to_i > 0
      item = @order.order_items.new
      item.departure_id = @order_params["arrival_routine_id"]
      #item.arrival_id = @order_params["departure_routine_id"]
      item.routine_id = item.departure.routine_id
      adult_category = TicketCategory.find_by_type_id TicketType::ADULT
      ticket = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["arrival_ticket_ids"], adult_category.id).first
      item.adult_fare = ticket.fare if ticket
      kid_category = TicketCategory.find_by_type_id TicketType::KID
      ticket = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["arrival_ticket_ids"], kid_category.id).first
      item.kid_fare = ticket.fare if ticket
      infant_category = TicketCategory.find_by_type_id TicketType::INFANT
      ticket = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], infant_category.id).first
      item.infant_fare = ticket.fare if ticket
      item.number_of_adult = @order_params["adult"].to_i
      item.number_of_kid = @order_params["kid"].to_i
      item.number_of_infant = @order_params["infant"].to_i
      item.travel_type_id = TravelType::COMING_BACK
      item.status_id = OrderStatus::VERIFIED
      if item.save
        generate_item_detail(item)
        update_departure_balance(item.departure_id)
      end
    end
  end

  def make_voucher
    item = @order.order_items.new

      # Notice, please read carefully... 
      # When first go out, departure_id is Penang, arrival_id is Langkawi..
      # When anytime want to back home, departure_id is Langkawi(_id), arrival_id is Penang(_id), this sentence will be as below..
    item.departure_id = @order_params["departure_id"]
    item.arrival_id = @order_params["arrival_id"]
    routine = Routine.find_by_departure_jetty_id_and_arrival_jetty_id(item.departure_id, item.arrival_id)

    if routine.present?
      item.routine_id = routine.id
      adult_category = TicketCategory.find_by_type_id TicketType::ADULT
      ticket = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, adult_category.id)
      item.adult_fare = ticket.fare if ticket
      kid_category = TicketCategory.find_by_type_id TicketType::KID
      ticket = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, kid_category.id)
      item.kid_fare = ticket.fare if ticket
      infant_category = TicketCategory.find_by_type_id TicketType::INFANT
      ticket = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, infant_category.id)
      item.infant_fare = ticket.fare if ticket
    end
    
    item.number_of_adult = @order_params["adult"].to_i
    item.number_of_kid = @order_params["kid"].to_i
    item.number_of_infant = @order_params["infant"].to_i
    item.travel_type_id = TravelType::COMING_BACK
    item.status_id = OrderStatus::VERIFIED
    if item.save
      generate_item_detail(item)
    end
  end

  def update_departure_balance(departure_id)
    dep = Departure.find(departure_id)
    dep.counter_sales += @total_ticket
    dep.save!
  end

  def generate_item_detail(order_item)
    count_adult = order_item.number_of_adult.to_i
    count_child = order_item.number_of_kid.to_i
    count_infant = order_item.number_of_infant.to_i
    @current_voucher_no = @company.last_voucher_number
    @current_receipt_no = @company.last_receipt_number

    if count_adult > 0
      count_adult.times.each do |adult|
        @detail = order_item.order_item_details.new
        adding_detail(order_item)
        @detail.fare = order_item.adult_fare
        @detail.ticket_category_id = TicketType::ADULT
        @detail.save!
      end
    end

    if count_child > 0
      count_child.times.each do |kid|
        @detail = order_item.order_item_details.new
        adding_detail(order_item)
        @detail.fare = order_item.kid_fare
        @detail.ticket_category_id = TicketType::KID
        @detail.save!
      end
    end

    if count_infant > 0
      count_infant.times.each do |infant|
        @detail = order_item.order_item_details.new
        adding_detail(order_item)
        @detail.fare = order_item.infant_fare
        @detail.ticket_category_id = TicketType::INFANT
        @detail.save!
      end
    end
    
    @company.update_attributes(:last_voucher_number => @current_voucher_no, :last_receipt_number => @current_receipt_no)
  end

  def adding_detail(order_item) 
    if @order.is_open_ticket?
      if order_item.is_coming_back?
        @detail.ticket_status_id = TicketStatus::VOUCHER
        @detail.serial_number = "VOU #{"%05d" % @current_voucher_no}" 
        @current_voucher_no += 1
      else
        @detail.ticket_status_id = TicketStatus::RECEIPT
        @detail.serial_number = "REC #{"%05d" % @current_receipt_no}" 
        @current_receipt_no += 1
      end
    else
      @detail.ticket_status_id = TicketStatus::RECEIPT
      @detail.serial_number = "REC #{"%05d" % @current_receipt_no}" 
      @current_receipt_no += 1
    end
  end

end