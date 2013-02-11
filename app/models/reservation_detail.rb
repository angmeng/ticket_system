class ReservationDetail < ActiveRecord::Base
  attr_accessible :order_id, :reservation_number

  belongs_to :order
end
