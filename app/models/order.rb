class Order < ActiveRecord::Base
  attr_accessible :amount_tender, :discount, :extra_charges, :free_tickets, :payment_type_id, :remark, :seller_id, :buyer_id, :buyer_type_id, :travel_type_id

  has_many :order_items

  def going_out_item
    @going_out ||= self.order_items.find_by_travel_type_id TravelType::GOING_OUT
  end

  def coming_back_item
    @coming_back ||= self.order_items.find_by_travel_type_id TravelType::COMING_BACK
  end

  def is_round_trip?
    self.travel_type_id == TravelType::ROUND_TRIP
  end


end
