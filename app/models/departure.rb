class Departure < ActiveRecord::Base
  attr_accessible :active, :custom_quota, :on_call, :online_quota, :sales_quota, :status_id, :vessel_id, :routine_id, :date, :time, :extra_trip

  validates :routine_id, :presence => true

  belongs_to :vessel
  belongs_to :routine

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
end
