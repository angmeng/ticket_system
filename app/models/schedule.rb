class Schedule < ActiveRecord::Base
  attr_accessible :active, :code, :departure_time, :online_quota, :routine_id, :sales_quota
  validates :code, :presence => true, :uniqueness => true
  validates :routine_id, :presence => true

  belongs_to :routine
end
