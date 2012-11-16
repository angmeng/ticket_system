class Schedule < ActiveRecord::Base
  attr_accessible :active, :code, :departure_time, :online_quota, :routine_id, :sales_quota
end
