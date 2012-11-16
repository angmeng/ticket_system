class Departure < ActiveRecord::Base
  attr_accessible :active, :custom_quota, :on_call, :online_quota, :sales_quota, :status_id, :vessel_id
end
