class OrderItem < ActiveRecord::Base
  attr_accessible :departure_id, :order_id, :routine_id, :number_of_adult, :number_of_kid, :adult_fare, :kid_fare, :travel_type_id, :number_of_infant, :arrival_id, :status_id, :voucher_no

  belongs_to :order
  belongs_to :departure
  belongs_to :routine

  has_many :order_item_details

  # def is_pending?
  #   self.travel_type_id == TravelType::PENDING
  # end

  def is_going_out?
    self.travel_type_id == TravelType::GOING_OUT
  end

  def is_coming_back?
    self.travel_type_id == TravelType::COMING_BACK
  end

  def total_adult_fare
  	self.number_of_adult * self.adult_fare
  end

  def total_kid_fare
  	self.number_of_kid * self.kid_fare
  end

  def total_tickets
  	self.number_of_adult + self.number_of_kid
  end

  def total_amount
  	total_adult_fare + total_kid_fare
  end

  def title
    self.routine.title
  end

end
