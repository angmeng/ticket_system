class Schedule < ActiveRecord::Base
  attr_accessible :active, :code, :departure_time, :online_quota, :routine_id, :sales_quota, :weekday, :departure_date, :extra_trip
  validates :code, :presence => true, :uniqueness => true
  validates :departure_time, :uniqueness => {:scope => [:weekday, :routine_id]}
  validates :routine_id, :presence => true
  validate :check_weekday_validation

  before_save :assign_weekday

  belongs_to :routine

  def weekday_name
  	case weekday
  	when WeekDays::SUN
  	  "Sunday"
  	when WeekDays::MON
  	  "Monday"
  	when WeekDays::TUE
  	  "Tuesday"
  	when WeekDays::WED
  	  "Wednesday"
  	when WeekDays::THU
  	  "Thursday"
  	when WeekDays::FRI
  	  "Friday"
  	when WeekDays::SAT
  	  "Saturday"
  	end
  end

private

  def check_weekday_validation
  	if self.extra_trip?
  	  errors.add(:departure_date, "cannot be blank") if self.departure_date.blank?
  	else
  	  errors.add(:weekday, "cannot be blank") if self.weekday.blank?
  	end
  end

  def assign_weekday
  	self.weekday = self.departure_date.wday if self.extra_trip?
  end
end
