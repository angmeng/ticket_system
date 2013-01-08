class OrderItem < ActiveRecord::Base
  attr_accessible :departure_id, :order_id, :routine_id, :number_of_adult, :number_of_kid, :adult_fare, :kid_fare, :travel_type_id, :number_of_infant, :arrival_id

  belongs_to :order
  belongs_to :departure
  belongs_to :routine

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
