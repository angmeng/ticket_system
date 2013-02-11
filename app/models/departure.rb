class Departure < ActiveRecord::Base
  attr_accessible :active, :custom_quota, :on_call, :online_quota, :sales_quota, :status_id, :vessel_id, :routine_id, :date, :time, :extra_trip, :online_sales, :counter_sales, :available_online_sales, :available_counter_sales

  validates :routine_id, :presence => true

  belongs_to :vessel
  belongs_to :routine
  has_many   :order_items

  before_save :update_balance

  def status
  	case self.status_id
  	when DepartureStatusType::OPEN
  	  "Open"
    when DepartureStatusType::CLOSE
      "Close"
    end
  end

  def date_time
    "#{self.date.strftime("%d-%m-%Y")} #{self.time.strftime("%H:%M")}"
  end

  private

  def update_balance
    self.available_counter_sales = self.sales_quota  - self.counter_sales
    self.available_online_sales  = self.online_quota - self.online_sales
  end
end
