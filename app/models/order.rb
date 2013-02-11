class Order < ActiveRecord::Base
  attr_accessible :amount_tender, :discount, :extra_charges, :free_tickets, :payment_type_id, :remark, :seller_id, :buyer_id, :buyer_type_id, :travel_type_id, :total_passenger, :bypass_credit, :bypass_credit_manager_id, :reservation

  has_one :warrant_purchase
  has_one :reservation_detail

  has_many :order_items
  has_many :passengers

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
    when TravelType::OPEN_TICKET
      "Open ticket"
    end
  end

  def is_single_trip?
    self.travel_type_id == TravelType::SINGLE_TRIP
  end

  def is_round_trip?
    self.travel_type_id == TravelType::ROUND_TRIP
  end

  def is_open_ticket?
    self.travel_type_id == TravelType::OPEN_TICKET
  end

  def buyer_is_agent?
    self.buyer_type_id == BuyerType::AGENT
  end

  def buyer_is_public?
    self.buyer_type_id == BuyerType::PUBLIC
  end

  def buyer_is_warrant?
    self.buyer_type_id == BuyerType::WARRANT
  end

  def agent
    @agent ||= Agent.find_by_id(self.buyer_id)
  end

  def warrant
    @warrant ||= Warrant.find_by_id(self.buyer_id)
  end

  def buyer_name
    case self.buyer_type_id
    when BuyerType::PUBLIC
      "Public User"
    when BuyerType::AGENT
      agent.fullname rescue "-"
    when BuyerType::WARRANT
      warrant.name rescue "-"
    end
  end

  def self.buyer_name(buyer_type, acc)
    case buyer_type
    when BuyerType::PUBLIC
      "Public User"
    when BuyerType::AGENT
      acc.fullname rescue "-"
    when BuyerType::WARRANT
      acc.name rescue "-"
    end
  end

  # def buyer_title
  #   case self.buyer_type_id
  #   when BuyerType::PUBLIC
  #     "Buyer Type"
  #   when BuyerType::AGENT
  #     "Agent"
  #   when BuyerType::WARRANT
  #     "Warrant"
  #   end
  # end

  def self.buyer_title(buyer_type)
    case buyer_type
    when BuyerType::PUBLIC
      "Buyer Type"
    when BuyerType::AGENT
      "Agent"
    when BuyerType::WARRANT
      "Warrant"
    end
  end

  def buyer_credit
    case self.buyer_type_id
    when BuyerType::PUBLIC
      "Not Available"
    when BuyerType::AGENT
      agent.credit rescue "-"
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

  def verified!
    if self.order_items.present?
      self.order_items.each {|item| item.update_attributes!(:status_id => OrderStatus::VERIFIED) if item.is_pending? }
      # if self.is_open_ticket?

      #   go_out = self.order_items.find_by_travel_type_id(TravelType::GOING_OUT)
      #   go_out.update_attributes!(:status_id => OrderStatus::VERIFIED) if go_out

      #   come_back = self.order_items.find_by_travel_type_id(TravelType::COMING_BACK)
      #   come_back.update_attributes!(:status_id => OrderStatus::VERIFIED) if come_back
      #   # :voucher_no => 

      # elsif self.is_round_trip?

      #   go_out = self.order_items.find_by_travel_type_id(TravelType::GOING_OUT)
      #   go_out.update_attributes!(:status_id => OrderStatus::VERIFIED) if go_out

      #   come_back = self.order_items.find_by_travel_type_id(TravelType::COMING_BACK)
      #   come_back.update_attributes!(:status_id => OrderStatus::VERIFIED) if come_back

      # else

      #   go_out = self.order_items.find_by_travel_type_id(TravelType::GOING_OUT)
      #   go_out.update_attributes!(:status_id => OrderStatus::VERIFIED) if go_out

      # end
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
    when PaymentType::FREE
      "Free"
    when PaymentType::RESERVATION
      "Reservation"
    else
      '-'
    end
  end

  def payment_type_is_credit?
    self.payment_type_id == PaymentType::CREDIT
  end

  def payment_type_is_free?
    self.payment_type_id == PaymentType::FREE
  end

  def payment_type_is_reservation?
    self.payment_type_id == PaymentType::RESERVATION
  end

  def is_reservation?
    self.reservation == true
  end
end
