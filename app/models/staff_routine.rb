class StaffRoutine < ActiveRecord::Base
  attr_accessible :routine_id, :staff_id
  belongs_to :staff
end
