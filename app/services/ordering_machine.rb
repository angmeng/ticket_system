class OrderingMachine

  def initialize(order, company, branch, params_payment_type)
  	@order_params = order
    @company = company
    @branch  = branch
    @total_ticket = @order_params["adult"].to_i + @order_params["kid"].to_i + @order_params["infant"].to_i
  	@order = Order.new
    @order.payment_type_id = params_payment_type[:payment_type_id]
    @order.branch_id = @branch.id
  end

  def self.store_order(order)
    @ret = {}
    @ret[:operate] = "yes"
    @order_params = order
    @item = OrderItem.new
    self.buyerType_and_tripType
    self.arrange_people_departure
    self.arrange_people_arrival if @ret[:travel_type_id].to_i == TravelType::ROUND_TRIP
    self.arrange_people_voucher if @ret[:travel_type_id].to_i == TravelType::OPEN_TICKET
    return @ret
  end

  def process
    make_order
    make_order_items
    @order
  end

  def make_order
  	@order.seller_id = @order_params["seller_id"]
    create_buyerType_and_tripType
    @order.total_passenger = @total_ticket
   	@order.save!
  end

  def create_buyerType_and_tripType
    case @order_params["buyer_type"]
    when "normal"
        @order.buyer_type_id  = BuyerType::PUBLIC
        @order.buyer_id       = 0
    when "agent"
        @order.buyer_type_id  = BuyerType::AGENT
        @order.buyer_id       = @order_params["agent_id"]
    when "warrant"
        @order.buyer_type_id  = BuyerType::WARRANT
        @order.buyer_id       = @order_params["warrant_id"]
    end
    case @order_params["trip_type"]
    when "round"
        @order.travel_type_id = TravelType::ROUND_TRIP
        @order.discount       = Company.first.discount_on_two_way_ticket
    when "one"
        @order.travel_type_id = TravelType::SINGLE_TRIP
    when "open_ticket"
        @order.travel_type_id = TravelType::OPEN_TICKET
        @order.discount       = Company.first.discount_on_two_way_ticket
    end
  end

  def self.buyerType_and_tripType
    case @order_params["buyer_type"]
    when "normal"
      if @ret.present?
        @ret[:buyer_type_id] = BuyerType::PUBLIC
        @ret[:buyer_id] = 0
      end
    when "agent"
      if @ret.present?
        @ret[:buyer_type_id] = BuyerType::AGENT
        @ret[:buyer_id]  = @order_params["agent_id"]
        if @ret[:buyer_type_id].present? && @ret[:buyer_id].present?
          buyer_data = Agent.find_by_id(@ret[:buyer_id].to_i) 
          @ret[:buyer_credit] = buyer_data.credit
          @ret[:buyer_title]  = Order.buyer_title(@ret[:buyer_type_id])
          @ret[:buyer_name]   = Order.buyer_name(@ret[:buyer_type_id], buyer_data)
        end
      end
    when "warrant"
      if @ret.present?
        @ret[:buyer_type_id] = BuyerType::WARRANT
        @ret[:buyer_id] = @order_params["warrant_id"]
        if @ret[:buyer_type_id].present? && @ret[:buyer_id].present?
          buyer_data = Warrant.find_by_id(@ret[:buyer_id].to_i) 
          @ret[:buyer_title]  = Order.buyer_title(@ret[:buyer_type_id])
          @ret[:buyer_name]   = Order.buyer_name(@ret[:buyer_type_id], buyer_data)
        end
      end
    end
    case @order_params["trip_type"]
    when "round"
      if @ret.present?
        @ret[:travel_type_id] = TravelType::ROUND_TRIP
        @ret[:discount] = Company.first.discount_on_two_way_ticket
      end
    when "one"
      if @ret.present?
        @ret[:travel_type_id] = TravelType::SINGLE_TRIP
      end
    when "open_ticket"
      if @ret.present?
        @ret[:travel_type_id] = TravelType::OPEN_TICKET
        @ret[:discount] = Company.first.discount_on_two_way_ticket
      end
    end
    @ret
  end

  def make_order_items
  	make_departure_order
    make_arrival_order if @order.is_round_trip?
    make_voucher if @order.is_open_ticket?
  end

  def make_departure_order
    if @order_params["adult"].to_i > 0
      @item = @order.order_items.new
      create_arrange_people_departure
      @item.travel_type_id = TravelType::GOING_OUT
      @item.status_id = OrderStatus::VERIFIED
      if @item.save
        generate_item_detail(@item)
        update_departure_balance(@item.departure_id)
      end
    end
  end

  def create_arrange_people_departure
      @item.departure_id = @order_params["departure_routine_id"]
      @item.routine_id = @item.departure.routine_id

      adult_category  = TicketCategory.find_by_type_id TicketType::ADULT
      ticket_adult    = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], adult_category.id).first
      kid_category    = TicketCategory.find_by_type_id TicketType::KID
      ticket_kid      = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], kid_category.id).first
      infant_category = TicketCategory.find_by_type_id TicketType::INFANT
      ticket_infant   = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], infant_category.id).first

      @item.adult_fare   = ticket_adult.fare if ticket_adult
      @item.kid_fare     = ticket_kid.fare if ticket_kid
      @item.infant_fare  = ticket_infant.fare if ticket_infant
      @item.number_of_adult = @order_params["adult"].to_i
      @item.number_of_kid = @order_params["kid"].to_i
      @item.number_of_infant = @order_params["infant"].to_i  
  end

  def self.arrange_people_departure
      @item.departure_id = @order_params["departure_routine_id"]
      @item.routine_id = @item.departure.routine_id

      adult_category  = TicketCategory.find_by_type_id TicketType::ADULT
      ticket_adult    = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], adult_category.id).first
      kid_category    = TicketCategory.find_by_type_id TicketType::KID
      ticket_kid      = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], kid_category.id).first
      infant_category = TicketCategory.find_by_type_id TicketType::INFANT
      ticket_infant   = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], infant_category.id).first

      if @ret.present?
        @ret[:go_place]             = @item.routine.title
        @ret[:go_adult_fare]        = ticket_adult.fare if ticket_adult
        @ret[:go_kid_fare]          = ticket_kid.fare if ticket_kid
        @ret[:go_infant_fare]       = ticket_infant.fare if ticket_infant

        @ret[:go_number_of_adult]   = @order_params["adult"].to_i
        @ret[:go_number_of_kid]     = @order_params["kid"].to_i
        @ret[:go_number_of_infant]  = @order_params["infant"].to_i

        @ret[:go_total_adult_fare]  = @ret[:go_adult_fare]  * @ret[:go_number_of_adult]
        @ret[:go_total_kid_fare]    = @ret[:go_kid_fare]    * @ret[:go_number_of_kid]
        @ret[:go_total_infant_fare] = @ret[:go_infant_fare] * @ret[:go_number_of_infant]
        @ret[:go_total_tickets]     = @ret[:go_number_of_adult] + @ret[:go_number_of_kid] + @ret[:go_number_of_infant]
        @ret[:go_total_amount]      = @ret[:go_total_adult_fare] + @ret[:go_total_kid_fare] + @ret[:go_total_infant_fare]
      end
      @ret
  end

  def make_arrival_order
    if @order_params["adult"].to_i > 0
      @item = @order.order_items.new
      
      create_arrange_people_arrival

      @item.travel_type_id = TravelType::COMING_BACK
      @item.status_id = OrderStatus::VERIFIED
      if @item.save
        generate_item_detail(@item)
        update_departure_balance(@item.departure_id)
      end
    end
  end

  def create_arrange_people_arrival
      @item.departure_id = @order_params["arrival_routine_id"]
      @item.routine_id   = @item.departure.routine_id
      adult_category     = TicketCategory.find_by_type_id TicketType::ADULT
      ticket_adult       = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["arrival_ticket_ids"], adult_category.id).first
      kid_category       = TicketCategory.find_by_type_id TicketType::KID
      ticket_kid         = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["arrival_ticket_ids"], kid_category.id).first
      infant_category    = TicketCategory.find_by_type_id TicketType::INFANT
      ticket_infant      = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], infant_category.id).first

      @item.adult_fare = ticket_adult.fare if ticket_adult
      @item.kid_fare = ticket_kid.fare if ticket_kid
      @item.infant_fare = ticket_infant.fare if ticket_infant
      @item.number_of_adult = @order_params["adult"].to_i
      @item.number_of_kid = @order_params["kid"].to_i
      @item.number_of_infant = @order_params["infant"].to_i
  end

  def self.arrange_people_arrival
      @item.departure_id = @order_params["arrival_routine_id"]
      @item.routine_id   = @item.departure.routine_id
      adult_category     = TicketCategory.find_by_type_id TicketType::ADULT
      ticket_adult       = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["arrival_ticket_ids"], adult_category.id).first
      kid_category       = TicketCategory.find_by_type_id TicketType::KID
      ticket_kid         = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["arrival_ticket_ids"], kid_category.id).first
      infant_category    = TicketCategory.find_by_type_id TicketType::INFANT
      ticket_infant      = Ticket.where("id IN(?) and ticket_category_id = ?", @order_params["departure_ticket_ids"], infant_category.id).first

      if @ret.present?
        @ret[:back_place]            = @item.routine.title
        @ret[:back_adult_fare]       = ticket_adult.fare if ticket_adult
        @ret[:back_kid_fare]         = ticket_kid.fare if ticket_kid
        @ret[:back_infant_fare]      = ticket_infant.fare if ticket_infant
        self.back_mode
      end
      @ret
  end

  def self.back_mode
    @ret[:back_number_of_adult]  = @order_params["adult"].to_i
    @ret[:back_number_of_kid]    = @order_params["kid"].to_i
    @ret[:back_number_of_infant] = @order_params["infant"].to_i

    @ret[:back_total_adult_fare]  = @ret[:back_adult_fare]  * @ret[:back_number_of_adult]
    @ret[:back_total_kid_fare]    = @ret[:back_kid_fare]    * @ret[:back_number_of_kid]
    @ret[:back_total_infant_fare] = @ret[:back_infant_fare] * @ret[:back_number_of_infant]
    @ret[:back_total_tickets]     = @ret[:back_number_of_adult] + @ret[:back_number_of_kid] + @ret[:back_number_of_infant]
    @ret[:back_total_amount]      = @ret[:back_total_adult_fare] + @ret[:back_total_kid_fare] + @ret[:back_total_infant_fare]
  end

  def make_voucher
    @item = @order.order_items.new

    create_arrange_people_voucher

    @item.travel_type_id = TravelType::COMING_BACK
    @item.status_id = OrderStatus::VERIFIED
    if @item.save
      generate_item_detail(@item)
    end
  end

  def create_arrange_people_voucher
      # Notice, please read carefully... 
      # When first go out, departure_id is Penang, arrival_id is Langkawi..
      # When anytime want to back home, departure_id is Langkawi(_id), arrival_id is Penang(_id), this sentence will be as below..
      @item.departure_id  = @order_params["departure_id"]
      @item.arrival_id    = @order_params["arrival_id"]
      routine             = Routine.find_by_departure_jetty_id_and_arrival_jetty_id(@item.departure_id, @item.arrival_id)

      if routine.present?
        @item.routine_id  = routine.id
        adult_category    = TicketCategory.find_by_type_id TicketType::ADULT
        ticket_adult      = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, adult_category.id)
        kid_category      = TicketCategory.find_by_type_id TicketType::KID
        ticket_kid        = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, kid_category.id)
        infant_category   = TicketCategory.find_by_type_id TicketType::INFANT
        ticket_infant     = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, infant_category.id)

        @item.adult_fare        = ticket_adult.fare if ticket_adult
        @item.kid_fare          = ticket_kid.fare if ticket_kid
        @item.infant_fare       = ticket_infant.fare if ticket_infant
        @item.number_of_adult   = @order_params["adult"].to_i
        @item.number_of_kid     = @order_params["kid"].to_i
        @item.number_of_infant  = @order_params["infant"].to_i
      end 
  end

  def self.arrange_people_voucher
      # Notice, please read carefully... 
      # When first go out, departure_id is Penang, arrival_id is Langkawi..
      # When anytime want to back home, departure_id is Langkawi(_id), arrival_id is Penang(_id), this sentence will be as below..
      @item.departure_id  = @order_params["departure_id"]
      @item.arrival_id    = @order_params["arrival_id"]
      routine             = Routine.find_by_departure_jetty_id_and_arrival_jetty_id(@item.departure_id, @item.arrival_id)

      if routine.present?
        @item.routine_id  = routine.id
        adult_category    = TicketCategory.find_by_type_id TicketType::ADULT
        ticket_adult      = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, adult_category.id)
        kid_category      = TicketCategory.find_by_type_id TicketType::KID
        ticket_kid        = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, kid_category.id)
        infant_category   = TicketCategory.find_by_type_id TicketType::INFANT
        ticket_infant     = Ticket.find_by_routine_id_and_ticket_category_id(routine.id, infant_category.id)

        if @ret.present?
          @ret[:back_place]            = @item.routine.title
          @ret[:back_adult_fare]       = ticket_adult.fare if ticket_adult
          @ret[:back_kid_fare]         = ticket_kid.fare if ticket_kid
          @ret[:back_infant_fare]      = ticket_infant.fare if ticket_infant
          self.back_mode
        end
      end 
      @ret   
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