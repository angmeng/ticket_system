class Order < ActiveRecord::Base
  attr_accessible :amount_tender, :discount, :extra_charges, :free_tickets, :payment_type_id, :remark, :seller_id, :buyer_id, :buyer_type_id, :travel_type_id, :status_id

  has_many :order_items
  belongs_to :seller, :class_name => "User"

  def going_out_item
    @going_out ||= self.order_items.find_by_travel_type_id TravelType::GOING_OUT
  end

  def coming_back_item
    @coming_back ||= self.order_items.find_by_travel_type_id TravelType::COMING_BACK
  end

  def travel_type
    case self.travel_type_id
    when TravelType::ROUND_TRIP
      "Round Trip"
    when TravelType::SINGLE_TRIP
      "Single Trip"
    end
  end

  def is_round_trip?
    self.travel_type_id == TravelType::ROUND_TRIP
  end

  def buyer_is_sub_agent?
    self.buyer_type_id == BuyerType::SUB_AGENT
  end

  def buyer_is_public?
    self.buyer_type_id == BuyerType::PUBLIC
  end

  def buyer_is_warrant?
    self.buyer_type_id == BuyerType::WARRANT
  end

  def sub_agent
    @sub_agent ||= SubAgent.find_by_id(self.buyer_id)
  end

  def warrant
    @warrant ||= Warrant.find_by_id(self.buyer_id)
  end

  def buyer_name
    case self.buyer_type_id
    when BuyerType::PUBLIC
      "Public User"
    when BuyerType::SUB_AGENT
      sub_agent.fullname rescue "-"
    when BuyerType::WARRANT
      warrant.name rescue "-"
    end
  end

  def buyer_title
    case self.buyer_type_id
    when BuyerType::PUBLIC
      "Buyer Type"
    when BuyerType::SUB_AGENT
      "Sub Agent"
    when BuyerType::WARRANT
      "Warrant"
    end
  end

  def buyer_credit
    case self.buyer_type_id
    when BuyerType::PUBLIC
      "Not Available"
    when BuyerType::SUB_AGENT
      sub_agent.credit rescue "-"
    when BuyerType::WARRANT
      "Not Available"
    end
  end

  def total_amount
    self.order_items.inject(0.00) {|sum, item| sum += item.total_amount}
  end

  def total_adult_tickets
    self.order_items.inject(0) {|sum, item| sum += item.number_of_adult}
  end

  def total_kid_tickets
    self.order_items.inject(0) {|sum, item| sum += item.number_of_kid}
  end

  def total_tickets
    total_adult_tickets + total_kid_tickets
  end

  def status
    case self.status_id
    when OrderStatus::PENDING
      "Pending"
    when OrderStatus::VERIFIED
      "Confirmed"
    when OrderStatus::VOIDED
      "Voided"
    end
  end

  def is_voided?
    self.status_id == OrderStatus::VOIDED
  end

  def is_verified?
    self.status_id == OrderStatus::VERIFIED
  end

  def is_pending?
    self.status_id == OrderStatus::PENDING
  end

  def verified!
    if is_pending?
      self.status_id = OrderStatus::VERIFIED 
      save!
    end
  end

  def payment_type
    case self.payment_type_id
    when PaymentType::CASH
      "Cash"
    when PaymentType::CREDIT
      "Credit"
    when PaymentType::CREDIT_CARD
      "Credit Card"
    when PaymentType::ONLINE
      "Online Payment Gateway"
    end
  end


end
